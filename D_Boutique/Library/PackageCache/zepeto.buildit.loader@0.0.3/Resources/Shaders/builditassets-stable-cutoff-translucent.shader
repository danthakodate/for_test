/*
일반적인 Cutoff 쉐이더에 투과효과가 추가된 쉐이더 입니다.

라이트맵을 구울 때, 그림자가 제대로 반영됩니다.
런타임에선 Double Side 로 랜더링 되기 때문에 많이 사용한다면 비효율적일 수 있습니다.
하지만 빌드잇에선 컷오프를 사용하는 경우 대부분이 뒷면까지 랜더링이 필요한 경우라서 기본적으로 Double Side 방식입니다.
*/
Shader "BuildItAssets/Stable/CutoffTranslucent"
{
    Properties 
    {
        [Header(Default)]
        _MainTex ("Texture", 2D) = "white" {}
        _Color ("Color", Color) = (1,1,1,1)

        [Header(Cutoff)]
        _Cutoff ("Cutoff", Range(0,1)) = 0.5
        _Power ("Power", Float) = 2

        [Header(Translucent)]
        _TranslucentColor ("Translucent Color", Color) = (1,1,1,1)
        _TranslucentPower ("Translucent Power", Range(0.03, 1000)) = 1000
        _TranslucentScale ("Translucent Scale", Range(0, 10)) = 10
        _TranslucentDistortion ("Translucent Distortion", Range(-1, 1)) = 0.4

        [Header(Light)]
        _NoLightDirection ("Light Direction", Vector) = (29.357, -164.436, -69.211)
        _NoLightColor ("Light Color", Color) = (1,1,1,1)
    }

    SubShader 
    {
        Tags 
        {
            "Queue"="AlphaTest"
            "IgnoreProjector"="True"
            "RenderType"="TransparentCutout"
        }
        Cull Off
        LOD 200

        CGPROGRAM
        #include "AutoLight.cginc"
        #pragma surface surf Translucent vertex:vert alphatest:_Cutoff nolightmap
        #pragma exclude_renderers flash
        #pragma target 3.0
        sampler2D _MainTex;
        fixed4 _Color;
        float _Power;
        float _TranslucentDistortion, _TranslucentPower, _TranslucentScale;
        fixed4 _TranslucentColor;
        float3 _NoLightDirection;
        fixed4 _NoLightColor;

        struct Input {
            float2 uv_MainTex;
            float3 localPos;
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

            // 알베도 설정
            o.Albedo = c.rgb;

            // 알파값 설정
            o.Alpha = c.a;
        }
        inline fixed4 LightingTranslucent(SurfaceOutput s, fixed3 lightDir, fixed3 viewDir, fixed atten)
        {
            // Tranlucent 계산
            half3 transLightDir = -normalize(_NoLightDirection) + s.Normal * _TranslucentDistortion * 0.01;
            float transDot = pow(max(0, dot(viewDir, -transLightDir)), _TranslucentPower) * _TranslucentScale;
            fixed3 transLight = (atten * 2) * (transDot) * s.Alpha * _TranslucentColor.rgb;
            fixed3 transAlbedo = s.Albedo * _NoLightColor.rgb * transLight;

            // Finish
            fixed4 c;
            c.rgb = transAlbedo;
            c.a = _NoLightColor.a * atten;
            return c;
        }
        ENDCG        
    }
    FallBack "Legacy Shaders/Transparent/Cutout/Diffuse"
}