/*
Default 쉐이더와 거의 동일하지만 결정적으로 Shade 하지 않습니다.
매우 이질적인 오브젝트들을 표현할 때 사용할 수 있을것이고
네온사인같은 오브젝트를 표현할 때도 사용할 수 있습니다.
사실상 형태와 색상만 표현하고자할 때 사용하시면 되겠습니다.
*/
Shader "BuildItAssets/Stable/NoShadeUVScroll"
{
    Properties
    {
        [Header(Default)]
        _MainTex ("Texture", 2D) = "white"{}
        _Color ("Color", Color) = (1,1,1,1)

        [Header(UV Scroll)]
        _UVScrollDirection("UV Scroll Direction", Vector) = (1,1,0,0)
        _UVScrollSpeed("UV Scroll Speed", Float) = 1
    }
    SubShader
    {
        LOD 100

        Pass
        {
            Tags
            {
                "RenderType"="Opaque" "LightMode"="ForwardBase"
            }

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.0
            #pragma multi_compile_fwdbase

            #include "UnityStandardBRDF.cginc"
            #include "UnityStandardUtils.cginc"
            #include "AutoLight.cginc"

            sampler2D _MainTex;
            float4 _MainTex_ST;
            fixed4 _Color;
            fixed2 _UVScrollDirection;
            float _UVScrollSpeed;

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
                SHADOW_COORDS(2)
                float2 uv : TEXCOORD3;
                half3 ambient : COLOR0;
            };

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.ambient = ShadeSH9(half4(o.normal, 1));
                TRANSFER_SHADOW(o);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                // UV Scroll
                i.uv.xy += _UVScrollDirection * _Time.y * _UVScrollSpeed;

                // Main Tex
                fixed3 mainTex = tex2D(_MainTex, i.uv).rgb;

                // Result
                fixed3 result = mainTex * _Color.rgb;

                // Finish
                return fixed4(result, _Color.a);
            }
            ENDCG
        }
    }
    FallBack "Mobile/Unlit (Supports Lightmap)"
}