Shader "Cooltime/PlayGround/Cursor"
{
    Properties
    {        
        _RimColor ("RimColor", Color) = (1,1,1,1)
        _RimBorder ("RimBorder", Range(0,1)) = 0.3
        _Fade ("Fade", Range(1,3)) = 2
             
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Transparent"}       
        
        CGPROGRAM
        #pragma surface surf Outline alpha:fade noambient    

        float4 _RimColor;
        float _RimBorder;
        float _Fade;

        struct Input
        {
            float3 viewDir;
        };
       
        void surf (Input IN, inout SurfaceOutput o)
        {              
            o.Albedo = _RimColor;            
            o.Emission = _RimColor * _Fade;
            o.Alpha = 1;
        }

        float4 LightingOutline (SurfaceOutput s, float3 lightDir, float3 viewDir, float atten)
        {            
            float rim = abs(dot(s.Normal, viewDir));
            if (rim > _RimBorder)
            {
                rim = 0;
            }
            else
            {
                rim = 1;
            }

            float4 final;

            final.rgb = s.Albedo * rim ;
            final.a = (s.Alpha * rim) + 0.1;                           
            return final;
        }
        ENDCG
    }
    FallBack "Legacy Shaders/Transparent/VertexLit"
}
