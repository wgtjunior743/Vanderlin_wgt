/datum/objective/personal/ravox_duel
	name = "Honor Duels"
	category = "Ravox's Chosen"
	triumph_count = 3
	immediate_effects = list("Gained an ability to challenge others")
	rewards = list("3 Triumphs", "Ravox grows stronger")
	var/duels_won = 0
	var/duels_required = 1

/datum/objective/personal/ravox_duel/on_creation()
	. = ..()
	var/datum/action/innate/ravox_challenge/challenge = new(src)
	challenge.Grant(owner.current)
	update_explanation_text()

/datum/objective/personal/ravox_duel/proc/on_duel_won()
	duels_won++
	if(duels_won >= duels_required && !completed)
		to_chat(owner.current, span_greentext("You have proven your worth in combat! Ravox is pleased!"))
		owner.current.adjust_triumphs(triumph_count * duels_required)
		completed = TRUE
		adjust_storyteller_influence(RAVOX, duels_required * 20)
		escalate_objective()

/datum/objective/personal/ravox_duel/update_explanation_text()
	explanation_text = "Win [duels_required] duel\s with honor against other warriors to prove your might!"

/datum/action/innate/ravox_challenge
	name = "Challenge to Duel"
	button_icon_state = "call_to_arms"

/datum/action/innate/ravox_challenge/Activate()
	var/list/duelists = list()
	for(var/mob/living/carbon/human/H in oview(7, owner))
		if(H.stat != CONSCIOUS)
			continue
		if(!H.mind || !H.client)
			continue
		duelists += H

	var/mob/living/carbon/human/duelist = browser_input_list(owner, "Who who challenge to an honor duel?", "RAVOX", sortList(duelists))
	if(QDELETED(src) || QDELETED(owner) || QDELETED(duelist))
		return

	var/challenge_message = "[owner] challenges you to an honor duel! Do you accept?"
	owner.visible_message(span_notice("[owner] challenges [duelist] to an honor duel!"), span_notice("You challenge [duelist] to a duel!"))
	var/answer = browser_alert(duelist, challenge_message, "Duel Challenge", DEFAULT_INPUT_CHOICES)
	if(QDELETED(src) || QDELETED(owner) || QDELETED(duelist))
		return
	if(answer != CHOICE_YES)
		to_chat(owner, span_warning("[duelist] has refused your challenge!"))
		duelist.visible_message(
			span_warning("[duelist] refuses [owner]'s duel challenge."),
			span_warning("You refuse [owner]'s challenge."),
		)
		return

	owner.visible_message(span_notice("[owner] and [duelist] prepare for an honor duel!"), span_notice("The duel begins!"))
	to_chat(owner, span_notice("The duel begins! Combat ends at unconsciousness or when a fighter yields (RMB on Combat Mode button)."))
	owner.playsound_local(owner, 'sound/magic/inspire_02.ogg', 100)

	to_chat(duelist, span_notice("The duel begins! Combat ends at unconsciousness or when a fighter yields (RMB on Combat Mode button)."))
	duelist.playsound_local(duelist, 'sound/magic/inspire_02.ogg', 100)

	new /datum/duel(owner, duelist, target)

/datum/duel
	var/ongoing = TRUE
	var/datum/weakref/challenger
	var/datum/weakref/challenged
	var/datum/weakref/objective

/datum/duel/New(mob/living/carbon/human/challenger, mob/living/carbon/human/challenged, datum/objective/personal/ravox_duel/listener)
	src.challenger = WEAKREF(challenger)
	src.challenged = WEAKREF(challenged)
	objective = WEAKREF(listener)

	addtimer(CALLBACK(src, PROC_REF(end_duel)), 8 MINUTES, TIMER_DELETE_ME)
	addtimer(CALLBACK(src, PROC_REF(check_duel)), 4 SECONDS, TIMER_UNIQUE|TIMER_OVERRIDE)

/datum/duel/Destroy(force, ...)
	challenger = null
	challenged = null
	return ..()

/datum/duel/proc/check_duel()
	if(QDELETED(src) || !ongoing)
		return
	var/mob/living/carbon/human/challenger_mob = challenger.resolve()
	var/mob/living/carbon/human/challenged_mob = challenged.resolve()
	if(QDELETED(challenger_mob) || QDELETED(challenged_mob))
		qdel(src)

	if(challenger_mob.surrendering || challenger_mob.incapacitated(IGNORE_GRAB))
		challenged_mob.visible_message(span_notice("[challenged_mob] defeats [challenged_mob] in the honor duel!"))
		finish_duel(challenger_mob, challenged_mob)
		return
	else if(challenged_mob.surrendering || challenged_mob.incapacitated(IGNORE_GRAB))
		challenger_mob.visible_message(span_notice("[challenger_mob] defeats [challenged_mob] in the honor duel!"))
		finish_duel(challenged_mob, challenger_mob)
		return

	addtimer(CALLBACK(src, PROC_REF(check_duel)), 4 SECONDS, TIMER_UNIQUE|TIMER_OVERRIDE)

/datum/duel/proc/end_duel()
	if(QDELETED(src) || !ongoing)
		return
	ongoing = FALSE
	var/mob/living/carbon/human/challenger_mob = challenger.resolve()
	if(challenger_mob)
		to_chat(challenger_mob, span_notice("The duel has gone on too long and is declared a draw!"))
	var/mob/living/carbon/human/challenged_mob = challenged.resolve()
	if(challenged_mob)
		to_chat(challenged_mob, span_notice("The duel has gone on too long and is declared a draw!"))

	qdel(src)

/datum/duel/proc/finish_duel(mob/living/loser, mob/living/winner)
	if(QDELETED(src) || !ongoing)
		return
	ongoing = FALSE

	to_chat(loser, span_red("You have lost the duel of honor!"))
	to_chat(winner, span_green("You have won the duel of honor!"))

	if(objective)
		var/datum/objective/personal/ravox_duel/ravox = objective.resolve()
		if(ravox?.owner == winner)
			ravox.on_duel_won()

	qdel(src)
