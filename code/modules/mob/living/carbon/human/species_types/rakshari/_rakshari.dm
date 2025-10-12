/mob/living/carbon/human/species/rakshari
	race = /datum/species/rakshari

/datum/species/rakshari
	name = "Rakshari"
	id = SPEC_ID_RAKSHARI
	changesource_flags = WABBAJACK
	native_language = "Zalad"

	desc = "Rakshari origins trace back to nomadic desert tribes, \
	whose survival in the harsh sands cultivated a culture steeped in resilience, cunning, and adaptability. \
	\n\n\
	Over centuries, the Rakshari united under the banners of powerful Zalad merchant-kings and warlords,\
	transforming their scattered clans into a dominant slaver force across the region. \
	They would often raid weaker settlements and rival caravans, \
	capturing slaves to fuel their expanding cities and economies. \
	Practice of this was justified through religious doctrines, \
	venerating strength and dominance as divine virtues. \
	\n\n\
	As they further attached themselves to Zaladin, however, \
	their people would integrate more sophisticated forms of servitude, \
	such as indentured contracts and debt bondage. \
	\n\n\
	THIS IS A DISCRIMINATED SPECIES. EXPECT A MORE DIFFICULT EXPERIENCE. PLAY AT YOUR OWN RISK."

	skin_tone_wording = "Tribal Identity"
	use_skintones = TRUE
	default_color = "FFFFFF"

	possible_ages = NORMAL_AGES_LIST_CHILD

	species_traits = list(EYECOLOR, OLDGREY)
	inherent_traits = list(TRAIT_NOMOBSWAP, TRAIT_KITTEN_MOM)

	specstats_m = list(STATKEY_STR = -2, STATKEY_PER = 2, STATKEY_INT = 0, STATKEY_CON = -2, STATKEY_END = 0, STATKEY_SPD = 2, STATKEY_LCK = 0)
	specstats_f = list(STATKEY_STR = -2, STATKEY_PER = 2, STATKEY_INT = 0, STATKEY_CON = -2, STATKEY_END = 0, STATKEY_SPD = 2, STATKEY_LCK = 0)

	limbs_icon_m = 'icons/roguetown/mob/bodies/m/rakshari.dmi'
	limbs_icon_f = 'icons/roguetown/mob/bodies/f/rakshari.dmi'
	child_icon = 'icons/roguetown/mob/bodies/c/child-rakshari.dmi'

	exotic_bloodtype = /datum/blood_type/human/rakshari

	offset_features_m = list(
		OFFSET_RING = list(0,0),\
		OFFSET_GLOVES = list(0,0),\
		OFFSET_WRISTS = list(0,0),\
		OFFSET_HANDS = list(0,0),\
		OFFSET_CLOAK = list(0,0),\
		OFFSET_FACEMASK = list(0,0),\
		OFFSET_HEAD = list(0,0),\
		OFFSET_FACE = list(0,0),\
		OFFSET_BELT = list(0,0),\
		OFFSET_BACK = list(0,0),\
		OFFSET_NECK = list(0,0),\
		OFFSET_MOUTH = list(0,0),\
		OFFSET_PANTS = list(0,0),\
		OFFSET_SHIRT = list(0,0),\
		OFFSET_ARMOR = list(0,0),\
		OFFSET_UNDIES = list(0,0),\
	)

	offset_features_f = list(
		OFFSET_RING = list(0,-1),\
		OFFSET_GLOVES = list(0,0),\
		OFFSET_WRISTS = list(0,0),\
		OFFSET_HANDS = list(0,0),\
		OFFSET_CLOAK = list(0,0),\
		OFFSET_FACEMASK = list(0,-1),\
		OFFSET_HEAD = list(0,-1),\
		OFFSET_FACE = list(0,0),\
		OFFSET_BELT = list(0,0),\
		OFFSET_BACK = list(0,-1),\
		OFFSET_NECK = list(0,-1),\
		OFFSET_MOUTH = list(0,-1),\
		OFFSET_PANTS = list(0,0),\
		OFFSET_SHIRT = list(0,0),\
		OFFSET_ARMOR = list(0,0),\
		OFFSET_UNDIES = list(0,0),\
	)
	organs = list(
		ORGAN_SLOT_BRAIN = /obj/item/organ/brain,
		ORGAN_SLOT_HEART = /obj/item/organ/heart,
		ORGAN_SLOT_LUNGS = /obj/item/organ/lungs,
		ORGAN_SLOT_EYES = /obj/item/organ/eyes,
		ORGAN_SLOT_EARS = /obj/item/organ/ears/rakshari,
		ORGAN_SLOT_TONGUE = /obj/item/organ/tongue,
		ORGAN_SLOT_LIVER = /obj/item/organ/liver,
		ORGAN_SLOT_STOMACH = /obj/item/organ/stomach,
		ORGAN_SLOT_APPENDIX = /obj/item/organ/appendix,
		ORGAN_SLOT_GUTS = /obj/item/organ/guts,
	)
	customizers = list(
		/datum/customizer/organ/eyes/humanoid,
		/datum/customizer/bodypart_feature/accessory,
		/datum/customizer/bodypart_feature/face_detail,
	)
	COOLDOWN_DECLARE(cat_meow_cooldown)

/datum/species/rakshari/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	RegisterSignal(C, COMSIG_MOB_SAY, PROC_REF(handle_speech))
	C.grant_language(/datum/language/common)
	C.grant_language(/datum/language/zalad)
	C.verbs += 	/mob/living/carbon/human/species/rakshari/verb/emote_meow
	C.verbs += 	/mob/living/carbon/human/species/rakshari/verb/emote_purr
	to_chat(C, "<span class='info'>I can speak Zalad with ,z before my speech.</span>")

/datum/species/rakshari/check_roundstart_eligible()
	return TRUE

/datum/species/rakshari/after_creation(mob/living/carbon/C)
	..()
	C.grant_language(/datum/language/common)
	C.grant_language(/datum/language/zalad)

/datum/species/rakshari/spec_life(mob/living/carbon/human/H)
	. = ..()
	if(prob(1) && !(H.rogue_sneaking))
		if(!COOLDOWN_FINISHED(src, cat_meow_cooldown))
			return
		var/emote = "meow"
		if(prob(15))
			emote = "purr"
		H.emote(emote, forced = TRUE)

		COOLDOWN_START(src, cat_meow_cooldown, 5 MINUTES)

/datum/species/rakshari/on_species_loss(mob/living/carbon/C)
	. = ..()
	UnregisterSignal(C, COMSIG_MOB_SAY)

/datum/species/rakshari/qualifies_for_rank(rank, list/features)
	return TRUE

/datum/species/rakshari/get_skin_list()
	return sortList(list(
		"Oasis Rakshari" = SKIN_COLOR_PLAIN_ELF, // - (White 2)
		"Mountain Rakshari" = SKIN_COLOR_MOUNTAIN_ELF, // - (White 3)
		"City Rakshari" = SKIN_COLOR_COASTAL_ELF, // - (White 4)
		"Desert Rakshari" = SKIN_COLOR_WOOD_ELF, // - (Mediterranean 1)
	))

