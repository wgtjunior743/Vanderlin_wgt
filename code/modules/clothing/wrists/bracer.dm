
/obj/item/clothing/wrists/bracers
	name = "plate vambraces"
	desc = "Plate forearm guards that offer superior protection while allowing mobility."
	body_parts_covered = ARMS
	icon_state = "bracers"
	item_state = "bracers"
	armor = list("blunt" = 80, "slash" = 80, "stab" = 80,  "piercing" = 60, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_LASHING, BCLASS_BITE, BCLASS_CUT, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST)
	blocksound = PLATEHIT
	resistance_flags = FIRE_PROOF
	anvilrepair = /datum/skill/craft/armorsmithing
	sewrepair = FALSE
	smeltresult = /obj/item/ingot/iron //no 1 to 1 conversion
	max_integrity = INTEGRITY_STRONG

/obj/item/clothing/wrists/bracers/iron
	name = "iron plate vambraces"
	desc = "Plate forearm guards that offer good protection while allowing mobility."
	icon_state = "ibracers"
	item_state = "ibracers"
	armor = ARMOR_MAILLE
	max_integrity = INTEGRITY_STANDARD


/obj/item/clothing/wrists/bracers/jackchain
	name = "jack chains"
	desc = "Thin strips of steel attached to small shoulder and elbow plates, worn on the outside of the arms to protect against slashes."
	icon_state = "jackchain"
	item_state = "jackchain"
	armor = ARMOR_MAILLE
	max_integrity = INTEGRITY_STANDARD
	prevent_crits = CUT_AND_MINOR_CRITS
	smeltresult = /obj/item/fertilizer/ash
	melting_material = /datum/material/steel
	melt_amount = 75

/obj/item/clothing/wrists/bracers/ironjackchain
	name = "iron jack chains"
	desc = "Thin strips of iron and small plates attached to small shoulder and elbow guards, worn on the outside of the arms to protect against slashes, bludgeons and whatever they block."
	icon_state = "ijackchain"
	item_state = "ijackchain"
	armor = ARMOR_MAILLE
	max_integrity = INTEGRITY_STANDARD
	prevent_crits = CUT_AND_MINOR_CRITS
	smeltresult = /obj/item/fertilizer/ash //we avoid melting one piece for one bar
	melting_material = /datum/material/iron // we get one bar per two pieces of the item recovered and smelted
	melt_amount = 75

/obj/item/clothing/wrists/bracers/leather
	name = "leather bracers"
	desc = "Boiled leather bracers typically worn by archers to protect their forearms."
	icon_state = "lbracers"
	item_state = "lbracers"
	armor = list("blunt" = 30, "slash" = 30, "stab" = 30,  "piercing" = 15, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_LASHING, BCLASS_BITE, BCLASS_CUT)
	resistance_flags = null
	blocksound = SOFTHIT
	smeltresult = /obj/item/fertilizer/ash
	blade_dulling = DULLING_BASHCHOP
	break_sound = 'sound/foley/cloth_rip.ogg'
	drop_sound = 'sound/foley/dropsound/cloth_drop.ogg'
	anvilrepair = null
	sewrepair = TRUE
	salvage_result = null
	max_integrity = INTEGRITY_STANDARD

//THE ARMOUR VALUES OF ADVANCED AND MASTERWORK BRACERS ARE INTENDED
//KEEP THIS IN MIND
//...why the hell do they exist anyways, we got advanced/masterwork gloves.

/obj/item/clothing/wrists/bracers/leather/advanced
	name = "hardened leather bracers"
	desc = "Hardened leather braces that will keep your wrists safe from bludgeoning."
	armor = list("blunt" = 60, "slash" = 40, "stab" = 20, "piercing" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_BLUNT, BCLASS_TWIST) //We're losing stab here
	max_integrity = INTEGRITY_STANDARD + 50

/obj/item/clothing/wrists/bracers/leather/masterwork
	name = "masterwork leather bracers"
	desc = "These bracers are a craftsmanship marvel. Made with the finest leather. Strong, nimible, reliable."
	armor = list("blunt" = 80, "slash" = 60, "stab" = 40, "piercing" = 0, "fire" = 0, "acid" = 0)
	prevent_crits = list(BCLASS_CUT, BCLASS_CHOP, BCLASS_BLUNT, BCLASS_TWIST) //We're getting chop here
	max_integrity = INTEGRITY_STANDARD + 100

/obj/item/clothing/wrists/bracers/leather/masterwork/Initialize()
	. = ..()
	filters += filter(type="drop_shadow", x=0, y=0, size=0.5, offset=1, color=rgb(218, 165, 32))
