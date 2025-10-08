/datum/action/cooldown/spell/bardic_inspiration
	name = "Bardic Inspiration"
	desc = "Inspire a target with stirring words."
	button_icon_state = "comedy"
	sound = 'sound/magic/ahh2.ogg'

	associated_skill = /datum/skill/misc/music

	charge_required = FALSE
	spell_type = NONE
	cooldown_time = 1 MINUTES
	invocation_type = INVOCATION_SHOUT
	has_visual_effects = FALSE

/datum/action/cooldown/spell/bardic_inspiration/is_valid_target(atom/cast_on)
	. = ..()
	if(!.)
		return FALSE
	return isliving(cast_on)

/datum/action/cooldown/spell/bardic_inspiration/before_cast(mob/living/cast_on)
	. = ..()
	if(. & SPELL_CANCEL_CAST)
		return

	var/message

	if(owner.cmode && ishuman(owner))
		message = "Let fortune favour the bold!"
	else
		message = browser_input_text(owner, "How will I inspire this fellow?", "XYLIX")
		if(QDELETED(src) || QDELETED(owner) || QDELETED(cast_on) || !can_cast_spell())
			return . | SPELL_CANCEL_CAST

	if(!message)
		reset_spell_cooldown()
		return . | SPELL_CANCEL_CAST

	invocation = message

/datum/action/cooldown/spell/bardic_inspiration/cast(mob/living/cast_on)
	. = ..()
	if(cast_on.can_hear())
		cast_on.apply_status_effect(/datum/status_effect/buff/bardic_inspiration)
