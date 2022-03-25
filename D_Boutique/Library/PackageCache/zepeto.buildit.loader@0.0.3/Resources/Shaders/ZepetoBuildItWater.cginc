struct VertexInput {
	float2 uv : TEXCOORD0;
	float4 vertex : POSITION;
	float3 normal : NORMAL;
};

struct VertexOutput {
	float4 pos : SV_POSITION;
	float2 uv : TEXCOORD0;
	fixed4 diff : COLOR0;
	float4 posWorld : TEXCOORD2;
	float3 normalDir : TEXCOORD3;
	float4 projPos : TEXCOORD4;
};

uniform sampler2D _CameraDepthTexture;
sampler2D _MainTex;
uniform sampler2D _AlphaTex;
uniform half _Gradient2;
uniform half4 _Color1;
uniform half4 _Color2;
uniform half _MainFoamIntensity;
uniform half _MainFoamScale;
uniform half _FoamSpeed;
uniform half _LightIntensity;
uniform half4 _Color0;
uniform half _Gradient1;
uniform sampler2D _WaterTexture; uniform float4 _WaterTexture_ST;
uniform half _MainFoamOpacity;
uniform half _SecondaryFoamIntensity;
uniform half _SecondaryFoamScale;
uniform half _SecondaryFoamOpacity;
uniform half4 _FresnelColor;
uniform half _FresnelExp;

VertexOutput waterVertex(VertexInput v) {
	VertexOutput o = (VertexOutput)0;

	o.uv = v.uv;
	o.normalDir = UnityObjectToWorldNormal(v.normal);
	o.posWorld = mul(unity_ObjectToWorld, v.vertex);
	o.pos = UnityObjectToClipPos(v.vertex);
	o.projPos = ComputeScreenPos(o.pos);

	COMPUTE_EYEDEPTH(o.projPos.z);

	half3 worldNormal = UnityObjectToWorldNormal(v.normal);
	half nl = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz));
	o.diff = nl * _LightColor0;
	o.diff.rgb += ShadeSH9(half4(worldNormal, 1));

	return o;
}

half3 waterFragment(VertexOutput i) {
	i.normalDir = normalize(i.normalDir);

	half3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
	half3 normalDirection = i.normalDir;
	half sceneZ = max(0, LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos)))) - _ProjectionParams.g);
	half partZ = max(0, i.projPos.z - _ProjectionParams.g);

	half4 node_2892 = _Time;
	half2 node_2122 = ((i.uv*_MainFoamScale) + node_2892.g*float2(0.02, 0.02));
	half4 node_2913 = tex2D(_WaterTexture, TRANSFORM_TEX(node_2122, _WaterTexture));
	half2 node_6407 = ((i.uv*_SecondaryFoamScale) + node_2892.g*float2(-0.01*_FoamSpeed, -0.01*_FoamSpeed));
	half4 node_5766 = tex2D(_WaterTexture, TRANSFORM_TEX(node_6407, _WaterTexture));
	half3 emissive = (((_MainFoamOpacity*(1.0 - saturate((sceneZ - partZ) / ((0.2*_MainFoamIntensity) + pow((_MainFoamIntensity*node_2913.r), 2.0))))) + lerp((_SecondaryFoamOpacity*pow(node_5766.r, 2.0)), 0.0, saturate((sceneZ - partZ) / _SecondaryFoamIntensity))) + lerp(lerp(lerp(_Color0.rgb, _Color1.rgb, saturate((sceneZ - partZ) / _Gradient1)), _Color2.rgb, saturate((sceneZ - partZ) / _Gradient2)), _FresnelColor.rgb, pow(1.0 - max(0, dot(normalDirection, viewDirection)), _FresnelExp)));
	half3 finalColor = emissive;

	finalColor *= i.diff * _LightIntensity;

	return finalColor;
}