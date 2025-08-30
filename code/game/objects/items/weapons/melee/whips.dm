/* WHIPS
==========================================================*/

/obj/item/weapon/whip
	force = DAMAGE_WHIP
	possible_item_intents = list(/datum/intent/whip/crack, /datum/intent/whip/lash)
	name = "whip"
	desc = "A leather whip, intertwining rope, leather and a fanged tip to inflict enormous pain. Favored by slavers and beast-tamers."
	icon_state = "whip"
	icon = 'icons/roguetown/weapons/32.dmi'
	sharpness = IS_BLUNT
	//dropshrink = 0.75
	wlength = WLENGTH_GREAT
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_HIP
	associated_skill = /datum/skill/combat/whipsflails
	anvilrepair = /datum/skill/craft/tanning
	resistance_flags = FLAMMABLE // Fully made of leather
	smeltresult = /obj/item/fertilizer/ash
	can_parry = FALSE
	swingsound = WHIPWOOSH
	throwforce = 5
	wdefense = 0
	minstr = 4
	sellprice = 30
	grid_width = 32
	grid_height = 64

/obj/item/weapon/whip/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list("shrink" = 0.5,"sx" = -10,"sy" = -3,"nx" = 11,"ny" = -2,"wx" = -7,"wy" = -3,"ex" = 3,"ey" = -3,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0,"nturn" = 22,"sturn" = -23,"wturn" = -23,"eturn" = 29,"nflip" = 0,"sflip" = 8,"wflip" = 8,"eflip" = 0)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)


/*------------\
| Lash intent |
\------------*/
/datum/intent/whip/lash
	name = "lash"
	blade_class = BCLASS_LASHING
	attack_verb = list("lashes", "whips")
	hitsound = list('sound/combat/hits/blunt/flailhit.ogg')
	chargetime = 5
	recovery = 5
	penfactor = 5
	reach = 2
	misscost = 7
	icon_state = "inlash"
	canparry = FALSE //Has reach and can't be parried, but needs to be charged and punishes misses.
	item_damage_type = "slash"

/*-------------\
| Crack intent |
\-------------*/
/datum/intent/whip/crack
	name = "crack"
	blade_class = BCLASS_BLUNT
	attack_verb = list("cracks", "strikes") //something something dwarf fotresss
	hitsound = list('sound/combat/hits/blunt/flailhit.ogg')
	chargetime = 0
	recovery = 5
	penfactor = 10
	reach = 1
	icon_state = "incrack"
	canparry = TRUE
	item_damage_type = "slash"

//................ Repenta En ............... //
/obj/item/weapon/whip/antique
	force = DAMAGE_WHIP+4
	name = "Repenta En"
	desc = "An extremely well maintained whip, with a polished steel tip and gilded handle"
	minstr = 7
	icon_state = "gwhip"
	resistance_flags = FIRE_PROOF
	smeltresult = /obj/item/ingot/steel
	sellprice = 50


//................ Silver Whip ............... //
/obj/item/weapon/whip/silver
	name = "silver whip"
	desc = "A whip with a silver handle, core and tip. It has been modified for inflicting burning pain on Nitebeasts."
	icon_state = "silverwhip"
	resistance_flags = FIRE_PROOF
	smeltresult = /obj/item/ingot/silver
	last_used = 0

/obj/item/weapon/whip/silver/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/silver)

//................ Psydon Whip ............... //
/obj/item/weapon/whip/psydon
	force = DAMAGE_WHIP+2
	name = "psydonian whip"
	desc = "A whip fashioned with the iconography of Psydon, and crafted entirely out of silver."
	icon_state = "psywhip"
	resistance_flags = FIRE_PROOF
	smeltresult = /obj/item/ingot/silver
	last_used = 0

/obj/item/weapon/whip/psydon/Initialize(mapload)
	. = ..()
	enchant(/datum/enchantment/silver)

//................ Caning Stick.................//
/obj/item/weapon/whip/cane
	name = "caning stick"
	desc = "A thin cane meant for striking others as punishment."
	icon_state = "canestick"
	possible_item_intents = list(/datum/intent/whip/lash/cane)
	force = DAMAGE_WHIP / 2
	wlength = WLENGTH_NORMAL
	max_integrity = 4 // Striking unarmoured parts doesn't take integrity, four hits to anything with an armor value will break it.
	sellprice = 0

/obj/item/weapon/whip/cane/getonmobprop(tag)
	. = ..()
	if(tag)
		switch(tag)
			if("gen")
				return list(
					"shrink" = 0.5,
					"sx" = -6,
					"sy" = -6,
					"nx" = 6,
					"ny" = -5,
					"wx" = -1,
					"wy" = -5,
					"ex" = -1,
					"ey" = -5,
					"nturn" = -45,
					"sturn" = -45,
					"wturn" = -45,
					"eturn" = -45,
					"nflip" = 0,
					"sflip" = 0,
					"wflip" = 0,
					"eflip" = 0,
					"northabove" = FALSE,
					"southabove" = TRUE,
					"eastabove" = TRUE,
					"westabove" = FALSE
				)
			if("onbelt")
				return list("shrink" = 0.3,"sx" = -2,"sy" = -5,"nx" = 4,"ny" = -5,"wx" = 0,"wy" = -5,"ex" = 2,"ey" = -5,"nturn" = 0,"sturn" = 0,"wturn" = 0,"eturn" = 0,"nflip" = 0,"sflip" = 0,"wflip" = 0,"eflip" = 0,"northabove" = 0,"southabove" = 1,"eastabove" = 1,"westabove" = 0)

/datum/intent/whip/lash/cane
	attack_verb = list("lashes", "canes")
	chargetime = 20
	no_early_release = TRUE
	penfactor = 0
	reach = 1 //no added range
	misscost = 10
	icon_state = "inlash"
	canparry = TRUE //Not meant for fighting with
	item_damage_type = "slash"

//................ Lashkiss Whip ............... //
/obj/item/weapon/whip/spiderwhip
	force = DAMAGE_WHIP+3
	name = "lashkiss whip"
	desc = "A dark whip with segmented, ashen spines for a base. Claimed to be hewn from dendrified prisoners of terror."
	icon_state = "spiderwhip"
	minstr = 6

//................ Chain Whip ............... //
/obj/item/weapon/whip/chain
	force = DAMAGE_WHIP+3
	possible_item_intents = list(/datum/intent/whip/crack/metal, /datum/intent/whip/lash/metal)
	name = "chain whip"
	desc = "An iron chain, fixed to a leather grip. Its incredibly heavy, and unwieldy. You'll likely hurt yourself more then anyone else with this."
	icon_state = "whip_chain"
	w_class = WEIGHT_CLASS_BULKY
	resistance_flags = FIRE_PROOF
	smeltresult = /obj/item/ingot/iron
	anvilrepair = /datum/skill/craft/weaponsmithing
	minstr = 9
	melt_amount = 75

/datum/intent/whip/lash/metal
	chargetime = 10
	hitsound = list('sound/combat/hits/blunt/flailhit.ogg')
	recovery = 5
	penfactor = 15

/datum/intent/whip/crack/metal
	penfactor = 20


//................ Xylix Whip ............... //
/obj/item/weapon/whip/xylix
	name = "cackle lash"
	force = DAMAGE_WHIP+4
	desc = "The chimes of this whip are said to sound as the trickster's laughter itself."
	icon_state = "xylixwhip"

/obj/item/weapon/whip/nagaika
	name = "nagaika whip"
	desc = "A short but heavy leather whip, sporting a blunt reinforced tip and a longer handle."
	icon_state = "nagaika"
	force = 25		//Same as a cudgel/sword for intent purposes. Basically a 2 range cudgel while one-handing.
	possible_item_intents = list(/datum/intent/whip/crack/metal, /datum/intent/whip/lash, /datum/intent/sword/strike)
	wdefense = 1	//Akin to a cudgel, still terrible at parrying though. Better than nothing I guess; thing is used irl as a counter-weapon to knives.
