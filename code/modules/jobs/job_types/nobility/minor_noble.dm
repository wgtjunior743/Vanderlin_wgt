/datum/job/minor_noble
	title = "Noble"
	tutorial = "The blood of a noble family runs through your veins. You are the living proof that the minor houses \
	still exist in spite of the Monarch. You have many mammons to your name, but with wealth comes \
	danger, so keep your wits and tread lightly..."
	display_order = JDO_MINOR_NOBLE
	department_flag = NOBLEMEN
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_TOWN
	total_positions = 2
	spawn_positions = 2
	min_pq = 1

	allowed_races = RACES_PLAYER_NONDISCRIMINATED

	outfit = /datum/outfit/job/noble
	apprentice_name = "Servant"
	give_bank_account = 60
	noble_income = 16

/datum/outfit/job/noble
	job_bitflag = BITFLAG_ROYALTY

/datum/outfit/job/noble/pre_equip(mob/living/carbon/human/H)
	..()
	var/prev_real_name = H.real_name
	var/prev_name = H.name
	var/honorary = "Lord"
	if(H.gender == FEMALE)
		honorary = "Lady"
	H.real_name = "[honorary] [prev_real_name]"
	H.name = "[honorary] [prev_name]"

	H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/music, rand(1,2), TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
	H.change_stat(STATKEY_INT, 1)
	shoes = /obj/item/clothing/shoes/boots
	backl = /obj/item/storage/backpack/satchel
	neck = /obj/item/storage/belt/pouch/coins/veryrich
	belt = /obj/item/storage/belt/leather
	ring = /obj/item/clothing/ring/silver
	switch(H.patron?.type)
		if(/datum/patron/inhumen/baotha)
			H.cmode_music = 'sound/music/cmode/antag/CombatBaotha.ogg'
	if(H.gender == FEMALE)
		H.change_stat(STATKEY_SPD, 1)
		H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		shirt = /obj/item/clothing/shirt/dress/silkdress/colored/random
		head = /obj/item/clothing/head/hatfur
		cloak = /obj/item/clothing/cloak/raincloak/furcloak
		backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
		beltr = /obj/item/weapon/knife/dagger/steel/special
		beltl = /obj/item/ammo_holder/quiver/arrows
		backpack_contents = list(/obj/item/reagent_containers/glass/bottle/wine = 1, /obj/item/reagent_containers/glass/cup/silver = 1)
	if(H.gender == MALE)
		H.change_stat(STATKEY_CON, 1)
		H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		pants = /obj/item/clothing/pants/tights/colored/black
		shirt = /obj/item/clothing/shirt/tunic/colored/random
		cloak = /obj/item/clothing/cloak/raincloak/furcloak
		head = /obj/item/clothing/head/fancyhat
		backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
		beltr = /obj/item/weapon/sword/rapier/dec
		beltl = /obj/item/ammo_holder/quiver/arrows
		backpack_contents = list(/obj/item/reagent_containers/glass/bottle/wine = 1, /obj/item/reagent_containers/glass/cup/silver = 1)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
