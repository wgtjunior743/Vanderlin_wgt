/obj/item/reagent_containers/food/snacks/smallrat
	name = "rat"
	desc = ""
	icon_state = "srat"
	icon = 'icons/roguetown/mob/monster/rat.dmi'
	list_reagents = list(/datum/reagent/consumable/nutriment = 5)
	foodtype = RAW
	verb_say = "squeaks"
	verb_yell = "squeaks"
	pass_flags = PASSDOORS
	obj_flags = CAN_BE_HIT
	var/dead = FALSE
	eat_effect = /datum/status_effect/debuff/uncookedfood
	max_integrity = 10
	sellprice = 0
	rotprocess = null

/obj/item/reagent_containers/food/snacks/smallrat/onbite(mob/living/carbon/human/user)
	if(loc == user)
		if(user.clan)
			if(do_after(user, 3 DECISECONDS, src))
				user.visible_message("<span class='warning'>[user] drinks from [src]!</span>",\
				"<span class='warning'>I drink from [src].</span>")
				playsound(user.loc, 'sound/misc/drink_blood.ogg', 100, FALSE, -4)

				user.adjust_bloodpool(50)
				var/blood_handle = BLOOD_PREFERENCE_RATS
				if(dead)
					blood_handle |= BLOOD_PREFERENCE_DEAD
				else
					blood_handle |= BLOOD_PREFERENCE_LIVING
				user.clan.handle_bloodsuck(user, blood_handle)
				playsound(get_turf(user), 'sound/vo/mobs/rat/rat_death.ogg', 100, FALSE, -1)
				if(dead)
					qdel(src)
					return
				icon_state = "srat1"
				rotprocess = SHELFLIFE_SHORT
				dead = TRUE
			return
	return ..()

/obj/item/reagent_containers/food/snacks/friedrat
	name = "fried rat"
	icon_state = "cookedrat"
	bitesize = 2
	list_reagents = list(/datum/reagent/consumable/nutriment = 4)
	w_class = WEIGHT_CLASS_TINY
	tastes = list("burnt flesh" = 1)
	rotprocess = SHELFLIFE_SHORT
	sellprice = 0
	plateable = TRUE

/obj/item/reagent_containers/food/snacks/smallrat/burning(input as num)
	if(!dead)
		if(burning >= burntime)
			dead = TRUE
			playsound(src, 'sound/vo/mobs/rat/rat_death.ogg', 100, FALSE, -1)
			icon_state = "srat1"
			rotprocess = SHELFLIFE_SHORT
	. = ..()

/obj/item/reagent_containers/food/snacks/smallrat/Crossed(mob/living/L)
	. = ..()
	if(L)
		if(!dead)
			if(isturf(loc))
				dir = pick(GLOB.cardinals)
				step(src, dir)
//				playsound(src, pick('sound/vo/mobs/rat/rat_life.ogg','sound/vo/mobs/rat/rat_life2.ogg','sound/vo/mobs/rat/rat_life3.ogg'), 100, TRUE, -1)



/obj/item/reagent_containers/food/snacks/smallrat/dead
	icon_state = "srat1"
	dead = TRUE
	rotprocess = SHELFLIFE_SHORT

/obj/item/reagent_containers/food/snacks/smallrat/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)
	if(dead)
		icon_state = "srat1"
		rotprocess = SHELFLIFE_SHORT

/obj/item/reagent_containers/food/snacks/smallrat/attack_hand(mob/user)
	if(isliving(user))
		var/mob/living/L = user
		if(!(L.mobility_flags & MOBILITY_PICKUP))
			return
	user.changeNext_move(CLICK_CD_MELEE)
	if(dead)
		..()
	else
		if(!isturf(loc))
			if(isliving(user))
				var/mob/living/L = user
				if(prob(L.STASPD * 1.5))
					..()
				else
					if(item_flags & IN_STORAGE)
						..()
					else
						dir = pick(GLOB.cardinals)
						step(src, dir)
						to_chat(user, "<span class='warning'>I fail to snatch it by the tail!</span>")
						playsound(src, pick('sound/vo/mobs/rat/rat_life.ogg','sound/vo/mobs/rat/rat_life2.ogg','sound/vo/mobs/rat/rat_life3.ogg'), 100, TRUE, -1)
						return
	..()

/obj/item/reagent_containers/food/snacks/smallrat/process()
	..()
	if(dead)
		return
	if(!isturf(loc)) //no floating out of bags
		return
	if(prob(5))
		playsound(src, pick('sound/vo/mobs/rat/rat_life.ogg','sound/vo/mobs/rat/rat_life2.ogg','sound/vo/mobs/rat/rat_life3.ogg'), 100, TRUE, -1)
	if(prob(75) && !dead)
		dir = pick(GLOB.cardinals)
		step(src, dir)
		for(var/obj/item/reagent_containers/food/snacks/S in loc)
			if(is_type_in_typecache(S, GLOB.RATS_DONT_EAT))
				return
			if(S != src)
				qdel(S)
				playsound(src,'sound/misc/eat.ogg', rand(30,60), TRUE)
				if(prob(23))
					var/turf/T = src.loc
					if(T)
						new /mob/living/simple_animal/hostile/retaliate/bigrat(T)
						dead = TRUE
						qdel(src)
						break




/obj/item/reagent_containers/food/snacks/smallrat/atom_destruction(damage_flag)
	if(!dead)
		new /obj/item/reagent_containers/food/snacks/smallrat/dead(src)
		playsound(src, 'sound/vo/mobs/rat/rat_death.ogg', 100, FALSE, -1)
		qdel(src)
		return 1
	return ..()

/obj/item/reagent_containers/food/snacks/smallrat/attackby(obj/item/I, mob/user, params)
	if(!dead)
		if(isliving(user))
			var/mob/living/L = user
			if(prob(L.STASPD * 2))
				..()
			else
				if(isturf(loc))
					dir = pick(GLOB.cardinals)
					step(src, dir)
					to_chat(user, "<span class='warning'>The vermin dodges my attack.</span>")
					playsound(src, pick('sound/vo/mobs/rat/rat_life.ogg','sound/vo/mobs/rat/rat_life2.ogg','sound/vo/mobs/rat/rat_life3.ogg'), 100, TRUE, -1)
					return
	..()
