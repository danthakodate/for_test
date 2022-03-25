Shader "Wit/StandardTransparent_js"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _Glossiness("Smoothness", Range(0,1)) = 0.5
        _Shininess("Shininess", Range(0.03, 1)) = 0.078125
        _BumpMap("Normal map", 2D) = "bump" {}

        _SparkleTex("Sparkle Texture", 2D) = "black" {} //the noise texture
        _SparkleColor("SparkleColor", Color) = (1,1,1,1) //color of the sparkle effect
        _SparkleRange("SparkleRange", range(0.1, 10)) = 0.1 //range of the sparkle effect
        _Intensity("Intensity", range(0.1, 30)) = 1 //intensity of the sparkle effect

        [HideInInspector]_LogLut("_LogLut", 2D) = "white" {}
        
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue" = "Transparent" }
        
        zwrite on    //! zwrite는 기본적으로 켜져있지만 확실하게 코드를 짜줍니다.
        ColorMask 0    //! 렌더하지 않습니다.
        CGPROGRAM
        
        #pragma surface surf _NoLit nolight keepalpha noambient noforwardadd nolightmap novertexlights noshadow        //! 최적화 코드
        
        struct Input
        {
            float2 color:COLOR;
        };
        
        void surf (Input IN, inout SurfaceOutput o)
        {
        }
        float4 Lighting_NoLit(SurfaceOutput s, float3 lightDir, float atten)    //! 커스텀 라이트 함수를 만들어 아무런 연산을 하지 않습니다.
        {
            return 0.0f;
        }
        ENDCG
        
        
        zwrite off
        CGPROGRAM
        
        #pragma surface surf StandardSpecular alpha:blend finalcolor:tonemapping
        #include "ToneMapping.cginc"
        
        sampler2D _MainTex;
        sampler2D _BumpMap;
        sampler2D _SparkleTex;

        float _SparkleRange, _Intensity;
        half4 _SparkleColor;

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_BumpMap;
            float2 uv_SparkleTex;

            float3 viewDir;
            float3 worldNormal; INTERNAL_DATA
        };
        
        half _Glossiness;
        half _Shininess;
        fixed4 _Color;	
        
        void surf(Input IN, inout SurfaceOutputStandardSpecular o)
        {
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex)* _Color;

            //sparkel effect
            fixed3 sparklemap = tex2D(_SparkleTex, IN.uv_SparkleTex);
            sparklemap -= half3(0.1, 0.8, 0.1);
            sparklemap = normalize(sparklemap);
            half sparkle = pow(saturate((dot(-IN.viewDir * float3(_SparkleRange, 0, _SparkleRange), normalize(sparklemap + IN.worldNormal)))), _Intensity);


            o.Albedo = c.rgb;
            o.Smoothness = _Glossiness;
            o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
            o.Specular = _Shininess;

            o.Emission = _SparkleColor * sparkle;

            o.Alpha = c.a;
        }
        void tonemapping(Input IN, SurfaceOutputStandardSpecular o, inout fixed4 color) {
            // color = ApplyColorGrading(color);
        }
        ENDCG
        // 보물 for js
        pass {                
            Name "ALPHA_WRITER"
            Blend One OneMinusSrcAlpha
            ColorMask A
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            
            struct appdata_t {
                float4 vertex : POSITION;
                float4 color : COLOR;
                float2 texcoord : TEXCOORD0;
            };       
            struct v2f {
                float4 vertex : SV_POSITION;
                fixed4 color : COLOR;
                float2 texcoord : TEXCOORD0;
            };
            
            sampler2D _MainTex;
            float4 _MainTex_ST;
            fixed4 _Color;
            
            v2f vert (appdata_t v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.color = v.color;
                o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
                return o;
            }                           
            fixed4 frag (v2f i) : SV_Target
            {
                return _Color * tex2D(_MainTex, i.texcoord);
            }
            ENDCG      
        }            
    }
    FallBack "Wit/Standard(NoColor)"
}
