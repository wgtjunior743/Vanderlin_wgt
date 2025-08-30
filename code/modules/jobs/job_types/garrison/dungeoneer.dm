/datum/job/dungeoneer
	title = "Dungeoneer"
	tutorial = "Be you an instrument of sadism for the King or the guarantor of his merciful hospitality, \
	your duties are a service paid for most handsomely. \
	Perhaps you were promoted from the garrison down to these cells \
	to get your brutality off the town streets where cracked skulls caused outcries, \
	or maybe your soft-hearted lord wanted to be sure his justice was done without malice. \
	In either case, your little world is the lowest office in the Realm; from it your guests see only hell."
	department_flag = GARRISON
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_DUNGEONEER
	faction = FACTION_TOWN
	total_positions = 1
	spawn_positions = 1
	min_pq = 10

	allowed_races = RACES_PLAYER_NONEXOTIC

	outfit = /datum/outfit/job/dungeoneer
	give_bank_account = 50

	cmode_music = 'sound/music/cmode/nobility/CombatDungeoneer.ogg'

/datum/outfit/job/dungeoneer
	job_bitflag = BITFLAG_GARRISON

/datum/outfit/job/dungeoneer/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/menacing
	neck = /obj/item/storage/belt/pouch/coins/poor	// Small storage. N.
	pants = /obj/item/clothing/pants/trou
	shoes = /obj/item/clothing/shoes/simpleshoes
	wrists = /obj/item/clothing/wrists/bracers/leather
	cloak = /obj/item/clothing/cloak/stabard/dungeon
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/weapon/whip/antique
	beltl = /obj/item/storage/keyring/dungeoneer
	backr = /obj/item/storage/backpack/satchel	// lack of satchel requires dealing with the merchant to correct, which requires entering town; not ideal. N.


	H.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE) // Allow reading notes passed to the literate noble prisoner, or writing reports. N. See peasants\prisoner.dm.
	H.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/traps, 3, TRUE)
	H.change_stat(STATKEY_STR, 2)
	H.change_stat(STATKEY_INT, -2)
	H.change_stat(STATKEY_END, 2)
	H.change_stat(STATKEY_CON, 1)
	H.change_stat(STATKEY_SPD, -1)
	H.change_stat(STATKEY_PER, -1)
	if(H.dna?.species)
		if(H.dna.species.id == SPEC_ID_HUMEN)
			H.dna.species.soundpack_m = new /datum/voicepack/male/warrior()
	H.verbs |= /mob/living/carbon/human/proc/torture_victim
