/datum/special_trait
	abstract_type = /datum/special_trait
	/// name of the trait
	var/name
	/// the text that is displayed to the user when they spawn in
	var/greet_text
	/// the requirements displayed to the user when they roll the trait in the lobby
	var/req_text
	/// the chance this trait will be rolled, the lower this is - the rarer it will roll.
	var/weight = 100
	// these are self explanatory
	var/list/allowed_sexes
	var/list/allowed_races
	var/list/allowed_ages
	var/list/allowed_patrons
	var/list/allowed_jobs
	var/list/allowed_migrants
	var/list/restricted_migrants
	var/list/restricted_traits
	var/list/restricted_races
	var/list/restricted_jobs
	var/allowed_flaw

/// check if this characters can be applied this special_trait
/datum/special_trait/proc/can_apply(mob/living/carbon/human/character)
	return TRUE

/// called after latejoin and transfercharacter in roundstart
/datum/special_trait/proc/on_apply(mob/living/carbon/human/character, silent)
	return


//// Sleep Specials
//// these should still be in the round-start/late join specials as well! It's just these are contextually fitting for Sleep Specials as well!
/datum/special_trait/nothing
	name = "Nothing"
	greet_text = span_notice("You're not special")
	weight = 7 //As rare as Vengant Bum, just to remind you it could have been it

/datum/special_trait/nightvision
	name = "Night Vision"
	greet_text = span_notice("I can easily see in the dark.")
	weight = 100

/datum/special_trait/nightvision/on_apply(mob/living/carbon/human/character, silent)
	var/obj/item/organ/eyes/eyes = character.getorganslot(ORGAN_SLOT_EYES)
	if(!eyes)
		return
	eyes.see_in_dark = 3
	eyes.lighting_alpha = LIGHTING_PLANE_ALPHA_NV_TRAIT
	character.update_sight()

/datum/special_trait/thickskin
	name = "Tough"
	greet_text = span_notice("I feel it. Thick Skin. Dense Flesh. Durable Bones. I'm a punch-taking machine.")
	weight = 100

/datum/special_trait/thickskin/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_CRITICAL_RESISTANCE, "[type]")
	character.change_stat(STATKEY_CON, 2)

/datum/special_trait/curseofcain
	name = "Flawed Immortality"
	greet_text = span_notice("I feel like I don't need to eat anymore, and my veins feel empty... Is this normal?")
	weight = 25

/datum/special_trait/curseofcain/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NOHUNGER, "[type]")
	ADD_TRAIT(character, TRAIT_NOBREATH, "[type]")

/datum/special_trait/deadened
	name = "Deadened"
	greet_text = span_notice("Ever since <b>it</b> happened, I've never been able to feel anything. Inside or out")
	weight = 25

/datum/special_trait/deadened/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NOMOOD, "[type]")
	ADD_TRAIT(character, TRAIT_NOSTINK, "[type]")

/datum/special_trait/latentmagic
	name = "Latent Magic"
	greet_text = span_notice("I have innate magical potential.")
	weight = 25

/datum/special_trait/latentmagic/on_apply(mob/living/carbon/human/character, silent)
	character.adjust_skillrank(/datum/skill/magic/arcane, 1, TRUE)

/datum/special_trait/value
	name = "Coin Counter"
	greet_text = span_notice("I know how to estimate an item's value.")
	weight = 100
	restricted_traits = list(TRAIT_SEEPRICES)

/datum/special_trait/value/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_SEEPRICES, "[type]")

/datum/special_trait/lightstep
	name = "Light Step"
	greet_text = span_notice("My steps are light, I will never trip a trap.")
	weight = 100

/datum/special_trait/lightstep/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_LIGHT_STEP, "[type]")

/datum/special_trait/night_owl
	name = "Night Owl"
	greet_text = span_notice("I've always preferred Noc over his other half.")
	weight = 100

/datum/special_trait/night_owl/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NIGHT_OWL, "[type]")

/datum/special_trait/beautiful
	name = "Beautiful"
	greet_text = span_notice("My face is a work of art")
	weight = 100

/datum/special_trait/beautiful/on_apply(mob/living/carbon/human/character, silent)
	REMOVE_TRAIT(character, TRAIT_UGLY, TRAIT_GENERIC)
	ADD_TRAIT(character, TRAIT_BEAUTIFUL, "[type]")

//positive

/datum/special_trait/eagle_eyed
	name = "Eagle Eyed"
	greet_text = span_notice("With my sharp aim I could always hit distant targets, \
	I've also hidden a crossbow and some bolts.")
	weight = 50

/datum/special_trait/eagle_eyed/on_apply(mob/living/carbon/human/character, silent)
	character.change_stat(STATKEY_PER, 2)
	character.adjust_skillrank(/datum/skill/combat/crossbows, 5, TRUE)
	character.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
	character.mind.special_items["Crossbow"] = /obj/item/gun/ballistic/revolver/grenadelauncher/crossbow
	character.mind.special_items["Bolts"] = /obj/item/ammo_holder/quiver/bolts

/datum/special_trait/mule
	name = "Mule"
	greet_text = span_notice("I've been dealing drugs and I have a stash hidden away")
	weight = 100

/datum/special_trait/mule/on_apply(mob/living/carbon/human/character, silent)
	character.mind.special_items["Stash One"] = /obj/item/storage/backpack/satchel/mule
	character.mind.special_items["Stash Two"] = /obj/item/storage/backpack/satchel/mule
	character.mind.special_items["Dagger"] = /obj/item/weapon/knife/dagger
	character.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)

/datum/special_trait/corn_fed
	name = "Corn Fed"
	greet_text = span_notice("My diet was quite rich in corn.")
	weight = 100

/datum/special_trait/corn_fed/on_apply(mob/living/carbon/human/character, silent)
	character.change_stat(STATKEY_CON, 2)
	character.change_stat(STATKEY_INT, -2)

/datum/special_trait/bookworm
	name = "Bookworm"
	greet_text = span_notice("I'm a fan of books and I enjoy reading them regularly.")
	weight = 100

/datum/special_trait/bookworm/on_apply(mob/living/carbon/human/character, silent)
	character.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)

/datum/special_trait/arsonist
	name = "Arsonist"
	greet_text = span_notice("I like seeing things combust and burn. I have hidden around two firebombs.")
	weight = 100

/datum/special_trait/arsonist/on_apply(mob/living/carbon/human/character, silent)
	character.mind.special_items["Firebomb One"] = /obj/item/explosive/bottle
	character.mind.special_items["Firebomb Two"] = /obj/item/explosive/bottle
	character.adjust_skillrank(/datum/skill/craft/alchemy, 1, TRUE)

/datum/special_trait/tombraider
	name = "Tomb Raider"
	greet_text = span_notice("It belongs in a museum. I have a whip hidden and I know how to use it.")
	weight = 50

/datum/special_trait/tombraider/on_apply(mob/living/carbon/human/character, silent)
	character.mind.special_items["Whip"] = /obj/item/weapon/whip/antique
	character.adjust_skillrank(/datum/skill/combat/whipsflails, 6, TRUE)

/datum/special_trait/psydons_rider
	name = "Psydon's Drunkest Rider"
	greet_text = span_notice("I ride! None of the laws shall stop me for that is Psydon's divine will!")
	req_text = "Worship Psydon"
	allowed_patrons = list(/datum/patron/psydon)
	weight = 100

/datum/special_trait/psydons_rider/on_apply(mob/living/carbon/human/character, silent)
	character.drunkenness = 50
	for(var/i in 1 to 2)
		var/obj/item/bottle = new /obj/item/reagent_containers/glass/bottle/wine(get_turf(character))
		character.put_in_hands(bottle, forced = TRUE)

	character.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
	new /mob/living/simple_animal/hostile/retaliate/saiga/tame/saddled(get_turf(character))

/datum/special_trait/spring_in_my_step
	name = "Spring in my Step"
	greet_text = span_notice("My legs are quite strong and where most have to climb, I can just jump")
	weight = 25

/datum/special_trait/spring_in_my_step/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_ZJUMP, "[type]")

/datum/special_trait/tolerant
	name = "Tolerant"
	greet_text = span_notice("I dream of an ideal future, one with peace between all races")
	weight = 100

/datum/special_trait/tolerant/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_TOLERANT, "[type]")

/datum/special_trait/thief
	name = "Thief"
	greet_text = span_notice("Life's not easy around here, but I've made mine a little easier by taking things of others")
	weight = 100

/datum/special_trait/thief/on_apply(mob/living/carbon/human/character, silent)
	character.adjust_skillrank(/datum/skill/misc/stealing, 5, TRUE)
	character.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
	character.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)

/datum/special_trait/languagesavant
	name = "Polyglot"
	greet_text = span_notice("I have always picked up on languages easily, \
	even those that are forbidden to mortals... except that accursed beastial chatter. What even is that nonsense?")
	weight = 50

/datum/special_trait/languagesavant/on_apply(mob/living/carbon/human/character, silent)
	character.grant_language(/datum/language/dwarvish)
	character.grant_language(/datum/language/elvish)
	character.grant_language(/datum/language/hellspeak)
	character.grant_language(/datum/language/celestial)
	character.grant_language(/datum/language/orcish)
	character.grant_language(/datum/language/deepspeak)
	character.grant_language(/datum/language/oldpsydonic)
	character.grant_language(/datum/language/zalad)
	character.grant_language(/datum/language/thievescant)

/datum/special_trait/tavernbrawler
	name = "Tavern Brawler"
	greet_text = span_notice("I love a good pub fight!")
	weight = 50

/datum/special_trait/tavernbrawler/on_apply(mob/living/carbon/human/character)
	character.clamped_adjust_skillrank(/datum/skill/combat/wrestling, 3, 4, TRUE)
	character.clamped_adjust_skillrank(/datum/skill/combat/unarmed, 3, 4, TRUE)
	character.change_stat(STATKEY_STR, 1)
	character.change_stat(STATKEY_END, 1)
	character.change_stat(STATKEY_CON, 1)

/datum/special_trait/mastercraftsmen
	name = "Master Craftsman"
	greet_text = "In my youth, I've decided I'd get a grasp on every trade, and pursued the 10 arts of the craft."
	req_text = "Middle-aged or Old"
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD)
	weight = 100

/datum/special_trait/mastercraftsmen/on_apply(mob/living/carbon/human/character)
	character.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	character.adjust_skillrank(/datum/skill/craft/weaponsmithing, 2, TRUE)
	character.adjust_skillrank(/datum/skill/craft/armorsmithing, 2, TRUE)
	character.adjust_skillrank(/datum/skill/craft/blacksmithing, 2, TRUE)
	character.adjust_skillrank(/datum/skill/craft/carpentry, 2, TRUE)
	character.adjust_skillrank(/datum/skill/craft/masonry, 2, TRUE)
	character.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE)
	character.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
	character.adjust_skillrank(/datum/skill/craft/engineering, 2, TRUE)
	character.adjust_skillrank(/datum/skill/craft/tanning, 2, TRUE)

/datum/special_trait/blueblood
	name = "Noble Lineage"
	greet_text = span_notice("I come of noble blood.")
	restricted_traits = list(TRAIT_NOBLE)
	weight = 100

/datum/special_trait/blueblood/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NOBLE, "[type]")
	character.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)

/datum/special_trait/richpouch
	name = "Rich Pouch"
	greet_text = span_notice("I've recently found a pouch filled with mammons, probably belonging to some noble.")
	weight = 100

/datum/special_trait/richpouch/on_apply(mob/living/carbon/human/character, silent)
	var/obj/item/pouch = new /obj/item/storage/belt/pouch/coins/rich(get_turf(character))
	character.put_in_hands(pouch, forced = TRUE)

/datum/special_trait/swift
	name = "Speedster"
	greet_text = span_notice("I feel like the fastest person alive and I can probably dodge anything, \
	as long as I'm not weighed down by medium or heavy armor")
	weight = 50

/datum/special_trait/swift/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_DODGEEXPERT, "[type]")
	character.adjust_skillrank(/datum/skill/misc/athletics, 6, TRUE)
	character.change_stat(STATKEY_SPD, 3)

/datum/special_trait/gourmand
	name = "Gourmand"
	greet_text = span_notice("I can eat even the most spoiled, raw, or toxic food and water as if they were delicacies..")
	weight = 100

/datum/special_trait/gourmand/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NASTY_EATER, "[type]")

/datum/special_trait/lucky
	name = "Fortune's Grace"
	greet_text = span_notice("Xylix favor me, I am extremely lucky.")
	req_text = "Have Xylix as your Patron"
	allowed_patrons = list(/datum/patron/divine/xylix)
	weight = 7

/datum/special_trait/lucky/on_apply(mob/living/carbon/human/character, silent)
	character.STALUC = rand(15, 20) //In other words, In the next round following the special, you are effectively lucky.

//neutral
/datum/special_trait/backproblems
	name = "Giant"
	greet_text = span_notice("I've always been called a giant. I am valued for my stature, but, \
	this world made for smaller folk has forced me to move cautiously.")
	req_text = "Not a kobold or dwarf"
	restricted_races = list(SPEC_ID_DWARF, SPEC_ID_KOBOLD)
	weight = 50

/datum/special_trait/backproblems/on_apply(mob/living/carbon/human/character)
	character.change_stat(STATKEY_STR, 2)
	character.change_stat(STATKEY_CON, 1)
	character.change_stat(STATKEY_SPD, -2)
	character.transform = character.transform.Scale(1.25, 1.25)
	character.transform = character.transform.Translate(0, (0.25 * 16))
	character.update_transform()

//negative
/datum/special_trait/nimrod
	name = "Nimrod"
	greet_text = span_boldwarning("In the past I learned slower than my peers, and I tend to be clumsy.")
	weight = 100

/datum/special_trait/nimrod/on_apply(mob/living/carbon/human/character, silent)
	character.change_stat(STATKEY_SPD, -2)
	character.change_stat(STATKEY_INT, -4)

/datum/special_trait/nopouch
	name = "No Pouch"
	greet_text = span_boldwarning("I lost my pouch recently, I'm without a zenny..")
	weight = 200

/datum/special_trait/nopouch/on_apply(mob/living/carbon/human/character, silent)
	var/obj/item/pouch = locate(/obj/item/storage/belt/pouch) in character
	if(character.wear_neck == pouch)
		character.wear_neck = null
	if(character.beltl == pouch)
		character.beltl = null
	if(character.beltr == pouch)
		character.beltr = null
	qdel(pouch)

/datum/special_trait/hussite
	name = "Known Heretic"
	greet_text = span_boldwarning("I've been denounced by the church for either reasons legitimate or not!")
	req_text = "Non-church role"
	weight = 20
	restricted_jobs = list(CHURCHMEN)

/datum/special_trait/hussite/on_apply(mob/living/carbon/human/character, silent)
	GLOB.excommunicated_players += character.real_name

/datum/special_trait/outlaw
	name = "Known Outlaw"
	greet_text = span_boldwarning("Whether for crimes I did or was accused of, I have been declared an outlaw!")
	weight = 20

/datum/special_trait/outlaw/on_apply(mob/living/carbon/human/character, silent)
	GLOB.outlawed_players |= character.real_name

/datum/special_trait/unlucky
	name = "Unlucky"
	greet_text = span_boldwarning("Ever since you knocked over that glass vase, you just feel... off")
	weight = 100

/datum/special_trait/unlucky/on_apply(mob/living/carbon/human/character, silent)
	character.STALUC = rand(1, 10)

/datum/special_trait/jesterphobia
	name = "Jesterphobic"
	greet_text = span_boldwarning("I have a severe, irrational fear of Jesters")
	weight = 50

/datum/special_trait/jesterphobia/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_JESTERPHOBIA, "[type]") // purely for the info text
	character.gain_trauma(/datum/brain_trauma/mild/phobia/jesters)

/datum/special_trait/wild_night
	name = "Wild Night"
	greet_text = span_boldwarning("I don't remember what I did last night, and now I'm lost!")
	weight = 200

/datum/special_trait/wild_night/on_apply(mob/living/carbon/human/character, silent)
	var/turf/location = get_spawn_turf_for_job("Pilgrim")
	character.forceMove(location)
	character.reagents.add_reagent(pick(/datum/reagent/ozium, /datum/reagent/moondust, /datum/reagent/druqks), 15)
	character.reagents.add_reagent(/datum/reagent/consumable/ethanol/beer, 72)
	grant_lit_torch(character)

/datum/special_trait/atrophy
	name = "Atrophy"
	greet_text = span_boldwarning("When growing up I could barely feed myself... this left me weak and fragile")
	weight = 50

/datum/special_trait/atrophy/on_apply(mob/living/carbon/human/character)
	character.change_stat(STATKEY_STR, -2)
	character.change_stat(STATKEY_CON, -2)
	character.change_stat(STATKEY_END, -1)

/datum/special_trait/lazy
	name = "Lazy"
	greet_text = span_boldwarning("I don't care, never did")
	weight = 50

/datum/special_trait/lazy/on_apply(mob/living/carbon/human/character)
	character.change_stat(STATKEY_STR, -1)
	character.change_stat(STATKEY_CON, -1)
	character.change_stat(STATKEY_END, -1)
	character.change_stat(STATKEY_SPD, -1)
	character.change_stat(STATKEY_PER, -1)

/datum/special_trait/bad_week
	name = "Bad Week"
	greet_text = span_boldwarning("Everything just seems to piss me off")
	weight = 100

/datum/special_trait/bad_week/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_BAD_MOOD, "[type]")

/datum/special_trait/nude_sleeper
	name = "Picky Sleeper"
	greet_text = span_boldwarning("I just can't seem to fall asleep unless I'm <i>truly</i> comfortable...")
	weight = 25

/datum/special_trait/nude_sleeper/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_NUDE_SLEEPER, "[type]")

//job specials
/datum/special_trait/punkprincess //I think everyone will like the Rebellous Prince-Like Princess. I'd love to do one for the prince as well that gives him princess loadout, but, up to you!
	name = "Rebellous Daughter"
	greet_text = span_notice("I am quite rebellious for a princess. Screw Noble Customs!")
	req_text = "Be a princess"
	allowed_sexes = list(FEMALE)
	allowed_jobs = list(/datum/job/prince)
	weight = 50

/datum/special_trait/punkprincess/on_apply(mob/living/carbon/human/character, silent)
	QDEL_NULL(character.wear_pants)
	QDEL_NULL(character.wear_shirt)
	QDEL_NULL(character.wear_armor)
	QDEL_NULL(character.shoes)
	QDEL_NULL(character.belt)
	QDEL_NULL(character.beltl)
	QDEL_NULL(character.beltr)
	QDEL_NULL(character.backr)
	QDEL_NULL(character.head)
	character.equip_to_slot_or_del(new /obj/item/clothing/pants/tights/colored/random(character), ITEM_SLOT_PANTS)
	character.equip_to_slot_or_del(new /obj/item/clothing/armor/chainmail(character), ITEM_SLOT_ARMOR)
	character.equip_to_slot_or_del(new /obj/item/storage/belt/leather(character), ITEM_SLOT_BELT)
	character.equip_to_slot_or_del(new /obj/item/storage/belt/pouch/coins/rich(character), ITEM_SLOT_BELT_R)
	character.equip_to_slot_or_del(new /obj/item/storage/backpack/satchel(character), ITEM_SLOT_BACK_R)
	character.equip_to_slot_or_del(new /obj/item/clothing/shoes/nobleboot(character), ITEM_SLOT_SHOES)
	character.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
	character.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
	character.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
	character.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	character.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	character.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	character.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	character.adjust_skillrank(/datum/skill/misc/reading, -2, TRUE)
	character.adjust_skillrank(/datum/skill/misc/sneaking, -2, TRUE)
	character.adjust_skillrank(/datum/skill/misc/stealing, -2, TRUE)

/datum/special_trait/vengantbum
	name = "Vengant Bum"
	greet_text = span_notice("I was once a nobleman, \
	high on life until my father was murdered right in front of me. \
	Thankfully, my mentor took me to safety and taught me all I needed to survive in these disgusting lands. \
	They think I am a lowlife, but that's just an advantage.")
	req_text = "Be a beggar"
	allowed_jobs = list(/datum/job/vagrant)
	weight = 7

/datum/special_trait/vengantbum/on_apply(mob/living/carbon/human/character, silent)
	ADD_TRAIT(character, TRAIT_DECEIVING_MEEKNESS, "[type]")
	character.adjust_skillrank(/datum/skill/combat/wrestling, 6, TRUE)
	character.adjust_skillrank(/datum/skill/combat/unarmed, 6, TRUE)
	character.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	character.set_stat_modifier("[type]", STATKEY_STR, 20)
	character.set_stat_modifier("[type]", STATKEY_CON, 20)
	character.set_stat_modifier("[type]", STATKEY_END, 20)

/datum/special_trait/my_precious
	name = "My Precious"
	greet_text = span_notice("The ring, it's so shiny.. so valuable, I can feel it's power. It's all mine!")
	req_text = "Be a beggar"
	allowed_jobs = list(/datum/job/vagrant)
	weight = 50

/datum/special_trait/my_precious/on_apply(mob/living/carbon/human/character, silent)
	QDEL_NULL(character.wear_pants)
	QDEL_NULL(character.wear_shirt)
	QDEL_NULL(character.wear_armor)
	QDEL_NULL(character.shoes)
	QDEL_NULL(character.head)
	var/obj/item/ring = new /obj/item/clothing/ring/dragon_ring(get_turf(character))
	character.put_in_hands(ring, forced = TRUE)

/datum/special_trait/illicit_merchant
	name = "Illicit Merchant"
	greet_text = span_notice("I'm sick of working as an underling, \
	I will start my own trade emporium. I've got my hands on a hidden merchant key and a curious magical device")
	req_text = "Be a Shophand"
	allowed_jobs = list(/datum/job/shophand)
	weight = 50

/datum/special_trait/illicit_merchant/on_apply(mob/living/carbon/human/character, silent)
	character.mind.special_items["Merchant Key"] = /obj/item/key/merchant
	character.mind.special_items["GOLDFACE Gem"] = /obj/item/gem_device/goldface

/datum/special_trait/thinker
	name = "The Thinker"
	greet_text = span_notice("Physique, Endurance, Constitution. \
	The trinity of what builds a great leader and an even greater kingdom... \
	or whatever those nimrods were yapping about! <b>I cast FIREBALL!!!</b>")
	req_text = "Monarch, worship Noc or Zizo"
	allowed_patrons = list(/datum/patron/divine/noc, /datum/patron/inhumen/zizo)
	allowed_jobs = list(/datum/job/lord)
	weight = 25 //Should be fine.

/datum/special_trait/thinker/on_apply(mob/living/carbon/human/character, silent)
	character.change_stat(STATKEY_STR, -3)
	character.change_stat(STATKEY_INT, 6)
	character.change_stat(STATKEY_CON, -1)
	character.change_stat(STATKEY_END, -1)
	character.adjust_skillrank(/datum/skill/magic/arcane, 5, TRUE)
	character.set_skillrank(/datum/skill/combat/swords, 2, TRUE) //Average only.
	character.adjust_spell_points(14) //Less points than Court Mage, why do Court mage get 17 points? what even?
	character.add_spell(/datum/action/cooldown/spell/undirected/touch/prestidigitation, silent = TRUE)
	character.generate_random_attunements(rand(4,6))
	character.mana_pool.set_intrinsic_recharge(MANA_ALL_LEYLINES)
	character.mana_pool.adjust_mana(100) //I don't know, they don't spawn with their full mana bar, so we give them a bit more mana at the start.
	new /obj/item/book/granter/spellbook/master(get_turf(character))

/datum/special_trait/skeleton
	name = "Skeleton"
	greet_text = span_boldwarning("I was- am afflicted with a curse by a lich that left me without my flesh but i still retained controls..(This is not a antagonist role, expect to be attacked unless wearing something to cover your head.)")
	allowed_jobs = list(/datum/job/pilgrim)
	req_text = "Be a Pilgrim."
	weight = 20

/datum/special_trait/skeleton/on_apply(mob/living/carbon/human/character, silent)
	character.skeletonize(FALSE)
	character.skele_look()
	character.grant_undead_eyes()
	ADD_TRAIT(character, TRAIT_NOLIMBDISABLE, "[type]")
	ADD_TRAIT(character, TRAIT_EASYDISMEMBER, "[type]")
	ADD_TRAIT(character, TRAIT_LIMBATTACHMENT, "[type]")
	ADD_TRAIT(character, TRAIT_NOHUNGER, "[type]")
	ADD_TRAIT(character, TRAIT_NOBREATH, "[type]")
	ADD_TRAIT(character, TRAIT_NOPAIN, "[type]")
	ADD_TRAIT(character, TRAIT_TOXIMMUNE, "[type]")
	character.update_body()

/datum/special_trait/overcompensating
	name = "Overcompensating"
	greet_text = span_boldwarning("I have an enormous sword on my back, I had it crafted specially for me, it left me peniless, but now nobody will mention my small pintle!.")
	allowed_jobs = list(/datum/job/vagrant)
	req_text = "Be a Beggar"
	weight = 10

/datum/special_trait/overcompensating/on_apply(mob/living/carbon/human/character, silent)
	QDEL_NULL(character.wear_pants)
	QDEL_NULL(character.wear_shirt)
	QDEL_NULL(character.wear_armor)
	QDEL_NULL(character.shoes)
	QDEL_NULL(character.belt)
	QDEL_NULL(character.beltl)
	QDEL_NULL(character.beltr)
	QDEL_NULL(character.backr)
	QDEL_NULL(character.head)
	character.equip_to_slot_or_del(new /obj/item/weapon/sword/long/greatsword/gutsclaymore(character), ITEM_SLOT_BACK_R)

/datum/special_trait/devoutknight
	name = "Devout Knight"
	greet_text = span_notice("I am a devoted warrior of the Ten, and my equipments lie hidden in their resting place, ready to be donned when the call comes.")
	allowed_jobs = list(/datum/job/royalknight)
	allowed_flaw = /datum/charflaw/addiction/godfearing
	allowed_patrons = ALL_TEMPLE_PATRONS
	req_text = "Be a Royal knight, With the Flaw 'devout follower' and be a follower of the ten."
	weight = 50

/datum/special_trait/devoutknight/on_apply(mob/living/carbon/human/character, silent)
	var/helmet = /obj/item/clothing/head/helmet/heavy/necked
	var/cloak = /obj/item/clothing/cloak/tabard/crusader/tief
	var/psycross = /obj/item/clothing/neck/psycross/g
	var/weapon = /obj/item/weapon/sword/long/judgement
	switch(character.patron?.type)
		if(/datum/patron/divine/astrata)
			psycross = /obj/item/clothing/neck/psycross/silver/astrata
			helmet = /obj/item/clothing/head/helmet/heavy/necked/astrata
			cloak = /obj/item/clothing/cloak/stabard/templar/astrata
			weapon = /obj/item/weapon/sword/long/exe/astrata
			character.cmode_music = 'sound/music/cmode/church/CombatAstrata.ogg'
		if(/datum/patron/divine/noc)
			psycross = /obj/item/clothing/neck/psycross/noc
			helmet = /obj/item/clothing/head/helmet/heavy/necked/noc
			cloak = /obj/item/clothing/cloak/stabard/templar/noc
			weapon = /obj/item/weapon/sword/sabre/noc
			character.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
			ADD_TRAIT(character, TRAIT_DUALWIELDER, TRAIT_GENERIC)
		if(/datum/patron/divine/dendor)
			psycross = /obj/item/clothing/neck/psycross/silver/dendor
			helmet = /obj/item/clothing/head/helmet/heavy/necked/dendorhelm
			cloak = /obj/item/clothing/cloak/stabard/templar/dendor
			weapon = /obj/item/weapon/polearm/halberd/bardiche/dendor
			character.cmode_music = 'sound/music/cmode/garrison/CombatForestGarrison.ogg'
			character.clamped_adjust_skillrank(/datum/skill/combat/polearms, 4, 4, TRUE)
		if(/datum/patron/divine/necra)
			psycross = /obj/item/clothing/neck/psycross/silver/necra
			helmet = /obj/item/clothing/head/helmet/heavy/necked/necra
			cloak = /obj/item/clothing/cloak/stabard/templar/necra
			weapon = /obj/item/weapon/flail/sflail/necraflail
			character.cmode_music = 'sound/music/cmode/church/CombatGravekeeper.ogg'
		if(/datum/patron/divine/pestra)
			psycross = /obj/item/clothing/neck/psycross/silver/pestra
			helmet = /obj/item/clothing/head/helmet/heavy/necked/pestrahelm
			cloak = /obj/item/clothing/cloak/stabard/templar/pestra
			weapon = /obj/item/weapon/knife/dagger/steel/pestrasickle
			character.mind.special_items["Second Weapon"] = /obj/item/weapon/knife/dagger/steel/pestrasickle
			character.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
			ADD_TRAIT(character, TRAIT_DUALWIELDER, TRAIT_GENERIC)
			character.clamped_adjust_skillrank(/datum/skill/combat/knives, 4, 4, TRUE)
			character.adjust_skillrank(/datum/skill/craft/alchemy, 2, TRUE)
		if(/datum/patron/divine/eora)
			helmet = /obj/item/clothing/head/helmet/sallet/eoran
			psycross = /obj/item/clothing/neck/psycross/silver/eora
			cloak = /obj/item/clothing/cloak/stabard/templar/eora
			weapon = /obj/item/weapon/sword/rapier/eora
			character.cmode_music = 'sound/music/cmode/church/CombatEora.ogg'
			character.mind.special_items["Eora's Gift"] = /obj/item/clothing/head/flowercrown/rosa
			ADD_TRAIT(character, TRAIT_BEAUTIFUL, TRAIT_GENERIC)
		if(/datum/patron/divine/ravox)
			psycross = /obj/item/clothing/neck/psycross/silver/ravox
			helmet = /obj/item/clothing/head/helmet/heavy/necked/ravox
			cloak = /obj/item/clothing/cloak/stabard/templar/ravox
			weapon = /obj/item/weapon/sword/long/ravox
			character.cmode_music = 'sound/music/cmode/adventurer/CombatOutlander2.ogg'
		if(/datum/patron/divine/malum)
			psycross = /obj/item/clothing/neck/psycross/silver/malum
			helmet = /obj/item/clothing/head/helmet/heavy/necked/malumhelm
			cloak = /obj/item/clothing/cloak/stabard/templar/malum
			weapon = /obj/item/weapon/mace/goden/steel/malum
			character.cmode_music = 'sound/music/cmode/adventurer/CombatOutlander2.ogg'
			character.clamped_adjust_skillrank(/datum/skill/combat/axesmaces, 4, 4, TRUE)
		if(/datum/patron/divine/abyssor)
			psycross = /obj/item/clothing/neck/psycross/silver/abyssor
			cloak = /obj/item/clothing/cloak/stabard/templar/abyssor
			weapon = /obj/item/weapon/polearm/spear/abyssor
			character.cmode_music = 'sound/music/cmode/adventurer/CombatMonk.ogg'
			character.adjust_skillrank(/datum/skill/labor/fishing, 1, TRUE)
			character.clamped_adjust_skillrank(/datum/skill/combat/polearms, 4, 4, TRUE)
		if(/datum/patron/divine/xylix)
			psycross = /obj/item/clothing/neck/psycross/silver/xylix
			helmet = /obj/item/clothing/head/helmet/heavy/necked/xylix
			cloak = /obj/item/clothing/cloak/stabard/templar/xylix
			weapon = /obj/item/weapon/whip/xylix
			character.clamped_adjust_skillrank(/datum/skill/combat/whipsflails, 4, 4, TRUE)
		if(/datum/patron/inhumen/graggar_zizo) //In case a admin decide to give them graggazo roundstart
			psycross = /obj/item/clothing/ring/silver/toper
			helmet = /obj/item/clothing/head/helmet/graggar
			cloak = /obj/item/clothing/cloak/graggar
			weapon = /obj/item/weapon/sword/long/judgement/evil
	if(!character.has_language(/datum/language/celestial))
		character.grant_language(/datum/language/celestial)
		to_chat(character, span_info("I can speak Celestial with ,c before my speech."))
	character.mind.special_items["Weapon"] = weapon
	character.mind.special_items["Tabard"] = cloak
	character.mind.special_items["Psycross"] = psycross
	character.mind.special_items["Helmet"] = helmet

/datum/special_trait/meow
	name = "Meow"
	greet_text = span_boldwarning("What?")
	req_text = "???"
	weight = 1

/datum/special_trait/meow/on_apply(mob/living/carbon/human/character, silent)
	var/mob/living/simple_animal/pet/cat/catte = new(get_turf(character))
	catte.real_name = character.real_name
	catte.name = character.real_name
	catte.desc = "This cat seems a little.. strange..."
	catte.ckey = character.ckey
	qdel(character)
