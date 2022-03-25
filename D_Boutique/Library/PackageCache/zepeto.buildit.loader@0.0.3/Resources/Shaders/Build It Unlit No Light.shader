Shader "Jason/Build It/Unlit No Light"
{
    Properties
    {
        [Header(Standard)]
        _MainTex ("Texture", 2D) = "white"{}
    }
    SubShader
    {
        LOD 100

        Pass
        {
            Tags { "RenderType"="Opaque" "LightMode"="ForwardBase" }

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_fwdbase
            
            #include "UnityStandardBRDF.cginc"
            #include "UnityStandardUtils.cginc"

            sampler2D _MainTex;
            float4 _MainTex_ST;
            
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
                float2 uv : TEXCOORD3;
            };
            v2f vert (appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }
            fixed4 frag (v2f i) : SV_Target
            {
                // Main Tex
                fixed3 mainTex = tex2D(_MainTex, i.uv).rgb;

                // Albedo
                float3 albedo = mainTex;

                // Finish
                return fixed4(albedo, 1);
            }
            ENDCG
        }
    }
    FallBack "Mobile/Unlit (Supports Lightmap)"
}
