Shader "Jason/Build It/Select Box"
{
    Properties
    {
        [Header(Standard)]
        _SurfaceColor("Surface Color", Color) = (0.03,0.03,0.03,1)
        _SurfaceLerp("Surface Lerp", Range(0,1)) = 0.5

        [Header(Rim)]
        _RimColor("Rim Color", Color) = (1,1,1,1)
        _RimPower("Rim Power", Float) = 0.2
        
        [Header(Wave)]
        _Wave("Wave", Range(0, 1)) = 1
        _WaveSpeed("Wave Speed", Float) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue"="Transparent" }
        Blend SrcAlpha One
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag nolightmap

            #include "UnityCG.cginc"
            #include "UnityLightingCommon.cginc"

            fixed4 _SurfaceColor;
            fixed _SurfaceLerp;
            fixed4 _RimColor;
            float _RimPower;
            fixed _Wave;
            float _WaveSpeed;

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
                float3 normal : NORMAL;
                float3 posWorld : TEXCOORD1;
            };
            v2f vert (appdata_base v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord.xy;
                o.normal = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                return o;
            }
            fixed4 frag (v2f i) : SV_Target
            {
                // Wave
                fixed wave = sin(_Time.y * _WaveSpeed) * _Wave;

                // Rim
                fixed3 viewDir = normalize(UnityWorldSpaceViewDir(i.posWorld));
                fixed4 rimResult = (1 - saturate(pow(dot(i.normal, viewDir), _RimPower))) * _RimColor;

                // Effect
                fixed4 effect = lerp(rimResult, _SurfaceColor, _SurfaceLerp * wave);

                // Finish
                return saturate(effect);
            }
            ENDCG
        }
    }
}
