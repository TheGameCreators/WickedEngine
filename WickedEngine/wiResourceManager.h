#pragma once
#include "CommonInclude.h"
#include "wiGraphicsDevice.h"
#include "wiAudio.h"

#include <memory>
#include <mutex>
#include <unordered_map>

struct wiResource
{
	union
	{
		const void* data = nullptr;
		const wiGraphics::Texture* texture;
		const wiAudio::Sound* sound;
	};

	enum DATA_TYPE
	{
		EMPTY,
		IMAGE,
		SOUND,
	} type = EMPTY;

	~wiResource();
};

namespace wiResourceManager
{
	enum FLAGS
	{
		EMPTY = 0,
		IMPORT_COLORGRADINGLUT = 1 << 0,
	};

#ifdef GGREDUCED
	// Extra Error Info
	void SetErrorCode(int iCode);
	int GetErrorCode(void);
#endif

	// Load a resource
	std::shared_ptr<wiResource> Load(const std::string& name, uint32_t flags = EMPTY);
#ifdef GGREDUCED
	// Free a previously loaded resource
	void FreeResource(const std::string& name);
#endif
	// Check if a resource is currently loaded
	bool Contains(const std::string& name);
	// Register a pre-created resource
	std::shared_ptr<wiResource> Register(const std::string& name, void* data, wiResource::DATA_TYPE data_type);
	// Invalidate all resources
	void Clear();
};
