/datum/job/feldsher
	title = "Feldsher"
	tutorial = "You have seen countless wounds over your time. \
	Stitched the sores of blades, sealed honey over the bubous of plague. \
	A thousand deaths stolen from the Carriagemen, yet these people will still call you a charlatan. \
	At least the Apothecary understands you."
	department_flag = NOBLEMEN
	display_order = JDO_FELDSHER
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_TOWN
	total_positions = 2
	spawn_positions = 2
	min_pq = 2

	//Reason all races allowed is you are basically a very talented court physician; even 'lower races' would find this to be one of the only ways to obtain a sort of nobility.
	allowed_races = RACES_PLAYER_NONEXOTIC

	outfit = /datum/outfit/job/feldsher
	give_bank_account = 100
	cmode_music = 'sound/music/cmode/nobility/combat_physician.ogg'

	spells = list(
		/datum/action/cooldown/spell/diagnose,
	)

/datum/outfit/job/feldsher
	job_bitflag = BITFLAG_ROYALTY

/datum/outfit/job/feldsher/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/shortboots
	shirt = /obj/item/clothing/shirt/undershirt/colored/red
	backr = /obj/item/storage/backpack/satchel
	backl = /obj/item/storage/backpack/satchel/surgbag
	pants = /obj/item/clothing/pants/tights/colored/random
	gloves = /obj/item/clothing/gloves/leather/feld
	armor = /obj/item/clothing/shirt/robe/feld
	head = /obj/item/clothing/head/roguehood/feld
	mask = /obj/item/clothing/face/feld
	neck = /obj/item/clothing/neck/feld
	belt = /obj/item/storage/belt/leather
	beltl = /obj/item/storage/keyring/feldsher
	beltr = /obj/item/storage/belt/pouch

	H.adjust_skillrank(/datum/skill/combat/wrestling, pick(2,2,3), TRUE)//so he can hold down unruly patients
	H.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 5, TRUE)
	H.adjust_skillrank(/datum/skill/craft/alchemy, 3, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
	if(H.age == AGE_OLD)
		H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.change_stat(STATKEY_STR, -1)
	H.change_stat(STATKEY_INT, 4)
	H.change_stat(STATKEY_CON, -1)
	ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
