/mob/living/simple_animal/hostile/retaliate/voiddragon/red/Initialize()
	. = ..()
	REMOVE_TRAIT(src, TRAIT_ANTIMAGIC, TRAIT_GENERIC)

/mob/living/simple_animal/hostile/retaliate/voiddragon/red	//subtype for dragon-kobold event, requested by Mario
	name = "red dragon"
	desc = "An ancient creature from a bygone age. Now would be a good time to run."
	health = 2500
	maxHealth = 2500
	attack_verb_continuous = "gouges"
	attack_verb_simple = "gouge"
	attack_sound = 'sound/misc/demon_attack1.ogg'
	icon_state = "dragon_red"
	icon_living = "dragon_red"
	icon_dead = "dragon_red_dead_redemption"
	speak_emote = list("roars")
	emote_hear = null
	emote_see = null
	base_intents = list(/datum/intent/unarmed/dragonclaw)
	faction = list("kobold")
	melee_damage_lower = 40
	melee_damage_upper = 40
	retreat_distance = 0
	minimum_distance = 0
	base_strength = 20
	aggressive = 1
	speed = 5
	move_to_delay = 7
	ranged = TRUE
	pixel_x = -32
	pixel_y = -32
	deathmessage = "collapses to the floor with a final roar, the impact rocking the ground."
	footstep_type = FOOTSTEP_MOB_HEAVY
	void_corruption = FALSE


/mob/living/simple_animal/hostile/retaliate/voiddragon/red/void_pull(atom/target)
	var/turf/T = get_turf(src)
	playsound(T, 'sound/magic/charging_lightning.ogg', 100, TRUE)

	// Visual effect
	new /obj/effect/temp_visual/dragon_swirl(T)

	// Pull in all mobs within range
	for(var/mob/living/L in range(7, src))
		if(L == src || L.stat == DEAD)
			continue
		L.visible_message(span_warning("[L] is pulled toward [src]!"))

		var/throw_dist = get_dist(L, src)

		// Calculate throw speed based on distance
		var/throw_speed = max(1, 3 - round(throw_dist / 3))
		L.throw_at(src, throw_dist, throw_speed)
		L.apply_damage(10, BRUTE)

	addtimer(CALLBACK(src, PROC_REF(void_pull_aftermath)), 1 SECONDS)


/mob/living/simple_animal/hostile/retaliate/voiddragon/red/void_explosion_detonate(turf/target)
	if(!target)
		return

	playsound(target, 'sound/magic/disintegrate.ogg', 200, TRUE)

	new /obj/effect/temp_visual/dragon_explosion(target)

	for(var/mob/living/L in range(3, target))
		var/dist = get_dist(target, L)
		var/damage = 30 * (1 - (dist / 4)) // 30 damage at epicenter, scaling down with distance
		L.apply_damage(damage, BRUTE)

		var/throw_dir = get_dir(target, L)
		L.throw_at(get_edge_target_turf(L, throw_dir), 3, 2)


/mob/living/simple_animal/hostile/retaliate/voiddragon/red/tsere
	name = "Tsere the Insurmountable"
	desc = "Her scales shimmer in the blue light, her form is death, her gaze is wisdom, her wings cut all. This is Tsere... The Insurmountable."
	faction = list("abberant")
	health = 4000
	maxHealth = 4000
