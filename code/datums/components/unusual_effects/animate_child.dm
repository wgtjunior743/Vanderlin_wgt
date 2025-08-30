
/atom
	var/datum/animate_holder/animate_holder

///this currently only supports a single animation set
/datum/animate_holder
	var/atom/parent
	///this is a pretty compicated situation where its a list of lists that follow the vars needed for animates
	var/list/steps = list()
	///this only exists for ui reasons its basically steps but its a list of all the easing levels and if they are true
	var/list/easings = list()
	///list of transformations per step and their type stored as list(type, list(x,x))
	var/list/transforms = list()
	///list of transformation types
	var/list/transformation_types = list()
	///list of random vars and their values setup as step = list(var = list(lower, upper))
	var/list/random_vars = list()
	///list of vars that we grab parent's value off of and add it
	var/list/parent_values = list()
	///do we animate the parent?
	var/animates_self = TRUE

/datum/animate_holder/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "AnimateHolder")
		ui.open()
	ui.set_autoupdate(TRUE)

/datum/animate_holder/ui_status(mob/user, datum/ui_state/state)
	return GLOB.always_state

/datum/animate_holder/ui_data(mob/user)
	var/list/data = list()
	data["steps"] = steps
	data["easings"] = easings
	data["transform_types"] = transformation_types
	data["transforms"] = transforms
	data["random_vars"] = random_vars
	data["parent_values"] = parent_values

	return data

/datum/animate_holder/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(.)
		return

	switch(action)
		if("modify_step")
			var/list/changes = list()
			changes += params["variable"]
			changes[params["variable"]] = params["value"]
			modify_index_value(params["index"], changes)
			. = TRUE

		if("modify_rand_state")
			var/list/changes = list()
			changes += params["variable"]
			if(!(params["variable"] in random_vars[params["index"]]))
				changes[params["variable"]] = "RANDOM"
				if(!random_vars[params["index"]])
					random_vars[params["index"]] = list()
				if(!(params["variable"] in random_vars[params["variable"]]))
					random_vars[params["index"]] |= params["variable"]
				random_vars[params["index"]][params["variable"]] = list(0, 0)
			else
				changes[params["variable"]] = 0
				random_vars[params["index"]][params["variable"]] = null
				random_vars[params["index"]] -= params["variable"]

			modify_index_value(params["index"], changes)

		if("set_random_value")
			if(params["rand_lower"])
				random_vars[params["index"]][params["variable"]][1] = params["rand_lower"]
			if(params["rand_upper"])
				random_vars[params["index"]][params["variable"]][2] = params["rand_upper"]

		if("modify_transform_value")
			if(params["matrix_type"])
				switch(params["matrix_type"])
					if("rotate")
						transformation_types[params["index"]] = MATRIX_ROTATE
					if("scale")
						transformation_types[params["index"]] = MATRIX_SCALE
					if("translate")
						transformation_types[params["index"]] = MATRIX_TRANSLATE

			if(params["value1"])
				transforms[params["index"]][1] = params["value1"]
			if(params["value2"])
				transforms[params["index"]][2] = params["value2"]

		if("modify_transform")
			var/matrix/transform
			switch(transformation_types[params["index"]])
				if(MATRIX_ROTATE)
					transform = matrix(transforms[params["index"]][1], MATRIX_ROTATE)
				if(MATRIX_SCALE)
					transform = matrix(transforms[params["index"]][1], transforms[params["index"]][2], MATRIX_SCALE)
				if(MATRIX_TRANSLATE)
					transform = matrix(transforms[params["index"]][1], transforms[params["index"]][2], MATRIX_TRANSLATE)

			steps[params["index"]] |= "transform"
			steps[params["index"]]["transform"] = transform

		if("add_blank_step")
			add_blank_step()
			. = TRUE

		if("remove_step")
			remove_step(params["index"])
			. = TRUE

		if("modify_easing")
			update_easing_step(params["index"], params["flag"], params["value"])
			. = TRUE

/datum/animate_holder/New(atom/creator)
	parent = creator

	if(parent)
		RegisterSignal(parent, COMSIG_PARENT_QDELETING, PROC_REF(handle_parent_del))

/datum/animate_holder/proc/handle_parent_del()
	SIGNAL_HANDLER
	remove_data()

/datum/animate_holder/proc/remove_data(from_destroy = FALSE)
	if(!parent)
		return
	UnregisterSignal(parent, COMSIG_PARENT_QDELETING)
	steps.Cut(1)
	easings.Cut(1)
	transforms.Cut(1)
	transformation_types.Cut(1)
	random_vars.Cut(1)
	parent_values.Cut(1)
	reanimate()
	parent.animate_holder = null
	parent = null
	if(!from_destroy)
		qdel(src)

/datum/animate_holder/Destroy(force)
	remove_data(TRUE)
	. = ..()

/datum/animate_holder/proc/remove_steps()
	steps.Cut(1)
	easings.Cut(1)
	transforms.Cut(1)
	transformation_types.Cut(1)
	random_vars.Cut(1)
	parent_values.Cut(1)

/datum/animate_holder/proc/reanimate()
	if(!animates_self)
		return

	var/first_item = TRUE
	var/step_number = 1
	for(var/list/held_list as anything in steps)
		var/list/copy_list = held_list.Copy()

		if(!length(copy_list))
			animate(parent)
			continue

		for(var/item in copy_list)
			if(copy_list[item] != "RANDOM")
				continue

			if(item == "transform")
				var/matrix/new_matrix
				var/list/range = random_vars[step_number][item]
				var/transform_data = transformation_types[step_number]
				switch(transform_data)
					if(MATRIX_ROTATE)
						new_matrix = matrix(rand(range[1], range[2]), MATRIX_ROTATE)
					if(MATRIX_SCALE)
						new_matrix = matrix(rand(range[1], range[2]), rand(range[1], range[2]), MATRIX_SCALE)
					if(MATRIX_TRANSLATE)
						new_matrix = matrix(rand(range[1], range[2]), rand(range[1], range[2]), MATRIX_TRANSLATE)
				copy_list[item] = new_matrix

			else
				var/list/range = random_vars["[step_number]"][item]
				copy_list[item] = rand(range[1], range[2])

		for(var/item in copy_list)
			if(!(item in parent_values[step_number]))
				continue
			if(parent_values[step_number][item])
				copy_list[item] += parent.vars[item]
			else
				copy_list[item] -= parent.vars[item]

		if(first_item)
			animate(arglist(list(parent) + copy_list))
			first_item = FALSE
		else
			if(copy_list["flags"] ==  ANIMATION_PARALLEL)
				animate(arglist(list(parent) + copy_list))
			else
				animate(arglist(copy_list))
		step_number++

//this proc basically runs on a passed atom which makes us able to modify particle spewers or anything that shares animates
/datum/animate_holder/proc/animate_object(atom/movable/animator)
	if(!animator)
		return
	var/first_item = TRUE
	var/step_number = 1
	for(var/list/held_list as anything in steps)
		if(!length(held_list))
			animate(animator)
			continue
		var/list/copy_list = held_list.Copy()

		for(var/item in copy_list)
			if(copy_list[item] != "RANDOM")
				continue

			if(item == "transform")
				var/matrix/new_matrix
				var/list/range = random_vars[step_number][item]
				var/transform_data = transformation_types[step_number]
				switch(transform_data)
					if(MATRIX_ROTATE)
						new_matrix = matrix(rand(range[1], range[2]), MATRIX_ROTATE)
					if(MATRIX_SCALE)
						new_matrix = matrix(rand(range[1], range[2]), rand(range[1], range[2]), MATRIX_SCALE)
					if(MATRIX_TRANSLATE)
						new_matrix = matrix(rand(range[1], range[2]), rand(range[1], range[2]), MATRIX_TRANSLATE)
				copy_list[item] = new_matrix

			else
				var/list/range = random_vars[step_number][item]
				copy_list[item] = rand(range[1], range[2])

		for(var/item in copy_list)
			if(!(item in parent_values[step_number]))
				continue
			if(parent_values[step_number][item])
				copy_list[item] += animator.vars[item]
			else
				copy_list[item] -= animator.vars[item]

		if(first_item)
			animate(arglist(list(animator) + copy_list))
			first_item = FALSE
		else
			if(copy_list["flags"] ==  ANIMATION_PARALLEL)
				animate(arglist(list(animator) + copy_list))
			else
				animate(arglist(copy_list))
		step_number++

/datum/animate_holder/proc/add_animation_step(list/addition)
	steps += list(addition)
	adjust_easing_list(addition, length(steps))
	transforms += list(list(1, 1))
	transformation_types += null
	random_vars += list(list())
	parent_values += list(list())
	reanimate()

/datum/animate_holder/proc/update_easing_step(index  = 1, easing_flag, value)
	if(!steps[index] || !easings[index])
		return
	easings[index][easing_flag] = value
	convert_easing_list(index)

/datum/animate_holder/proc/convert_easing_list(index = 1)
	var/list/easing = easings[index]

	var/ending_easing_value = NONE

	if(easing["LINEAR_EASING"])
		ending_easing_value |= LINEAR_EASING
	if(easing["SINE_EASING"])
		ending_easing_value |= SINE_EASING
	if(easing["CIRCULAR_EASING"])
		ending_easing_value |= CIRCULAR_EASING
	if(easing["QUAD_EASING"])
		ending_easing_value |= QUAD_EASING
	if(easing["CUBIC_EASING"])
		ending_easing_value |= CUBIC_EASING
	if(easing["BOUNCE_EASING"])
		ending_easing_value |= BOUNCE_EASING
	if(easing["ELASTIC_EASING"])
		ending_easing_value |= ELASTIC_EASING
	if(easing["BACK_EASING"])
		ending_easing_value |= BACK_EASING
	if(easing["JUMP_EASING"])
		ending_easing_value |= JUMP_EASING

	if(!steps[index]["easing"])
		steps[index] |= "easing"

	steps[index]["easing"] = ending_easing_value
	reanimate()

/datum/animate_holder/proc/adjust_easing_list(list/addition, index = 1)
	var/list/easing = list(
		"LINEAR_EASING" = FALSE,
		"SINE_EASING" = FALSE,
		"CIRCULAR_EASING" = FALSE,
		"QUAD_EASING" = FALSE,
		"CUBIC_EASING" = FALSE,
		"BOUNCE_EASING" = FALSE,
		"ELASTIC_EASING" = FALSE,
		"BACK_EASING" = FALSE,
		"JUMP_EASING" = FALSE,
	)

	if(addition["easing"])
		var/easing_value = addition["easing"]

		if(easing_value & LINEAR_EASING)
			easing["LINEAR_EASING"] = TRUE
		if(easing_value & SINE_EASING)
			easing["SINE_EASING"] = TRUE
		if(easing_value & CIRCULAR_EASING)
			easing["CIRCULAR_EASING"] = TRUE
		if(easing_value & QUAD_EASING)
			easing["QUAD_EASING"] = TRUE
		if(easing_value & CUBIC_EASING)
			easing["CUBIC_EASING"] = TRUE
		if(easing_value & BOUNCE_EASING)
			easing["BOUNCE_EASING"] = TRUE
		if(easing_value & ELASTIC_EASING)
			easing["ELASTIC_EASING"] = TRUE
		if(easing_value & BACK_EASING)
			easing["BACK_EASING"] = TRUE
		if(easing_value & JUMP_EASING)
			easing["JUMP_EASING"] = TRUE
	easings += list(easing)

/datum/animate_holder/proc/remove_step(index = 1)
	if(!steps[index])
		return // this is modify not add
	steps.Cut(index, index+1)
	easings.Cut(index, index+1)
	transforms.Cut(index, index+1)
	transformation_types.Cut(index, index+1)
	random_vars.Cut(index, index+1)
	parent_values.Cut(index, index+1)
	reanimate()

/datum/animate_holder/proc/modify_specific_list(index = 1, list/new_list)
	if(!steps[index])
		return // this is modify not add
	steps[index] = new_list
	reanimate()

/datum/animate_holder/proc/modify_index_value(index = 1, list/change)
	if(!steps[index])
		return // this is modify not add

	for(var/item in change)
		if(!(item in steps[index]))
			steps[index] |= item
		steps[index][item] = change[item]

	reanimate()

/datum/animate_holder/proc/add_blank_step()
	easings += list(list(
		"LINEAR_EASING" = FALSE,
		"SINE_EASING" = FALSE,
		"CIRCULAR_EASING" = FALSE,
		"QUAD_EASING" = FALSE,
		"CUBIC_EASING" = FALSE,
		"BOUNCE_EASING" = FALSE,
		"ELASTIC_EASING" = FALSE,
		"BACK_EASING" = FALSE,
		"JUMP_EASING" = FALSE,
	))

	steps += list(list())
	transforms += list(list(1, 1))
	transformation_types += null
	random_vars += list(list())
	parent_values += list(list())

/datum/animate_holder/proc/return_list_strippped_nulls(list/new_list)
	//not a complete list but all that I can see being used atm
	var/list/base_list = list(
		"time" = null,
		"loop" = null,
		"easing" = null,
		"flags" = null,
		"alpha" = null,
		"color" = null,
		"infra_luminosity" = null,
		"layer" = null,
		"maptext_width" = null,
		"maptext_height" = null,
		"maptext_x" = null,
		"maptext_y" = null,
		"luminosity" = null,
		"pixel_x" = null,
		"pixel_y" = null,
		"pixel_w" = null,
		"pixel_z" = null,
		"transform" = null,
		"dir" = null,
		"maptext" = null,
	)
	for(var/index in new_list)
		if(index in base_list)
			base_list[index] = new_list[index]

	for(var/item in base_list)
		if(base_list[item] == null)
			base_list.Cut(item)

	return base_list


/datum/animate_holder/proc/set_random_var(step, change_var, list/inputs)
	var/list/changes = list()
	changes[change_var] = "RANDOM"
	modify_index_value(step, changes)
	if(!random_vars[step])
		random_vars += list(list())
		random_vars[step] = list()
	if(!random_vars[step][change_var])
		random_vars[step] |= change_var
		random_vars[step][change_var] = list()

	random_vars[step][change_var] = inputs


/datum/animate_holder/proc/set_parent_copy(step, change_var, adds = TRUE)
	if(!parent_values[step])
		parent_values += list()
		parent_values[step] = list()
	parent_values[step] |= change_var
	parent_values[step][change_var] = adds

/datum/animate_holder/proc/set_transform_type(step, matrix_type)
	transformation_types[step] = matrix_type

///list format of the animation step for if the generic add_animate_step proc is missing vars in updates this passes it in as a arglist list.
/atom/proc/add_animation_step_list(list/instructions)
	if(!length(instructions))
		return
	if(!animate_holder)
		animate_holder = new(src)
	animate_holder.add_animation_step(instructions)
