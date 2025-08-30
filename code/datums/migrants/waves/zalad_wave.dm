/datum/migrant_role/zalad/emir
	name = "Zalad Emir"
	greet_text = "An Emir hailing from the Deshret, here on business for the Mercator's Guild."
	allowed_sexes = list(MALE)
	allowed_races = RACES_PLAYER_ZYBANTINE
	outfit = /datum/outfit/job/zalad_migration/emir
	grant_lit_torch = TRUE
	is_recognized = TRUE

/datum/outfit/job/zalad_migration/emir/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/shalal
	gloves = /obj/item/clothing/gloves/leather
	head = /obj/item/clothing/head/crown/circlet
	cloak = /obj/item/clothing/cloak/raincloak/colored/purple
	armor = /obj/item/clothing/armor/gambeson/arming
	belt = /obj/item/storage/belt/leather/shalal
	beltl = /obj/item/weapon/sword/sabre/shalal
	beltr = /obj/item/flashlight/flare/torch/lantern
	backr = /obj/item/storage/backpack/satchel
	ring = /obj/item/clothing/ring/gold/guild_mercator
	shirt = /obj/item/clothing/shirt/tunic/colored/purple
	pants = /obj/item/clothing/pants/trou/leather
	neck = /obj/item/clothing/neck/shalal/emir
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/veryrich)
	if(H.gender == FEMALE)
		armor = /obj/item/clothing/armor/leather/jacket/silk_coat
		shirt = /obj/item/clothing/shirt/dress/silkdress/colored/black
	if(H.mind)
		H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
		H.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.adjust_skillrank(/datum/skill/misc/music, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
		var/prev_real_name = H.real_name
		var/prev_name = H.name
		var/honorary = "Emir"
		if(H.gender == FEMALE)
			honorary = "Amirah"
		H.real_name = "[honorary] [prev_real_name]"
		H.name = "[honorary] [prev_name]"
		if(!H.has_language(/datum/language/zalad))
			H.grant_language(/datum/language/zalad)
			to_chat(H, "<span class='info'>I can speak Zalad with ,z before my speech.</span>")
		H.change_stat(STATKEY_INT, 1)
		H.change_stat(STATKEY_END, 2)
		ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
		H.cmode_music = 'sound/music/cmode/adventurer/CombatOutlander.ogg'


/datum/migrant_role/zalad/amirah
	name = "Zalad Amirah"
	greet_text = "An Amirah hailing from Deshret, here on business for the Mercator's Guild to the Isle of the Enigma."
	allowed_sexes = list(FEMALE)
	allowed_races = RACES_PLAYER_ZYBANTINE
	outfit = /datum/outfit/job/zalad_migration/amirah
	grant_lit_torch = TRUE
	is_recognized = TRUE

/datum/outfit/job/zalad_migration/amirah/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/shalal
	gloves = /obj/item/clothing/gloves/leather
	head = /obj/item/clothing/head/crown/nyle
	cloak = /obj/item/clothing/cloak/raincloak/colored/purple
	armor = /obj/item/clothing/armor/leather/jacket/silk_coat
	belt = /obj/item/storage/belt/leather/shalal
	beltl = /obj/item/weapon/sword/sabre/shalal
	beltr = /obj/item/flashlight/flare/torch/lantern
	backr = /obj/item/storage/backpack/satchel
	ring = /obj/item/clothing/ring/gold/guild_mercator
	shirt = /obj/item/clothing/shirt/dress/silkdress/colored/black
	pants = /obj/item/clothing/pants/trou/leather
	neck = /obj/item/clothing/neck/shalal/emir
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/veryrich = 1, /obj/item/reagent_containers/glass/bottle/wine = 1)

	if(H.mind)
		H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
		H.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.adjust_skillrank(/datum/skill/misc/music, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
		var/prev_real_name = H.real_name
		var/prev_name = H.name
		var/honorary = "Amirah"
		H.real_name = "[honorary] [prev_real_name]"
		H.name = "[honorary] [prev_name]"
		if(!H.has_language(/datum/language/zalad))
			H.grant_language(/datum/language/zalad)
			to_chat(H, "<span class='info'>I can speak Zalad with ,z before my speech.</span>")
		H.change_stat(STATKEY_INT, 1)
		H.change_stat(STATKEY_END, 2)
		ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
		H.cmode_music = 'sound/music/cmode/adventurer/CombatOutlander.ogg'

/datum/migrant_role/zalad/furusiyya
	name = "Furusiyya"
	greet_text = "You are a furusiyya, pledged to the Emir and the Amirah. Make sure they come out alive of that place."
	allowed_sexes = list(MALE)
	allowed_races = RACES_PLAYER_ZYBANTINE
	outfit = /datum/outfit/job/zalad_migration/furusiyya
	grant_lit_torch = TRUE
	is_recognized = TRUE

/datum/outfit/job/zalad_migration/furusiyya/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
		H.adjust_skillrank(/datum/skill/combat/swords, 4, TRUE)
		H.adjust_skillrank(/datum/skill/combat/whipsflails, 4, TRUE)
		H.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
		H.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
		H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
		H.change_stat(STATKEY_STR, 3)
		H.change_stat(STATKEY_PER, 1)
		H.change_stat(STATKEY_INT, 2)
		H.change_stat(STATKEY_CON, 2)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_SPD, -1)

	var/randy = rand(1,5)
	switch(randy)
		if(1 to 2)
			backr = /obj/item/weapon/polearm/halberd/bardiche
		if(3 to 4)
			backr = /obj/item/weapon/polearm/eaglebeak
		if(5)
			backr = /obj/item/weapon/polearm/spear/billhook


	pants = /obj/item/clothing/pants/tights/colored/black
	beltl = /obj/item/storage/belt/pouch/coins/mid
	shoes = /obj/item/clothing/shoes/boots/rare/zybanplate
	gloves = /obj/item/clothing/gloves/rare/zybanplate
	belt = /obj/item/storage/belt/leather/shalal
	shirt = /obj/item/clothing/shirt/undershirt/colored/random
	armor = /obj/item/clothing/armor/rare/zybanplate
	backl = /obj/item/storage/backpack/satchel
	head = /obj/item/clothing/head/rare/zybanplate
	wrists = /obj/item/clothing/wrists/bracers
	neck = /obj/item/clothing/neck/chaincoif
	if(!H.has_language(/datum/language/zalad))
		H.grant_language(/datum/language/zalad)
		to_chat(H, "<span class='info'>I can speak Zalad with ,z before my speech.</span>")

	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/cmode/adventurer/CombatOutlander.ogg'

/datum/migrant_role/zalad_guard
	name = "Zalad Soldier"
	greet_text = "You are a slave soldier from Deshret, sent as an escort to the emirs on a foreign land, do not fail them."
	allowed_sexes = list(MALE,FEMALE)
	allowed_races = RACES_PLAYER_ALL
	outfit = /datum/outfit/job/zalad_migration/zalad_guard
	grant_lit_torch = TRUE

/datum/outfit/job/zalad_migration/zalad_guard/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/shalal
	head = /obj/item/clothing/head/helmet/sallet/zalad
	gloves = /obj/item/clothing/gloves/angle
	belt = /obj/item/storage/belt/leather/shalal
	armor = /obj/item/clothing/armor/brigandine/coatplates
	beltr = /obj/item/weapon/sword/long/rider
	beltl= /obj/item/flashlight/flare/torch/lantern
	shirt = /obj/item/clothing/shirt/undershirt/colored/black
	pants = /obj/item/clothing/pants/tights/colored/red
	neck = /obj/item/clothing/neck/keffiyeh/colored/red
	backl = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/poor)
	if(!H.has_language(/datum/language/zalad))
		H.grant_language(/datum/language/zalad)
		to_chat(H, "<span class='info'>I can speak Zalad with ,z before my speech.</span>")
	if(H.mind)
		H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/sneaking, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/lockpicking, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/polearms, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/whipsflails, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/shields, pick(0,1,1), TRUE)
		H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_END, 2)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/cmode/adventurer/CombatOutlander.ogg'

/datum/migrant_role/qatil
	name = "Qatil"
	greet_text = "You are the Amirah's confident and most loyal protector, you shan't let them die in these wretched lands."
	allowed_races = list(\
		SPEC_ID_HUMEN,\
		SPEC_ID_ELF,\
		SPEC_ID_RAKSHARI,\
		SPEC_ID_HALF_ELF,\
		SPEC_ID_TIEFLING,\
		SPEC_ID_DROW,\
		SPEC_ID_HALF_DROW,\
	)
	outfit = /datum/outfit/job/zalad_migration/qatil

/datum/outfit/job/zalad_migration/qatil/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.mind)
		H.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
		H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE)
		H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
		H.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/lockpicking, 3, TRUE)
		H.adjust_skillrank(/datum/skill/craft/traps, 1, TRUE)
		H.change_stat(STATKEY_STR, 1)
		H.change_stat(STATKEY_SPD, 2)
		H.change_stat(STATKEY_END, 1)

	pants = /obj/item/clothing/pants/trou/leather
	beltr = /obj/item/weapon/knife/dagger/steel/special
	shoes = /obj/item/clothing/shoes/shalal
	gloves = /obj/item/clothing/gloves/angle
	belt = /obj/item/storage/belt/leather/shalal
	shirt = /obj/item/clothing/shirt/undershirt/colored/red
	armor = /obj/item/clothing/armor/leather/splint
	backl = /obj/item/storage/backpack/satchel
	head = /obj/item/clothing/neck/keffiyeh/colored/red
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/poor, /obj/item/lockpick)
	if(!H.has_language(/datum/language/zalad))
		H.grant_language(/datum/language/zalad)
		to_chat(H, "<span class='info'>I can speak Zalad with ,z before my speech.</span>")

	ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	H.cmode_music = 'sound/music/cmode/adventurer/CombatOutlander3.ogg'

/datum/migrant_wave/zalad_wave
	name = "The Deshret Expedition"
	max_spawns = 1
	shared_wave_type = list(/datum/migrant_wave/grenzelhoft_visit,/datum/migrant_wave/zalad_wave,/datum/migrant_wave/rockhill_wave,/datum/migrant_wave/heartfelt)
	weight = 25
	downgrade_wave = /datum/migrant_wave/zalad_wave_down
	roles = list(
		/datum/migrant_role/zalad/emir = 1,
		/datum/migrant_role/zalad/amirah = 1,
		/datum/migrant_role/zalad/furusiyya = 1,
		/datum/migrant_role/qatil = 1,
		/datum/migrant_role/zalad_guard = 2
	)
	greet_text = "The Mercator Guild sent you, respected Zybantinian to seek favorable business proposal within the Kingdom of Vanderlin."

/datum/migrant_wave/zalad_wave_down
	name = "The Deshret Expedition"
	max_spawns = 1
	shared_wave_type = list(/datum/migrant_wave/grenzelhoft_visit,/datum/migrant_wave/zalad_wave,/datum/migrant_wave/rockhill_wave,/datum/migrant_wave/heartfelt)
	can_roll = FALSE
	roles = list(
		/datum/migrant_role/zalad/emir = 1,
		/datum/migrant_role/zalad/amirah = 1,
		/datum/migrant_role/zalad/furusiyya = 1,
		/datum/migrant_role/qatil = 1
	)
	greet_text = "The Mercator Guild sent you, respected Zybantinian to seek favorable business proposal within the Kingdom of Vanderlin. Unfortunately most of your guards died on the way here."
