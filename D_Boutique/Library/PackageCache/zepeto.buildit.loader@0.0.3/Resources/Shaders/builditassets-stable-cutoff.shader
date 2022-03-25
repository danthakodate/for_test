/*
일반적인 Cutoff 쉐이더 입니다.

라이트맵을 구울 때, 그림자가 제대로 반영됩니다.
런타임에선 Double Side 로 랜더링 되기 때문에 많이 사용한다면 비효율적일 수 있습니다.
하지만 빌드잇에선 컷오프를 사용하는 경우 대부분이 뒷면까지 랜더링이 필요한 경우라서 기본적으로 Double Side 방식입니다.
*/
Shader "BuildItAssets/Stable/Cutoff"
{
    Properties
    {
        [Header(Default)]
        _MainTex ("Base",   2D)    = ""{}
        _Color   ("Color",  Color) = (1, 1, 1, 1)

        [Header(Cutoff)]
        _Cutoff  ("Cutoff", Float) = 0.5
    }

    CGINCLUDE

    #include "UnityCG.cginc"

    struct v2f
    {
        float4 position : SV_POSITION;
        float2 texcoord : TEXCOORD0;
    };

    sampler2D _MainTex;
    float4 _MainTex_ST;
    float4 _Color;
    float _Cutoff;

    v2f vert(appdata_base v)
    {
        v2f o;
        o.position = UnityObjectToClipPos(v.vertex);
        o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
        return o;
    }

    float4 frag(v2f i) : COLOR
    {
        float4 c = tex2D(_MainTex, i.texcoord);
        clip(c.a - _Cutoff);
        return c * _Color;
    }

    ENDCG

    SubShader
    {
        Tags { "RenderType"="TransparentCutout" "Queue"="AlphaTest" }
        Lod 100
        Cull Off
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            ENDCG
        }
    } 
    FallBack "Legacy Shaders/Transparent/Cutout/Diffuse"
}