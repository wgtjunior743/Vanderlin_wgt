/datum/migrant_role
	abstract_type = /datum/migrant_role
	/// Name of the role
	var/name = "MIGRANT ROLE"
	/// Restricts species if the list is not null
	var/list/allowed_races
	/// Restricts sexes if list is not null
	var/list/allowed_sexes
	/// Restricts ages if list is not null
	var/list/allowed_ages = ALL_AGES_LIST
	/// Typepath of outfit for the migrant role
	var/outfit
	/// Typepath of the antag datum for the migrant role
	var/antag_datum
	/// If defined they'll get adv class rolls
	var/list/advclass_cat_rolls
	/// Text to greet player of this role in the wave
	var/greet_text
	/// Whether to grant a lit torch upon spawn
	var/grant_lit_torch = FALSE
	/// Whether to show them as foreigners
	var/is_foreigner = TRUE // Hide their title, show them as a foreigner
	var/is_recognized = FALSE // Show their title even as a foreigner.
	var/advjob_examine = TRUE
	var/banned_leprosy = TRUE
	var/banned_lunatic = TRUE

/datum/migrant_role/proc/after_spawn(mob/living/carbon/human/character)
	if(is_foreigner)
		ADD_TRAIT(character, TRAIT_FOREIGNER, TRAIT_GENERIC)
	if(is_recognized)
		ADD_TRAIT(character, TRAIT_RECOGNIZED, TRAIT_GENERIC)
	return

/datum/migrant_role/pilgrim
	name = "Pilgrim"
	banned_leprosy = FALSE
	advclass_cat_rolls = list(CTAG_PILGRIM = 10)

/datum/migrant_role/adventurer
	name = "Adventurer"
	advclass_cat_rolls = list(CTAG_ADVENTURER = 5)

/datum/migrant_role/bandit
	name = "Bandit"
	antag_datum = /datum/antagonist/bandit
	advclass_cat_rolls = list(CTAG_BANDIT = 20)
	grant_lit_torch = TRUE

/datum/migrant_role/mercenary
	name = "Mercenary"
	advclass_cat_rolls = list(CTAG_MERCENARY = 20)
	grant_lit_torch = TRUE

/datum/migrant_role/lich
	name = "Lich"
	antag_datum = /datum/antagonist/lich
