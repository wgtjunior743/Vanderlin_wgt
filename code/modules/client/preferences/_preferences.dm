GLOBAL_LIST_EMPTY(preferences_datums)

GLOBAL_LIST_EMPTY(chosen_names)

GLOBAL_LIST_INIT(name_adjustments, list())

/datum/preferences
	var/client/parent
	//doohickeys for savefiles
	var/path
	var/default_slot = 1				//Holder so it doesn't default to slot 1, rather the last one used
	var/max_save_slots = 20

	//non-preference stuff
	var/muted = 0
	var/last_ip
	var/last_id

	//game-preferences
	var/lastchangelog = ""				//Saved changlog filesize to detect if there was a change
	/// color of the players text in OOC messages
	var/ooccolor = null
	/// color of admin's asay messages
	var/asaycolor = "#ff4500"			//This won't change the color for current admins, only incoming ones.
	/// pronouns that will be shown when hovering over the users name in OOC messages
	var/oocpronouns = ""
	/// the ghost icon this admin ghost will get when becoming an aghost.
	var/admin_ghost_icon = null
	var/ui_theme = UI_PREFERENCE_LIGHT_MODE
	var/triumphs = 0
	var/enable_tips = TRUE
	var/tip_delay = 500 //tip delay in milliseconds

	//Antag preferences
	var/list/be_special = list()		//Special role selection
	var/tmp/old_be_special = 0			//Bitflag version of be_special, used to update old savefiles and nothing more
										//If it's 0, that's good, if it's anything but 0, the owner of this prefs file's antag choices were,
										//autocorrected this round, not that you'd need to check that.

	var/UI_style = null
	var/buttons_locked = TRUE
	var/hotkeys = TRUE

	var/chat_on_map = TRUE
	var/showrolls = TRUE
	var/max_chat_length = CHAT_MESSAGE_MAX_LENGTH
	var/see_chat_non_mob = TRUE

	// Custom Keybindings
	var/list/key_bindings = list()

	var/tgui_fancy = TRUE
	var/tgui_lock = TRUE
	var/windowflashing = TRUE
	var/toggles = TOGGLES_DEFAULT
	var/db_flags
	var/chat_toggles = TOGGLES_DEFAULT_CHAT
	var/ghost_form = "ghost"
	var/ghost_orbit = GHOST_ORBIT_CIRCLE
	var/ghost_accs = GHOST_ACCS_DEFAULT_OPTION
	var/ghost_others = GHOST_OTHERS_DEFAULT_OPTION
	var/ghost_hud = 1
	var/inquisitive_ghost = 1
	var/allow_midround_antag = 1
	var/preferred_map = null

	var/uses_glasses_colour = 0

	//character preferences
	/// Keeps track of round-to-round randomization of the character slot, prevents overwriting.
	var/slot_randomized

	/// The character's real name.
	var/real_name

	/// Gender of character (used for masculine or feminine model selection).
	var/gender = MALE

	/// Character's pronouns.
	var/pronouns = HE_HIM

	/// The type of voice soundpack the mob should use.
	var/voice_type = VOICE_TYPE_MASC

	/// Age of character.
	var/age = AGE_ADULT

	/// Character's origin.
	var/origin = "Default"

	/// Underwear type.
	var/underwear = "Nude"

	/// Underwear color.
	var/underwear_color = null

	/// Undershirt type.
	var/undershirt = "Nude"

	/// Accessory type.
	var/accessory = "Nothing"

	/// Detail type.
	var/detail = "Nothing"

	/// Socks type.
	var/socks = "Nude"

	/// Skin color.
	var/skin_tone = "caucasian1"

	/// Eye color.
	var/eye_color = "000"

	/// Voice color.
	var/voice_color = "a0a0a0"

	/// Detail color.
	var/detail_color = "000"

	/// link to a page containing your headshot image
	var/headshot_link

	/// text of your flavor
	var/flavortext

	/// The species this character is.
	var/datum/species/pref_species = new /datum/species/human/northern()	//Mutant race
	/// The patron/god/diety this character worships
	var/datum/patron/selected_patron
	/// The default patron to use if none is selected
	var/static/datum/patron/default_patron = /datum/patron/divine/astrata
	var/list/features = MANDATORY_FEATURE_LIST
	var/list/randomise = list(
		(RANDOM_BODY) = FALSE,
		(RANDOM_BODY_ANTAG) = FALSE,
		(RANDOM_UNDERWEAR) = FALSE,
		(RANDOM_UNDERWEAR_COLOR) = FALSE,
		(RANDOM_UNDERSHIRT) = FALSE,
		(RANDOM_SKIN_TONE) = FALSE,
		(RANDOM_EYE_COLOR) = FALSE
	)

	var/phobia = "spiders"

	var/list/custom_names = list()

	//Job preferences 2.0 - indexed by job title , no key or value implies never
	var/list/job_preferences = list()

		// Want randomjob if preferences already filled - Donkie
	var/joblessrole = RETURNTOLOBBY  //defaults to 1 for fewer assistants

	/// 0 = character settings, 1 = game preferences
	var/current_tab = 0

	var/unlock_content = 0

	var/list/ignoring = list()

	var/clientfps = 100//0 is sync

	var/parallax

	var/ambientocclusion = TRUE
	///Should we automatically fit the viewport?
	var/auto_fit_viewport = FALSE
	///Should we be in the widescreen mode set by the config?
	var/widescreenpref = TRUE
	///What size should pixels be displayed as? 0 is strech to fit
	var/pixel_size = 0
	///What scaling method should we use?
	var/scaling_method = "normal"

	var/musicvol = 50
	var/mastervol = 50

	var/anonymize = TRUE

	var/lastclass

	var/list/exp = list()
	var/list/menuoptions

	var/datum/migrant_pref/migrant
	var/next_special_trait = null

	var/action_buttons_screen_locs = list()

	var/domhand = 2
	var/alignment = ALIGNMENT_TN
	var/datum/charflaw/charflaw

	/// Family system
	var/family = FAMILY_NONE
	var/setspouse = ""
	var/gender_choice = ANY_GENDER

	var/crt = FALSE

	var/list/customizer_entries = list()
	var/list/list/body_markings = list()
	var/update_mutant_colors = TRUE

	var/list/descriptor_entries = list()
	var/list/custom_descriptors = list()

	var/list/preference_message_list = list()

	/// Tracker to whether the person has ever spawned into the round, for purposes of applying the respawn ban
	var/has_spawned = FALSE
	///our selected accent
	var/selected_accent = ACCENT_DEFAULT
	/// If our owner has patreon access
	var/patreon = FALSE

	/// If the user clicked "Don't ask again" on the randomize character prompt
	var/randomize_shutup = FALSE
	/// Custom UI scale
	var/ui_scale
	/// Assoc list of culinary preferences, where the key is the type of the culinary preference, and value is food/drink typepath
	var/list/culinary_preferences = list()

/datum/preferences/New(client/C)
	parent = C

	migrant  = new /datum/migrant_pref(src)

	flavortext = null
	headshot_link = null

	// C/parent can be a client_interface
	if(isclient(parent))
		patreon = parent?.patreon?.has_access(ACCESS_ASSISTANT_RANK)

	for(var/custom_name_id in GLOB.preferences_custom_names)
		custom_names[custom_name_id] = get_default_name(custom_name_id)

	UI_style = GLOB.available_ui_styles[1]

	if(istype(C))
		if(!IsGuestKey(C.key))
			load_path(C.ckey)
			unlock_content = C.IsByondMember()
			if(unlock_content)
				max_save_slots += 5
		if(patreon)
			max_save_slots += 30
	var/loaded_preferences_successfully = load_preferences()
	if(loaded_preferences_successfully)
		if(load_character())
			if(check_nameban(C.ckey))
				real_name = pref_species.random_name(gender,1)
			return
	//we couldn't load character data so just randomize the character appearance + name
	randomise_appearance_prefs(include_patreon = patreon)		//let's create a random character then - rather than a fat, bald and naked man.
	if(!charflaw)
		charflaw = pick(GLOB.character_flaws)
		charflaw = GLOB.character_flaws[charflaw]
		charflaw = new charflaw()
	if(!selected_patron)
		selected_patron = GLOB.patronlist[default_patron]
	key_bindings = deepCopyList(GLOB.hotkey_keybinding_list_by_key) // give them default keybinds and update their movement keys
	if(isclient(C))
		C.update_movement_keys()
	real_name = pref_species.random_name(gender,1)
	if(!loaded_preferences_successfully)
		save_preferences()
	save_character()		//let's save this new random character so it doesn't keep generating new ones.
	menuoptions = list()
	return

#define APPEARANCE_CATEGORY_COLUMN "<td valign='top' width='14%'>"
#define MAX_MUTANT_ROWS 4

/datum/preferences/proc/ShowChoices(mob/user, tabchoice)
	if(!user || !user.client)
		return
	if(slot_randomized)
		load_character(default_slot) // Reloads the character slot. Prevents random features from overwriting the slot if saved.
		slot_randomized = FALSE
	var/list/dat = list("<center>")
	dat += "</center>"

	// Top-level menu table
	dat += "<table style='width: 100%; line-height: 20px;'>"
	// FIRST ROW
	dat += "<tr>"
	dat += "<td style='width:33%;text-align:left'>"
	dat += "<a style='white-space:nowrap;' href='?_src_=prefs;preference=changeslot;'>Change Character</a>"
	dat += "</td>"


	dat += "<td style='width:33%;text-align:center'>"
	if(SStriumphs.triumph_buys_enabled)
		dat += "<a style='white-space:nowrap;' href='?_src_=prefs;preference=triumph_buy_menu'>Triumph Shop</a>"
	dat += "</td>"

	dat += "<td style='width:33%;text-align:right'>"
	dat += "<a href='?_src_=prefs;preference=keybinds;task=menu'>Keybinds</a>"
	dat += "</td>"
	dat += "</tr>"


	// NEXT ROW
	dat += "<tr>"
	dat += "<td style='width:33%;text-align:left'>"
	dat += "</td>"

	dat += "<td style='width:33%;text-align:center'>"
	dat += "<a href='?_src_=prefs;preference=job;task=menu'>Class Selection</a>"
	dat += "</td>"

	dat += "<td style='width:33%;text-align:right'>"

	dat += "</td>"
	dat += "</tr>"

	// ANOTHA ROW
	dat += "<tr style='padding-top: 0px;padding-bottom:0px'>"
	dat += "<td style='width:33%;text-align:left'>"
	dat += "</td>"

	dat += "<td style='width:33%;text-align:center'>"
	dat += "<a href='?_src_=prefs;preference=antag;task=menu'>Special Roles</a>"
	dat += "</td>"

	dat += "<td style='width:33%;text-align:right'>"
	dat += "</td>"
	dat += "</tr>"

	// ANOTHER ROW HOLY SHIT WE FINALLY A GOD DAMN GRID NOW! WHOA!
	dat += "<tr style='padding-top: 0px;padding-bottom:0px'>"
	dat += "<td style='width:33%; text-align:left'>"
	dat += "<a href='?_src_=prefs;preference=playerquality;task=menu'><b>PQ:</b></a> [get_playerquality(user.ckey, text = TRUE)]"
	dat += "</td>"

	dat += "<td style='width:33%;text-align:center'>"
	dat += "<a href='?_src_=prefs;preference=triumphs;task=menu'><b>TRIUMPHS:</b></a> [user.get_triumphs() ? "\Roman [user.get_triumphs()]" : "None"]"
	dat += "</td>"

	dat += "<td style='width:33%;text-align:right'>"
	dat += "</td>"

	dat += "</table>"

	// Encapsulating table
	dat += "<table width = '100%'>"
	// Only one Row
	dat += "<tr>"
	// Leftmost Column, 40% width
	dat += "<td width=40% valign='top'>"

	//-----------START OF IDENT TABLE-----------//
	dat += "<h2 style='padding-left: 4px'>Identity</h2>"
	dat += "<table width='100%'><tr><td width='75%' valign='top'>"
	dat += "<a style='white-space:nowrap; padding: 0px' href='?_src_=prefs;preference=randomiseappearanceprefs;'>Randomize Character</a>"
	dat += "<br>"
	dat += "<b>Name:</b> "
	if(check_nameban(user.ckey))
		dat += "<a href='?_src_=prefs;preference=name;task=input'>NAMEBANNED</a><BR>"
	else
		dat += "<a href='?_src_=prefs;preference=name;task=input'>[real_name]</a> <a href='?_src_=prefs;preference=name;task=random'>\[R\]</a>"

	dat += "<BR>"
	dat += "<b>Species:</b> <a href='?_src_=prefs;preference=species;task=input'>[pref_species.name]</a>[spec_check() ? "" : " (!)"]<BR>"
	dat += "<b>Pronouns:</b> <a href='?_src_=prefs;preference=pronouns;task=input'>[pronouns]</a><BR>"

	if(!(AGENDER in pref_species.species_traits))
		var/dispGender
		if(gender == MALE)
			dispGender = "Masculine" // repurpose gender as bodytype, display accordingly
		else if(gender == FEMALE)
			dispGender = "Feminine" // repurpose gender as bodytype, display accordingly
		else
			dispGender = "Other"
		dat += "<b>Body Type:</b> <a href='?_src_=prefs;preference=gender'>[dispGender]</a><BR>"
		if(randomise[RANDOM_BODY] || randomise[RANDOM_BODY_ANTAG]) //doesn't work unless random body
			dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_GENDER]'>Always Random Bodytype: [(randomise[RANDOM_GENDER]) ? "Yes" : "No"]</A>"
			dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_GENDER_ANTAG]'>When Antagonist: [(randomise[RANDOM_GENDER_ANTAG]) ? "Yes" : "No"]</A>"

	if(AGE_IMMORTAL in pref_species.possible_ages)
		dat += "<b>Age:</b> <a href='?_src_=prefs;preference=age;task=input'>[AGE_IMMORTAL]</a><BR>"
	else
		dat += "<b>Age:</b> <a href='?_src_=prefs;preference=age;task=input'>[age]</a><BR>"

	dat += "<b>Flaw:</b> <a href='?_src_=prefs;preference=charflaw;task=input'>[charflaw]</a><BR>"
	var/datum/faith/selected_faith = GLOB.faithlist[selected_patron?.associated_faith]
	dat += "<b>Faith:</b> <a href='?_src_=prefs;preference=faith;task=input'>[selected_faith?.name || "FUCK!"]</a><BR>"
	dat += "<b>Patron:</b> <a href='?_src_=prefs;preference=patron;task=input'>[selected_patron?.name || "FUCK!"]</a><BR>"
	dat += "<b>Family:</b> <a href='?_src_=prefs;preference=family'>[family ? family : "None"]</a><BR>"
	if(family == FAMILY_FULL || family == FAMILY_NEWLYWED)
		dat += "<b>Preferred Spouse:</b> <a href='?_src_=prefs;preference=setspouse'>[setspouse ? setspouse : "None"]</a><BR>"
		dat += "<b>Preferred Gender:</b> <a href='?_src_=prefs;preference=gender_choice'>[gender_choice ? gender_choice : "Any Gender"]</a><BR>"
	dat += "<b>Dominance:</b> <a href='?_src_=prefs;preference=domhand'>[domhand == 1 ? "Left-handed" : "Right-handed"]</a><BR>"
	dat += "<b>Food Preferences:</b> <a href='?_src_=prefs;preference=culinary;task=menu'>Change</a><BR>"
	dat += "</tr></table>"
	//-----------END OF IDENT TABLE-----------//


	// Middle dummy Column, 20% width
	dat += "</td>"
	dat += "<td width=20% valign='top'>"
	// Rightmost column, 40% width
	dat += "<td width=40% valign='top'>"
	dat += "<h2 style='padding-left: 4px'>Body</h2>"

	//-----------START OF BODY TABLE-----------
	dat += "<table width='100%'><tr><td width='1%' valign='top'>"

	var/use_skintones = pref_species.use_skintones
	if(use_skintones)

		//dat += APPEARANCE_CATEGORY_COLUMN
		var/skin_tone_wording = pref_species.skin_tone_wording // Both the skintone names and the word swap here is useless fluff

		dat += "<b>[skin_tone_wording]: </b><a href='?_src_=prefs;preference=s_tone;task=input'>Change </a>"
		//dat += "<a href='?_src_=prefs;preference=toggle_random;random_type=[RANDOM_SKIN_TONE]'>[(randomise[RANDOM_SKIN_TONE]) ? "Lock" : "Unlock"]</A>"
		dat += "<br>"

	dat += "<br>"
	dat += "<b>Voice Type:</b> <a href='?_src_=prefs;preference=voicetype;task=input'>[voice_type]</a>"
	dat += "<br><b>Voice Color:</b> <a href='?_src_=prefs;preference=voice;task=input'>Change</a>"
	dat += "<br>"
	dat += "<br><b>Accent:</b> <a href='?_src_=prefs;preference=selected_accent;task=input'>[selected_accent]</a>"
	dat += "<br>"
	dat += "<br><b>Features:</b> <a href='?_src_=prefs;preference=customizers;task=menu'>Change</a>"
	if(length(pref_species.descriptor_choices))
		dat += "<br><b>Descriptors:</b> <a href='?_src_=prefs;preference=descriptors;task=menu'>Change</a>"
		dat += "<br>"

	dat += "<br><b>Headshot:</b> <a href='?_src_=prefs;preference=headshot;task=input'>Change</a>"
	if(headshot_link != null)
		dat += "<br><img src='[headshot_link]' width='100px' height='100px'>"
	dat += "<br><b>Flavortext:</b> <a href='?_src_=prefs;preference=flavortext;task=input'>Change</a>"
	dat += "<br></td>"

	dat += "</tr></table>"
	//-----------END OF BODY TABLE-----------//
	dat += "</td>"
	dat += "</tr>"
	dat += "</table>"

	if(!IsGuestKey(user.key))
		dat += "<a href='?_src_=prefs;preference=save'>Save</a><br>"
		dat += "<a href='?_src_=prefs;preference=load'>Undo</a><br>"

	// well.... one empty slot here for something I suppose lol
	dat += "<table width='100%'>"
	dat += "<tr>"
	dat += "<td width='33%' align='left'></td>"
	dat += "<td width='33%' align='center'>"
	var/mob/dead/new_player/N = user
	if(istype(N))
		dat += "<a href='?_src_=prefs;preference=bespecial'><b>[next_special_trait ? "<font color='red'>SPECIAL</font>" : "BE SPECIAL"]</b></a><BR>"

	dat += "<a href='?_src_=prefs;preference=finished'>DONE</a>"
	dat += "</center>"

	dat += "</td>"
	dat += "<td width='33%' align='right'>"
	dat += "<b>Be Voice:</b> <a href='?_src_=prefs;preference=schizo_voice'>[(toggles & SCHIZO_VOICE) ? "Enabled":"Disabled"]</a>"
	dat += "</td>"
	dat += "</tr>"
	dat += "</table>"

	if(user.client.is_new_player())
		dat = list("<center>REGISTER!</center>")

	user?.client.acquire_dpi()
	winshow(user, "stonekeep_prefwin", TRUE)
	winshow(user, "stonekeep_prefwin.character_preview_map", TRUE)
	var/datum/browser/popup = new(user, "preferences_browser", "<div align='center'>Character Sheet</div>", 700, 600)
	popup.set_window_options(can_close = TRUE)
	popup.set_content(dat.Join())
	popup.open(FALSE)
	update_preview_icon()
	onclose(user, "stonekeep_prefwin", src)

#undef APPEARANCE_CATEGORY_COLUMN
#undef MAX_MUTANT_ROWS

/datum/preferences/proc/CaptureKeybinding(mob/user, datum/keybinding/kb, old_key)
	var/HTML = {"
	<div id='focus' style="outline: 0;" tabindex=0>Keybinding: [kb.full_name]<br>[kb.description]<br><br><b>Press any key to change<br>Press ESC to clear</b></div>
	<script>
	var deedDone = false;
	document.onkeyup = function(e) {
		if(deedDone){ return; }
		var alt = e.altKey ? 1 : 0;
		var ctrl = e.ctrlKey ? 1 : 0;
		var shift = e.shiftKey ? 1 : 0;
		var numpad = (95 < e.keyCode && e.keyCode < 112) ? 1 : 0;
		var escPressed = e.keyCode == 27 ? 1 : 0;
		var url = 'byond://?_src_=prefs;preference=keybinds;task=keybindings_set;keybinding=[kb.name];old_key=[old_key];clear_key='+escPressed+';key='+e.key+';alt='+alt+';ctrl='+ctrl+';shift='+shift+';numpad='+numpad+';key_code='+e.keyCode;
		window.location=url;
		deedDone = true;
	}
	document.getElementById('focus').focus();
	</script>
	"}
	winshow(user, "capturekeypress", TRUE)
	var/datum/browser/noclose/popup = new(user, "capturekeypress", "<div align='center'>Keybindings</div>", 350, 300)
	popup.set_content(HTML)
	popup.open(FALSE)
	onclose(user, "capturekeypress", src)

/datum/preferences/proc/SetChoices(mob/user, limit = 15, list/splitJobs = list("Captain", "Priest", "Merchant", "Butler", "Village Elder"), widthPerColumn = 295, height = 620) //295 620
	if(!SSjob)
		return

	//limit - The amount of jobs allowed per column. Defaults to 17 to make it look nice.
	//splitJobs - Allows you split the table by job. You can make different tables for each department by including their heads. Defaults to CE to make it look nice.
	//widthPerColumn - Screen's width for every column.
	//height - Screen's height.

	var/width = widthPerColumn

	var/HTML = "<center>"
	if(!length(SSjob.joinable_occupations))
		HTML += "<center><a href='?_src_=prefs;preference=job;task=close'>Done</a></center><br>" // Easier to press up here.
	else
		//HTML += "<b>Choose class preferences</b><br>"
		//HTML += "<div align='center'>Left-click to raise a class preference, right-click to lower it.<br></div>"
		HTML += "<center><a href='?_src_=prefs;preference=job;task=close'>Done</a></center><br>" // Easier to press up here.
		if(joblessrole != RETURNTOLOBBY && joblessrole != BERANDOMJOB) // this is to catch those that used the previous definition and reset.
			joblessrole = RETURNTOLOBBY
		HTML += "<b>If Role Unavailable:</b><font color='purple'><a href='?_src_=prefs;preference=job;task=nojob'>[joblessrole]</a></font><BR>"
		HTML += "<script type='text/javascript'>function setJobPrefRedirect(level, rank) { window.location.href='?_src_=prefs;preference=job;task=setJobLevel;level=' + level + ';text=' + encodeURIComponent(rank); return false; }</script>"
		HTML += "<table width='100%' cellpadding='1' cellspacing='0'><tr><td width='20%'>" // Table within a table for alignment, also allows you to easily add more colomns.
		HTML += "<table width='100%' cellpadding='1' cellspacing='0'>"
		var/index = -1

		//The job before the current job. I only use this to get the previous jobs color when I'm filling in blank rows.
		var/datum/job/lastJob
		for(var/datum/job/job as anything in sortList(SSjob.joinable_occupations, GLOBAL_PROC_REF(cmp_job_display_asc)))
			if(!job.total_positions && !job.spawn_positions)
				continue

			if(job.spawn_positions <= 0)
				continue

			index += 1
			if(index >= limit) //|| (job.title in splitJobs))
				width += widthPerColumn
				if((index < limit) && (lastJob != null))
					//If the cells were broken up by a job in the splitJob list then it will fill in the rest of the cells with
					//the last job's selection color. Creating a rather nice effect.
					for(var/i = 0, i < (limit - index), i += 1)
						HTML += "<tr bgcolor='#000000'><td width='60%' align='right'>&nbsp</td><td>&nbsp</td></tr>"
				HTML += "</table></td><td width='20%'><table width='100%' cellpadding='1' cellspacing='0'>"
				index = 0

			if(job.title in splitJobs)
				HTML += "<tr bgcolor='#000000'><td width='60%' align='right'><hr></td></tr>"

			HTML += "<tr bgcolor='#000000'><td width='60%' align='right'>"
			var/rank = job.title
			var/used_name = (gender == FEMALE && job.f_title) ? job.f_title : job.title
			lastJob = job
			if(is_role_banned(user.ckey, job.title))
				HTML += "[used_name]</td> <td><a href='?_src_=prefs;bancheck=[rank]'> BANNED</a></td></tr>"
				continue
			var/required_playtime_remaining = job.required_playtime_remaining(user.client)
			if(required_playtime_remaining)
				HTML += "[used_name]</td> <td><font color=red> \[ [get_exp_format(required_playtime_remaining)] as [job.get_exp_req_type()] \] </font></td></tr>"
				continue
			if(!job.player_old_enough(user.client))
				var/available_in_days = job.available_in_days(user.client)
				HTML += "[used_name]</td> <td><font color=red> \[IN [(available_in_days)] DAYS\]</font></td></tr>"
				continue
			if(CONFIG_GET(flag/usewhitelist))
				if(job.whitelist_req && (!user.client.whitelisted()))
					HTML += "<font color=#6183a5>[used_name]</font></td> <td> </td></tr>"
					continue

			if(get_playerquality(user.ckey) < job.min_pq)
				HTML += "<font color=#a36c63>[used_name] (Min PQ: [job.min_pq])</font></td> <td> </td></tr>"
				continue
			if(length(job.allowed_ages) && !(user.client.prefs.age in job.allowed_ages))
				HTML += "<font color=#a36c63>[used_name]</font></td> <td> </td></tr>"
				continue
			if(length(job.allowed_races) && !(user.client.prefs.pref_species.id in job.allowed_races))
				if(!(user.client.has_triumph_buy(TRIUMPH_BUY_RACE_ALL)))
					HTML += "<font color=#a36c63>[used_name]</font></td> <td> </td></tr>"
					continue
			if(length(job.allowed_patrons) && !(user.client.prefs.selected_patron.type in job.allowed_patrons))
				HTML += "<font color=#a36c63>[used_name]</font></td> <td> </td></tr>"
				continue
			if(length(job.allowed_sexes) && !(user.client.prefs.gender in job.allowed_sexes))
				HTML += "<font color=#a36c63>[used_name]</font></td> <td> </td></tr>"
				continue

			HTML += {"
				<style>

					.tutorialhover {
						position: relative;
						display: inline-block;
						border-bottom: 1px dotted black;
					}

					.tutorialhover .tutorial {

						visibility: hidden;
						width: 280px;
						background-color: black;
						color: #e3c06f;
						text-align: center;
						border-radius: 6px;
						padding: 5px 0;

						position: absolute;
						z-index: 1;
						top: 100%;
						left: 50%;
						margin-left: -140px;
					}

					.tutorialhover:hover .tutorial{
						visibility: visible;
					}

				</style>

				<div class="tutorialhover">[used_name]</font>
				<span class="tutorial">[job.tutorial]<br>
				Slots: [job.spawn_positions]</span>
				</div>

			"}

			HTML += "</td><td width='40%'>"

			var/prefLevelLabel = "ERROR"
			var/prefLevelColor = "pink"
			var/prefUpperLevel = -1 // level to assign on left click
			var/prefLowerLevel = -1 // level to assign on right click

			switch(job_preferences[job.title])
				if(JP_HIGH)
					prefLevelLabel = "High"
					prefLevelColor = "slateblue"
					prefUpperLevel = 4
					prefLowerLevel = 2
				if(JP_MEDIUM)
					prefLevelLabel = "Medium"
					prefLevelColor = "green"
					prefUpperLevel = 1
					prefLowerLevel = 3
				if(JP_LOW)
					prefLevelLabel = "Low"
					prefLevelColor = "orange"
					prefUpperLevel = 2
					prefLowerLevel = 4
				else
					prefLevelLabel = "NEVER"
					prefLevelColor = "red"
					prefUpperLevel = 3
					prefLowerLevel = 1

			HTML += "<a class='white' href='?_src_=prefs;preference=job;task=setJobLevel;level=[prefUpperLevel];text=[rank]' oncontextmenu='javascript:return setJobPrefRedirect([prefLowerLevel], \"[rank]\");'>"
			HTML += "<font color=[prefLevelColor]>[prefLevelLabel]</font>"
			HTML += "</a></td></tr>"

		for(var/i = 1, i < (limit - index), i += 1) // Finish the column so it is even
			HTML += "<tr bgcolor='000000'><td width='60%' align='right'>&nbsp</td><td>&nbsp</td></tr>"

		HTML += "</td'></tr></table>"
		HTML += "</center></table><br>"

		//var/message = "Get random job if preferences unavailable"
		//if(joblessrole == RETURNTOLOBBY)
		//	message = "Return to lobby if preferences unavailable"
		//HTML += "<center><br><a href='?_src_=prefs;preference=job;task=random'>[message]</a></center>"
		if(user.client.prefs.lastclass)
			HTML += "<center><a href='?_src_=prefs;preference=job;task=triumphthing'>PLAY AS [user.client.prefs.lastclass] AGAIN</a></center>"
		else
			HTML += "<br>"
		HTML += "<center><a href='?_src_=prefs;preference=job;task=reset'>Reset</a></center>"

	var/datum/browser/noclose/popup = new(user, "mob_occupation", "<div align='center'>Class Selection</div>", width, height)
	popup.set_window_options(can_close = FALSE)
	popup.set_content(HTML)
	popup.open(FALSE)

/datum/preferences/proc/SetJobPreferenceLevel(datum/job/job, level)
	if (!job)
		return FALSE

	if (level == JP_HIGH) // to high
		//Set all other high to medium
		for(var/j in job_preferences)
			if(job_preferences[j] == JP_HIGH)
				job_preferences[j] = JP_MEDIUM
				//technically break here

	job_preferences[job.title] = level
	return TRUE

/datum/preferences/proc/UpdateJobPreference(mob/user, role, desiredLvl)
	if(!SSjob || !length(SSjob.joinable_occupations))
		return
	var/datum/job/job = SSjob.GetJob(role)

	if(!job || !(job.job_flags & JOB_NEW_PLAYER_JOINABLE))
		user << browse(null, "window=mob_occupation")
		ShowChoices(user,4)
		return

	if (!isnum(desiredLvl))
		to_chat(user, "<span class='danger'>UpdateJobPreference - desired level was not a number. Please notify coders!</span>")
		ShowChoices(user,4)
		CRASH("UpdateJobPreference called with desiredLvl value of [isnull(desiredLvl) ? "null" : desiredLvl]")

	var/jpval = null
	switch(desiredLvl)
		if(3)
			jpval = JP_LOW
		if(2)
			jpval = JP_MEDIUM
		if(1)
			jpval = JP_HIGH

	SetJobPreferenceLevel(job, jpval)
	SetChoices(user)

	return 1


/datum/preferences/proc/ResetJobs(mob/user, silent = FALSE)
	job_preferences = list()
	if(!silent)
		to_chat(user, "<font color='red'>Classes reset.</font>")

/datum/preferences/proc/ResetLastClass(mob/user)
	if(user.client?.prefs)
		if(!user.client.prefs.lastclass)
			return
	if(browser_alert(user, "Use 2 TRIUMPHS to play as this class again?", "OUROBOROS", DEFAULT_INPUT_CONFIRMATIONS) != CHOICE_CONFIRM)
		return
	if(user.client?.prefs)
		if(user.client.prefs.lastclass)
			if(user.get_triumphs() < 2)
				to_chat(user, "<span class='warning'>I haven't TRIUMPHED enough.</span>")
				return
			user.adjust_triumphs(-2)
			user.client.prefs.lastclass = null
			user.client.prefs.save_preferences()

/datum/preferences/proc/SetKeybinds(mob/user)
	var/list/dat = list()
	// Create an inverted list of keybindings -> key
	var/list/user_binds = list()
	for (var/key in key_bindings)
		for(var/kb_name in key_bindings[key])
			user_binds[kb_name] += list(key)

	var/list/kb_categories = list()
	// Group keybinds by category
	for (var/name in GLOB.keybindings_by_name)
		var/datum/keybinding/kb = GLOB.keybindings_by_name[name]
		kb_categories[kb.category] += list(kb)

	dat += "<style>label { display: inline-block; width: 200px; }</style><body>"

	dat += "<center><a href='?_src_=prefs;preference=keybinds;task=close'>Done</a></center><br>"
	for (var/category in kb_categories)
		for (var/i in kb_categories[category])
			var/datum/keybinding/kb = i
			if(!length(user_binds[kb.name]))
				dat += "<label>[kb.full_name]</label> <a href ='?_src_=prefs;preference=keybinds;task=keybindings_capture;keybinding=[kb.name];old_key=["Unbound"]'>Unbound</a>"
			//	var/list/default_keys = hotkeys ? kb.hotkey_keys : kb.classic_keys
			//	if(LAZYLEN(default_keys))
			//		dat += "| Default: [default_keys.Join(", ")]"
				dat += "<br>"
			else
				var/bound_key = user_binds[kb.name][1]
				dat += "<label>[kb.full_name]</label> <a href ='?_src_=prefs;preference=keybinds;task=keybindings_capture;keybinding=[kb.name];old_key=[bound_key]'>[bound_key]</a>"
				for(var/bound_key_index in 2 to length(user_binds[kb.name]))
					bound_key = user_binds[kb.name][bound_key_index]
					dat += " | <a href ='?_src_=prefs;preference=keybinds;task=keybindings_capture;keybinding=[kb.name];old_key=[bound_key]'>[bound_key]</a>"
				if(length(user_binds[kb.name]) < MAX_KEYS_PER_KEYBIND)
					dat += "| <a href ='?_src_=prefs;preference=keybinds;task=keybindings_capture;keybinding=[kb.name]'>Add Secondary</a>"
				dat += "<br>"

	dat += "<br><br>"
	dat += "<a href ='?_src_=prefs;preference=keybinds;task=keybindings_reset'>\[Reset to default\]</a>"
	dat += "</body>"

	var/datum/browser/noclose/popup = new(user, "keybind_setup", "<div align='center'>Keybinds</div>", 600, 600) //no reason not to reuse the occupation window, as it's cleaner that way
	popup.set_window_options(can_close = FALSE)
	popup.set_content(dat.Join())
	popup.open(FALSE)

/datum/preferences/proc/SetAntag(mob/user)
	var/list/dat = list()

	dat += "<style>label { display: inline-block; width: 200px; }</style><body>"
	dat += "<center><a href='?_src_=prefs;preference=antag;task=close' style='display:block;margin-bottom:2px'>Done</a></center>"
	dat += "<h2 style='margin:5;padding:5;line-height:1.2'>Villains</h2>"

	if(is_total_antag_banned(user.ckey))
		dat += "<font color=red><b>I am banned from antagonist roles.</b></font><br>"
		src.be_special = list()

	for (var/i in GLOB.special_roles_rogue)
		if(is_antag_banned(user.ckey, i))
			dat += "<b>[capitalize(i)]:</b> <a href='?_src_=prefs;bancheck=[i]'>BANNED</a><br>"
		else
			var/days_remaining = null
			if(ispath(GLOB.special_roles_rogue[i]) && CONFIG_GET(flag/use_age_restriction_for_jobs)) //If it's a game mode antag, check if the player meets the minimum age
				days_remaining = get_remaining_days(user.client)

			if(days_remaining)
				dat += "<b>[capitalize(i)]:</b> <font color=red> \[IN [days_remaining] DAYS\]</font><br>"
			else
				dat += "<b>[capitalize(i)]:</b> <a href='?_src_=prefs;preference=antag;task=be_special;be_special_type=[i]'>[(i in be_special) ? "Enabled" : "Disabled"]</a><br>"

	dat += "</body>"

	var/datum/browser/noclose/popup = new(user, "antag_setup", "<div align='center'>Special Roles</div>", 265, 340) //no reason not to reuse the occupation window, as it's cleaner that way
	popup.set_window_options(can_close = FALSE)
	popup.set_content(dat.Join())
	popup.open(FALSE)

/datum/preferences/proc/LorePopup(mob/user)
	if(!user || !user.client)
		return
	var/list/dat = list()
	var/datum/browser/noclose/popup  = new(user, "lore_primer", "<div align='center'>Lore Primer</div>", 650, 900)
	dat += GLOB.roleplay_readme
	popup.set_content(dat.Join())
	popup.open(FALSE)

/datum/preferences/Topic(href, href_list, hsrc)			//yeah, gotta do this I guess..
	. = ..()
	if(href_list["close"])
		var/client/C = usr.client
		if(C)
			C.clear_character_previews()

/datum/preferences/proc/process_link(mob/user, list/href_list)
	if(href_list["bancheck"])
		var/list/ban_details = is_banned_from_with_details(user.ckey, user.client.address, user.client.computer_id, href_list["bancheck"])
		var/admin = FALSE
		if(GLOB.admin_datums[user.ckey] || GLOB.deadmins[user.ckey])
			admin = TRUE
		for(var/i in ban_details)
			if(admin && !text2num(i["applies_to_admins"]))
				continue
			ban_details = i
			break //we only want to get the most recent ban's details
		if(ban_details && ban_details.len)
			var/expires = "This is a permanent ban."
			if(ban_details["expiration_time"])
				expires = " The ban is for [DisplayTimeText(text2num(ban_details["duration"]) MINUTES)] and expires on [ban_details["expiration_time"]] (server time)."
			to_chat(user, "<span class='danger'>You, or another user of this computer or connection ([ban_details["key"]]) is banned from playing [href_list["bancheck"]].<br>The ban reason is: [ban_details["reason"]]<br>This ban (BanID #[ban_details["id"]]) was applied by [ban_details["admin_key"]] on [ban_details["bantime"]] during round ID [ban_details["round_id"]].<br>[expires]</span>")
			return
	if(href_list["preference"] == "job")
		switch(href_list["task"])
			if("close")
				user << browse(null, "window=mob_occupation")
				ShowChoices(user,4)
			if("reset")
				ResetJobs(user, TRUE)
				SetChoices(user,4)
			if("triumphthing")
				ResetLastClass(user)
			if("nojob")
				switch(joblessrole)
					if(RETURNTOLOBBY)
						joblessrole = BERANDOMJOB
					if(BERANDOMJOB)
						joblessrole = RETURNTOLOBBY
				SetChoices(user)
			if("tutorial")
				if(href_list["tut"])
					to_chat(user, "<span class='info'>* ----------------------- *</span>")
					to_chat(user, href_list["tut"])
					to_chat(user, "<span class='info'>* ----------------------- *</span>")
			if("random")
				joblessrole = BERANDOMJOB
				SetChoices(user)
			if("setJobLevel")
				if(SSticker.job_change_locked)
					return 1
				UpdateJobPreference(user, href_list["text"], text2num(href_list["level"]))
			else
				SetChoices(user)
		return 1

	else if(href_list["preference"] == "antag")
		switch(href_list["task"])
			if("close")
				user << browse(null, "window=antag_setup")
				ShowChoices(user)
			if("be_special")
				var/be_special_type = href_list["be_special_type"]
				if(be_special_type in be_special)
					be_special -= be_special_type
				else
					be_special += be_special_type
				SetAntag(user)
			if("update")
				SetAntag(user)
			else
				SetAntag(user)

	else if(href_list["preference"] == "triumphs")
		user.show_triumphs_list()

	else if(href_list["preference"] == "playerquality")
		check_pq_menu(user.ckey)

	else if(href_list["preference"] == "culinary")
		show_culinary_ui(user)
		return

	else if(href_list["preference"] == "markings")
		ShowMarkings(user)
		return
	else if(href_list["preference"] == "descriptors")
		show_descriptors_ui(user)
		return

	else if(href_list["preference"] == "customizers")
		ShowCustomizers(user)
		return
	else if(href_list["preference"] == "triumph_buy_menu")
		SStriumphs.startup_triumphs_menu(user.client)

	else if(href_list["preference"] == "keybinds")
		switch(href_list["task"])
			if("close")
				user << browse(null, "window=keybind_setup")
				ShowChoices(user)
			if("update")
				SetKeybinds(user)
			if("keybindings_capture")
				var/datum/keybinding/kb = GLOB.keybindings_by_name[href_list["keybinding"]]
				var/old_key = href_list["old_key"]
				CaptureKeybinding(user, kb, old_key)
				return

			if("keybindings_set")
				var/kb_name = href_list["keybinding"]
				if(!kb_name)
					user << browse(null, "window=capturekeypress")
					SetKeybinds(user)
					return

				var/clear_key = text2num(href_list["clear_key"])
				var/old_key = href_list["old_key"]
				if(clear_key)
					if(key_bindings[old_key])
						key_bindings[old_key] -= kb_name
						if(!length(key_bindings[old_key]))
							key_bindings -= old_key
					user << browse(null, "window=capturekeypress")
					save_preferences()
					SetKeybinds(user)
					return

				var/new_key = uppertext(href_list["key"])
				var/AltMod = text2num(href_list["alt"]) ? "Alt" : ""
				var/CtrlMod = text2num(href_list["ctrl"]) ? "Ctrl" : ""
				var/ShiftMod = text2num(href_list["shift"]) ? "Shift" : ""
				var/numpad = text2num(href_list["numpad"]) ? "Numpad" : ""
				// var/key_code = text2num(href_list["key_code"])

				if(GLOB._kbMap[new_key])
					new_key = GLOB._kbMap[new_key]

				var/full_key
				switch(new_key)
					if("Alt")
						full_key = "[new_key][CtrlMod][ShiftMod]"
					if("Ctrl")
						full_key = "[AltMod][new_key][ShiftMod]"
					if("Shift")
						full_key = "[AltMod][CtrlMod][new_key]"
					else
						full_key = "[AltMod][CtrlMod][ShiftMod][numpad][new_key]"
				if(key_bindings[old_key])
					key_bindings[old_key] -= kb_name
					if(!length(key_bindings[old_key]))
						key_bindings -= old_key
				key_bindings[full_key] += list(kb_name)
				key_bindings[full_key] = sortList(key_bindings[full_key])

				DIRECT_OUTPUT(user, browse(null, "window=capturekeypress"))
				user.client.update_movement_keys()
				save_preferences()
				SetKeybinds(user)

			if("keybindings_reset")
				var/choice = browser_alert(user, "Do you really want to reset your keybindings?", "Setup keybindings", DEFAULT_INPUT_CONFIRMATIONS)
				if(choice != CHOICE_CONFIRM)
					return
				hotkeys = TRUE
				key_bindings = deepCopyList(GLOB.hotkey_keybinding_list_by_key)
				user.client.update_movement_keys()
				SetKeybinds(user)
			else
				SetKeybinds(user)
		return TRUE

	switch(href_list["task"])
		if("change_customizer")
			handle_customizer_topic(user, href_list)
			ShowChoices(user)
			ShowCustomizers(user)
			return
		if("change_marking")
			handle_body_markings_topic(user, href_list)
			ShowChoices(user)
			ShowMarkings(user)
			return
		if("change_descriptor")
			handle_descriptors_topic(user, href_list)
			show_descriptors_ui(user)
			return
		if("change_culinary_preferences")
			handle_culinary_topic(user, href_list)
			show_culinary_ui(user)
			return
		if("random")
			switch(href_list["preference"])
				if("name")
					real_name = pref_species.random_name(gender,1)
				if("age")
					age = pick(pref_species.possible_ages)
				if("eyes")
					eye_color = random_eye_color()
				if("s_tone")
					var/list/skins = pref_species.get_skin_list()
					skin_tone = skins[pick(skins)]
				if("species")
					random_species()
				if("all")
					apply_character_randomization_prefs()

		if("input")

			if(href_list["preference"] in GLOB.preferences_custom_names)
				ask_for_custom_name(user,href_list["preference"])

			switch(href_list["preference"])
				if("name")
					var/new_name = browser_input_text(user, "DECIDE YOUR HERO'S IDENTITY", "THE SELF", real_name, MAX_NAME_LEN, encode = FALSE)
					if(new_name)
						new_name = reject_bad_name(new_name)
						if(new_name)
							real_name = new_name
						else
							to_chat(user, "<font color='red'>Invalid name. Your name should be at least 2 and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z, -, ' and .</font>")
					GLOB.name_adjustments |= "[parent] changed their characters name to [new_name]."
					log_character("[parent] changed their characters name to [new_name].")

				if("age")
					var/new_age = browser_input_list(user, "SELECT YOUR HERO'S AGE", "YILS DEAD", pref_species.possible_ages, age)
					if(new_age)
						age = new_age
						ResetJobs(user)
				if ("pronouns")
					var/list/allowed_pronouns = pref_species.allowed_pronouns
					if(!allowed_pronouns || !length(allowed_pronouns))
						// fallback to the default pronouns list
						allowed_pronouns = PRONOUNS_LIST

					if(length(allowed_pronouns) == 1)
						pronouns = allowed_pronouns[1]
						to_chat(user, span_warning("This species can only use [pronouns]."))
						return

					var/pronouns_input = browser_input_list(user, "CHOOSE HOW MORTALS REFER TO YOUR HERO", "DISOBEY SOCIAL NORMS", allowed_pronouns)
					if(pronouns_input)
						pronouns = pronouns_input
						to_chat(user, span_warning("Your character's pronouns are now [pronouns]."))
				if ("voicetype")
					var/list/allowed_voices
					if(gender == MALE)
						allowed_voices = pref_species.allowed_voicetypes_m
					else if(gender == FEMALE)
						allowed_voices = pref_species.allowed_voicetypes_f
					else
						allowed_voices = VOICE_TYPES_LIST
					if(!allowed_voices || !length(allowed_voices))
						allowed_voices = VOICE_TYPES_LIST
					if(length(allowed_voices) == 1)
						voice_type = allowed_voices[1]
						to_chat(user, span_warning("This species can only use the [voice_type] voice type."))
						return

					var/voicetype_input = browser_input_list(user, "CHOOSE YOUR HERO'S VOICE TYPE", "DISCARD SOCIETY'S EXPECTATIONS", allowed_voices)
					if(voicetype_input)
						voice_type = voicetype_input
						if(voicetype_input == VOICE_TYPE_ANDRO)
							to_chat(user, span_warning("This will use the feminine voicepack pitched down a bit to achieve a more androgynous sound."))
						to_chat(user, span_warning("Your character will now vocalize with a [lowertext(voice_type)] affect."))
				if("faith")
					var/list/faiths_named = list()
					for(var/path as anything in GLOB.preference_faiths)
						var/datum/faith/faith = GLOB.faithlist[path]
						if(!faith.name)
							continue
						faiths_named["\The [faith.name]"] = faith
					var/faith_input = browser_input_list(user, "SELECT YOUR HERO'S BELIEF", "PUPPETS ON STRINGS", faiths_named, "\The [selected_patron.associated_faith::name]")
					if(faith_input)
						var/datum/faith/faith = faiths_named[faith_input]
						to_chat(user, "<font color='purple'>Faith: [faith.name]</font>")
						to_chat(user, "<font color='purple'>Background: [faith.desc]</font>")
						selected_patron = GLOB.preference_patrons[faith.godhead] || GLOB.preference_patrons[pick(GLOB.patrons_by_faith[faith_input])]

				if("patron")
					var/list/patrons_named = list()
					for(var/path as anything in GLOB.patrons_by_faith[selected_patron?.associated_faith || initial(default_patron.associated_faith)])
						var/datum/patron/patron = GLOB.preference_patrons[path]
						if(!patron.name)
							continue
						var/pref_name = patron.display_name ? patron.display_name : patron.name
						patrons_named[pref_name] = patron
					var/datum/faith/current_faith = GLOB.faithlist[selected_patron?.associated_faith] || GLOB.faithlist[initial(default_patron.associated_faith)]
					var/god_input = browser_input_list(user, "SELECT YOUR HERO'S PATRON GOD", uppertext("\The [current_faith.name]"), patrons_named, selected_patron)
					if(god_input)
						selected_patron = patrons_named[god_input]
						to_chat(user, "<font color='purple'>Patron: [selected_patron]</font>")
						to_chat(user, "<font color='purple'>Domain: [selected_patron.domain]</font>")
						to_chat(user, "<font color='purple'>Background: [selected_patron.desc]</font>")
						to_chat(user, "<font color='purple'>Flawed aspects: [selected_patron.flaws]</font>")
						to_chat(user, "<font color='purple'>Likely Worshippers: [selected_patron.worshippers]</font>")
						to_chat(user, "<font color='red'>Considers these to be Sins: [selected_patron.sins]</font>")
						to_chat(user, "<font color='white'>Blessed with boon(s): [selected_patron.boons]</font>")

				if("voice")
					var/new_voice = input(user, "SELECT YOUR HERO'S VOICE COLOR", "THE THROAT","#"+voice_color) as color|null
					if(new_voice)
						if(color_hex2num(new_voice) < 230)
							to_chat(user, "<font color='red'>This voice color is too dark for mortals.</font>")
							return
						voice_color = sanitize_hexcolor(new_voice)

				if("headshot")
					if(!patreon)
						to_chat(user, "This is a patreon exclusive feature, your headshot link will be applied but others will only be able to view it if you are a patreon supporter.")

					to_chat(user, "<span class='notice'>Please use an image of the head and shoulder area to maintain immersion level. Lastly, ["<span class='bold'>do not use a real life photo or use any image that is less than serious.</span>"]</span>")
					to_chat(user, "<span class='notice'>If the photo doesn't show up properly in-game, ensure that it's a direct image link that opens properly in a browser.</span>")
					to_chat(user, "<span class='notice'>Keep in mind that the photo will be downsized to 325x325 pixels, so the more square the photo, the better it will look.</span>")
					var/new_headshot_link = input(user, "Input the headshot link (https, hosts: gyazo, lensdump, imgbox, catbox):", "Headshot", headshot_link) as text|null
					if(!new_headshot_link)
						return
					var/is_valid_link = is_valid_headshot_link(user, new_headshot_link, FALSE)
					if(!is_valid_link)
						to_chat(user, span_notice("Failed to update headshot"))
						return
					headshot_link = new_headshot_link
					to_chat(user, "<span class='notice'>Successfully updated headshot picture</span>")
					log_game("[user] has set their Headshot image to '[headshot_link]'.")

				if("species")
					var/list/selectable = get_selectable_species(patreon)

					var/result = browser_input_list(user, "SELECT YOUR HERO'S PEOPLE:", "VANDERLIN FAUNA", selectable, pref_species)

					if(result)
						var/species = GLOB.species_list[result]
						pref_species = new species

						to_chat(user, "<em>[pref_species.name]</em>")
						if(pref_species.desc)
							to_chat(user, "[pref_species.desc]")

						if(!length(pref_species.allowed_pronouns))
							to_chat(user, span_warning("This species does not have any allowed pronouns. Please contact a coder to add them."))
						else if (length(pref_species.allowed_pronouns) == 1)
							pronouns = pref_species.allowed_pronouns[1]
						else if(!(pronouns in pref_species.allowed_pronouns))
							pronouns = pref_species.allowed_pronouns[1]

						//Now that we changed our species, we must verify that the mutant colour is still allowed.
						real_name = pref_species.random_name(gender,1)
						ResetJobs(user)
						randomise_appearance_prefs(~(RANDOMIZE_SPECIES))
						customizer_entries = list()
						validate_customizer_entries()
						reset_all_customizer_accessory_colors()
						randomize_all_customizer_accessories()
						accessory = "Nothing"

				if("charflaw")
					var/list/flawslist = GLOB.character_flaws.Copy()
					var/result = browser_input_list(user, "SELECT YOUR HERO'S FLAW", "PERFECTION IS IMPOSSIBLE", flawslist, FALSE)
					if(result)
						result = flawslist[result]
						var/datum/charflaw/C = new result()
						charflaw = C
						if(charflaw.desc)
							to_chat(user, "<span class='info'>[charflaw.desc]</span>")

				if("flavortext")
					to_chat(user, "<span class='notice'>["<span class='bold'>Flavortext should not include nonphysical nonsensory attributes such as backstory or the character's internal thoughts. NSFW descriptions are prohibited.</span>"]</span>")
					var/new_flavortext = input(user, "Input your character description:", "Flavortext", flavortext) as message|null
					if(new_flavortext == null)
						return
					if(new_flavortext == "")
						flavortext = null
						ShowChoices(user)
						return
					flavortext = new_flavortext
					to_chat(user, "<span class='notice'>Successfully updated flavortext</span>")
					log_game("[user] has set their flavortext'.")

				if("s_tone")
					var/listy = pref_species.get_skin_list()
					var/new_s_tone = browser_input_list(user, "CHOOSE YOUR HERO'S [uppertext(pref_species.skin_tone_wording)]", "THE SUN", listy)
					if(new_s_tone)
						skin_tone = listy[new_s_tone]

				if("selected_accent")
					if(!patreon)
						to_chat(user, "Sorry this is a patreon exclusive feature.")
						return
					var/accent = browser_input_list(user, "CHOOSE YOUR HERO'S ACCENT", "VOICE OF THE WORLD", GLOB.accent_list, selected_accent)
					if(accent)
						selected_accent = accent

				if("ooccolor")
					var/new_ooccolor = input(user, "Choose your OOC colour:", "Game Preference", ooccolor) as color|null
					if(new_ooccolor)
						ooccolor = sanitize_ooccolor(new_ooccolor)

				if("asaycolor")
					var/new_asaycolor = input(user, "Choose your ASAY color:", "Game Preference", asaycolor) as color|null
					if(new_asaycolor)
						asaycolor = sanitize_ooccolor(new_asaycolor)
				if ("clientfps")
					var/desiredfps = input(user, "Choose your desired fps. (0 = synced with server tick rate (currently:[world.fps]))", "Character Preference", clientfps)  as null|num
					if (!isnull(desiredfps))
						clientfps = desiredfps
						parent.fps = desiredfps
				if("ui")
					var/pickedui = input(user, "Choose your UI style.", "Character Preference", UI_style)  as null|anything in sortList(GLOB.available_ui_styles)
					if(pickedui)
						UI_style = "Rogue"
						if (parent && parent.mob && parent.mob.hud_used)
							parent.mob.hud_used.update_ui_style(ui_style2icon(UI_style))
		else
			switch(href_list["preference"])
				if("publicity")
					if(unlock_content)
						toggles ^= MEMBER_PUBLIC
				if ("max_chat_length")
					var/desiredlength = input(user, "Choose the max character length of shown Runechat messages. Valid range is 1 to [CHAT_MESSAGE_MAX_LENGTH] (default: [initial(max_chat_length)]))", "Character Preference", max_chat_length)  as null|num
					if (!isnull(desiredlength))
						max_chat_length = clamp(desiredlength, 1, CHAT_MESSAGE_MAX_LENGTH)
				if("gender")
					var/pickedGender = MALE
					if(gender == MALE)
						pickedGender = FEMALE
					if(pickedGender && pickedGender != gender)
						gender = pickedGender
						real_name = real_name = pref_species.random_name(gender,1)
						ResetJobs(user)
						randomise_appearance_prefs(RANDOMIZE_UNDERWEAR | RANDOMIZE_HAIRSTYLE)
						accessory = "Nothing"
						detail = "Nothing"
				if("domhand")
					if(domhand == 1)
						domhand = 2
					else
						domhand = 1
				if("bespecial")
					if(next_special_trait)
						print_special_text(user, next_special_trait)
						return
					to_chat(user, span_boldwarning("You will become special for one round, this could be something negative, positive or neutral and could have a high impact on your character and your experience. You cannot back out from or reroll this, and it will not carry over to other rounds."))
					to_chat(user, span_boldwarning("THIS COSTS 1 TRIUMPH"))
					if(user.get_triumphs() < 1)
						to_chat(user, span_bignotice("YOU DON'T HAVE ENOUGH TRIUMPHS."))
						return
					var/result = alert(user, "You'll receive a unique trait for one round\n You cannot back out from or reroll this\nDo you really want to spend 1 triumph for it?", "Be Special", "Yes", "No")
					if(result != "Yes")
						return
					user.adjust_triumphs(-1)
					if(next_special_trait)
						return
					next_special_trait = roll_random_special(user.client)
					if(next_special_trait)
						log_game("SPECIALS: Rolled [next_special_trait] for ckey: [user.ckey]")
						print_special_text(user, next_special_trait)
						user.playsound_local(user, 'sound/misc/alert.ogg', 100)
						to_chat(user, span_warning("This will be applied on your next game join."))
						to_chat(user, span_warning("You may switch your character and choose any role, if you don't meet the requirements (if any are specified) it won't be applied"))

				if("family")
					var/list/famtree_options_list = list(FAMILY_NONE, FAMILY_PARTIAL, FAMILY_NEWLYWED, FAMILY_FULL, "EXPLAIN THIS TO ME")
					var/new_family = browser_input_list(user, "SELECT YOUR HERO'S BOND", "BLOOD IS THICKER THAN WATER", famtree_options_list, family)
					if(new_family == "EXPLAIN THIS TO ME")
						to_chat(user, span_purple("\
						--[FAMILY_NONE] will disable this feature.<br>\
						--[FAMILY_PARTIAL] will assign you as a progeny of a local house based on your species. This feature will instead assign you as a aunt or uncle to a local family if your older than ADULT.<br>\
						--[FAMILY_NEWLYWED] assigns you a spouse without adding you to a family. Setspouse will prioritize pairing you with another newlywed with the same name as your setspouse.<br>\
						--[FAMILY_FULL] will attempt to assign you as matriarch or patriarch of one of the local houses of the kingdom/town. Setspouse will will prevent \
						players with the setspouse = None from matching with you unless their name equals your setspouse."))

					else if(new_family)
						family = new_family
				//Setspouse is part of the family subsystem. It will check existing families for this character and attempt to place you in this family.
				if("setspouse")
					var/newspouse = browser_input_text(user, "INPUT THE IDENTITY OF ANOTHER HERO", "TIL DEATH DO US PART")
					if(newspouse)
						setspouse = newspouse
					else
						setspouse = null
				//Gender_choice is part of the family subsytem. It will check existing families members with the same preference of this character and attempt to place you in this family.
				if("gender_choice")
					// If pronouns are neutral, lock to ANY_GENDER
					if(pronouns == THEY_THEM || pronouns == IT_ITS)
						to_chat(user, span_warning("With neutral pronouns, you may only choose [ANY_GENDER]."))
						gender_choice = ANY_GENDER
					else
						var/list/gender_choice_option_list = list(ANY_GENDER, SAME_GENDER, DIFFERENT_GENDER)
						var/new_gender_choice  = browser_input_list(user, "SELECT YOUR HERO'S PREFERENCE", "TO LOVE AND TO CHERISH", gender_choice_option_list, gender_choice)
						if(new_gender_choice)
							gender_choice = new_gender_choice
				if("alignment")
					var/new_alignment = browser_input_list(user, "SELECT YOUR HERO'S MORALITY", "CUT FROM THE SAME CLOTH", ALL_ALIGNMENTS_LIST, alignment)
					if(new_alignment)
						alignment = new_alignment
				if("hotkeys")
					hotkeys = !hotkeys
					if(hotkeys)
						winset(user, null, "input.focus=true command=activeInput input.background-color=[COLOR_INPUT_ENABLED]  input.text-color = #EEEEEE")
					else
						winset(user, null, "input.focus=true command=activeInput input.background-color=[COLOR_INPUT_DISABLED]  input.text-color = #ad9eb4")

				if("chat_on_map")
					chat_on_map = !chat_on_map
				if("see_chat_non_mob")
					see_chat_non_mob = !see_chat_non_mob
				if("action_buttons")
					buttons_locked = !buttons_locked
				if("tgui_fancy")
					tgui_fancy = !tgui_fancy
				if("tgui_lock")
					tgui_lock = !tgui_lock
				if("winflash")
					windowflashing = !windowflashing

				//here lies the badmins
				if("hear_adminhelps")
					user.client.toggleadminhelpsound()
				if("hear_prayers")
					user.client.toggle_prayer_sound()
				if("announce_login")
					user.client.toggleannouncelogin()
				if("combohud_lighting")
					toggles ^= COMBOHUD_LIGHTING
				if("toggle_dead_chat")
					user.client.deadchat()
				if("toggle_radio_chatter")
					user.client.toggle_hear_radio()
				if("toggle_prayers")
					user.client.toggleprayers()
				if("toggle_deadmin_always")
					toggles ^= DEADMIN_ALWAYS
				if("toggle_deadmin_antag")
					toggles ^= DEADMIN_ANTAGONIST
				if("toggle_deadmin_head")
					toggles ^= DEADMIN_POSITION_HEAD
				if("toggle_deadmin_security")
					toggles ^= DEADMIN_POSITION_SECURITY
				if("toggle_deadmin_silicon")
					toggles ^= DEADMIN_POSITION_SILICON


				if("be_special")
					var/be_special_type = href_list["be_special_type"]
					if(be_special_type in be_special)
						be_special -= be_special_type
					else
						be_special += be_special_type

				if("toggle_random")
					var/random_type = href_list["random_type"]
					if(randomise[random_type])
						randomise -= random_type
					else
						randomise[random_type] = TRUE

				if("hear_midis")
					toggles ^= SOUND_MIDI

				if("lobby_music")
					toggles ^= SOUND_LOBBY
					if((toggles & SOUND_LOBBY) && user.client && isnewplayer(user))
						user.client.playtitlemusic()
					else
						user.stop_sound_channel(CHANNEL_LOBBYMUSIC)

				if("ghost_ears")
					chat_toggles ^= CHAT_GHOSTEARS

				if("ghost_sight")
					chat_toggles ^= CHAT_GHOSTSIGHT

				if("ghost_whispers")
					chat_toggles ^= CHAT_GHOSTWHISPER

				if("ghost_radio")
					chat_toggles ^= CHAT_GHOSTRADIO

				if("ghost_pda")
					chat_toggles ^= CHAT_GHOSTPDA

				if("income_pings")
					chat_toggles ^= CHAT_BANKCARD

				if("pull_requests")
					chat_toggles ^= CHAT_PULLR

				if("allow_midround_antag")
					toggles ^= MIDROUND_ANTAG

				if("ambientocclusion")
					ambientocclusion = !ambientocclusion
					if(parent && parent.screen && parent.screen.len)
						var/atom/movable/screen/plane_master/game_world/PM = locate(/atom/movable/screen/plane_master/game_world) in parent.screen
						PM.backdrop(parent.mob)
						PM = locate(/atom/movable/screen/plane_master/game_world_fov_hidden) in parent.screen
						PM.backdrop(parent.mob)
						PM = locate(/atom/movable/screen/plane_master/game_world_above) in parent.screen
						PM.backdrop(parent.mob)

				if("auto_fit_viewport")
					auto_fit_viewport = !auto_fit_viewport
					if(auto_fit_viewport && parent)
						parent.fit_viewport()

				if("widescreenpref")
					widescreenpref = !widescreenpref
					user.client.view_size.setDefault(getScreenSize(widescreenpref))

				if("pixel_size")
					switch(pixel_size)
						if(PIXEL_SCALING_AUTO)
							pixel_size = PIXEL_SCALING_1X
						if(PIXEL_SCALING_1X)
							pixel_size = PIXEL_SCALING_1_2X
						if(PIXEL_SCALING_1_2X)
							pixel_size = PIXEL_SCALING_2X
						if(PIXEL_SCALING_2X)
							pixel_size = PIXEL_SCALING_3X
						if(PIXEL_SCALING_3X)
							pixel_size = PIXEL_SCALING_AUTO
					user.client.view_size.apply() //Let's winset() it so it actually works

				if("scaling_method")
					switch(scaling_method)
						if(SCALING_METHOD_NORMAL)
							scaling_method = SCALING_METHOD_DISTORT
						if(SCALING_METHOD_DISTORT)
							scaling_method = SCALING_METHOD_BLUR
						if(SCALING_METHOD_BLUR)
							scaling_method = SCALING_METHOD_NORMAL
					user.client.view_size.setZoomMode()

				if("schizo_voice")
					toggles ^= SCHIZO_VOICE
					if(toggles & SCHIZO_VOICE)
						to_chat(user, "<span class='warning'>You are now a voice.\n\
										As a voice, you will receive meditations from players asking about game mechanics!\n\
										Good voices could be rewarded with PQ by staff for answering meditations, while bad ones are punished.</span>")
					else
						to_chat(user, span_warning("You are no longer a voice."))

				if("migrants")
					migrant.show_ui()
					return

				if("loreprimer")
					LorePopup(user)

				if("manifest")
					parent.view_actors_manifest()
					return

				if("finished")
					user << browse(null, "window=latechoices") //closes late choices window
					user << browse(null, "window=playersetup") //closes the player setup window
					user << browse(null, "window=preferences") //closes job selection
					user << browse(null, "window=mob_occupation")
					user << browse(null, "window=latechoices") //closes late job selection
					user << browse(null, "window=migration") // Closes migrant menu

					SStriumphs.remove_triumph_buy_menu(user.client)

					winshow(user, "stonekeep_prefwin", FALSE)
					user << browse(null, "window=preferences_browser")
					user << browse(null, "window=lobby_window")
					return

				if("save")
					save_preferences()
					save_character()

				if("load")
					load_preferences()
					load_character()

				if("changeslot")
					var/list/choices = list()
					if(path)
						var/savefile/S = new /savefile(path)
						if(S)
							for(var/i=1, i<=max_save_slots, i++)
								var/name
								S.cd = "/character[i]"
								S["real_name"] >> name
								if(!name)
									name = "Slot[i]"
								choices[name] = i
					var/choice = browser_input_list(user, "WHO IS YOUR HERO?", "NECRA AWAITS", choices, real_name)
					if(choice)
						choice = choices[choice]
						if(!load_character(choice))
							randomise_appearance_prefs(include_patreon = patreon)
							save_character()

				if("randomiseappearanceprefs")
					if(!randomize_shutup)
						var/alert_response = browser_alert(user, "Are you sure you want to randomise your appearance preferences? This will overwrite your current preferences.", "Randomise Appearance Preferences", list("Yes", "No", "Don\'t Ask Again This Round (Yes)"))
						if(alert_response != "Yes")
							if(alert_response == "Don't Ask Again This Round (Yes)")
								randomize_shutup = TRUE
							else
								return
					randomise_appearance_prefs(include_patreon = patreon)
					customizer_entries = list()
					validate_customizer_entries()
					reset_all_customizer_accessory_colors()
					randomize_all_customizer_accessories()
					ResetJobs(user)

				if("tab")
					if (href_list["tab"])
						current_tab = text2num(href_list["tab"])

	ShowChoices(user)
	return 1



/// Sanitization checks to be performed before using these preferences.
/datum/preferences/proc/sanitize_chosen_prefs()
	if(!(pref_species.name in get_selectable_species(patreon)))
		pref_species = new /datum/species/human/northern
		save_character()

	if(CONFIG_GET(flag/humans_need_surnames) && (pref_species.id == SPEC_ID_HUMEN))
		var/firstspace = findtext(real_name, " ")
		var/name_length = length(real_name)
		if(!firstspace)	//we need a surname
			real_name += " [pick(GLOB.last_names)]"
		else if(firstspace == name_length)
			real_name += "[pick(GLOB.last_names)]"

/// Applies the randomization prefs, sanitizes the result and then applies the preference to the human mob.
/// This is good if you are applying prefs to a mob as if they were joining the round.
/datum/preferences/proc/safe_transfer_prefs_to(mob/living/carbon/human/character, icon_updates = TRUE, is_antag = FALSE)
	apply_character_randomization_prefs(is_antag)
	sanitize_chosen_prefs()
	apply_prefs_to(character, icon_updates)

/// Applies the given preferences to a human mob. Calling this directly will skip sanitisation.
/// This is good if you are applying prefs to a mob as if you were cloning them.
/datum/preferences/proc/apply_prefs_to(mob/living/carbon/human/character, icon_updates = TRUE)
	if(QDELETED(character) || !ishuman(character))
		return
	character.age = age
	character.gender = gender
	character.set_species(pref_species.type, icon_update = FALSE, pref_load = src)
	if(real_name in GLOB.chosen_names)
		character.real_name = pref_species.random_name(gender)
	else
		character.real_name = real_name
	character.name = character.real_name

	character.dna.features = features.Copy()
	character.dna.real_name = character.real_name

	var/obj/item/organ/eyes/organ_eyes = character.getorgan(/obj/item/organ/eyes)
	if(organ_eyes)
		organ_eyes.eye_color = eye_color
		organ_eyes.old_eye_color = eye_color

	character.skin_tone = skin_tone
	character.underwear = underwear
	character.undershirt = undershirt
	character.detail = detail
	character.socks = socks

	/* V: */

	character.headshot_link = headshot_link
	character.flavortext = flavortext
	character.pronouns = pronouns
	character.voice_type = voice_type

	character.domhand = domhand
	character.voice_color = voice_color
	character.set_patron(selected_patron)
	character.familytree_pref = family
	character.gender_choice_pref = gender_choice
	character.setspouse = setspouse

	if(charflaw)
		// ???
		var/obj/item/bodypart/O = character.get_bodypart(BODY_ZONE_R_ARM)
		if(O)
			O.drop_limb()
			qdel(O)
		O = character.get_bodypart(BODY_ZONE_L_ARM)
		if(O)
			O.drop_limb()
			qdel(O)
		character.regenerate_limb(BODY_ZONE_R_ARM)
		character.regenerate_limb(BODY_ZONE_L_ARM)
		character.set_flaw(charflaw.type, FALSE)

	if(culinary_preferences)
		apply_culinary_preferences(character)

	if(parent)
		var/datum/role_bans/bans = get_role_bans_for_ckey(parent.ckey)
		for(var/datum/role_ban_instance/ban as anything in bans.bans)
			if(!ban.curses)
				continue
			for(var/curse_name as anything in ban.curses)
				var/datum/curse/curse = GLOB.curse_names[curse_name]
				character.add_curse(curse.type)

		apply_trait_bans(character, parent.ckey)

		if(is_misc_banned(parent.ckey, BAN_MISC_LEPROSY))
			ADD_TRAIT(character, TRAIT_LEPROSY, TRAIT_BAN_PUNISHMENT)
		if(is_misc_banned(parent.ckey, BAN_MISC_PUNISHMENT_CURSE))
			ADD_TRAIT(character, TRAIT_PUNISHMENT_CURSE, TRAIT_BAN_PUNISHMENT)

		if(patreon)
			character.accent = selected_accent

	/* :V */

	if(icon_updates)
		character.update_body()
		character.update_body_parts(redraw = TRUE)

/datum/preferences/proc/get_default_name(name_id)
	// you can use name_id to add more here
	return random_unique_name()

/datum/preferences/proc/ask_for_custom_name(mob/user,name_id)
	var/namedata = GLOB.preferences_custom_names[name_id]
	if(!namedata)
		return

	var/raw_name = input(user, "Choose your character's [namedata["qdesc"]]:","Character Preference") as text|null
	if(!raw_name)
		if(namedata["allow_null"])
			custom_names[name_id] = get_default_name(name_id)
		else
			return
	else
		var/sanitized_name = reject_bad_name(raw_name,namedata["allow_numbers"])
		if(!sanitized_name)
			to_chat(user, "<font color='red'>Invalid name. Your name should be at least 2 and at most [MAX_NAME_LEN] characters long. It may only contain the characters A-Z, a-z,[namedata["allow_numbers"] ? ",0-9," : ""] -, ' and .</font>")
			return
		else
			custom_names[name_id] = sanitized_name

/datum/preferences/proc/is_active_migrant()
	if(!migrant)
		return FALSE
	if(!migrant.active)
		return FALSE
	return TRUE

/datum/preferences/proc/allowed_respawn()
	if(!has_spawned)
		return TRUE
	if(is_misc_banned(parent.ckey, BAN_MISC_RESPAWN))
		return FALSE
	return TRUE

/datum/preferences/proc/get_ui_theme_stylesheet()
	switch(ui_theme)

		if(UI_PREFERENCE_LIGHT_MODE)

			. = {"
			<html>
			<head>
			  <style>
			    body {
			      background-color: #ffffff;
			      color: #000000;
			    }

			    a {
			      color: #1a0dab;
			    }

			    a:visited {
			      color: #660099;
			    }

			    hr {
			      border-top: 1px solid #ccc;
			    }
			  </style>
			</head>
			</html>
			"}

		if(UI_PREFERENCE_DARK_MODE)

			. = {"
			<html>
			<head>
			  <style>
			    body {
			      background-color: #121212;
			      color: #e0e0e0;
			    }
			    a {
			      color: #90caf9;
			    }
			    a:visited {
			      color: #ce93d8;
			    }
			    hr {
			      border-top: 1px solid #444;
			    }
			  </style>
			</head>
			</html>
			"}

/datum/proc/is_valid_headshot_link(mob/user, value, silent = FALSE)
	var/static/list/allowed_hosts = list("i.gyazo.com", "a.l3n.co", "b.l3n.co", "c.l3n.co", "images2.imgbox.com", "thumbs2.imgbox.com")
	var/static/list/valid_extensions = list("jpg", "png", "jpeg", "gif")

	if(!length(value))
		return FALSE

	// Ensure link starts with "https://"
	if(findtext(value, "https://") != 1)
		if(!silent)
			to_chat(user, "<span class='warning'>Your link must be https!</span>")
		return FALSE

	// Extract domain from the URL
	var/start_index = length("https://") + 1
	var/end_index = findtext(value, "/", start_index)
	var/domain = (end_index ? copytext(value, start_index, end_index) : copytext(value, start_index))

	// Check if domain is in the allowed list
	if(!(domain in allowed_hosts))
		if(!silent)
			to_chat(user, "<span class='warning'>The image must be hosted on an approved site.</span>")
		return FALSE

	// Extract the filename and extension
	var/list/path_split = splittext(value, "/")
	var/filename = path_split[length(path_split)]
	var/list/file_parts = splittext(filename, ".")

	if(length(file_parts) < 2)
		return FALSE

	var/extension = file_parts[length(file_parts)]

	// Validate extension
	if(!(extension in valid_extensions))
		if(!silent)
			to_chat(user, "<span class='warning'>The image must be one of the following extensions: '[english_list(valid_extensions)]'</span>")
		return FALSE

	return TRUE

