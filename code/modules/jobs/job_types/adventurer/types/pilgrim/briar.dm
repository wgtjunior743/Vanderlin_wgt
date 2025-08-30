/datum/advclass/pilgrim/briar
	name = "Briar"
	allowed_sexes = list(MALE, FEMALE)

	outfit = /datum/outfit/job/adventurer/briar
	category_tags = list(CTAG_PILGRIM)
	tutorial = "Stoic gardeners or flesh-eating predators, all can follow Dendors path. <br>His Briars scorn civilized living, many embracing their animal nature, being fickle and temperamental."
//	allowed_patrons = list(/datum/patron/divine/dendor)		this doesn't work so long its a subclass type. Besides its preferable to forceswitch as it does to make selection less clunky.
	cmode_music = 'sound/music/cmode/garrison/CombatForestGarrison.ogg'
	maximum_possible_slots = 4	// to be lowered to 2? once testing is done

/datum/outfit/job/adventurer/briar/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_SEEDKNOW, TRAIT_GENERIC)

	belt = /obj/item/storage/belt/leather/rope
	mask = /obj/item/clothing/face/druid
	neck = /obj/item/clothing/neck/psycross/silver/dendor
	shirt = /obj/item/clothing/armor/leather/vest
	armor = /obj/item/clothing/shirt/robe/dendor
	wrists = /obj/item/clothing/wrists/bracers/leather
	beltl = /obj/item/weapon/knife/stone
	backl = /obj/item/weapon/mace/goden/shillelagh

	H.change_stat(STATKEY_STR, 1)
	H.change_stat(STATKEY_END, 1)
	H.change_stat(STATKEY_INT, -1)

	if(H.mind)
		if(H.patron != /datum/patron/divine/dendor)
			H.set_patron(/datum/patron/divine/dendor, TRUE) //Yeah, no sorry, you're an antag, you can't do dendor things.

		H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.adjust_skillrank(/datum/skill/magic/holy, 3, TRUE)
		H.adjust_skillrank(/datum/skill/labor/taming, 4, TRUE)
		H.adjust_skillrank(/datum/skill/craft/tanning, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/riding, 1, TRUE)
		H.adjust_skillrank(/datum/skill/labor/butchering, 2, TRUE)
		H.adjust_skillrank(/datum/skill/labor/farming, 3, TRUE)
		H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.mind.teach_crafting_recipe(/datum/repeatable_crafting_recipe/dendor/shillelagh)
		H.mind.teach_crafting_recipe(/datum/repeatable_crafting_recipe/dendor/forestdelight)

		if(H.age == AGE_OLD)
			H.adjust_skillrank(/datum/skill/magic/holy, 1, TRUE)

		// the unique Dendor crafting recipes. Dendor shrines (pantheon cross) and alt cosmetic helmet
		H.mind.teach_crafting_recipe(/datum/repeatable_crafting_recipe/dendor/visage)
		H.mind.teach_crafting_recipe(/datum/blueprint_recipe/dendor/shrine)
		H.mind.teach_crafting_recipe(/datum/blueprint_recipe/dendor/shrine/saiga)
		H.mind.teach_crafting_recipe(/datum/blueprint_recipe/dendor/shrine/volf)
		H.mind.teach_crafting_recipe(/datum/blueprint_recipe/dendor/shrine/troll)
		H.mind.teach_crafting_recipe(/datum/repeatable_crafting_recipe/dendor/sacrifice_growing)
		H.mind.teach_crafting_recipe(/datum/repeatable_crafting_recipe/dendor/sacrifice_stinging)
		H.mind.teach_crafting_recipe(/datum/repeatable_crafting_recipe/dendor/sacrifice_devouring)
		H.mind.teach_crafting_recipe(/datum/repeatable_crafting_recipe/dendor/sacrifice_lording)

	ADD_TRAIT(H, TRAIT_HEAD_BUTCHER, TRAIT_GENERIC)
	var/holder = H.patron?.devotion_holder
	if(holder)
		var/datum/devotion/devotion = new holder()
		devotion.make_acolyte()
		devotion.grant_to(H)

/datum/outfit/job/adventurer/briar
	var/tutorial = "<br><br><font color='#44720e'><span class='bold'>You know well how to make a shrine to Dendor, wood, thorns, and the head of a favored animal.<br><br>Choose a path stinging, devouring or growing, and make your sacrifices...<br><br>Remember - Dendor will only grant special powers from Blessing the first time you do recieve it, and only those mastering all his Miracles can unlock their full potential.  </span></font><br><br>"

/datum/outfit/job/adventurer/briar/post_equip(mob/living/carbon/human/H)
	..()
	to_chat(H, tutorial)

/obj/item/dendor_blessing
	name = "growing blessing of Dendor"
	icon = 'icons/roguetown/misc/magick.dmi'
	icon_state = "dendor_grow"
	plane = -1
	layer = 4.2
	alpha = 155
	var/associated_shrine = /obj/structure/fluff/psycross/crafted/shrine/dendor_gote

/obj/item/dendor_blessing/attack_atom(atom/attacked_atom, mob/living/user)
	if(!istype(attacked_atom, associated_shrine))
		return ..()

	. = TRUE
	if(ishuman(user) && user.patron.type == /datum/patron/divine/dendor)
		if(!check_blessing_requirements(user))
			return
		icon_state = "[icon_state]_end"

		if(!do_after(user, 3 SECONDS, target = src, display_over_user = TRUE))
			icon_state = initial(icon_state)
			return

		record_round_statistic(STATS_DENDOR_SACRIFICES)
		if(HAS_TRAIT(user, TRAIT_BLESSED))
			to_chat(user, span_info("Dendor will not grant more powers, but he still approves of the sacrifice, judging by the signs..."))
			user.apply_status_effect(/datum/status_effect/buff/blessed)
			qdel(src)
			return

		ADD_TRAIT(user, TRAIT_BLESSED, TRAIT_GENERIC)
		INVOKE_ASYNC(src, PROC_REF(give_blessing), user)
		qdel(src)
	else
		to_chat(user, span_warning("Dendor finds me unworthy of his blessings..."))
	return

/obj/item/dendor_blessing/proc/check_blessing_requirements(mob/living/user)
	return TRUE

/obj/item/dendor_blessing/proc/give_blessing(mob/living/carbon/human/user)
	playsound(get_turf(user), 'sound/vo/smokedrag.ogg', 100, TRUE)
	playsound(get_turf(user), 'sound/misc/wind.ogg', 100, TRUE, -1)
	to_chat(user, span_good("Plants grow rampant with your every step... things that constrain no longer impede you."))
	user.emote("smile")
	ADD_TRAIT(user, TRAIT_WEBWALK, TRAIT_GENERIC)
	user.add_spell(/datum/action/cooldown/spell/undirected/touch/entangler, source = user.cleric)
	user.apply_status_effect(/datum/status_effect/buff/calm)

/*	.................   Yellow Blessings of Dendor   ................... */
/obj/item/dendor_blessing/stinging
	name = "stinging blessing of Dendor"
	icon_state = "dendor_sting"
	associated_shrine = /obj/structure/fluff/psycross/crafted/shrine/dendor_saiga

/obj/item/dendor_blessing/stinging/give_blessing(mob/living/carbon/human/user)
	playsound(get_turf(user), 'sound/vo/smokedrag.ogg', 100, TRUE)
	playsound(get_turf(user), 'sound/misc/wind.ogg', 100, TRUE, -1)
	to_chat(user, span_good("You feel as if light follows your every step... your foraging will be easier from now on, surely."))
	user.emote("smile")
	ADD_TRAIT(user, TRAIT_FORAGER, TRAIT_GENERIC)
	ADD_TRAIT(user, TRAIT_MIRACULOUS_FORAGING, TRAIT_GENERIC)
	user.add_spell(/datum/action/cooldown/spell/conjure/kneestingers, source = user.cleric)
	user.apply_status_effect(/datum/status_effect/buff/calm)

/*	.................  Red Blessings of Dendor   ................... */
/obj/item/dendor_blessing/devouring
	name = "devouring blessing of Dendor"
	icon_state = "dendor_consume"
	associated_shrine = /obj/structure/fluff/psycross/crafted/shrine/dendor_volf

/obj/item/dendor_blessing/devouring/check_blessing_requirements(mob/living/user)
	if(!user.get_spell(/datum/action/cooldown/spell/undirected/bless_crops))
		to_chat(user, span_warning("My faith to Dendor isn't sufficient enough..."))
		return FALSE
	return ..()

/obj/item/dendor_blessing/devouring/give_blessing(mob/living/user)
	playsound(get_turf(user), 'sound/vo/smokedrag.ogg', 100, TRUE)
	to_chat(user, span_danger("A volf howls far away...and your teeth begin to sear with pain!"))
	playsound(get_turf(user), 'sound/vo/mobs/wwolf/idle (1).ogg', 50, TRUE)
	user.Immobilize(2 SECONDS)
	sleep(2 SECONDS)

	user.emote("pain")
	sleep(0.5 SECONDS)

	playsound(get_turf(user), 'sound/combat/fracture/fracturewet (1).ogg', 70, TRUE, -1)
	user.Immobilize(30)
	sleep(3.5 SECONDS)

	to_chat(user, span_warning("My incisors transform to predatory fangs!"))
	playsound(get_turf(user), 'sound/combat/fracture/fracturewet (1).ogg', 70, TRUE, -1)
	user.emote("rage", forced = TRUE)
	ADD_TRAIT(user, TRAIT_STRONGBITE, TRAIT_GENERIC)
	ADD_TRAIT(user, TRAIT_BESTIALSENSE, TRAIT_GENERIC)
	user.update_sight()

	user.remove_spell(/datum/action/cooldown/spell/undirected/bless_crops)
	user.apply_status_effect(/datum/status_effect/buff/barbrage/briarrage)
	to_chat(user, span_warning("Things that grow no longer interests me, the desire to hunt fills my heart!"))

/*	.................  Purple Blessings of Dendor   ................... */
/obj/item/dendor_blessing/lording
	name = "lording blessing of Dendor"
	icon_state = "dendor_lord"
	associated_shrine = /obj/structure/fluff/psycross/crafted/shrine/dendor_troll

/obj/item/dendor_blessing/lording/check_blessing_requirements(mob/living/user)
	if(!user.get_spell(/datum/action/cooldown/spell/healing))
		to_chat(user, span_warning("My faith to Dendor isn't sufficient enough..."))
		return FALSE
	return ..()

/obj/item/dendor_blessing/lording/give_blessing(mob/living/carbon/human/user)
	playsound(get_turf(user), 'sound/vo/smokedrag.ogg', 100, TRUE)
	playsound(get_turf(user), pick('sound/vo/mobs/troll/idle1.ogg','sound/vo/mobs/troll/idle2.ogg'), 50, TRUE)
	to_chat(user, span_good("The rumblings of a troll echoes through the trees. Your offering was acknowledged by the ancient dwellers of the forest."))
	user.emote("rage", forced = TRUE)
	user.physiology.pain_mod *= 0.6 // to offset the lack of healing and the damage conversion from troll form
	user.remove_spell(/datum/action/cooldown/spell/healing)
	user.add_spell(/datum/action/cooldown/spell/undirected/troll_shape, source = user.cleric)
	user.add_spell(/datum/action/cooldown/spell/undirected/shapeshift/troll_form)
	to_chat(user, span_warning("I no longer care for mending wounds, let the lords of the forest be known!"))
