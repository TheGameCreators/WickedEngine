#include "objectHF.hlsli"
#include "skyHF.hlsli"

float4 main(float4 pos : SV_POSITION, float2 clipspace : TEXCOORD) : SV_TARGET
{
	// avoid CameraPos since it introduces floating point inaccuracies
	// use Z=1.0 to get a vector to the near plane rather than the far plane (might be infinite)
	float4 unprojected = mul(g_xCamera_InvP, float4(clipspace, 1.0f, 1.0f));
	unprojected.xyz /= unprojected.w;

	float3x3 InvView3 = (float3x3) g_xCamera_InvV;
	float3 V = mul( InvView3, unprojected.xyz );
	V = normalize( V );
	
	float4 color = float4(GetDynamicSkyColor(V), 1);

	return color;
}
