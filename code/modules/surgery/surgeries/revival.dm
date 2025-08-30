/datum/surgery/revival
	name = "Revive"
	steps = list(
		/datum/surgery_step/incise,
		/datum/surgery_step/clamp,
		/datum/surgery_step/retract,
		/datum/surgery_step/saw,
		/datum/surgery_step/infuse_lux,
		/datum/surgery_step/cauterize
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	possible_locs = list(BODY_ZONE_CHEST)

/datum/surgery_step/infuse_lux
	name = "Infuse Lux"
	implements = list(
		/obj/item/reagent_containers/lux = 80,
	)
	target_mobtypes = list(/mob/living/carbon/human, /mob/living/carbon/monkey)
	time = 10 SECONDS
	surgery_flags = SURGERY_BLOODY | SURGERY_INCISED | SURGERY_CLAMPED | SURGERY_RETRACTED | SURGERY_BROKEN
	skill_min = SKILL_LEVEL_EXPERT

/datum/surgery_step/infuse_lux/validate_target(mob/user, mob/living/target, target_zone, datum/intent/intent)
	. = ..()
	if(target.stat < DEAD)
		to_chat(user, span_notice("They're not dead!"))
		return FALSE
	if(target.mob_biotypes & MOB_UNDEAD)
		to_chat(user, span_notice("You cannot infuse life into the undead! The rot must be cured first."))
		return FALSE
	if(HAS_TRAIT(target, TRAIT_NECRA_CURSE))
		to_chat(user, span_warning("Necra holds tight to this one."))
		return FALSE

/datum/surgery_step/infuse_lux/preop(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	display_results(user, target,
		span_notice("I begin to infuse [target]'s heart with lux."),
		span_notice("[user] begins to work lux into [target]'s heart."),
		span_notice("[user] begins to something into [target]'s innards..."),
	)
	return TRUE

/datum/surgery_step/infuse_lux/success(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent)
	if(!target.revive(full_heal = FALSE))
		to_chat(user, span_warning("Nothing happens."))
		return FALSE
	display_results(user, target,
		span_notice("You succeed in restarting [target]'s heart with the infusion of lux."),
		span_notice("[user] works lux into [target]'s heart."),
		span_notice("[user] works something into [target]'s innards..."),
	)
	target.blood_volume += BLOOD_VOLUME_SURVIVE
	target.reagents.add_reagent(/datum/reagent/medicine/atropine, 3)
	var/mob/living/carbon/spirit/underworld_spirit = target.get_spirit()
	if(underworld_spirit)
		var/mob/dead/observer/ghost = underworld_spirit.ghostize()
		qdel(underworld_spirit)
		ghost.mind.transfer_to(target, TRUE)
	target.grab_ghost(force = TRUE) // even suicides
	target.emote("breathgasp")
	target.update_body()
	target.visible_message(span_notice("[target] is dragged back from Necra's hold!"), span_green("I awake from the void."))
	qdel(tool)
	target.remove_status_effect(/datum/status_effect/debuff/lux_drained)
	target.remove_status_effect(/datum/status_effect/debuff/flaw_lux_taken)
	record_round_statistic(STATS_LUX_REVIVALS)
	return TRUE

/datum/surgery_step/infuse_lux/failure(mob/user, mob/living/target, target_zone, obj/item/tool, datum/intent/intent, success_prob)
	display_results(user, target, span_warning("I screwed up!"),
		span_warning("[user] screws up!"),
		span_notice("[user] works the lux into [target]'s innards."), TRUE)
	return TRUE
