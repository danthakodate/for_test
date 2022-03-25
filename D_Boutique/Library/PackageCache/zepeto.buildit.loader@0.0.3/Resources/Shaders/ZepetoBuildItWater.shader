Shader "Wit/WaterMutiLayer" {
    Properties {
        _Color0 ("Color0", Color) = (0.1877163,0.9117647,0.6421192,1)
        _Gradient1 ("Gradient1", Float ) = 1
        _Color1 ("Color1", Color) = (0.1877163,0.6421192,0.9117647,1)
        _Gradient2 ("Gradient2", Float ) = 2
        _Color2 ("Color2", Color) = (0.1712803,0.2384142,0.4852941,1)
        _FresnelColor ("FresnelColor", Color) = (0.7205882,0.907505,1,1)
        _FresnelExp ("FresnelExp", Float ) = 5
        _MainFoamIntensity ("MainFoamIntensity", Float ) = 1
        _MainFoamScale ("MainFoamScale", Float ) = 1
        _MainFoamOpacity ("MainFoamOpacity", Range(0, 1)) = 1
        _SecondaryFoamIntensity ("SecondaryFoamIntensity", Float ) = 1
        _SecondaryFoamScale ("SecondaryFoamScale", Float ) = 1
        _SecondaryFoamOpacity ("SecondaryFoamOpacity", Range(0, 1)) = 1
        _WaterTexture ("WaterTexture", 2D) = "white" {}
		_AlphaTex ("Alpha mask (R)", 2D) = "white" {}
		_FoamSpeed ("FoamSpeed", Float) = 1
		_LightIntensity ("LightIntensity", Float) = 1
    }
    SubShader {
        Tags {
            "Queue"="Transparent"
            "RenderType"="Transparent"
            "DisableBatching"="True"
        }

		Blend SrcAlpha OneMinusSrcAlpha

        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "UnityLightingCommon.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 switch 
            #pragma target 2.0
            uniform sampler2D _CameraDepthTexture;
			sampler2D _MainTex;
			uniform sampler2D _AlphaTex;
            uniform float _Gradient2;
            uniform float4 _Color1;
            uniform float4 _Color2;
            uniform float _MainFoamIntensity;
            uniform float _MainFoamScale;
			uniform float _FoamSpeed;
			uniform float _LightIntensity;
            uniform float4 _Color0;
            uniform float _Gradient1;
            uniform sampler2D _WaterTexture; uniform float4 _WaterTexture_ST;
            uniform float _MainFoamOpacity;
            uniform float _SecondaryFoamIntensity;
            uniform float _SecondaryFoamScale;
            uniform float _SecondaryFoamOpacity;
            uniform float4 _FresnelColor;
            uniform float _FresnelExp;

            struct VertexInput {
				float2 uv : TEXCOORD0;
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                //float2 texcoord : TEXCOORD0;
            };

            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv : TEXCOORD0;
                fixed4 diff : COLOR0;
                float4 posWorld : TEXCOORD2;
                float3 normalDir : TEXCOORD3;
                float4 projPos : TEXCOORD4;
				//float2 texcoord : TEXCOORD0;
                UNITY_FOG_COORDS(4)
            };

			float4 _MainTex_ST;

            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv = v.uv;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                half3 worldNormal = UnityObjectToWorldNormal(v.normal);
                half nl = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz));
                o.diff = nl * _LightColor0;
                o.diff.rgb += ShadeSH9(half4(worldNormal, 1));
                o.diff.rgb = o.diff.rgb;
				//o.texcoord = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float sceneZ = max(0,LinearEyeDepth (UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos)))) - _ProjectionParams.g);
                float partZ = max(0,i.projPos.z - _ProjectionParams.g);
////// Lighting:
////// Emissive:
                float4 node_2892 = _Time;
                float2 node_2122 = ((i.uv*_MainFoamScale)+node_2892.g*float2(0.02,0.02));
                float4 node_2913 = tex2D(_WaterTexture,TRANSFORM_TEX(node_2122, _WaterTexture));
                float2 node_6407 = ((i.uv*_SecondaryFoamScale)+node_2892.g*float2(-0.01*_FoamSpeed,-0.01*_FoamSpeed));
                float4 node_5766 = tex2D(_WaterTexture,TRANSFORM_TEX(node_6407, _WaterTexture));
                float3 emissive = (((_MainFoamOpacity*(1.0 - saturate((sceneZ-partZ)/((0.2*_MainFoamIntensity)+pow((_MainFoamIntensity*node_2913.r),2.0)))))+lerp((_SecondaryFoamOpacity*pow(node_5766.r,2.0)),0.0,saturate((sceneZ-partZ)/_SecondaryFoamIntensity)))+lerp(lerp(lerp(_Color0.rgb,_Color1.rgb,saturate((sceneZ-partZ)/_Gradient1)),_Color2.rgb,saturate((sceneZ-partZ)/_Gradient2)),_FresnelColor.rgb,pow(1.0-max(0,dot(normalDirection, viewDirection)),_FresnelExp)));
                float3 finalColor = emissive;
                finalColor *= i.diff * _LightIntensity;

				fixed4 col2 = tex2D(_AlphaTex, i.uv);

                fixed4 finalRGBA = fixed4(finalColor,col2.r);

                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
