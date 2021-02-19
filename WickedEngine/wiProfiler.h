#pragma once
#include "wiGraphicsDevice.h"

#include <string>

namespace wiProfiler
{
	typedef size_t range_id;

	// Begin collecting profiling data for the current frame
	void BeginFrame();

	// Finalize collecting profiling data for the current frame
	void EndFrame(wiGraphics::CommandList cmd);

	// Start a CPU profiling range
	range_id BeginRangeCPU(const char* name);

	// Start a GPU profiling range
	range_id BeginRangeGPU(const char* name, wiGraphics::CommandList cmd);

	// End a profiling range
	void EndRange(range_id id);

	// Renders a basic text of the Profiling results to the (x,y) screen coordinate
	void DrawData(float x, float y, wiGraphics::CommandList cmd);

#ifdef GGREDUCED
	std::string GetProfilerData(void);
	void CountPolygons(int iPoly);
	void CountDrawCalls(void);
	int GetPolygons(void);
	int GetDrawCalls(void);
	void CountDrawCallsShadows(void);
	int GetDrawCallsShadows(void);
	void CountDrawCallsTransparent(void);
	int GetDrawCallsTransparent(void);
#endif

	// Enable/disable profiling
	void SetEnabled(bool value);

	bool IsEnabled();
};

