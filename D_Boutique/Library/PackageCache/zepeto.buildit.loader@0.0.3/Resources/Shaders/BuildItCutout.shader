Shader "BuildIt/Cutout"
{
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_Power ("Power", Float) = 1
		_MainTex ("Texture", 2D) = "white" {}
		_Cutoff ("Cutoff", Range(0,1)) = 0.5
		_ShadowOrigin ("Shadow Origin", Vector) = (0,0,0,0)
		_ShadowDistance ("Shadow Distance", Float) = 5
		_ShadowPower ("Shadow Power", Float) = 1
	}

	SubShader {
		Tags {
			"Queue"="AlphaTest"
			"IgnoreProjector"="True"
			"RenderType"="TransparentCutout"
		}
		Cull Back
		LOD 200

		CGPROGRAM
		#include "AutoLight.cginc"
		#pragma surface surf Lambert vertex:vert alphatest:_Cutoff nolightmap

		#define USE_SHADOW_DISTANCE 1

		sampler2D _MainTex;
		fixed4 _Color;
		float _Power;
		#if USE_SHADOW_DISTANCE
			float4 _ShadowOrigin;
			float _ShadowDistance;
			float _ShadowPower;
		#endif

		struct Input {
			float2 uv_MainTex;
			#if USE_SHADOW_DISTANCE
				float3 localPos;
			#endif
		};

		void vert (inout appdata_full v, out Input o)
		{
			UNITY_INITIALIZE_OUTPUT(Input, o);
			o.localPos = v.vertex.xyz;
		}

		void surf (Input IN, inout SurfaceOutput o) 
		{
			// 텍스쳐값 추출
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color * _Power;

			// 거리 추출
			#if USE_SHADOW_DISTANCE
				float d = pow(saturate(distance(_ShadowOrigin, IN.localPos)/ _ShadowDistance), _ShadowPower);
			#endif

			// 알베도 설정
			#if USE_SHADOW_DISTANCE
				o.Albedo = c.rgb * d;
			#else
				o.Albedo = c.rgb;
			#endif
			
			// 알파값 설정
			o.Alpha = c.a;
		}
		ENDCG
	}

	FallBack "Legacy Shaders/Transparent/Cutout/Diffuse"
}