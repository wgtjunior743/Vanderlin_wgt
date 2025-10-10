/datum/job/noc_inquisitor
	title = "Noc Inquisitor"
	tutorial = "Yeah"
	department_flag = CHURCHMEN
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_PURITAN
	faction = FACTION_TOWN
	total_positions = 1
	spawn_positions = 1
	min_pq = 15
	bypass_lastclass = TRUE

	allowed_races = list(SPEC_ID_HUMEN)

	outfit = /datum/outfit/inquisitor
	is_foreigner = TRUE
	is_recognized = TRUE
	antag_role = /datum/antagonist/purishep
	cmode_music = 'sound/music/cmode/church/CombatInquisitor.ogg'

	job_bitflag = BITFLAG_CHURCH

/datum/outfit/noc_inquisitor
	name = "Inquisitor"

/datum/outfit/inquisitor/pre_equip(mob/living/carbon/human/H)
	..()
	shirt = /obj/item/clothing/armor/gambeson/heavy/colored/dark
	belt = /obj/item/storage/belt/leather/black
	shoes = /obj/item/clothing/shoes/otavan/inqboots
	pants = /obj/item/clothing/pants/trou/leather
	cloak = /obj/item/clothing/cloak/cape/inquisitor
	head = /obj/item/clothing/head/leather/inqhat
	gloves = /obj/item/clothing/gloves/leather/otavan/inqgloves
	wrists = /obj/item/clothing/neck/psycross/silver
	backr = /obj/item/storage/backpack/satchel
	backl = /obj/item/weapon/sword/long/forgotten
	beltl = /obj/item/flashlight/flare/torch/lantern
	neck = /obj/item/clothing/neck/bevor
	mask = /obj/item/clothing/face/spectacles/inqglasses
	armor = /obj/item/clothing/armor/medium/scale/inqcoat
	backpack_contents = list(/obj/item/storage/keyring/inquisitor = 1, /obj/item/storage/belt/pouch/coins/rich = 1)
	var/prev_real_name = H.real_name
	var/prev_name = H.name
	var/honorary = "Ritter"
	if(H.gender == FEMALE)
		honorary = "Ritterin"
	H.real_name = "[honorary] [prev_real_name]"
	H.name = "[honorary] [prev_name]"
	H.confession_points = 10 // Starting with 10 points
	H.purchase_history = list() // Initialize as an empty list to track purchases

	H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/firearms, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
	H.change_stat(STATKEY_INT, 2)
	H.change_stat(STATKEY_STR, 1)
	H.change_stat(STATKEY_PER, 2)
	H.change_stat(STATKEY_SPD, 2)
	H.change_stat(STATKEY_END, 1)
	if(!H.has_language(/datum/language/oldpsydonic))
		H.grant_language(/datum/language/oldpsydonic)
	if(H.mind?.has_antag_datum(/datum/antagonist))
		return
	var/datum/antagonist/new_antag = new /datum/antagonist/purishep()
	H.mind?.add_antag_datum(new_antag)
	H.set_patron(/datum/patron/psydon)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC) //his gear is medium, he needs this to dodge well
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
	H.verbs |= /mob/living/carbon/human/proc/torture_victim
	H.verbs |= /mob/living/carbon/human/proc/faith_test
	to_chat(H,span_info("\
		-I can speak Old Psydonic with ,m before my speech.\n\
		-The Holy Bishop of the Inquisition has sent you here on a task to root out evil within this town. Make The Holy Bishop proud!\n\
		-You've also been gaven 10 favors to use at the mail machines, you can get more favor by sending signed confessions to The Holy Bishop. Spend your favors wisely.")
		)
	H.mind?.teach_crafting_recipe(/datum/repeatable_crafting_recipe/reading/confessional)
	if(H.dna?.species.id == SPEC_ID_HUMEN)
		H.dna.species.native_language = "Old Psydonic"
		H.dna.species.accent_language = H.dna.species.get_accent(H.dna.species.native_language)
