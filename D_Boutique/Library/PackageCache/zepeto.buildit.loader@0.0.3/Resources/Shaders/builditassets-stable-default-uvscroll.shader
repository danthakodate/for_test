/*
빌드잇의 기본적인 색감을 보장하는 쉐이더 입니다.

Light 가 없는 제페토 본체 환경이나 Assets 환경에서
제작자의 의도가 더 정확하게 반영되도록 만들어졌습니다.
해당 쉐이더를 이용하여 오브젝트가 만들어진다면
제페토 본체 및 빌드잇의 다양한 환경에서 거의 동일한 결과물을 얻을 수 있습니다.

또한 해당 쉐이더는 실시간 라이트를 받고있지 않으므로
그림자 계산또한 존재하지 않습니다. (오직 1Pass)

참고사항으로
아래의 _NoLightDirection 은 초기화시
var lightDirection = 광원 오브젝트의 로테이션값 * Vector3.forward;
를 통해 먼저 빛의 방향벡터를 계산하고, 해당 값을 설정해 주어야 합니다.
이후에는 랜더링시 다른 계산없이 방향값을 가져올 수 있게됩니다.
동시에 _NoLightColor 또한 라이트의 색상값을 가져온다면 더 좋을 것 같네요. 기본적으론 흰색입니다.
*/
Shader "BuildItAssets/Stable/DefaultUVScroll"
{
    Properties
    {
        [Header(Default)]
        _MainTex ("Texture", 2D) = "white"{}
        _Color ("Color", Color) = (1,1,1,1)

        [Header(NoLight)]
        _NoLightDirection ("Light Direction", Vector) = (29.357, -164.436, -69.211)
        _NoLightColor ("Light Color", Color) = (1,1,1,1)

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
            #pragma multi_compile __ USE_LIGHTMAP

            #include "UnityStandardBRDF.cginc"
            #include "UnityStandardUtils.cginc"
            #include "AutoLight.cginc"

            sampler2D _MainTex;
            float4 _MainTex_ST;
            fixed4 _Color;
            half3 _NoLightDirection;
            fixed4 _NoLightColor;
            fixed2 _UVScrollDirection;
            float _UVScrollSpeed;

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv : TEXCOORD0;
                #if defined(USE_LIGHTMAP)
                    float2 uvLightmap : TEXCOORD1;
                #endif
            };

            struct v2f
            {
                float4 pos : SV_POSITION;
                float3 normal : TEXCOORD0;
                float3 worldPos : TEXCOORD1;
                SHADOW_COORDS(2)
                float2 uv : TEXCOORD3;
                #if defined(USE_LIGHTMAP)
                    float2 uvLightmap : TEXCOORD4;
                #endif
                half3 ambient : COLOR0;
            };

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.normal = UnityObjectToWorldNormal(v.normal);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                #if defined(USE_LIGHTMAP)
                    o.uvLightmap = v.uvLightmap * unity_LightmapST.xy + unity_LightmapST.zw;
                #endif
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

                // Albedo
                fixed3 albedo = mainTex * _Color.rgb;

                // Lighting
                fixed3 lighting = fixed3(1, 1, 1);
                #if defined(USE_LIGHTMAP)

                    // Direction 이 설정된 경우
                    #if defined(DIRLIGHTMAP_COMBINED)
                        fixed3 lightmap = DecodeLightmap(UNITY_SAMPLE_TEX2D(unity_Lightmap, i.uvLightmap));
                        fixed4 lightmapDirection = UNITY_SAMPLE_TEX2D_SAMPLER(unity_LightmapInd, unity_Lightmap, i.uvLightmap);
                        lighting = DecodeDirectionalLightmap(lightmap, lightmapDirection, i.normal);

                        // Direction 이 설정되지 않은 경우
                    #else
                        lighting = DecodeLightmap(UNITY_SAMPLE_TEX2D(unity_Lightmap, i.uvLightmap));
                    #endif

                    // 라이트맵을 사용하지 않는 경우
                #else

                    // Light Direction
                    fixed3 lightDir = -normalize(_NoLightDirection);

                    // Normal 에 따른 빛의 영향력 수치 추출
                    half lightDot = saturate(dot(i.normal, lightDir));

                    // Light Color
                    fixed3 lightColor = _NoLightColor;

                    // Ambient
                    fixed3 ambient = i.ambient;

                    // Lighting 계산
                    lighting = lightDot * lightColor + ambient;
                #endif

                // Result
                fixed3 result = albedo * lighting;

                // Finish
                return fixed4(result, _Color.a);
            }
            ENDCG
        }
    }
    FallBack "Mobile/Unlit (Supports Lightmap)"
}