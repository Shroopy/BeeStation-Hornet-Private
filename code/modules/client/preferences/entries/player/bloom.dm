/datum/preference/numeric/bloom
	category = PREFERENCE_CATEGORY_GAME_PREFERENCES
	db_key = "bloom_amount"
	preference_type = PREFERENCE_PLAYER
	minimum = 0
	maximum = 100

/datum/preference/numeric/bloom/create_default_value()
	return round((ADDITIVE_LIGHTING_PLANE_ALPHA_NORMAL / 255) * 100)

/datum/preference/numeric/bloom/apply_to_client(client/client, value)
	client.mob?.update_sight()
