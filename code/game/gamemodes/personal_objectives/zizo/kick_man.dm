/datum/objective/personal/kick_groin
	name = "Kick Groin"
	category = "Zizo's Chosen"
	triumph_count = 2
	rewards = list("2 Triumphs", "Zizo grows stronger", "Your nutcracks will be stronger")

/datum/objective/personal/kick_groin/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_MOB_KICK, PROC_REF(on_kick_attempted))
	update_explanation_text()

/datum/objective/personal/kick_groin/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_MOB_KICK)
	return ..()

/datum/objective/personal/kick_groin/proc/on_kick_attempted(datum/source, mob/living/target, zone_hit, damage_blocked)
	SIGNAL_HANDLER
	if(completed || target.gender != MALE || target.stat == DEAD || zone_hit != BODY_ZONE_PRECISE_GROIN)
		return

	if(damage_blocked)
		to_chat(owner.current, span_notice("The kick must inflict actual PAIN to please Zizo!"))
	else
		complete_objective()

/datum/objective/personal/kick_groin/proc/complete_objective()
	to_chat(owner.current, span_greentext("You've established your dominance over this man and completed Zizo's objective!"))
	owner.current.adjust_triumphs(triumph_count)
	completed = TRUE
	adjust_storyteller_influence(ZIZO, 20)
	ADD_TRAIT(owner.current, TRAIT_NUTCRACKER, TRAIT_GENERIC)
	escalate_objective()
	UnregisterSignal(owner.current, COMSIG_MOB_KICK)

/datum/objective/personal/kick_groin/update_explanation_text()
	explanation_text = "Kick a man in the balls to show your dominance and earn Zizo's approval!"
