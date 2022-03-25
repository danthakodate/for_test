Shader "BuildItAssets/Stable/Glass" {
	Properties{

		[Header(Default)]
		_MainTex("Main Texture", 2D) = "black" {}
		_Color("Color", Color) = (1, 1, 1, 1)
		
		[Header(Reflection)]
		_MaskTex("Reflection Mask (R)", 2D) = "white" {}
		_MaskPower("Mask Power", Range(0.0, 1.0)) = 0.5
		_ColorPower("Color Power", Range(0.0, 1.0)) = 0.8
		_Reflectivity("Reflections Power", Range(0.0, 1.0)) = 0.5
	}

	SubShader{
		Tags { "RenderType" = "Transparent" "Queue" = "Transparent" "IgnoreProjector" = "True" }
		LOD 100

		Pass {
			Name "BASE"
			Tags { "LightMode" = "ForwardBase" }

			ZWrite Off
			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
			#include "UnityCG.cginc"
			#include "UnityLightingCommon.cginc"
			#pragma target 3.0
			#pragma vertex vert
			#pragma fragment frag

			fixed4 _Color;
			sampler2D _MainTex, _MaskTex;
			float4 _MainTex_ST, _MaskTex_ST;
			float _MaskPower, _ColorPower, _Reflectivity;

			struct a2v {
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float4 texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct v2f {
				float4 pos : SV_POSITION;
				float4 coord0 : TEXCOORD0;
				float3 norm : TEXCOORD1;
				float3 eye : TEXCOORD2;
				UNITY_VERTEX_OUTPUT_STEREO
			};

			v2f vert(a2v v) {
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				o.pos = UnityObjectToClipPos(v.vertex);
				o.coord0.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
				o.coord0.zw = TRANSFORM_TEX(v.texcoord, _MaskTex);
				o.norm = UnityObjectToWorldNormal(v.normal);
				o.eye = _WorldSpaceCameraPos.xyz - mul(unity_ObjectToWorld, v.vertex).xyz;
				//UNITY_TRANSFER_FOG(o, o.pos);
				return o;
			}

			fixed4 frag(v2f i) : SV_Target{
				
				// Dirt의 alpha를 이용해서 color와 합성.
				fixed4 dirtOrg = tex2D(_MainTex, i.coord0);
				fixed3 dirt = lerp(_Color.rgb, dirtOrg.rgb * dirtOrg.a, dirtOrg.a);
				
				// dirt + Color + Light
				dirt = lerp(dirt, _Color, _Color.a * _ColorPower) * _LightColor0;

				// Unity Reflect Color
				fixed4 refl = UNITY_SAMPLE_TEXCUBE(unity_SpecCube0, reflect(-i.eye, i.norm));
				refl.rgb = DecodeHDR(refl, unity_SpecCube0_HDR) * _Reflectivity;

				// 마스크를 이용하여 dirt와 reflect을 합성.
				fixed mask = tex2D(_MaskTex, i.coord0.zw).r * _MaskPower;
				fixed3 result = lerp(refl, dirt, mask);

				// 마스크와 반사 강도에 따라서 계산 된 색 표현.
				return fixed4(result, saturate(mask + _Reflectivity));
			}
			ENDCG
		}
	}

	Fallback Off
}