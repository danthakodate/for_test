Shader "Cooltime/PlayGroundStandard"  {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Color("Color", Color) = (1.0, 1.0, 1.0, 1.0)

		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Shininess ("Shininess", Range (0.03, 1)) = 0.078125
		_NormalMap ("Normal map", 2D) = "normal" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM

		#pragma surface surf Lambert
		
		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _NormalMap;
		sampler2D _SpecularTex;
		struct Input {
			float2 uv_MainTex;
			float2 uv_NormalMap;
			float2 uv_SpecularTex;
		};

		half _Glossiness;	
		half _Shininess;
		fixed4 _Color;


		void surf (Input IN, inout SurfaceOutput o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			o.Normal = UnpackNormal(tex2D(_NormalMap, IN.uv_NormalMap));
        	o.Specular = _Shininess;
			o.Alpha = c.a;
		}

		ENDCG
	}
	FallBack "Diffuse"
}
