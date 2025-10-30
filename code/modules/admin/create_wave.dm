GLOBAL_LIST_EMPTY(custom_jobs) // Admin created jobs
GLOBAL_LIST_EMPTY(custom_waves) // Created waves

// Minimal custom job datum
/datum/job/custom_job
	title = "Unnamed Job"
	tutorial = "No description provided."
	enabled = FALSE
	can_random = FALSE
	job_flags = (JOB_EQUIP_RANK)

/datum/create_wave
	var/datum/admins/admin_holder = null

	// Lists for the real time add/removal of those vars for Job
	var/list/pending_skills = list()
	var/list/pending_traits = list()
	var/list/pending_stats = list()

	// Lists for the real time add/removal of those vars for Wave
	var/list/pending_jobs = list()

	// Lists used on the Custom Job HTML
	var/list/factions_list = list("FACTION_NONE","FACTION_TOWN","FACTION_SOME_OTHER")
	var/list/outfits_list = list(/datum/outfit/apothecary,/datum/outfit/inquisition_crusader)
	var/list/sexes_list = list(MALE,FEMALE)
	var/list/races_list = RACES_PLAYER_ALL
	var/list/ages_list = list(AGE_CHILD,AGE_ADULT,AGE_MIDDLEAGED, AGE_OLD, AGE_IMMORTAL)
	var/list/stats_list = list(STATKEY_INT,STATKEY_STR,STATKEY_PER,STATKEY_SPD,STATKEY_CON,STATKEY_LCK)
	var/list/skills_list = list()
	var/list/languages_list = list()
	var/list/traits_list = list()
	var/list/antag_list = list()
	var/list/patrons_list = list()

	// Lists used on the Custom Wave HTML

	var/list/potential_jobs = list()
	var/potential_jobs_options = ""

	// Create HTML options for skills dropdown
	var/skills_options = ""
	var/trait_options = ""
	var/stat_options = ""

	// Temps vars to recreate the job browser
	var/temp_job_title
	var/temp_job_tutorial
	var/temp_faction
	var/temp_outfit
	var/temp_antag
	var/temp_allowed_sexes
	var/temp_allowed_races
	var/temp_allowed_ages
	var/temp_languages
	var/temp_patrons

	// Temps vars to recreate the wave browser
	var/temp_wave_title
	var/temp_wave_greeting_text
	var/temp_min_pop
	var/temp_max_pop


/datum/custom_wave
	abstract_type = /datum/migrant_wave
	var/name = "Custom Wave"
	var/greeting_text = "Hello Hello"

	var/min_pop
	var/max_pop


	var/timer
	var/spawn_landmark

	var/list/candidates = list()
	var/list/wave_jobs = list()

/datum/create_wave/New()

	for(var/datum/skill/skill as anything in subtypesof(/datum/skill))
		if(is_abstract(skill))
			continue
		skills_list += new skill

	for(var/trait in GLOB.traits_by_type)
		traits_list += GLOB.traits_by_type[trait]

	for(var/trait in traits_list)
		trait_options += "<option value='[(trait)]'>[trait]</option>"

	for(var/datum/skill/skill in skills_list)
		skills_options += "<option value='[(skill.type)]'>[skill.name]</option>"
		qdel(skill)

	for(var/stat in stats_list)
		stat_options += "<option value='[(stat)]'>[stat]</option>"

	for(var/datum/patron as anything in subtypesof(/datum/patron))
		var/datum/patron/i = new patron
		if(!i.name)
			continue
		qdel(i)
		patrons_list += patron

	for(var/datum/antagonist as anything in subtypesof(/datum/antagonist))
		antag_list += antagonist

	for(var/datum/language/language as anything in subtypesof(/datum/language))
		if(language == /datum/language/aphasia)
			continue
		languages_list += language



/datum/create_wave/Topic(href, href_list)
	..()
	message_admins("Topic trigger")
	var/client/C = usr?.client
	if(!C)
		return

	if(href_list["join_wave"])
		var/datum/custom_wave/CW = locate(href_list["chosen_wave"]) in GLOB.custom_waves
		if(!CW)
			return

		if(!(C in CW.candidates))
			CW.candidates += C
			to_chat(usr, "<span class='notice'>You have joined the custom wave.</span>")
		return

	if(href_list["decline_wave"])
		to_chat(usr, "<span class='warning'>You ignored the custom wave call.</span>")
		return


	if(usr.client != admin_holder.owner || !check_rights(0))
		message_admins("[usr.key] has attempted to override the admin panel!")
		log_admin("[key_name_admin(usr)] tried to use the admin panel without authorization.")
		return


	if(href == "close=1")
		message_admins("TRIGGER CLOSE PENDING_SKILL LIST EMPTY")
		pending_skills = list()
		pending_traits = list()
		pending_stats = list()
		temp_job_title = null

		return

	// Menu Related Topic
	if(href_list["job_manager_menu"])
		if(!check_rights(R_ADMIN))
			return
		custom_job_manager(usr)
	else if(href_list["wave_manager_menu"])
		if(!check_rights(R_ADMIN))
			return
		custom_wave_manager(usr)
	else if(href_list["outfit_manager_menu"])
		if(!check_rights(R_ADMIN))
			return
	// Job related Topic
	else if(href_list["create_job_finalize"])
		if(!check_rights(R_ADMIN))
			return
		create_job_finalize(usr, href_list)
	else if(href_list["create_job_menu"])
		if(!check_rights(R_ADMIN))
			return
		create_job(usr)
	else if(href_list["delete_job"])
		if(!check_rights(R_ADMIN))
			return
		var/datum/job/custom_job/J = locate(href_list["chosen_job"]) in GLOB.custom_jobs
		delete_job(usr, J)
	else if(href_list["edit_job"])
		if(!check_rights(R_ADMIN))
			return
		var/datum/job/custom_job/J = locate(href_list["chosen_job"]) in GLOB.custom_jobs
	else if(href_list["view_job"])
		if(!check_rights(R_ADMIN))
			return
		var/datum/job/custom_job/J = locate(href_list["chosen_job"]) in GLOB.custom_jobs
		view_job(usr, J)
	else if(href_list["add_skill"])
		if(!check_rights(R_ADMIN))
			return
		var/skill = href_list["skill"]
		var/datum/skill/S = new skill
		var/level = text2num(href_list["level"])

		temp_job_title = href_list["title"]


		if(skill in pending_skills)
			to_chat(usr, span_warning("[S.name] is already in the job skill list!"))
			return

		if(level && level > 0 && level < 7)
			// Store as list of lists: [skill_path, level]
			pending_skills[skill] = level
			to_chat(usr, span_notice("Added [S.name] at level [level]."))
			create_job(usr, href_list)
		else
			to_chat(usr, span_notice("Failed to add [S.name], invalid level inserted [level]."))
		qdel(S)
	else if(href_list["add_trait"])
		if(!check_rights(R_ADMIN))
			return
		message_admins("ADD TRAIT")
		var/trait = href_list["trait"]
		if(trait in pending_traits)
			to_chat(usr, span_warning("[trait] is already in the job trait list!"))
			return
		if(trait)
			pending_traits += trait
			to_chat(usr, span_notice("Added [trait]."))
			create_job(usr, href_list)
	else if(href_list["add_stat"])
		if(!check_rights(R_ADMIN))
			return
		var/stat = href_list["stat"]
		var/modifier = href_list["modifier"]
		if(stat in pending_stats)
			to_chat(usr, span_warning("[stat] is already in the job stat list!"))
			return
		if(stat)
			pending_stats[stat] = modifier
			to_chat(usr, span_notice("Added [stat] with a modifier of [modifier]"))
			create_job(usr)
	// Export a single job as JSON
	else if(href_list["export_job"])
		if(!check_rights(R_ADMIN))
			return
		var/datum/job/custom_job/J = locate(href_list["chosen_job"]) in GLOB.custom_jobs
		if(J)
			var/list/json_data = list()
			json_data += J.get_json_data()
			J.export_to_file(usr)
	// Import jobs
	else if(href_list["import_jobs"])
		if(!check_rights(R_ADMIN))
			return
		load_job(usr)
		custom_job_manager(usr)
		message_admins("IMPORT JOB TRIGGER")

	// Wave related Topic
	if(href_list["create_wave_finalize"])
		if(!check_rights(R_ADMIN))
			return
		create_wave_finalize(usr, href_list)
	else if(href_list["create_wave_menu"])
		if(!check_rights(R_ADMIN))
			return
		create_wave(usr)
	else if(href_list["delete_wave"])
		if(!check_rights(R_ADMIN))
			return
		var/datum/custom_wave/CW = locate(href_list["chosen_wave"]) in GLOB.custom_waves
		delete_wave(usr, CW)
	else if(href_list["edit_wave"])
		if(!check_rights(R_ADMIN))
			return
		var/datum/custom_wave/CW = locate(href_list["chosen_wave"]) in GLOB.custom_waves
	else if(href_list["view_wave"])
		if(!check_rights(R_ADMIN))
			return
		var/datum/custom_wave/CW = locate(href_list["chosen_wave"]) in GLOB.custom_waves
		view_wave(usr, CW)
	else if(href_list["add_jobs"])
		if(!check_rights(R_ADMIN))
			return
		var/job = href_list["job"]
		var/datum/job/J = new job

		temp_wave_title = href_list["name"]
		if(job in pending_jobs)
			to_chat(usr, span_warning("[J.title] is already in the job list!"))
			return

		pending_jobs += job
		qdel(J)
		create_wave(usr)
	else if(href_list["start_wave"])
		if(!check_rights(R_ADMIN))
			return
		var/datum/custom_wave/CW = locate(href_list["chosen_wave"]) in GLOB.custom_waves
		start_wave(usr, CW)

/client/proc/custom_job_manager()
	set category = "Debug"
	set name = "Custom Job Manager"

	if(!check_rights(R_DEBUG))
		return
	holder.create_wave.menu(usr)

/datum/create_wave/proc/menu(mob/admin)
	var/list/dat = list()
	dat += "<a href='byond://?src=[REF(src)];[HrefToken()];job_manager_menu=1'>Job Manager Menu </a><br>"
	dat += "<a href='byond://?src=[REF(src)];[HrefToken()];wave_manager_menu=1'>Wave Manager Menu</a><br>"
	dat += "<a href='byond://?src=[REF(src)];[HrefToken()];outfit_manager_menu=1'>Outfit Manager Menu</a><br>"

	var/datum/browser/popup = new(admin, "menu", "Menu", 500, 500, src)
	popup.set_content(dat.Join())
	popup.open(FALSE)


// Admin-side proc to show the manager
/datum/create_wave/proc/custom_job_manager(mob/admin)

	var/list/dat = list("<ul>")
	for(var/datum/job/custom_job/J in GLOB.custom_jobs)
		var/vv = FALSE
		dat += "<li><a href='byond://?src=[REF(src)];[HrefToken()];view_job=1;chosen_job=[REF(J)]'>[J.title]</a>[vv ? " (Custom Fields)" : ""]</li> "
		dat += "<a href='byond://?src=[REF(src)];[HrefToken()];delete_job=1;chosen_job=[REF(J)]'>Delete</a> "
		dat += "<a href='byond://?src=[REF(src)];[HrefToken()];edit_job=1;chosen_job=[REF(J)]'>Edit</a> "
		dat += "<a href='byond://?src=[REF(src)];[HrefToken()];export_job=1;chosen_job=[REF(J)]'>Export</a>"
		dat += "</li>"
	dat += "</ul>"
	dat += "<a href='byond://?src=[REF(src)];[HrefToken()];create_job_menu=1'>Create Job</a><br>"
	dat += "<a href='byond://?src=[REF(src)];[HrefToken()];import_jobs=1'>Import Job</a><br>"


	var/datum/browser/popup = new(admin, "customjobmanager", "Custom Job Manager", 670, 650, src)
	popup.set_content(dat.Join())
	popup.open(FALSE)


// Admin-side proc to show the manager
/datum/create_wave/proc/custom_wave_manager(mob/admin)
	if(!length(potential_jobs))
		for(var/J in SSjob.joinable_occupations)
			var/datum/job/job = J
			potential_jobs += job

	if(potential_jobs_options == "")
		for(var/job in potential_jobs)
			potential_jobs_options += "<option value='[(job)]'>[job]</option>"

	var/list/dat = list("<ul>")
	for(var/datum/custom_wave/CW in GLOB.custom_waves)
		var/vv = FALSE
		dat += "<li><a href='byond://?src=[REF(src)];[HrefToken()];view_wave=1;chosen_wave=[REF(CW)]'>[CW.name]</a>[vv ? " (Custom Fields)" : ""]</li> "
		dat += "<a href='byond://?src=[REF(src)];[HrefToken()];delete_wave=1;chosen_wave=[REF(CW)]'>Delete</a> "
		dat += "<a href='byond://?src=[REF(src)];[HrefToken()];edit_wave=1;chosen_wave=[REF(CW)]'>Edit</a> "
		dat += "<a href='byond://?src=[REF(src)];[HrefToken()];start_wave=1;chosen_wave=[REF(CW)]'>Start Wave</a> "
		dat += "</li>"
	dat += "</ul>"
	dat += "<a href='byond://?src=[REF(src)];[HrefToken()];create_wave_menu=1'>Create Wave</a><br>"
	dat += "<a href='byond://?src=[REF(src)];[HrefToken()];import_waves=1'>Import Wave</a><br>"


	var/datum/browser/popup = new(admin, "customjobmanager", "Custom Job Manager", 670, 650, src)
	popup.set_content(dat.Join())
	popup.open(FALSE)



// View Job
/datum/create_wave/proc/view_job(mob/admin, datum/job/custom_job/J)
	if(!J)
		return

	var/list/dat = list("<html><body>")
	dat += "<h2>Job Preview: [J.title]</h2>"
	dat += "<b>Tutorial</b><br><pre style='white-space:pre-wrap;'>[J.tutorial]</pre>"
	dat += "<h3>Faction:</h3> [J.faction]<br>"
	dat += "<h3>Outfit:</h3> [J.outfit]<br>"
	dat += "<h3>Custom Combat Song:</h3>"
	if(J.cmode_music)
		dat += "[J.cmode_music]<br>"
	else
		dat += "No custom combat song.<br>"
	dat += "<h3>Antag role:</h3>"
	if(J.antag_role)
		dat += "[J.antag_role]<br>"
	else
		dat += "Not an antag.<br>"
	dat += "<h3>Foreigner:</h3>"
	if(J.is_foreigner)
		dat += "Yes.<br>"
	else
		dat += "No.<br>"
	dat += "<h3>Recognized:</h3>"
	if(J.is_recognized)
		dat += "Yes.<br>"
	else
		dat += "No.<br>"
	dat += "<h3>Magick User:</h3>"
	if(J.magic_user)
		dat += "Yes.<br>"
	else
		dat += "No.<br>"
	dat += "<h3>Allowed sexes:</h3> "
	for(var/sex in J.allowed_sexes)
		dat += "[sex] "
	dat += "<h3>Allowed ages:</h3> "
	for(var/age in J.allowed_ages)
		dat += "[age] "
	dat += "<br>"
	dat += "<h3>Allowed races:</h3> "
	for(var/race in J.allowed_races)
		dat += "[race] "
	dat += "<h3>Languages:</h3> "
	if(length(J.languages))
		for(var/language in J.languages)
			var/datum/language/L = new language
			dat += "[L.name] "
			qdel(L)
	dat += "<h3>Allowed Patrons:</h3><br>"
	if(length(J.allowed_patrons))
		for(var/patrons in J.allowed_patrons)
			var/datum/patron/P = new patrons
			dat += "<li>[P.name]</li>"
			qdel(P)
	else
		dat += "<li>All Patrons are Allowed.</li>"
	dat += "<h3>Skills:</h3><ul>"
	if(length(J.skills))
		for(var/skill_path in J.skills)
			var/level = J.skills[skill_path]
			var/datum/skill/S = new skill_path
			dat += "<li>[S.name] (Level [level])</li>"
			qdel(S)
	dat += "<h3>Traits:</h3><ul>"
	for(var/trait in J.traits)
		dat += "<li>[trait]</li>"
	dat += "<h3>Stats:</h3><ul>"
	if(length(J.jobstats))
		for(var/stats_path in J.jobstats)
			var/modifier = J.jobstats[stats_path]
			dat += "<li>[stats_path] Modifier [modifier]</li>"
	dat += "</ul>"
	dat += "<br>"
	dat += "<br>"
//	dat += "<br><a href='byond://?src=[REF(src)];[HrefToken()];'>Close</a>"
	dat += "</body></html>"

	var/datum/browser/popup = new(admin, "customjob_view", "Custom Job Preview", 600, 520, src)
	popup.set_content(dat.Join())
	popup.open(FALSE)

// Delete a job
/datum/create_wave/proc/delete_job(mob/admin, datum/job/custom_job/J)
	if(!J)
		return
	GLOB.custom_jobs -= J
	qdel(J)
	to_chat(admin, "<span class='notice'>Custom job deleted.</span>")
	custom_job_manager(admin)

// Helper function to generate <option> HTML for a true/false (boolean) selector
/datum/create_wave/proc/generate_boolean_option(current_value)
	var/html = ""
	var/list/bool_options = list("TRUE" = TRUE, "FALSE" = FALSE)
	for(var/label in bool_options)
		var/value = bool_options[label]
		html += "<option value='[value]'[(current_value == value) ? " selected" : ""]>[label]</option>"
	return html

// Helper function to generate <option> HTML for a single select
/datum/create_wave/proc/generate_options(list/options, text_selected = "")
	var/opts = ""
	for(var/opt in options)
		opts += "<option value='[opt]'[opt == text_selected ? " text_selected" : ""]>[opt]</option>"
	return opts

// Helper function to generate checkboxes for multi-select
/datum/create_wave/proc/generate_checkboxes(list/options, name, list_selected = list())
	var/html = ""
	for(var/opt in options)
		var/v_display_name = ""
		if(ispath(opt, /datum)) // any datum path
			var/datum/D = new opt
			if("name" in D.vars)
				v_display_name = D.vars["name"] || "[opt]"
				if("display_name" in D.vars)
					v_display_name = D.vars["display_name"] || D.vars["name"]
			else
				v_display_name = "[opt]"
			qdel(D)
		else
			v_display_name = "[opt]"

		html += "<input type='checkbox' name='[name]' value='[opt]'[(opt in list_selected) ? " checked" : ""]> [v_display_name]<br>"
	return html


/datum/create_wave/proc/create_job(mob/admin)



	message_admins("TEMP TITLE [temp_job_title]")

	/*
	temp_allowed_sexes = href_list["job_allowed_sexes"]
	if(temp_allowed_sexes && !istype(temp_allowed_sexes,/list))
		temp_allowed_sexes = list(temp_allowed_sexes)

	temp_allowed_races = href_list["job_allowed_races"]
	if(temp_allowed_races && !istype(temp_allowed_races,/list))
		temp_allowed_races = list(temp_allowed_races)

	temp_allowed_ages = href_list["job_allowed_ages"]
	if(temp_allowed_ages && !istype(temp_allowed_ages,/list))
		temp_allowed_ages = list(temp_allowed_ages)

	temp_languages = href_list["job_languages"]
	if(temp_languages && !istype(temp_languages,/list))
		temp_languages = list(temp_languages)

	temp_patrons = href_list["job_allowed_patrons"]
	if(temp_patrons && !istype(temp_patrons,/list))
		temp_patrons = list(temp_patrons)
	*/

    // Generate HTML form
	var/dat = {"
	<html><head><title>Create Custom Job</title></head><body>
	<form name='job' action='byond://?src=[REF(src)];[HrefToken()]' method='get'>
	<input type='hidden' name='src' value='[REF(src)]'>
	[HrefTokenFormField()]
	<input type='hidden' name='create_job_finalize' value='1'>
	<table>
		<tr><th>Name:</th><td><input type='text' name='job_title'  id='job_t' value='[temp_job_title ? temp_job_title : "Custom Job"]'></td></tr>
		<tr><th>Tutorial:</th><td><textarea name='job_tutorial' style='width:400px'>[temp_job_tutorial ? temp_job_tutorial : "Describe the job here..."]</textarea></td></tr>
		<tr><th>Faction:</th><td>
			<select name='job_faction'>
				[generate_options(factions_list,temp_faction)]
			</select>
		</td></tr>
		<tr><th>Outfit:</th><td>
			<select name='job_outfit'>
				[generate_options(outfits_list)]
			</select>
		</td></tr>
		<tr><th>Custom Combat Music</th><td>
			<select name='job_custom_music' id='job_custom_music' onchange='
				document.getElementById("music_row").style.display = (this.value == "1") ? "table-row" : "none";
			'>
				[generate_boolean_option(FALSE)]
			</select>
			<br>
		</td></tr>
		<tr id='music_row' style='display:none'>
			<th>Music Path (Example: sound/music/cmode/church/CombatInquisitor.ogg)</th>
			<td><input type='text' name='job_song' id='job_song' value='Write here.'></td>
		</tr>
		<tr><th>Antag</th><td>
			<select name='job_enabled_antag' id='job_custom_music' onchange='
				document.getElementById("antag_options").style.display = (this.value == "1") ? "block" : "none";
			'>
				[generate_boolean_option(FALSE)]
			</select>
			<br>
			<div id='antag_options' style='display:none'>
				<select name='job_antag'>
					[generate_options(antag_list)]
				</select>
			</div>
		</td></tr>
		<tr><th>Foreigner</th><td>
			<select name='job_foreigner' onchange='
				document.getElementById("recognized_row").style.display = (this.value == "1") ? "table-row" : "none";
			'>
				[generate_boolean_option(FALSE)]
			</select>
		</td></tr>
		<tr id='recognized_row' style='display:none'><th>Recognized</th><td>
			<select name='job_recognized'>
				[generate_boolean_option(FALSE)]
			</select>
		</td></tr>
		<tr ><th>Magick User</th><td>
			<select name='job_magick_user'>
				[generate_boolean_option(FALSE)]
			</select>
		</td></tr>
		<tr><th>Allowed Sexes:</th><td>
			[generate_checkboxes(sexes_list,"job_allowed_sexes", temp_allowed_sexes)]
		</td></tr>
		<tr><th>Allowed Races:</th><td>
			[generate_checkboxes(races_list,"job_allowed_races")]
		</td></tr>
		<tr><th>Allowed Ages:</th><td>
			[generate_checkboxes(ages_list,"job_allowed_ages")]
		</td></tr>
		<tr><th>Languages:</th><td>
			[generate_checkboxes(languages_list,"job_languages")]
		</td></tr>
		<tr><th>Patrons (Leave everything unchecked to allow all patrons):</th><td>
			[generate_checkboxes(patrons_list,"job_allowed_patrons")]
		</td></tr>
		<tr><th>Skills:</th>
		<td>
			<select id='skills_dropdown'>
				[skills_options]
			</select>

			<input type='number' id='skills_level' value='0' style='width:50px'>
		"}
	if(length(pending_skills))
		dat += "<h4>Added Skills:</h4><ul>"
		for(var/skill_path in pending_skills)
			var/level = pending_skills[skill_path]
			var/datum/skill/S = new skill_path
			dat += "<li>[S.name] (Level [level])</li>"
			qdel(S)
		dat += "</ul>"
	else
		dat += "<i>No skills added yet.</i>"
	dat += {"
		<button type='button' onclick='
			var skill = document.getElementById("skills_dropdown").value;
			var level = document.getElementById("skills_level").value;
			var title = document.getElementById("job_t").value;
			window.location.href = "?src=[REF(src)];[HrefToken()];add_skill=1;skill=" + encodeURIComponent(skill) + ";level=" + encodeURIComponent(level) +";title=" + encodeURIComponent(title);
		'>Add Skill</button>

	"}
	dat+= "</td></tr>"
	dat += {"
		<tr><th>Traits:</th>
		<td>
			<select id='traits_dropdown'>
				[trait_options]
			</select>
	"}
	if(length(pending_traits))
		dat+= "<br>"
		dat += "<h4>Added Traits:</h4><ul>"
		for(var/trait in pending_traits)
			dat += "<li>[trait]</li>"
		dat += "</ul>"
	else
		dat += "<i>No traits added yet.</i>"
	dat+= {"
			<button type='button' onclick='
				var trait = document.getElementById("traits_dropdown").value;
				window.location.href = "?src=[REF(src)];[HrefToken()];add_trait=1;trait=" + encodeURIComponent(trait);
			'>Add Trait</button>
	"}
	dat+= "</td></tr>"
	dat += {"
		<tr><th>Stats:</th>
		<td>
			<select id='stats_dropdown'>
				[stat_options]
			</select>
			<input type='number' id='stats_level' value='0' style='width:50px'>

	"}
	if(length(pending_stats))
		dat += "<h4>Stats Modifiers:</h4><ul>"
		for(var/stats in pending_stats)
			var/modifier = pending_stats[stats]
			dat += "<li>[stats] Modifier: [modifier]</li>"
		dat += "</ul>"
	else
		dat += "<i>No Stats Modifiers added yet.</i>"
	dat += {"
		<button type='button' onclick='
			var stat = document.getElementById("stats_dropdown").value;
			var modifier = document.getElementById("stats_level").value;
			window.location.href = "?src=[REF(src)];[HrefToken()];add_stat=1;stat=" + encodeURIComponent(stat) + ";modifier=" + encodeURIComponent(modifier);
		'>Add Stat</button>
	"}
	dat+= "</td></tr>"
	dat += {"
	</table>
	<br><input type='submit' value='Save'>
	</form></body></html>
	"}


	var/datum/browser/popup = new(admin, "customjob_create", "Create Custom Job", 600, 700, src)
	popup.set_content(dat)
	popup.open(TRUE)


// Finalize job creation from HTML form


/datum/create_wave/proc/create_job_finalize(mob/admin, list/href_list)
	var/datum/job/custom_job/J = new

	J.title = href_list["job_title"]
	J.tutorial = href_list["job_tutorial"]
	J.faction = href_list["job_faction"]


	var/antag_enabled = text2num(href_list["job_enabled_antag"])
	var/custom_song_enabled = text2num(href_list["job_custom_music"])
	var/recognized = text2num(href_list["job_recognized"])
	var/foreigner = text2num(href_list["job_foreigner"])
	var/magick_user = text2num(href_list["job_magick_user"])

	if(antag_enabled == 1)
		J.antag_role = text2path(href_list["job_antag"])
	if(custom_song_enabled ==1)
		J.cmode_music = href_list["job_song"]
	if(recognized == 1)
		J.is_recognized = TRUE
	if(foreigner == 1)
		J.is_foreigner = TRUE
	if(magick_user == 1)
		J.magic_user = TRUE

	J.outfit = text2path(href_list["job_outfit"])


	J.allowed_sexes = list()
	var/sexes = href_list["job_allowed_sexes"]
	if(sexes)
		if(!istype(sexes, /list))
			sexes = list(sexes)
		for(var/sex in sexes)
			J.allowed_sexes += sex

	J.allowed_races = list()
	var/races = href_list["job_allowed_races"]
	if(races)
		if(!istype(races, /list))
			races = list(races)
		for(var/r in races)
			J.allowed_races += r

	J.allowed_ages = list()
	var/ages = href_list["job_allowed_ages"]
	if(ages)
		if(!istype(ages, /list))
			ages = list(ages)
		for(var/a in ages)
			J.allowed_ages += a

	J.languages = list()
	var/languages = href_list["job_languages"]
	if(languages)
		if(!istype(languages, /list))
			languages = list(languages)
		for(var/L in languages)
			J.languages += L

	J.allowed_patrons = list()
	var/patrons = href_list["job_allowed_patrons"]
	if(patrons)
		if(!istype(patrons, /list))
			patrons = list(patrons)
		for(var/P in patrons)
			J.allowed_patrons += P


	J.skills = list()
	if(pending_skills)
		J.skills = pending_skills.Copy()

	J.traits = list()
	if(pending_traits)
		J.traits = pending_traits.Copy()

	J.jobstats = list()
	if(pending_stats)
		J.jobstats = pending_stats.Copy()

	pending_skills = list()
	pending_traits = list()
	pending_stats = list()
	temp_job_title = null

	GLOB.custom_jobs += J
	message_admins("[key_name(usr)] created custom job: '[J.title]'")
	qdel(J)
	custom_job_manager(admin)

/datum/job/custom_job/proc/export_to_file(mob/admin)
	var/stored_data = get_json_data()
	var/json = json_encode(stored_data)
	var/f = file("data/TempJobExport")
	fdel(f)
	WRITE_FILE(f,json)
	admin << ftp(f,"[title].json")

/datum/create_wave/proc/load_job(mob/admin)
	// Ask admin to select a file
	var/job_file = input("Pick job JSON file:", "File") as null|file
	if(!job_file)
		return

	// Read JSON contents
	var/filedata = file2text(job_file)
	var/json = json_decode(filedata)
	if(!json)
		to_chat(admin, "<span class='warning'>JSON decode error.</span>")
		return

	// Ensure this is a single JSON object
	if(!islist(json))
		to_chat(admin, "<span class='warning'>Invalid file format (expected a single JSON job object).</span>")
		return

	// Create the job
	var/datum/job/custom_job/J = new()

	// Let your existing loader handle the fields
	J.load_from_json(json)

	// Add it to the global job list
	GLOB.custom_jobs += J

	message_admins("[key_name(admin)] loaded a custom job! Name: \"[J.title]\"")
	to_chat(admin, span_notice("Successfully loaded job '[J.title]'."))


/datum/create_wave/proc/create_wave(mob/admin)

    // Generate HTML form
	var/dat = {"
	<html><head><title>Create Custom Wave</title></head><body>
	<form name='wave' action='byond://?src=[REF(src)];[HrefToken()]' method='get'>
	<input type='hidden' name='src' value='[REF(src)]'>
	[HrefTokenFormField()]
	<input type='hidden' name='create_wave_finalize' value='1'>
	<table>
		<tr><th>Name:</th><td><input type='text' name='wave_title'  id='wave_t' value='[temp_wave_title ? temp_wave_title : "Custom Wave"]'></td></tr>
		<tr><th>Tutorial:</th><td><textarea name='wave_greeting_text' style='width:400px'>[temp_wave_greeting_text ? temp_wave_greeting_text : "Wave Tutorial here..."]</textarea></td></tr>
		"}
	dat+= "</td></tr>"
	dat += {"
		<tr><th>Jobs:</th>
		<td>
			<select id='jobs_dropdown'>
				[potential_jobs_options]
			</select>
	"}
	if(length(pending_jobs))
		dat+= "<br>"
		dat += "<h4>Added Jobs:</h4><ul>"
		for(var/job in pending_jobs)
			dat += "<li>[job]</li>"
		dat += "</ul>"
	else
		dat += "<i>No jobs added yet.</i>"
	dat+= {"
			<button type='button' onclick='
				var job = document.getElementById("jobs_dropdown").value;
				var name = document.getElementById("wave_t").value;
				window.location.href = "?src=[REF(src)];[HrefToken()];add_jobs=1;job=" + encodeURIComponent(job) + ";name=" + encodeURIComponent(name);
			'>Add Job</button>
	"}
	dat+= "</td></tr>"
	dat += {"
	</table>
	<br><input type='submit' value='Save'>
	</form></body></html>
	"}
	var/datum/browser/popup = new(admin, "customwave_create", "Create Wave Job", 600, 700, src)
	popup.set_content(dat)
	popup.open(FALSE)



// View Wave
/datum/create_wave/proc/view_wave(mob/admin, datum/custom_wave/CW)
	if(!CW)
		return

	var/list/dat = list("<html><body>")
	dat += "<h2>Job Preview: [CW.name]</h2>"
	dat += "<b>Tutorial</b><br><pre style='white-space:pre-wrap;'>[CW.greeting_text]</pre>"
	dat += "<h3>Jobs:</h3><ul>"
	if(length(CW.wave_jobs))
		for(var/job_path in CW.wave_jobs)
			dat += "<li>[job_path]</li>"
	dat += "</body></html>"

	var/datum/browser/popup = new(admin, "customwave_view", "Custom Wave Preview", 600, 520, src)
	popup.set_content(dat.Join())
	popup.open(FALSE)

// Delete a Wave
/datum/create_wave/proc/delete_wave(mob/admin, datum/custom_wave/CW)
	if(!CW)
		return
	GLOB.custom_waves -= CW
	qdel(CW)
	to_chat(admin, "<span class='notice'>Custom wave deleted.</span>")
	custom_wave_manager(admin)


/datum/create_wave/proc/create_wave_finalize(mob/admin, list/href_list)
	var/datum/custom_wave/CW = new

	CW.name = href_list["wave_title"]
	CW.greeting_text = href_list["wave_greeting_text"]

	CW.wave_jobs = list()
	if(pending_jobs)
		CW.wave_jobs = pending_jobs.Copy()


	pending_jobs = list()
	temp_wave_title = null

	GLOB.custom_waves += CW
	message_admins("[key_name(usr)] created custom job: '[CW.name]'")
	qdel(CW)
	custom_wave_manager(admin)


/datum/create_wave/proc/start_wave(mob/admin, datum/custom_wave/CW)
	if(!CW)
		return

	CW.spawn_landmark = admin.loc

	for(var/client/C in GLOB.clients)
		var/mob/dead_mob = C.mob
		if(!dead_mob || !isdead(dead_mob))
			continue

		// Send ghost/lobby popup
		var/list/dat = list("<html><body>")
		dat += "<center><b>An admin is forming a custom wave.</b><br>Join it?</b><br><br>"
		dat += "<a href='byond://?src=[REF(src)];join_wave=1;chosen_wave=[REF(CW)]'>Join</a>"
		dat += "<a href='byond://?src=[REF(src)];decline_wave=1'>Decline</a></center>"
		dat += "</body></html>"

		var/datum/browser/popup = new(dead_mob, "wave_call", "Join Custom Wave", 400, 200)
		popup.set_content(dat.Join())
		popup.open(FALSE)

	to_chat(admin, span_notice("Wave call sent to all ghosts.</span>"))

	CW.timer = addtimer(CALLBACK(src, PROC_REF(finalize_wave), admin, CW), 60 SECONDS)



/datum/create_wave/proc/finalize_wave(mob/admin, datum/custom_wave/CW)
	if(!CW)
		return

	if(!length(CW.candidates))
		message_admins("No one accepted the wave call.")
		return

	to_chat(admin, span_notice("Deploying [length(CW.candidates)] participants...</span>"))

	for(var/client/C in CW.candidates)
		if(!C || !C.mob || !isdead(C.mob))
			continue

		// Just the skeleton for now
		var/mob/dead_mob = C.mob
		var/spawn_loc = CW.spawn_landmark
		var/mob/living/carbon/human/H = new /mob/living/carbon/human(spawn_loc)
		H.key = C.key
		to_chat(H, span_notice("You awaken as part of the wave...</span>"))

	CW.candidates.Cut()
	if(CW.timer)
		//deltimer(CW.timer)
		CW.timer = null

