/datum/job/advclass/wretch/bloodsucker
	title = "Bloodsucker"
	tutorial = "You have recently been embraced as a vampire. You do not know whom your sire is, strange urges, unnatural strength, a thirst you can barely control. You were outed as a monster and are now on the run"
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_NONDISCRIMINATED //noble options, I don't know if its even possible to implement a race lock on class choices.
	category_tags = list(CTAG_WRETCH) // Due to vampire status: skilled weapon skill, no armor besides a gorget.
	outfit = /datum/outfit/wretch/bloodsucker
	total_positions = 1
	roll_chance = 25

/datum/outfit/wretch/bloodsucker/pre_equip(mob/living/carbon/human/H)

	var/classes = list("The Noble", "The Count", "The Bum")
	var/classchoice = browser_input_list(H, "Choose your archetypes", "Available archetypes", classes)
	switch(classchoice)
		if("The Noble")
			noble_equip(H)
		if("The Count")
			grenzel_equip(H)
		if("The Bum")
			bum_equip(H)

/datum/outfit/wretch/bloodsucker/proc/noble_equip(mob/living/carbon/human/H)
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
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 5, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.change_stat(STATKEY_STR, 1)
	H.change_stat(STATKEY_INT, 3) // quick smart vampire
	H.change_stat(STATKEY_SPD, 2)
	H.change_stat(STATKEY_PER, 2) // has a bow
	shoes = /obj/item/clothing/shoes/boots
	backl = /obj/item/storage/backpack/satchel
	neck = /obj/item/clothing/neck/gorget
	belt = /obj/item/storage/belt/leather
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_FOREIGNER, TRAIT_GENERIC)
	wretch_select_bounty(H)
	if(H.mind)
		if(H.mind.has_antag_datum(/datum/antagonist))
			return
		var/datum/antagonist/vampire/new_antag = new /datum/antagonist/vampire(new /datum/clan/caitiff, TRUE)
		H.mind.add_antag_datum(new_antag)
	if(H.gender == FEMALE)
		H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		shirt = /obj/item/clothing/shirt/dress/silkdress/colored/random
		head = /obj/item/clothing/head/hatfur
		cloak = /obj/item/clothing/cloak/raincloak/furcloak
		backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
		beltr = /obj/item/weapon/sword/rapier/dec
		beltl = /obj/item/ammo_holder/quiver/arrows
		backpack_contents = list(/obj/item/reagent_containers/glass/bottle/wine = 1, /obj/item/reagent_containers/glass/cup/golden = 1, /obj/item/weapon/knife/dagger/steel/special, /obj/item/clothing/face/shepherd/rag)
	if(H.gender == MALE)
		H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		pants = /obj/item/clothing/pants/tights/colored/black
		shirt = /obj/item/clothing/shirt/tunic/colored/random
		cloak = /obj/item/clothing/cloak/raincloak/furcloak
		head = /obj/item/clothing/head/fancyhat
		backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
		beltr = /obj/item/weapon/sword/rapier/dec
		beltl = /obj/item/ammo_holder/quiver/arrows
		backpack_contents = list(/obj/item/reagent_containers/glass/bottle/wine = 1, /obj/item/reagent_containers/glass/cup/golden = 1, /obj/item/storage/belt/pouch/coins/mid, /obj/item/weapon/knife/dagger/steel/special, /obj/item/clothing/face/shepherd/rag)

/datum/outfit/wretch/bloodsucker/proc/grenzel_equip(mob/living/carbon/human/H)
	shoes = /obj/item/clothing/shoes/rare/grenzelhoft
	gloves = /obj/item/clothing/gloves/angle/grenzel
	head = /obj/item/clothing/head/helmet/skullcap/grenzelhoft
	belt = /obj/item/storage/belt/leather/plaquegold
	beltl = /obj/item/weapon/sword/sabre/dec
	backr = /obj/item/storage/backpack/satchel
	ring = /obj/item/clothing/ring/gold
	shirt = /obj/item/clothing/shirt/grenzelhoft
	pants = /obj/item/clothing/pants/grenzelpants
	neck = /obj/item/clothing/neck/gorget
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/mid, /obj/item/weapon/knife/dagger/steel/special, /obj/item/clothing/face/shepherd/rag)

	if(H.mind)
		H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 5, TRUE)
		H.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.adjust_skillrank(/datum/skill/misc/music, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
		var/prev_real_name = H.real_name
		var/prev_name = H.name
		var/honorary = "Count"
		if(H.gender == FEMALE)
			honorary = "Countess"
		H.real_name = "[honorary] [prev_real_name]"
		H.name = "[honorary] [prev_name]"
		if(!H.has_language(/datum/language/oldpsydonic))
			H.grant_language(/datum/language/oldpsydonic)
			to_chat(H, "<span class='info'>I can speak Old Psydonic with ,m before my speech.</span>")
		H.change_stat(STATKEY_CON, 2)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_STR, 2) // more of a brute type
		ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_FOREIGNER, TRAIT_GENERIC)
		if(H.dna?.species.id == SPEC_ID_HUMEN)
			H.dna.species.native_language = "Old Psydonic"
			H.dna.species.accent_language = H.dna.species.get_accent(H.dna.species.native_language)
		wretch_select_bounty(H)
		if(H.mind)
			if(H.mind.has_antag_datum(/datum/antagonist))
				return
			var/datum/antagonist/vampire/new_antag = new /datum/antagonist/vampire(new /datum/clan/caitiff, TRUE)
			H.mind.add_antag_datum(new_antag)

/datum/outfit/wretch/bloodsucker/proc/bum_equip(mob/living/carbon/human/H)
	cloak = /obj/item/clothing/cloak/tribal // yes, just a cloak
	H.adjust_skillrank(/datum/skill/misc/sneaking, pick(4,5), TRUE)
	H.adjust_skillrank(/datum/skill/misc/stealing, pick(4,5), TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, pick (1,2,3,4,5), TRUE) // thug lyfe
	H.adjust_skillrank(/datum/skill/misc/climbing, pick(4,5), TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, pick(1,2,3,4,5), TRUE) // Street-fu
	H.adjust_skillrank(/datum/skill/combat/unarmed, pick(1,2,3,4,5,6), TRUE)
	H.base_fortune = rand(1, 20)
	H.change_stat(STATKEY_STR, pick(-1,1,2,3))
	H.change_stat(STATKEY_INT, pick(-2,-1,1,2))
	H.change_stat(STATKEY_SPD, pick(-2,-1,1,2))
	H.add_spell(/datum/action/cooldown/spell/undirected/shapeshift/rat_vampire) // seems funny, rat powers, sewer lurker
	ADD_TRAIT(H, TRAIT_FOREIGNER, TRAIT_GENERIC)
	wretch_select_bounty(H)
	if(H.mind)
		if(H.mind.has_antag_datum(/datum/antagonist))
			return
		var/datum/antagonist/vampire/new_antag = new /datum/antagonist/vampire(new /datum/clan/caitiff, TRUE)
		H.mind.add_antag_datum(new_antag)
