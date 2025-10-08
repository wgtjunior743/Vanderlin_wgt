/datum/job/adept
	title = "Adept"
	tutorial = "You were a convicted criminal, the lowest scum of Vanderlin. \
	Your master, the Inquisitor, saved you from the gallows \
	and has given you true purpose in service to Psydon. \
	You will not let him down."
	department_flag = CHURCHMEN
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_SHEPHERD
	faction = FACTION_TOWN
	total_positions = 3
	spawn_positions = 3
	min_pq = 5
	bypass_lastclass = TRUE

	allowed_races = RACES_PLAYER_ALL

	outfit = /datum/outfit/adept
	advclass_cat_rolls = list(CTAG_ADEPT = 20)
	can_have_apprentices = FALSE
	is_foreigner = TRUE

	job_bitflag = BITFLAG_CHURCH

/datum/outfit/adept // Base outfit for Adepts, before loadouts
	name = "Adept"
	shoes = /obj/item/clothing/shoes/boots
	mask = /obj/item/clothing/face/facemask/silver
	beltr = /obj/item/storage/belt/pouch/coins/poor
	pants = /obj/item/clothing/pants/trou/leather
	shirt = /obj/item/clothing/armor/gambeson/light/colored/black
	wrists = /obj/item/clothing/neck/psycross/silver

// Brutal Zealot, a class balanced to town guard, with noticeably more strength but less intelligence and perception. Axe/Mace and shield focus.
/datum/job/advclass/adept/bzealot
	title = "Brutal Zealot"
	tutorial = "You are a former thug who has been given a chance to redeem yourself by the Inquisitor. You serve him and Psydon with your physical strength and zeal."
	outfit = /datum/outfit/adept/bzealot

	category_tags = list(CTAG_ADEPT)
	cmode_music = 'sound/music/cmode/church/CombatInquisitor.ogg'

/datum/outfit/adept/bzealot/pre_equip(mob/living/carbon/human/H)
	..()
	//Armor for class
	belt = /obj/item/storage/belt/leather
	head = /obj/item/clothing/head/adeptcowl
	neck = /obj/item/clothing/neck/chaincoif
	armor = /obj/item/clothing/armor/chainmail
	cloak = /obj/item/clothing/cloak/tabard/adept
	beltl = /obj/item/weapon/mace/spiked
	backr = /obj/item/weapon/shield/wood/adept
	gloves = /obj/item/clothing/gloves/leather
	backpack_contents = list(/obj/item/storage/keyring/adept = 1, /obj/item/weapon/knife/dagger/silver/psydon = 1)

	//Stats for class
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/firearms, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.change_stat(STATKEY_STR, 3)
	H.change_stat(STATKEY_INT, -2)
	H.change_stat(STATKEY_PER, -2)
	H.change_stat(STATKEY_END, 1)
	H.change_stat(STATKEY_CON, 1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
	if(H.dna?.species)
		H.dna.species.soundpack_m = new /datum/voicepack/male/warrior() // Lunkhead.


// Reformed Thief, a class balanced to rogue. Axe and crossbow focus.
/datum/job/advclass/adept/rthief
	title = "Reformed Thief"
	tutorial = "You are a former thief who has been given a chance to redeem yourself by the Inquisitor. You serve him and Psydon with your stealth and cunning."
	outfit = /datum/outfit/adept/rthief

	category_tags = list(CTAG_ADEPT)
	cmode_music = 'sound/music/cmode/adventurer/CombatRogue.ogg'

/datum/outfit/adept/rthief/pre_equip(mob/living/carbon/human/H)
	..()
	//Armor for class
	belt = /obj/item/storage/belt/leather
	armor = /obj/item/clothing/armor/leather/splint
	head = /obj/item/clothing/head/adeptcowl
	neck = /obj/item/clothing/neck/gorget
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
	backl = /obj/item/ammo_holder/quiver/arrows
	beltl = /obj/item/weapon/mace/cudgel
	pants = /obj/item/clothing/pants/trou/leather
	cloak = /obj/item/clothing/cloak/shredded
	backpack_contents = list(/obj/item/lockpick = 1, /obj/item/storage/keyring/adept = 1, /obj/item/weapon/knife/dagger/silver/psydon = 1)

	//Stats for class
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/stealing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/firearms, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE)
	H.change_stat(STATKEY_STR, -1)
	H.change_stat(STATKEY_END, 1)
	H.change_stat(STATKEY_PER, 1)
	H.change_stat(STATKEY_SPD, 2)
	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
	H.grant_language(/datum/language/thievescant)
	to_chat(H, span_info("I can gesture in thieves' cant with ,t before my speech."))

// Vile Highwayman. Your run of the mill swordsman, albeit fancy, smarter than the other two so he has some non combat related skills.
/datum/job/advclass/adept/highwayman
	title = "Vile Renegade"
	tutorial = "You were a former outlaw who has been given a chance to redeem yourself by the Inquisitor. You serve him and Psydon with your survival skills."
	outfit = /datum/outfit/adept/highwayman

	category_tags = list(CTAG_ADEPT)
	cmode_music = 'sound/music/cmode/towner/CombatGaffer.ogg'

/datum/outfit/adept/highwayman/pre_equip(mob/living/carbon/human/H)
	..()
	//Armor for class
	belt = /obj/item/storage/belt/leather
	armor = /obj/item/clothing/armor/leather/jacket/leathercoat/renegade
	head = /obj/item/clothing/head/helmet/leather/tricorn
	neck = /obj/item/clothing/neck/highcollier/iron/renegadecollar
	beltl =  /obj/item/weapon/sword/short
	l_hand = /obj/item/weapon/whip // Great length, they don't need to be next to a person to help in apprehending them.
	pants = /obj/item/clothing/pants/trou/leather
	backpack_contents = list(/obj/item/storage/keyring/adept = 1, /obj/item/weapon/knife/dagger/silver/psydon = 1)

	//Stats for class
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE) // Try to stablize more heretics for questioning.
	H.adjust_skillrank(/datum/skill/labor/mathematics, 2, TRUE) // Smart... For a knave.
	H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/firearms, 1, TRUE)
	H.change_stat(STATKEY_PER, 1)
	H.change_stat(STATKEY_INT, 2)
	H.change_stat(STATKEY_SPD, 1)
	H.change_stat(STATKEY_CON, -1)
	ADD_TRAIT(H, TRAIT_FORAGER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
	if(H.dna?.species)
		H.dna.species.soundpack_m = new /datum/voicepack/male/knight() // We're going with gentleman-thief here.


/datum/outfit/adept/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		if(H.mind.has_antag_datum(/datum/antagonist))
			return
		var/datum/antagonist/new_antag = new /datum/antagonist/purishep()
		H.mind.add_antag_datum(new_antag)
		H.set_patron(/datum/patron/psydon, TRUE)
		H.verbs |= /mob/living/carbon/human/proc/torture_victim
		H.verbs |= /mob/living/carbon/human/proc/faith_test
		if(!H.has_language(/datum/language/oldpsydonic))
			H.grant_language(/datum/language/oldpsydonic)
			to_chat(H, span_info("I can speak Old Psydonic with ,m before my speech."))
		H.mind.teach_crafting_recipe(/datum/repeatable_crafting_recipe/reading/confessional)
