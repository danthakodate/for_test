// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Shader created with Shader Forge v1.26 
// Shader Forge (c) Neat Corporation / Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.26;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:2,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:2,rntp:3,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False;n:type:ShaderForge.SFN_Final,id:3138,x:32719,y:32712,varname:node_3138,prsc:2|emission-5969-RGB,clip-5969-A,voffset-2656-OUT;n:type:ShaderForge.SFN_Tex2d,id:5969,x:32219,y:32620,ptovrint:False,ptlb:MainTex,ptin:_MainTex,varname:node_5969,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:2ede96bc457ef654faa2d9c2b498dc52,ntxv:0,isnm:False;n:type:ShaderForge.SFN_VertexColor,id:782,x:32101,y:32924,varname:node_782,prsc:2;n:type:ShaderForge.SFN_Multiply,id:2656,x:32276,y:33058,varname:node_2656,prsc:2|A-782-R,B-3000-OUT;n:type:ShaderForge.SFN_ValueProperty,id:68,x:31110,y:33301,ptovrint:False,ptlb:Intensity,ptin:_Intensity,varname:node_68,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:1;n:type:ShaderForge.SFN_Time,id:1989,x:31076,y:33705,varname:node_1989,prsc:2;n:type:ShaderForge.SFN_Cos,id:2237,x:31319,y:33705,varname:node_2237,prsc:2|IN-1989-T;n:type:ShaderForge.SFN_TexCoord,id:3122,x:31076,y:33478,varname:node_3122,prsc:2,uv:0;n:type:ShaderForge.SFN_OneMinus,id:6577,x:31274,y:33514,varname:node_6577,prsc:2|IN-3122-V;n:type:ShaderForge.SFN_Multiply,id:7422,x:31511,y:33572,varname:node_7422,prsc:2|A-6577-OUT,B-2237-OUT;n:type:ShaderForge.SFN_FragmentPosition,id:1225,x:31299,y:33131,varname:node_1225,prsc:2;n:type:ShaderForge.SFN_Sin,id:7896,x:31534,y:33198,varname:node_7896,prsc:2|IN-1225-X;n:type:ShaderForge.SFN_Multiply,id:5131,x:31764,y:33271,varname:node_5131,prsc:2|A-7896-OUT,B-9660-OUT;n:type:ShaderForge.SFN_Multiply,id:9660,x:31650,y:33435,varname:node_9660,prsc:2|A-68-OUT,B-7422-OUT;n:type:ShaderForge.SFN_Append,id:3000,x:31997,y:33179,varname:node_3000,prsc:2|A-5131-OUT,B-5172-OUT,C-5131-OUT;n:type:ShaderForge.SFN_Vector1,id:5172,x:31935,y:33010,varname:node_5172,prsc:2,v1:0;proporder:5969-68;pass:END;sub:END;*/

Shader "BuildIt/EcoTales_Unlit_SimpleGrass" {
    Properties {
        _Color("Color", Color) = (1,1,1,1)
        _MainTex ("MainTex", 2D) = "white" {}
        _Intensity ("Intensity", Float ) = 1
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="AlphaTest"
            "RenderType"="TransparentCutout"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Cull Off
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            //#pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            // fixed4 _Color;
            uniform float4 _TimeEditor;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _Intensity;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float4 vertexColor : COLOR;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                float4 node_1989 = _Time + _TimeEditor;
                float node_5131 = (sin(mul(unity_ObjectToWorld, v.vertex).r)*(_Intensity*((1.0 - o.uv0.g)*cos(node_1989.g))));
                v.vertex.xyz += (o.vertexColor.r*float3(node_5131,0.0,node_5131));
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos(v.vertex );
                return o;
            }
        
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {

                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                // _MainTex_var.rgb *= _Color.rgb;
                clip(_MainTex_var.a - 0.5);
////// Lighting:
////// Emissive:
                float3 emissive = _MainTex_var.rgb;
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
   
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_SHADOWCASTER
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma exclude_renderers gles3 metal d3d11_9x xbox360 xboxone ps3 ps4 psp2 
            #pragma target 3.0
            uniform float4 _TimeEditor;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _Intensity;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv0 : TEXCOORD1;
                float4 posWorld : TEXCOORD2;
                float4 vertexColor : COLOR;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.vertexColor = v.vertexColor;
                float4 node_1989 = _Time + _TimeEditor;
                float node_5131 = (sin(mul(unity_ObjectToWorld, v.vertex).r)*(_Intensity*((1.0 - o.uv0.g)*cos(node_1989.g))));
                v.vertex.xyz += (o.vertexColor.r*float3(node_5131,0.0,node_5131));
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos(v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                clip(_MainTex_var.a - 0.5);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    //CustomEditor "ShaderForgeMaterialInspector"
}
