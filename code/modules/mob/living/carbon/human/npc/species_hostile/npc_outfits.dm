/datum/outfit/npc/light_gear/pre_equip(mob/living/carbon/human/H)
	..()
	cloak = /obj/item/clothing/cloak/raincloak/colored/random
	belt = /obj/item/storage/belt/leather
	pants = /obj/item/clothing/pants/trou/leather/splint
	head = /obj/item/clothing/head/helmet/leather
	gloves = /obj/item/clothing/gloves/leather
	neck = /obj/item/clothing/neck/coif
	wrists = /obj/item/clothing/wrists/bracers/leather
	if(prob(10))
		shoes = /obj/item/clothing/shoes/boots/leather
	else if(prob(20))
		shoes = /obj/item/clothing/shoes/boots
	else
		shoes = /obj/item/clothing/shoes/boots/clothlinedanklets


	var/loadout = rand(1,10)
	switch(loadout)
		if(1)
			armor = /obj/item/clothing/armor/leather/hide
			if(prob(90))
				l_hand = /obj/item/weapon/knife/dagger
				r_hand = /obj/item/weapon/knife/dagger
			else
				// Lucky bastard
				l_hand = /obj/item/weapon/knife
				r_hand = /obj/item/weapon/knife
		if(2)
			armor = /obj/item/clothing/armor/leather/hide
			l_hand = /obj/item/weapon/knife/dagger

		if(3)
			armor = /obj/item/clothing/armor/leather
			l_hand = /obj/item/weapon/sword/iron

		if(4)
			head = /obj/item/clothing/head/helmet/leather/volfhelm
			armor = /obj/item/clothing/armor/chainmail/iron
			l_hand = /obj/item/weapon/knife/copper
			r_hand = /obj/item/weapon/knife/copper

		if(5)
			// A valorian dueslist perished and got their stuff stolen
			head = /obj/item/clothing/head/leather/duelhat
			armor = /obj/item/clothing/armor/leather/jacket/leathercoat/duelcoat
			l_hand = /obj/item/weapon/sword/rapier
			if(prob(1)) // Where did they got this sword from?
				r_hand = /obj/item/weapon/sword/rapier

		if(6)
			armor = /obj/item/clothing/armor/leather/splint
			l_hand = /obj/item/weapon/sword/long/shotel/iron
			if(prob(50))
				r_hand = /obj/item/weapon/sword/long/shotel/iron
		if(7)
			armor = /obj/item/clothing/armor/leather/heavy
			l_hand = /obj/item/weapon/sword

		if(8)
			l_hand = /obj/item/weapon/knife/dagger/steel/special
			armor = /obj/item/clothing/armor/leather/jacket
			head = /obj/item/clothing/head/bardhat

		if(9)
			armor = /obj/item/clothing/armor/leather/jacket/sea
			l_hand =  /obj/item/weapon/sword/sabre/cutlass

		if(10)
			armor = /obj/item/clothing/armor/leather/hide
			l_hand = /obj/item/weapon/sword/iron
			r_hand = /obj/item/weapon/sword/iron


/datum/outfit/npc/medium_gear/pre_equip(mob/living/carbon/human/H)
	..()
	var/loadout = rand(1,10)


/datum/outfit/npc/heavy_gear/pre_equip(mob/living/carbon/human/H)
	..()
	var/loadout = rand(1,10)