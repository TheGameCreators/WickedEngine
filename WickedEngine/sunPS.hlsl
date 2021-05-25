#include "objectHF.hlsli"
#include "globals.hlsli"
#include "skyHF.hlsli"

float4 main(float4 pos : SV_POSITION, float2 clipspace : TEXCOORD) : SV_TARGET
{
	float4 unprojected = mul(g_xCamera_InvP, float4(clipspace, 1.0f, 1.0f));
	unprojected.xyz /= unprojected.w;

	float3x3 InvView3 = (float3x3) g_xCamera_InvV;
	float3 direction = mul( InvView3, unprojected.xyz );
	direction = normalize( direction );

	return float4(GetDynamicSkyColor(direction, true, false, true), 1);
}
