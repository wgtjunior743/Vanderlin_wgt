/obj/item/weapon/scabbard
	icon = 'icons/roguetown/weapons/scabbard.dmi'
	alternate_worn_layer = UNDER_CLOAK_LAYER

	resistance_flags = FLAMMABLE
	parrysound = "parrywood"
	attacked_sound = "parrywood"
	sharpness = IS_BLUNT
	blade_dulling = DULLING_BASHCHOP
	possible_item_intents = list(SHIELD_BASH)

/obj/item/weapon/scabbard/Initialize()
	. = ..()
	ADD_TRAIT(src, TRAIT_HARD_TO_STEAL, TRAIT_GENERIC)

/obj/item/weapon/scabbard/update_icon_state()
	icon_state = initial(icon_state)
	item_state = initial(item_state)

	if(length(contents))
		var/obj/item/sheathed_weapon = contents[1]
		var/icon/possible_sheaths = icon(icon) //hehe
		var/list/extensions = list()
		for(var/s in possible_sheaths.IconStates(1))
			extensions[s] = TRUE
		qdel(possible_sheaths)
		if(extensions[icon_state+"_[sheathed_weapon.icon_state]"])
			icon_state += "_[sheathed_weapon.icon_state]"
		else
			icon_state += "-sheathed"
	return ..()

/*
	GENERIC SCABBARDS
*/
/obj/item/weapon/scabbard/knife
	name = "knife sheath"
	desc = "A slingable sheath made of leather, meant to host surprises of smaller sizes."
	icon_state = "sheath"

	force = 3
	throwforce = 3
	max_integrity = 50
	w_class = WEIGHT_CLASS_SMALL
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_BACK|ITEM_SLOT_WRISTS|ITEM_SLOT_NECK

	wdefense = MEDIOCHRE_PARRY
	wlength = WLENGTH_SHORT
	wbalance = HARD_TO_DODGE
	associated_skill = /datum/skill/combat/knives
	sewrepair = TRUE
	sellprice = 2

	grid_width = 32
	grid_height = 64

/obj/item/weapon/scabbard/knife/apply_components()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob, slot_flags|ITEM_SLOT_HANDS)
	AddComponent(/datum/component/storage/concrete/scabbard/knife)

/obj/item/weapon/scabbard/knife/getonmobprop(tag)
	..()

	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5, "sx" = -6, "sy" = -1, "nx" = 6, "ny" = -1, "wx" = 0, "wy" = -2, "ex" = 0, "ey" = -2, "northabove" = 0, "southabove" = 1, "eastabove" = 1, "westabove" = 0, "nturn" = 0, "sturn" = 0, "wturn" = 0, "eturn" = 0, "nflip" = 1, "sflip" = 1, "wflip" = 1,"eflip" = 0)
			if("onback")
				return list("shrink" = 0.4, "sx" = -3, "sy" = -1, "nx" = 0, "ny" = 0, "wx" = -4, "wy" = 0, "ex" = 2, "ey" = 1, "northabove" = 0, "southabove" = 1, "eastabove" = 1, "westabove" = 0, "nturn" = 0, "sturn" = 10, "wturn" = 32, "eturn" = -23, "nflip" = 0, "sflip" = 8, "wflip" = 8, "eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.5, "sx" = -2, "sy" = -5, "nx" = 4, "ny" = -5, "wx" = 0, "wy" = -5, "ex" = 2, "ey" = -5, "nturn" = 0, "sturn" = 0, "wturn" = 0, "eturn" = 0, "nflip" = 0, "sflip" = 0, "wflip" = 0, "eflip" = 0, "northabove" = 0, "southabove" = 1, "eastabove" = 1, "westabove" = 1)

/obj/item/weapon/scabbard/knife/noble
	name = "silver decorated knife sheath"
	desc = "A slingable sheath made of leather, enamored with elaborate silver decorations, often seen on the hips of nobles"
	icon_state = "nsheath"

/obj/item/weapon/scabbard/knife/royal
	name = "gold decorated knife sheath"
	desc = "A slingable sheath made of leather, enamored with exquisite golden decorations, often seen on the hips of royalty"
	icon_state = "rsheath"

/obj/item/weapon/scabbard/sword
	name = "scabbard"
	desc = "A scabbard designed to hold a sword. The natural conclusion for those wishing to carry longblades."
	icon_state = "scabbard"

	force = 7
	force_wielded = 8
	max_integrity = 75
	sellprice = 3
	slot_flags = ITEM_SLOT_HIP|ITEM_SLOT_BACK

	wdefense = GREAT_PARRY
	w_class = WEIGHT_CLASS_BULKY
	anvilrepair = /datum/skill/craft/carpentry
	associated_skill = /datum/skill/combat/swords

/obj/item/weapon/scabbard/sword/apply_components()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob, slot_flags|ITEM_SLOT_HANDS)
	AddComponent(/datum/component/storage/concrete/scabbard/sword)

/obj/item/weapon/scabbard/sword/getonmobprop(tag)
	. = ..()

	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.6, "sx" = -6, "sy" = -1, "nx" = 6, "ny" = -1, "wx" = 0, "wy" = -2, "ex" = 0, "ey" = -2, "northabove" = 0, "southabove" = 1, "eastabove" = 1, "westabove" = 0, "nturn" = 0, "sturn" = 0, "wturn" = 0, "eturn" = 0, "nflip" = 1, "sflip" = 0, "wflip" = 1, "eflip" = 0)
			if("onback")
				return list("shrink" = 0.5, "sx" = 1, "sy" = 4, "nx" = 1, "ny" = 2, "wx" = 3, "wy" = 3, "ex" = 0, "ey" = 2, "nturn" = 0, "sturn" = 0, "wturn" = 0, "eturn" = 0, "nflip" = 8, "sflip" = 0, "wflip" = 0, "eflip" = 0, "northabove" = 1, "southabove" = 0, "eastabove" = 0, "westabove" = 0)
			if("onbelt")
				return list("shrink" = 0.5, "sx" = -2, "sy" = -5, "nx" = 4, "ny" = -5, "wx" = 0, "wy" = -5, "ex" = 2, "ey" = -5, "nturn" = 0, "sturn" = 0, "wturn" = -90, "eturn" = 0, "nflip" = 0, "sflip" = 0, "wflip" = 0, "eflip" = 0, "northabove" = 0, "southabove" = 1, "eastabove" = 1, "westabove" = 1)

/obj/item/weapon/scabbard/sword/noble
	name = "silver decorated scabbard"
	desc = "A scabbard designed to hold a sword. This one is decorated on a silver platter."
	icon_state = "nscabbard"

/obj/item/weapon/scabbard/sword/royal
	name = "gold decorated scabbard"
	desc = "A scabbard designed to hold a sword. This one is lined with golden fittings, fit for a royal."
	icon_state = "rscabbard"
