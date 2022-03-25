Shader "Jason/Build It Water/Plane"
{
    Properties
    {
        [Header(Standard)]
        _MainTex ("Texture", 2D) = "white"{}
        _Color ("Color", Color) = (1,1,1,1)

        [Header(Surface)]
        _SurfaceScale ("Surface Scale", Float) = 1
        _SurfacePower ("Surface Power", Float) = 0.75
        _SurfaceDirection ("Surface Direction", Vector) = (1,0,0,0)
        _SurfaceSpeed ("Surface Speed", Float) = 0.1

        [Header(Bright)]
        _BrightColor ("Bright Color", Color) = (1,1,1,1)
        _BrightPower ("Bright Power", Float) = 20

        [Header(Foam)]
        _FoamTexture ("Foam Texture", 2D) = "white"{}
        _FoamColor ("Foam Color", Color) = (1,1,1,1)
        _FoamDistance ("Foam Distance", Float) = 2

        [Header(Dot)]
        _DotTexture ("Dot Texture", 2D) = "white"{}
        _DotDirection ("Dot Direction", Vector) = (0,1,0)
        _DotPower ("Dot Power", Float) = 0.5

        [Header(Vertex Distortion)]
        _DistortionTexture ("Distortion Texture", 2D) = "bump"{}
        _DistortionPower ("Distortion Power", Float) = 0.1
        _DistortionSpeed ("Distortion Speed", Float) = 50

        [Header(Noise Scale)]
        _NoiseScale ("Noise Scale", Float) = 2
        _NoisePower ("Nouse Power", Range(0,1)) = 0.2

        [Header(Alpha)]
        _Alpha ("Alpha", Range(0,1)) = 0.8
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent" "DisableBatching"="true" }
        LOD 100

        GrabPass { "_GrabTexture" }

        Pass
        {
            Tags { "LightMode"="ForwardBase" }
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fwdbase
            
            #include "UnityStandardBRDF.cginc"
            #include "UnityStandardUtils.cginc"
            #include "AutoLight.cginc"

            sampler2D _MainTex, _FoamTexture, _DepthTexture, _DotTexture, _DistortionTexture;
            float4 _MainTex_ST, _SurfaceDirection;
            fixed4 _Color, _BrightColor;
            float _SurfaceScale, _SurfacePower, _SurfaceSpeed, _BrightPower, _DotPower, _DistortionPower, _DistortionSpeed, _NoiseScale;
            fixed _NoisePower, _Alpha;
            fixed3 _DotDirection;
            sampler2D _GrabTexture, _CameraDepthTexture;

            float4 _FoamColor;
            float _FoamDistance;

            float Random2To1(float2 value, float2 dotDir = float2(12.9898, 78.233)){float2 smallValue = sin(value); float random = dot(smallValue, dotDir); random = frac(sin(random) * 143758.5453); return random;}
            float2 Random2To2(float2 value){return float2(Random2To1(value, float2(12.989, 78.233)), Random2To1(value, float2(39.346, 11.135)));}

            float Voronoi(float2 value)
            {
                float2 baseCell = floor(value);
                float minDistToCell = 10;
                [unroll]
                for(int x=-1; x<=1; x++){
                    [unroll]
                    for(int y=-1; y<=1; y++){
                        float2 cell = baseCell + float2(x, y);
                        float2 cellPosition = cell + Random2To2(cell);
                        float2 toCell = cellPosition - value;
                        float distToCell = length(toCell);
                        if(distToCell < minDistToCell){
                            minDistToCell = distToCell;
                        }
                    }
                }
                return minDistToCell;
            }

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };
            struct v2f
            {
                float4 pos : SV_POSITION;
                float3 normal : TEXCOORD0;
                float3 worldPos : TEXCOORD1;
                float4 screenPos : TEXCOORD2;
                float4 grabPassPos : TEXCOORD3;
                float3 localPos : TEXCOORD4;
                SHADOW_COORDS(4)
                float2 uv : TEXCOORD5;
                
            };
            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                
                // Vertex Distortion
                float DistortionSample = tex2Dlod(_DistortionTexture, float4(normalize(o.worldPos).xz, 0, 0));
                o.pos.y += sin(_Time * _DistortionSpeed * DistortionSample) * _DistortionPower;
                o.pos.x += cos(_Time * _DistortionSpeed * DistortionSample) * _DistortionPower;

                // Local Position
                o.localPos = v.vertex.xyz;   

                // Screen Position
                o.screenPos = ComputeScreenPos(o.pos);
                
                // Grab Pass
                o.grabPassPos = ComputeGrabScreenPos(o.pos);

                TRANSFER_SHADOW(o);
                return o;
            }
            fixed4 frag (v2f i) : SV_Target
            {
                // View Direction
                float3 viewDir = normalize(UnityWorldSpaceViewDir(i.worldPos));
                
                // Dot
                float dotViewDir = pow(1 - saturate(dot(i.normal, viewDir)), _DotPower);
                float dotUp = saturate(DotClamped(i.normal, _DotDirection));
                fixed3 dotColor = tex2D(_DotTexture, float2(dotViewDir, 0.5));
                dotColor = pow(dotColor, _DotPower);

                // Light Color
                fixed4 lightColor = _LightColor0;

                // Bright Color
                fixed4 brightColor = _BrightColor * dotViewDir;
                brightColor = pow(brightColor, _BrightPower);

                // Shadow
                half shadow = SHADOW_ATTENUATION(i);

                // Surface
                float2 surfaceUV = i.uv * _SurfaceScale + _SurfaceDirection * _SinTime.w * _SurfaceSpeed;
                fixed4 surfaceColor = tex2D(_MainTex, surfaceUV) * _Color;

                // Noise
                fixed noise = (Voronoi(surfaceUV * _NoiseScale) - 0.5) * _NoisePower;

                // Grab Pass
                fixed4 grabUV = i.grabPassPos + noise;
                fixed3 grabColor = tex2Dproj(_GrabTexture, grabUV).rgb;

                // Foam
                float4 foamDepthSample = SAMPLE_DEPTH_TEXTURE_PROJ(_CameraDepthTexture, i.screenPos);
                float foamDepth = LinearEyeDepth(foamDepthSample).r;
                fixed foamLine = 1 - saturate(_FoamDistance * (foamDepth - i.screenPos.w));
                fixed4 foamGradient = fixed4(tex2D(_FoamTexture, fixed2(foamLine, 0.5)).rgb, 1);
                fixed4 foamColor = _FoamColor * foamGradient;
                
                // Finish
                fixed3 result = surfaceColor * dotUp;
                result *= lightColor;
                result += brightColor;
                result *= dotColor;
                result = lerp(grabColor, result, _Alpha);
                result += foamColor;
                return fixed4(result, 1);
            }
            ENDCG
        }
        Pass
        {
            Tags { "LightMode"="ForwardAdd" }
            Blend OneMinusDstColor One
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fwdadd_fullshadows

            #include "UnityStandardBRDF.cginc"
            #include "AutoLight.cginc"

            float _SurfaceScale;
            float _SurfacePower;
            float4 _SurfaceDirection;
            float _SurfaceSpeed;
            float _NoiseScale;
            fixed _NoisePower;

            float Random2To1(float2 value, float2 dotDir = float2(12.9898, 78.233)){float2 smallValue = sin(value); float random = dot(smallValue, dotDir); random = frac(sin(random) * 143758.5453); return random;}
            float2 Random2To2(float2 value){return float2(Random2To1(value, float2(12.989, 78.233)), Random2To1(value, float2(39.346, 11.135)));}

            float Voronoi(float2 value)
            {
                float2 baseCell = floor(value);
                float minDistToCell = 10;
                [unroll]
                for(int x=-1; x<=1; x++){
                    [unroll]
                    for(int y=-1; y<=1; y++){
                        float2 cell = baseCell + float2(x, y);
                        float2 cellPosition = cell + Random2To2(cell);
                        float2 toCell = cellPosition - value;
                        float distToCell = length(toCell);
                        if(distToCell < minDistToCell){
                            minDistToCell = distToCell;
                        }
                    }
                }
                return minDistToCell;
            }

            struct appdata
            {
                float4 vertex : POSITION;
                float4 normal : NORMAL;
                float2 uv : TEXCOORD0;
            };
            struct v2f
            {
                float4 pos : SV_POSITION;
                float3 normal : TEXCOORD0;
                float3 worldPos : TEXCOORD1;
                LIGHTING_COORDS(2,3)
                float2 uv : TEXCOORD4;
            };
            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex);
                o.uv = v.uv;
                TRANSFER_SHADOW(o);
                return o;
            }
            fixed4 frag(v2f i) : SV_Target
            {
                // Light Position By Object
                #if defined(POINT) || defined(SPOT)
                    float3 lightDir = normalize(_WorldSpaceLightPos0.xyz - i.worldPos);
                #else
                    float3 lightDir = _WorldSpaceLightPos0.xyz;
                #endif

                // Attenuation (almost shadow)
                UNITY_LIGHT_ATTENUATION(attenuation, i, i.worldPos);

                // Noise
                float2 surfaceUV = i.uv * _SurfaceScale + _SurfaceDirection * _SinTime.w * _SurfaceSpeed;
                float noise = (Voronoi(surfaceUV * _NoiseScale) - 0.5) * _NoisePower;
                attenuation += noise;

                // Light Color
                fixed3 lightColor = _LightColor0.rgb;
                
                // Light Space
                fixed lightSpace = DotClamped(i.normal, lightDir);
                
                // Finish
                fixed3 result = lightSpace * lightColor * attenuation;
                return fixed4(result, attenuation);
            }
            ENDCG
        }
        // Pass
        // {
            //     Tags { "LightMode"="ShadowCaster" }
            //     CGPROGRAM
            //     #pragma vertex vert
            //     #pragma fragment frag
            //     #pragma multi_compile_shadowcaster
            //     #include "UnityCG.cginc"
            //     struct v2f {V2F_SHADOW_CASTER;};
            //     v2f vert(appdata_base v) {v2f o; TRANSFER_SHADOW_CASTER_NORMALOFFSET(o) return o;}
            //     float4 frag(v2f i) : SV_Target {SHADOW_CASTER_FRAGMENT(i)}
            //     ENDCG
        // }
    }
    FallBack "Mobile/Unlit (Supports Lightmap)"
}
