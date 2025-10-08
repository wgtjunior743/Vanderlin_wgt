/datum/objective/personal/improve_craft
	name = "Improve Craft Skills"
	category = "Malum's Chosen"
	triumph_count = 2
	rewards = list("2 Triumphs", "Malum grows stronger", "Malum blesses you (+1 Intelligence)")
	var/levels_gained = 0
	var/required_levels = 2

/datum/objective/personal/improve_craft/on_creation()
	. = ..()
	if(owner?.current)
		RegisterSignal(owner.current, COMSIG_SKILL_RANK_INCREASED, PROC_REF(on_skill_improved))
	update_explanation_text()

/datum/objective/personal/improve_craft/Destroy()
	if(owner?.current)
		UnregisterSignal(owner.current, COMSIG_SKILL_RANK_INCREASED)
	return ..()

/datum/objective/personal/improve_craft/proc/on_skill_improved(datum/source, datum/skill/skill_ref, new_level, old_level)
	SIGNAL_HANDLER
	if(completed)
		return

	if(!istype(skill_ref, /datum/skill/craft))
		return

	var/real_old = (old_level == SKILL_LEVEL_NONE && !(skill_ref in owner.current.skills?.known_skills)) ? SKILL_LEVEL_NONE : old_level

	if(new_level <= real_old)
		return

	var/level_diff = new_level - real_old
	levels_gained += level_diff

	if(levels_gained >= required_levels)
		to_chat(owner.current, span_greentext("You've improved your craft skills enough to please Malum!"))
		owner.current.adjust_triumphs(triumph_count)
		completed = TRUE
		adjust_storyteller_influence(MALUM, 20)
		owner.current.set_stat_modifier("malum_blessing", STATKEY_INT, 1)
		escalate_objective()
		UnregisterSignal(owner.current, COMSIG_SKILL_RANK_INCREASED)
	else
		var/remaining = required_levels - levels_gained
		to_chat(owner.current, span_notice("Craft skill improved! [remaining] more level[remaining == 1 ? "" : "s"] needed to fulfill Malum's task!"))

/datum/objective/personal/improve_craft/update_explanation_text()
	explanation_text = "Improve your craft skills by gaining [required_levels] new skill levels through practice or dreams. For Malum!"
