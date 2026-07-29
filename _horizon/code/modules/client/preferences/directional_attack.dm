/// Boundary for how many z levels down to render properly before we start going cheapo mode
/datum/preference/numeric/directional_attack
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	savefile_key = "directional_attack"
	savefile_identifier = PREFERENCE_PLAYER

/datum/preference/toggle/directional_attack/apply_to_client(client/client, value)
	client?.directional_attack = value

