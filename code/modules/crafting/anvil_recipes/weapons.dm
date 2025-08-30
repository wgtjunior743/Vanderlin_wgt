/datum/anvil_recipe/weapons
	appro_skill = /datum/skill/craft/weaponsmithing
	i_type = "Weapons"
	abstract_type = /datum/anvil_recipe/weapons
	category = "Weapons"


////////////////////////////////////
// --------- TIN -----------
//honestly the only tin "weapon" that comes to mind would be lead bullets
/datum/anvil_recipe/weapons/tin
	abstract_type = /datum/anvil_recipe/weapons/tin
	req_bar = /obj/item/ingot/tin
	craftdiff = 0
////////////////////////////////////

/datum/anvil_recipe/weapons/tin/lead_bullet
	name = "4x Lead Bullets"
	recipe_name = "a handful of lead bullets."
	created_item = /obj/item/ammo_casing/caseless/bullet
	craftdiff = 1
	createditem_extra = 3

//////////////////////////////////////////////////////////////////////////////////////////////
// --------- COPPER -----------
/datum/anvil_recipe/weapons/copper
	abstract_type = /datum/anvil_recipe/weapons/copper
	req_bar = /obj/item/ingot/copper
	craftdiff = 0
///////////////////////////////////////////////

/datum/anvil_recipe/weapons/copper/caxe
	name = "Copper Hatchet (+Bar)"
	recipe_name = "an Axe"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/ingot/copper)
	created_item = /obj/item/weapon/axe/copper

/datum/anvil_recipe/weapons/copper/cbludgeon
	name = "Copper Bludgeon (+Stick)"
	recipe_name = "a Bludgeon"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/mace/bludgeon/copper

/datum/anvil_recipe/weapons/copper/cdagger
	name = "x2 Copper Daggers"
	recipe_name = "a couple Daggers"
	appro_skill = /datum/skill/craft/weaponsmithing
	created_item = /obj/item/weapon/knife/copper
	createditem_extra = 1

//datum/anvil_recipe/weapons/copper/cmace
//	name = "Mace (2)"
//	recipe_name = "a Mace"
//	appro_skill = /datum/skill/craft/weaponsmithing
//	req_bar = /obj/item/ingot/copper
//	additional_items = list(/obj/item/ingot/copper)
//	created_item = (/obj/item/weapon/mace/coppermace)
//	craftdiff = 0

/datum/anvil_recipe/weapons/copper/cmesser
	name = "Copper Messer (+Stick)"
	recipe_name = "a Messer"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/sword/coppermesser

/datum/anvil_recipe/weapons/copper/cspears
	name = "2x Copper Javelins (+Small Log)"
	recipe_name = "two Spears"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/polearm/spear/stone/copper
	createditem_extra = 1

/datum/anvil_recipe/weapons/copper/cfalx
	name = "Copper Falx (+Bar)"
	recipe_name = "a great copper sword"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/ingot/copper)
	created_item = /obj/item/weapon/sword/long/rider/copper

// --------- BRONZE -----------
/datum/anvil_recipe/weapons/bronze
	abstract_type = /datum/anvil_recipe/weapons/bronze
	req_bar = /obj/item/ingot/bronze
	craftdiff = 1
///////////////////////////////////////////////

/datum/anvil_recipe/weapons/bronze/gladius
	name = "Gladius"
	created_item = /obj/item/weapon/sword/gladius

/datum/anvil_recipe/weapons/bronze/spear
	name = "Bronze Spear (+Bar, +Small Log)"
	additional_items = list(/obj/item/ingot/bronze, /obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/polearm/spear/bronze

// --------- IRON ------------ Middle Tier, what most disgusting Men at Arms have
/datum/anvil_recipe/weapons/iron
	abstract_type = /datum/anvil_recipe/weapons/iron
	req_bar = /obj/item/ingot/iron
	craftdiff = 1
///////////////////////////////////////////////

/datum/anvil_recipe/weapons/iron/arrows
	name = "5x Arrows (+Plank)"
	recipe_name = "five Arrows"
	appro_skill = /datum/skill/craft/engineering
	additional_items = list(/obj/item/natural/wood/plank)
	created_item = /obj/item/ammo_casing/caseless/arrow
	createditem_extra = 4
	i_type = "Ammo"
	craftdiff = 0

/datum/anvil_recipe/weapons/iron/bolts
	name = "5x Crossbow Bolts (+Plank)"
	recipe_name = "five Crossbow Bolts"
	appro_skill = /datum/skill/craft/engineering
	additional_items = list(/obj/item/natural/wood/plank)
	created_item = /obj/item/ammo_casing/caseless/bolt
	createditem_extra = 4
	i_type = "Ammo"

/datum/anvil_recipe/weapons/iron/axe_iron
	name = "Iron Axe (+Stick)"
	recipe_name = "an Axe"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/axe/iron

/datum/anvil_recipe/weapons/iron/bardiche
	name = "Bardiche (+Bar, +Small Log)"
	recipe_name = "a Bardiche"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/ingot/iron,/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/polearm/halberd/bardiche
	craftdiff = 2

/datum/anvil_recipe/weapons/iron/woodcutter
	name = "Woodcutter Axe (+Small Log)"
	recipe_name = "a great axe for woodcutters"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/polearm/halberd/bardiche/woodcutter

/datum/anvil_recipe/weapons/iron/warcutter
	name = "Footman War Axe (+Bar, +Small Log)"
	recipe_name = "a war greataxe"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/ingot/iron,/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/polearm/halberd/bardiche/warcutter
	craftdiff = 2

/datum/anvil_recipe/weapons/iron/dagger_iron
	name = "Dagger x2"
	recipe_name = "a couple Daggers"
	appro_skill = /datum/skill/craft/weaponsmithing
	created_item = /obj/item/weapon/knife/dagger
	createditem_extra = 1
	craftdiff = 0 // To train with

/datum/anvil_recipe/weapons/iron/dagger_iron
	name = "3x Villager Knives"
	recipe_name = "three peasantry knives"
	appro_skill = /datum/skill/craft/weaponsmithing
	created_item = /obj/item/weapon/knife/villager
	createditem_extra = 2
	craftdiff = 0

/datum/anvil_recipe/weapons/iron/cleaver
	name = "Cleaver"
	recipe_name = "a Cleaver"
	appro_skill = /datum/skill/craft/weaponsmithing
	created_item = /obj/item/weapon/knife/cleaver

/datum/anvil_recipe/weapons/iron/flail_iron
	name = "Militia flail (+Chain, +Stick)"
	recipe_name = "a militia flail"
	additional_items = list(/obj/item/rope/chain, /obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/flail/militia

/datum/anvil_recipe/weapons/iron/lucerne
	name = "Lucerne (+Bar, +Small Log)"
	recipe_name = "a Lucerne"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/ingot/iron,/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/polearm/eaglebeak/lucerne
	craftdiff = 2

/datum/anvil_recipe/weapons/iron/sledgehammer
	name = "Sledgehammer (+Small Log)"
	recipe_name = "a big hammer"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = 	/obj/item/weapon/hammer/sledgehammer

/datum/anvil_recipe/weapons/iron/mace_iron
	name = "Iron Mace (+Stick)"
	recipe_name = "a Mace"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/mace

/datum/anvil_recipe/weapons/iron/ibludgeon
	name = "Iron Bludgeon (+Stick)"
	recipe_name = "a Bludgeon"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/mace/bludgeon

/datum/anvil_recipe/weapons/iron/warhammer
	name = "Iron Warhammer (+1 Stick)"
	recipe_name = "a Warhammer"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/mace/warhammer

/datum/anvil_recipe/weapons/iron/messer_iron
	name = "Messer"
	recipe_name = "a Messer"
	created_item = /obj/item/weapon/sword/scimitar/messer

/datum/anvil_recipe/weapons/iron/spear_iron
	name = "2x Spears (+Small Log)"
	recipe_name = "a couple Spears"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/polearm/spear
	createditem_extra = 1

/datum/anvil_recipe/weapons/iron/shortsword_iron
	name = "Short Sword"
	recipe_name = "a Short Sword"
	created_item = /obj/item/weapon/sword/short

/datum/anvil_recipe/weapons/iron/sword_iron
	name = "Sword"
	recipe_name = "a Sword"
	appro_skill = /datum/skill/craft/weaponsmithing
	created_item = /obj/item/weapon/sword/iron
	craftdiff = 0

/datum/anvil_recipe/weapons/iron/sword_iron
	name = "Estoc"
	recipe_name = "a Duelist Sword"
	appro_skill = /datum/skill/craft/weaponsmithing
	created_item = /obj/item/weapon/sword/rapier/ironestoc

/datum/anvil_recipe/weapons/iron/towershield
	name = "Tower Shield (+Small Log)"
	recipe_name = "a Tower Shield"
	appro_skill = /datum/skill/craft/armorsmithing
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/shield/tower
	craftdiff = 2

/datum/anvil_recipe/weapons/iron/ironbuckler
	name = "Iron Buckler"
	recipe_name = "a small Shield"
	appro_skill = /datum/skill/craft/armorsmithing
	created_item = /obj/item/weapon/shield/tower/buckleriron

/datum/anvil_recipe/weapons/iron/warclub
	name = "Warclub (+Small Log)"
	recipe_name = "a Warclub"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/mace/goden
	craftdiff = 2

/datum/anvil_recipe/weapons/iron/zweihander
	name = "Zweihander (+Bar x2)"
	recipe_name = "a Zweihander"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/ingot/iron, /obj/item/ingot/iron)
	created_item = /obj/item/weapon/sword/long/greatsword/zwei
	craftdiff = 3

/datum/anvil_recipe/weapons/iron/elvenclub
	name = "Elven Warclub"
	recipe_name = "a Warclub"
	appro_skill = /datum/skill/craft/weaponsmithing
	created_item = /obj/item/weapon/mace/elvenclub
	craftdiff = 2

// --------- STEEL ------------  Fancy gear for Knights
/datum/anvil_recipe/weapons/steel
	abstract_type = /datum/anvil_recipe/weapons/steel
	req_bar = /obj/item/ingot/steel
	craftdiff = 2
///////////////////////////////////////////////

/datum/anvil_recipe/weapons/steel/axe_steel
	name = "Steel Axe (+Stick)"
	recipe_name = "an Axe"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/axe/steel

/datum/anvil_recipe/weapons/steel/sledgehammer
	name = "Steel Sledgehammer (+Small Log)"
	recipe_name = "a big Sledgehammer"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = 	/obj/item/weapon/hammer/sledgehammer/war

/datum/anvil_recipe/weapons/steel/battleaxe
	name = "Battle Axe (+Bar x2)"
	recipe_name = "a Battle Axe"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/weapon/axe/battle
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/billhook
	name = "Billhook (+Small Log)"
	recipe_name = "a Billhook"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/polearm/spear/billhook
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/cutlass_steel
	name = "Cutlass"
	recipe_name = "a Cutlass"
	appro_skill = /datum/skill/craft/weaponsmithing
	created_item = /obj/item/weapon/sword/sabre/cutlass

/datum/anvil_recipe/weapons/steel/dagger_steel
	name = "2x Steel Daggers"
	recipe_name = "a couple Daggers"
	appro_skill = /datum/skill/craft/weaponsmithing
	created_item = /obj/item/weapon/knife/dagger/steel
	createditem_extra = 1
	craftdiff = 1

/datum/anvil_recipe/weapons/steel/decsaber
	name = "Decorated Sabre (+Gold Bar)"
	recipe_name = "a Decorated Sabre"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/ingot/gold)
	created_item = /obj/item/weapon/sword/sabre/dec
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/decsword
	name = "Decorated Sword (+Gold Bar)"
	recipe_name = "a Decorated Sword"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/ingot/gold)
	created_item = /obj/item/weapon/sword/decorated
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/decrapier
	name = "Decorated Rapier (+Gold Bar)"
	recipe_name = "a Decorated Rapier"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/ingot/gold)
	created_item = /obj/item/weapon/sword/rapier/dec
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/eaglebeak
	name = "Eagle's Beak (+Bar, +Small Log)"
	recipe_name = "an Eagle's Beak"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/ingot/steel,/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/polearm/eaglebeak
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/flail_steel
	name = "Steel Flail (+Chain, +Stick)"
	recipe_name = "a Flail"
	additional_items = list(/obj/item/rope/chain, /obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/flail/sflail

/datum/anvil_recipe/weapons/steel/grandmace
	name = "Grand Mace (+Small Log)"
	recipe_name = "a Grand Mace"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/mace/goden/steel
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/greatsword
	name = "Greatsword (+Bar x2)"
	recipe_name = "a Greatsword"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/ingot/steel, /obj/item/ingot/steel)
	created_item = /obj/item/weapon/sword/long/greatsword
	craftdiff = 4

/datum/anvil_recipe/weapons/steel/halberd
	name = "Halberd (+Bar, +Small Log)"
	recipe_name = "a Halberd"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/ingot/steel,/obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/polearm/halberd
	craftdiff = 4

/datum/anvil_recipe/weapons/steel/huntknife
	name = "Hunting Knife"
	recipe_name = "a Hunting Knife"
	appro_skill = /datum/skill/craft/weaponsmithing
	created_item = /obj/item/weapon/knife/hunting

/datum/anvil_recipe/weapons/steel/kiteshield
	name = "Kite Shield (+Bar, +Hide)"
	recipe_name = "a Kite Shield"
	appro_skill = /datum/skill/craft/armorsmithing
	additional_items = list(/obj/item/ingot/steel,/obj/item/natural/hide)
	created_item = /obj/item/weapon/shield/tower/metal
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/longsword
	name = "Longsword (+Bar)"
	recipe_name = "a Longsword"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/weapon/sword/long
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/mace_steel
	name = "Steel Mace (+Bar)"
	recipe_name = "a Mace"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/weapon/mace/steel

/datum/anvil_recipe/weapons/steel/swarhammer
	name = "Steel Warhammer (+Bar)"
	recipe_name = "a Warhammer"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/weapon/mace/warhammer/steel

/datum/anvil_recipe/weapons/steel/peasant_flail
	name = "Peasant Flail (+Chain, +Small Log)"
	recipe_name = "a two-handed flail"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/rope/chain, /obj/item/grown/log/tree/small)
	created_item = /obj/item/weapon/flail/peasant
	craftdiff = 3

/datum/anvil_recipe/weapons/iron/chain_whip
	name = "Chain Whip (+chain)"
	recipe_name = "a whip made from chains"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/rope/chain)
	created_item = /obj/item/weapon/whip/chain
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/paxe
	name = "Pick-Axe (+Bar, +Stick)"
	recipe_name = "a Pick that is also an Axe"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/ingot/steel, /obj/item/grown/log/tree/stick)
	created_item = /obj/item/weapon/pick/paxe
	craftdiff = 3

/datum/anvil_recipe/weapons/steel/rapier_steel
	name = "Rapier"
	recipe_name = "a Rapier"
	appro_skill = /datum/skill/craft/weaponsmithing
	created_item = /obj/item/weapon/sword/rapier

/datum/anvil_recipe/weapons/steel/saber_steel
	name = "Sabre"
	recipe_name = "a Sabre"
	appro_skill = /datum/skill/craft/weaponsmithing
	created_item = /obj/item/weapon/sword/sabre

/datum/anvil_recipe/weapons/steel/sword_steel
	name = "Arming Sword"
	recipe_name = "a Sword"
	appro_skill = /datum/skill/craft/weaponsmithing
	created_item = /obj/item/weapon/sword/arming

/datum/anvil_recipe/weapons/steel/scimitar_steel
	name = "Scimitar"
	recipe_name = "a Zalad Sword"
	appro_skill = /datum/skill/craft/weaponsmithing
	created_item = /obj/item/weapon/sword/scimitar

/datum/anvil_recipe/weapons/steel/falchion
	name = "Falchion"
	recipe_name = "a heavy one handed sword"
	appro_skill = /datum/skill/craft/weaponsmithing
	created_item = /obj/item/weapon/sword/scimitar/falchion

/datum/anvil_recipe/weapons/steel/elvenclub
	name = "Regal Elven Warclub (+Gold bar)"
	recipe_name = "a Elven Warclub"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/ingot/gold)
	created_item = /obj/item/weapon/mace/elvenclub/steel

// --------- SILVER ------------  Harder to craft, does less damage and has less durability than steel, but banes undead.

/datum/anvil_recipe/weapons/silver
	abstract_type = /datum/anvil_recipe/weapons/silver
	req_bar = /obj/item/ingot/silver
	craftdiff = 4
///////////////////////////////////////////////

/datum/anvil_recipe/weapons/silver/dagger
	name = "Silver Dagger"
	recipe_name = "a Silver Dagger"
	appro_skill = /datum/skill/craft/weaponsmithing
	created_item = /obj/item/weapon/knife/dagger/silver
	craftdiff = 3

/datum/anvil_recipe/weapons/silver/silver_whip
	name = "Silver Whip (+2 Cured Hide)"
	recipe_name = "a whip made modified with silver"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/natural/hide/cured,/obj/item/natural/hide/cured)
	created_item = /obj/item/weapon/whip/silver

/datum/anvil_recipe/weapons/silver/sword_silver
	name = "Silver Sword"
	recipe_name = "a Silver Sword"
	appro_skill = /datum/skill/craft/weaponsmithing
	created_item = /obj/item/weapon/sword/silver

/datum/anvil_recipe/weapons/silver/rapier_silver
	name = "Silver Rapier"
	recipe_name = "a Silver Rapier"
	appro_skill = /datum/skill/craft/weaponsmithing
	created_item = /obj/item/weapon/sword/rapier/silver

/datum/anvil_recipe/weapons/silver/forgotten
	name = "Forgotten Blade (+Steel Bar)"
	recipe_name = "a Forgotten Blade"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/ingot/steel)
	created_item = /obj/item/weapon/sword/long/forgotten

/datum/anvil_recipe/weapons/silver/declong
	name = "Decorated Silver Longsword (+Silver bar, +Gold bar)"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/ingot/silver, /obj/item/ingot/gold)
	created_item = /obj/item/weapon/sword/long/decorated

/datum/anvil_recipe/weapons/silver/noble_sword_scabbard
	name = "Decorated Silver Sword Scabbard (+Scabbard)"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/weapon/scabbard/sword)
	created_item = /obj/item/weapon/scabbard/sword/noble

/datum/anvil_recipe/weapons/silver/noble_knife_sheath
	name = "Decorated Silver Knife Sheath (+Sheath)"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/weapon/scabbard/knife)
	created_item = /obj/item/weapon/scabbard/knife/noble

/datum/anvil_recipe/weapons/gold
	abstract_type = /datum/anvil_recipe/weapons/gold
	req_bar = /obj/item/ingot/gold
	craftdiff = 5

/datum/anvil_recipe/weapons/gold/noble_sword_scabbard
	name = "Decorated Golden Sword Scabbard (+Scabbard)"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/weapon/scabbard/sword)
	created_item = /obj/item/weapon/scabbard/sword/royal

/datum/anvil_recipe/weapons/gold/noble_knife_sheath
	name = "Decorated Golden Knife Sheath (+Sheath)"
	appro_skill = /datum/skill/craft/weaponsmithing
	additional_items = list(/obj/item/weapon/scabbard/knife)
	created_item = /obj/item/weapon/scabbard/knife/royal

