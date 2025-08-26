/datum/job/forestguard
	title = "Forest Guard"
	tutorial = "You've been keeping the streets clean of neer-do-wells and taffers for most of your time in the garrison.\
	You've been through the wringer - alongside soldiers in the short-lived Goblin Wars. \
	The Wars were rough, the few who survived came back changed. Perhaps you'd agree. \
	\
	\n\n\
	A fellow soldier had been given the title of Forest Warden for their valorant efforts \
	and they've plucked you from one dangerous position into another. \
	Atleast with your battle-family by your side, you will never die alone."
	department_flag = GARRISON
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_FORGUARD
	faction = FACTION_TOWN
	total_positions = 4
	spawn_positions = 4
	min_pq = 5
	bypass_lastclass = TRUE
	selection_color = "#0d6929"

	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD, AGE_IMMORTAL, AGE_CHILD)
	allowed_races = RACES_PLAYER_GUARD
	give_bank_account = 30
	can_have_apprentices = FALSE
	cmode_music = 'sound/music/cmode/garrison/CombatForestGarrison.ogg'

	outfit = /datum/outfit/job/forestguard
	advclass_cat_rolls = list(CTAG_FORGARRISON = 20)


/datum/outfit/job/forestguard
	job_bitflag = BITFLAG_GARRISON

/datum/outfit/job/forestguard/pre_equip(mob/living/carbon/human/H)
	..()
	if(SSmapping.config.map_name == "Rosewood")
		cloak = /obj/item/clothing/cloak/forrestercloak/snow
	else
		cloak = /obj/item/clothing/cloak/forrestercloak
	shirt = /obj/item/clothing/shirt/undershirt/colored/black
	pants = /obj/item/clothing/pants/trou/leather
	shoes = /obj/item/clothing/shoes/boots
	wrists = /obj/item/clothing/wrists/bracers/leather
	gloves = /obj/item/clothing/gloves/leather
	belt = /obj/item/storage/belt/leather/fgarrison
	backl = /obj/item/storage/backpack/satchel

/datum/job/forestguard/after_spawn(mob/living/carbon/spawned, client/player_client)
	..()

// Ravager, whips, flails, axes and swords and shields.
/datum/advclass/forestguard/infantry
	name = "Forest Ravager"
	tutorial = "In the goblin wars- you alone were deployed to the front lines, caving skulls and chopping legs - saving your family-at-arms through your reckless diversions. \ With your bloodied axe and flail, every swing and crack was another hatch on your tally. Now that the War's over, even with your indomitable spirit and tireless zeal - let's see if that still rings true."
	outfit = /datum/outfit/job/forestguard/infantry
	category_tags = list(CTAG_FORGARRISON)
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD, AGE_IMMORTAL)

/datum/outfit/job/forestguard/infantry/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/helmet/medium/decorated/skullmet
	neck = /obj/item/clothing/neck/gorget
	beltl = /obj/item/weapon/flail/militia
	beltr = /obj/item/weapon/axe/iron
	armor = /obj/item/clothing/armor/leather/advanced/forrester
	backr = /obj/item/weapon/shield/heater
	backpack_contents = list(/obj/item/weapon/knife/hunting = 1, /obj/item/rope/chain = 1, /obj/item/storage/belt/pouch/coins/poor)
	H.verbs |= /mob/proc/haltyell


	H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/lumberjacking, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.change_stat(STATKEY_STR, 2)
	H.change_stat(STATKEY_END, 3)
	H.change_stat(STATKEY_CON, 3)
	H.change_stat(STATKEY_SPD, -1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC) //Should help Ravagers be more survivable compared to reavers.
	ADD_TRAIT(H, TRAIT_FORAGER, TRAIT_GENERIC)

// Ranger, bows and knives
/datum/advclass/forestguard/ranger
	name = "Forest Ranger"
	tutorial = "In the Wars you were always one of the fastest, aswell as one of the frailest in the platoon. \ Your trusty bow has served you well- of course, none you've set your sights on have found the tongue to disagree."
	outfit = /datum/outfit/job/forestguard/ranger
	category_tags = list(CTAG_FORGARRISON)
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD, AGE_IMMORTAL)

/datum/outfit/job/forestguard/ranger/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/helmet/medium/decorated/skullmet
	neck = /obj/item/clothing/neck/gorget
	beltl = /obj/item/weapon/knife/cleaver/combat
	beltr = /obj/item/ammo_holder/quiver/arrows
	armor = /obj/item/clothing/armor/leather/advanced/forrester
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/long
	backpack_contents = list(/obj/item/weapon/knife/hunting = 1, /obj/item/rope/chain = 1, /obj/item/storage/belt/pouch/coins/poor)
	H.verbs |= /mob/proc/haltyell
	if(H.mind)
		H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.adjust_skillrank(/datum/skill/labor/lumberjacking, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
		H.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.change_stat(STATKEY_STR, -2)
		H.change_stat(STATKEY_END, 1)
		H.change_stat(STATKEY_PER, 2)
		H.change_stat(STATKEY_SPD, 3)
		ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_FORAGER, TRAIT_GENERIC)

// Reaver, Axes and Maces
/datum/advclass/forestguard/reaver
	name = "Forest Reaver"
	tutorial = "In the Wars you took an oath to never shy from a hit. Axe in hand, thirsting for blood, you simply enjoy the <i>chaos of battle...</i>"
	outfit = /datum/outfit/job/forestguard/reaver
	category_tags = list(CTAG_FORGARRISON)
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD, AGE_IMMORTAL)

/datum/outfit/job/forestguard/reaver/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/helmet/medium/decorated/skullmet
	neck = /obj/item/clothing/neck/gorget
	beltl = /obj/item/weapon/mace/steel/morningstar
	armor = /obj/item/clothing/armor/leather/advanced/forrester
	backr = /obj/item/weapon/polearm/halberd/bardiche/woodcutter
	beltr = /obj/item/weapon/axe/iron
	backpack_contents = list(/obj/item/weapon/knife/hunting = 1, /obj/item/rope/chain = 1, /obj/item/storage/belt/pouch/coins/poor)
	H.verbs |= /mob/proc/haltyell
	if(H.mind)
		H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.adjust_skillrank(/datum/skill/labor/lumberjacking, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)

		H.change_stat(STATKEY_STR, 2)
		H.change_stat(STATKEY_CON, 2)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_SPD, 1)
		ADD_TRAIT(H, TRAIT_DUALWIELDER, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOPAINSTUN, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_FORAGER, TRAIT_GENERIC)

// Ruffian, knives, bows and a lot of cooking.
/datum/advclass/forestguard/ruffian
	name = "Forest Ruffian"
	tutorial = "For your terrible orphan pranks and antics in the city, you were rounded up by the city's Watch and put to work in the infamous forest garrison. \n\n A ruffian by circumstance, a proven listener of war stories - you might just become more than a troublemaker."
	outfit = /datum/outfit/job/forestguard/ruffian
	category_tags = list(CTAG_FORGARRISON)
	allowed_ages = list(AGE_CHILD)

/datum/outfit/job/forestguard/ruffian/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/helmet/medium/decorated/skullmet //placeholder, I have to sprite something new for the Brats, like a gator skull
	neck = /obj/item/clothing/neck/gorget
	beltl = /obj/item/weapon/knife/cleaver/combat
	beltr = /obj/item/ammo_holder/quiver/arrows
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow //placeholder, going to give them a slingshot in another PR later
	armor = /obj/item/clothing/armor/leather
	backpack_contents = list(/obj/item/weapon/knife/hunting = 1, /obj/item/cooking/pan = 1, /obj/item/reagent_containers/food/snacks/egg = 1)
	H.verbs |= /mob/proc/haltyellorphan //pitch shifted for the lols

	if(H.mind) //if you want your ruffians to have combat skills, take them up as apprentices
		//otherwise, mix of orphan and ranger skills, with some labour skills to imply housework
		H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE) //considering master climbing, I can make another youngling subclass for such
		H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
		H.adjust_skillrank(/datum/skill/craft/carpentry, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.adjust_skillrank(/datum/skill/labor/butchering, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/crossbows, 1, TRUE) //weak fuck
		H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
		H.change_stat(STATKEY_STR, rand(-2,1)) //broadly conscripted street urchins, randomization keeps them from being too powerful/consistent
		H.change_stat(STATKEY_INT, round(rand(-2,2)))
		H.change_stat(STATKEY_CON, -1)
		ADD_TRAIT(H, TRAIT_FORAGER, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_ORPHAN, TRAIT_GENERIC) //someone please abuse this

/mob/proc/haltyellorphan()
	set name = "HALT!"
	set category = "Noises"
	emote("haltyellorphan")
