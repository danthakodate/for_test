// TODO : �̰� draw call �ٿ��� ��.

Shader "Wit/WaterMutiLayer_RED" {
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
		_AlphaTex ("Alpha mask", 2D) = "white" {}
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
			#include "ZepetoBuildItWater.cginc"

            #pragma multi_compile_fwdbase_fullshadows
            //#pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 switch 
            #pragma target 2.0

			half4 _MainTex_ST;

            VertexOutput vert (VertexInput v) {
                return waterVertex(v);
            }

			half4 frag(VertexOutput i) : COLOR {
				fixed4 alphaMap = tex2D(_AlphaTex, i.uv);
				fixed alpha = alphaMap.r;
				if (alpha < 0.01) {
					discard;
				}
				return fixed4(waterFragment(i), alpha);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
