#include "globals.hlsli"
#include "impostorHF.hlsli"

struct OutputPrepass
{
	float4 velocity : SV_TARGET0;
	uint   readback : SV_TARGET1;  // virtual texture read back
};

OutputPrepass main(VSOut input)
{
	clip(dither(input.pos.xy + GetTemporalAASampleRotation()) - input.dither);
	float3 uv_col = input.tex;
	clip(impostorTex.Sample(sampler_linear_clamp, uv_col).a - 0.5f);

	const float2 pixel = input.pos.xy;
	const float2 ScreenCoord = pixel * g_xFrame_InternalResolution_rcp;

	float2 pos2D = ScreenCoord * 2 - 1;
	pos2D.y *= -1;
	input.pos2DPrev.xy /= input.pos2DPrev.w;
	const float2 velocity = ((input.pos2DPrev.xy - g_xFrame_TemporalAAJitterPrev) - (pos2D.xy - g_xFrame_TemporalAAJitter)) * float2(0.5, -0.5);

	OutputPrepass output;
	output.velocity = float4(velocity, 0, 0); /*FORMAT_R16G16_FLOAT*/
	output.readback = 0;
	return output;
}
