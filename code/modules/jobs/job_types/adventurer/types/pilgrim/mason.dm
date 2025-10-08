//dwarf, master mason

/datum/job/advclass/pilgrim/mason
	title = "Mason"
	tutorial = "Despite the lack of a formal guild in Vanderlin, you've traveled there to hone your stonemasonry. \
	You've known your entire life there are ancient secrets within stone, and now you must prove their value to others."
	allowed_races = RACES_PLAYER_ALL
	outfit = /datum/outfit/adventurer/mason
	category_tags = list(CTAG_PILGRIM)
	apprentice_name = "Mason Apprentice"
	cmode_music = 'sound/music/cmode/towner/CombatBeggar.ogg'//pilgrims aren't towners, this fits them more for a combat on the woods

/datum/outfit/adventurer/mason/pre_equip(mob/living/carbon/human/H)
	..()

	H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mining, rand(1,3), TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/carpentry, rand(1,2), TRUE)
	H.adjust_skillrank(/datum/skill/craft/masonry, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/engineering, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)

	head = pick(/obj/item/clothing/head/hatfur, /obj/item/clothing/head/hatblu)
	armor = /obj/item/clothing/armor/leather/vest
	cloak = /obj/item/clothing/cloak/apron/waist/colored/brown
	neck = /obj/item/storage/belt/pouch/coins/mid
	pants = /obj/item/clothing/pants/trou
	shirt = pick(/obj/item/clothing/shirt/undershirt/colored/random, /obj/item/clothing/shirt/tunic/colored/random)
	shoes = /obj/item/clothing/shoes/boots/leather
	belt = /obj/item/storage/belt/leather
	beltl = /obj/item/weapon/hammer
	beltr = /obj/item/weapon/chisel
	backl = /obj/item/storage/backpack/backpack

	H.change_stat(STATKEY_STR, 1)
	H.change_stat(STATKEY_INT, 2)
	H.change_stat(STATKEY_END, 1)
	H.change_stat(STATKEY_CON, 1)
	H.change_stat(STATKEY_SPD, -1)

	if(H.dna.species.id == SPEC_ID_DWARF)
		head = /obj/item/clothing/head/helmet/leather/minershelm
		H.cmode_music = 'sound/music/cmode/combat_dwarf.ogg'
