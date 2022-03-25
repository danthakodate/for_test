Shader "BuildItAssets/Stable/Water/Cube"
{
    Properties
    {
        [Header(Default)]
        _MainTex ("Texture", 2D) = "white"{}
        _Color ("Color", Color) = (1,1,1,1)

        [Header(Surface)]
        _SurfaceScale ("Surface Scale", Float) = 1
        _SurfaceDirection ("Surface Direction", Vector) = (1,0,0,0)
        _SurfaceSpeed ("Surface Speed", Float) = 0.1

        [Header(Depth)]
        _DepthTexture ("Depth Texture", 2D) = "white"{}
        _DepthColor ("Depth Color", Color) = (1,1,1,1)
        _DepthPower ("Depth Power", Float) = 1
        _DepthClampMin ("Depth Clamp Min", Range(0,1)) = 0
        _DepthClampMax ("Depth Clamp Max", Range(0,1)) = 1

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
        _NoisePower ("Noise Power", Range(0,1)) = 0.2

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
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.0
            #pragma multi_compile_fwdbase

            #include "UnityCG.cginc"
            
            sampler2D _MainTex, _FoamTexture, _DepthTexture, _DotTexture, _DistortionTexture;
            float4 _MainTex_ST, _SurfaceDirection;
            fixed4 _Color, _DepthColor;
            float _SurfaceScale, _SurfaceSpeed, _DepthPower, _DotPower, _DistortionPower, _DistortionSpeed, _NoiseScale;
            fixed _DepthClampMin, _DepthClampMax, _NoisePower, _Alpha;
            fixed3 _DotDirection;
            sampler2D _GrabTexture, _CameraDepthTexture;

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
                return o;
            }
            fixed4 frag (v2f i) : SV_Target
            {
                // View Direction
                float3 viewDir = normalize(UnityWorldSpaceViewDir(i.worldPos));
                
                // Dot
                float dotViewDir = pow(1 - saturate(dot(i.normal, viewDir)), _DotPower);
                float dotUp = saturate(dot(i.normal, _DotDirection));
                float dotSide = 1 - dotUp;
                fixed3 dotColor = tex2D(_DotTexture, float2(dotViewDir, 0.5));
                dotColor = pow(dotColor, _DotPower);

                // Surface
                float2 surfaceUV = i.uv * _SurfaceScale + _SurfaceDirection * _SinTime.w * _SurfaceSpeed;
                fixed4 surfaceColor = tex2D(_MainTex, surfaceUV) * _Color;

                // Noise
                fixed noise = (Voronoi(surfaceUV * _NoiseScale) - 0.5) * _NoisePower;

                // Grab Pass
                fixed4 grabUV = i.grabPassPos + noise;
                fixed3 grabColor = tex2Dproj(_GrabTexture, grabUV).rgb;

                // Depth
                fixed depth = (i.localPos.y + 0.5 - _DepthClampMin) / (_DepthClampMax - _DepthClampMin);
                fixed3 depthColor = tex2D(_DepthTexture, fixed2(depth, 0.5)) * _DepthColor;
                depthColor = pow(depthColor, _DepthPower);
                
                // Finish
                fixed3 result = surfaceColor * dotUp;
                result += depthColor * dotSide;
                result *= dotColor;
                result = lerp(grabColor, result, _Alpha);
                return fixed4(result, 1);
            }
            ENDCG
        }
    }
    FallBack "Mobile/Unlit"
}
