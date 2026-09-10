GLOBAL_LIST_INIT(used_sound_channels, list(
	CHANNEL_MASTER_VOLUME,
	CHANNEL_SOUND_EFFECTS,
	CHANNEL_AMBIENCE,
	CHANNEL_WEATHER,
	CHANNEL_MACHINERY,
	CHANNEL_FOOTSTEPS,
	CHANNEL_MOB_SOUNDS,
	CHANNEL_MOB_EMOTES,
	CHANNEL_VOICES,
	CHANNEL_SHUTTLES,
	CHANNEL_UI,
	CHANNEL_RINGTONES,
	CHANNEL_VOX,
	CHANNEL_ANNOUNCEMENTS,
	CHANNEL_HEARTBEAT,
	CHANNEL_LOBBYMUSIC,
	CHANNEL_EVENT_MUSIC,
	CHANNEL_JUKEBOX,
	CHANNEL_INSTRUMENTS,
	CHANNEL_ADMIN,
	CHANNEL_ADMIN_SOUNDS,
))

GLOBAL_LIST_INIT(proxy_sound_channels, list(
	CHANNEL_SOUND_EFFECTS,
	CHANNEL_FOOTSTEPS,
	CHANNEL_WEATHER,
	CHANNEL_MACHINERY,
	CHANNEL_INSTRUMENTS,
	CHANNEL_MOB_SOUNDS,
	CHANNEL_MOB_EMOTES,
	CHANNEL_VOICES,
	CHANNEL_ADMIN_SOUNDS,
	CHANNEL_SHUTTLES,
))

GLOBAL_DATUM_INIT(cached_mixer_channels, /alist, alist())

/proc/guess_mixer_channel(soundin)
	var/sound_text_string
	if(istype(soundin, /sound))
		var/sound/bleh = soundin
		sound_text_string = "[bleh.file]"
	else
		sound_text_string = "[soundin]"
	if(GLOB.cached_mixer_channels[sound_text_string])
		return GLOB.cached_mixer_channels[sound_text_string]
	else if(findtext(sound_text_string, "effects/"))
		. = GLOB.cached_mixer_channels[sound_text_string] = CHANNEL_SOUND_EFFECTS
	else if(findtext(sound_text_string, "machines/"))
		. = GLOB.cached_mixer_channels[sound_text_string] = CHANNEL_MACHINERY
	else if(findtext(sound_text_string, "creatures/"))
		. = GLOB.cached_mixer_channels[sound_text_string] = CHANNEL_MOB_SOUNDS
	else if(findtext(sound_text_string, "announcer/"))
		. = GLOB.cached_mixer_channels[sound_text_string] = CHANNEL_VOX
	else if(findtext(sound_text_string, "ai/"))
		// . = GLOB.cached_mixer_channels[sound_text_string] = CHANNEL_STORYTELLER
		WARNING("'guess_mixer_channel() == /ai' paased and not changed")
	else if(findtext(sound_text_string, "chatter/"))
		. = GLOB.cached_mixer_channels[sound_text_string] = CHANNEL_VOICES
	else if(findtext(sound_text_string, "items/"))
		. = GLOB.cached_mixer_channels[sound_text_string] = CHANNEL_SOUND_EFFECTS
	else if(findtext(sound_text_string, "weapons/"))
		. = GLOB.cached_mixer_channels[sound_text_string] = CHANNEL_SOUND_EFFECTS
	else if(findtext(sound_text_string, "hyperspace/"))
		. = GLOB.cached_mixer_channels[sound_text_string] = CHANNEL_SHUTTLES
	else
		return FALSE

// Channel -> category
GLOBAL_LIST_INIT(channel_to_category, init_channel_categories())

/proc/init_channel_categories()
	var/list/map = list()
	for(var/channel in GLOB.used_sound_channels)
		var/list/info = get_channel_info(channel)
		if(length(info) >= 3)
			map["[channel]"] = info[3]
	return map

/// Calculates the "adjusted" volume for a user's volume mixer (3 layers: Master -> Category -> Channel)
/proc/calculate_mixed_volume(client/client, volume, mixer_channel)
	. = volume
	var/datum/preferences/prefs = client?.prefs
	if(isnull(prefs))
		return .

	var/list/channels = prefs.channel_volume
	var/channel_key = "[mixer_channel]"

	. *= channels["[CHANNEL_MASTER_VOLUME]"] * 0.01

	if(isnull(mixer_channel) || !(channel_key in channels))
		return .

	. *= channels[channel_key] * 0.01

	if(mixer_channel != CHANNEL_MASTER_VOLUME)
		var/category = GLOB.channel_to_category[channel_key]
		if(!isnull(category))
			var/cat_vol = prefs.category_volume[category]
			if(!isnull(cat_vol))
				. *= cat_vol * 0.01
