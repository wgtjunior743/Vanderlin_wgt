// Verb to link discord accounts to BYOND accounts
/client/verb/linkdiscord()
	set category = "OOC"
	set name = "Verify Discord Account"
	set desc = "Verify your discord account with your BYOND account"

	// Safety checks
	if(!CONFIG_GET(flag/sql_enabled))
		to_chat(src, span_warning("This feature requires the SQL backend to be running."))
		return

	if(!SSdiscord || !SSdiscord.reverify_cache)
		to_chat(src, span_warning("Wait for the Discord subsystem to finish initialising"))
		return
	var/message = ""
	// Simple sanity check to prevent a user doing this too often
	var/cached_one_time_token = SSdiscord.reverify_cache[usr.ckey]
	if(cached_one_time_token && cached_one_time_token != "")
		message = "You already generated your one time token, it is [cached_one_time_token], if you need a new one, you will have to wait until the round ends, or switch to another server, try verifying yourself in discord by using the command <span class='warning'>\" /verifydiscord token:[cached_one_time_token] \"</span><br>If that doesn't work, type in /verifydiscord to show the command, then copy and paste the token."
	else
		// Will generate one if an expired one doesn't exist already, otherwise will grab existing token
		var/one_time_token = SSdiscord.get_or_generate_one_time_token_for_ckey(ckey)
		SSdiscord.reverify_cache[usr.ckey] = one_time_token
		message = "Your one time token is: [one_time_token], Assuming you have the required living minutes in game, you can now verify yourself in discord by using the command <span class='warning'>\" /verifydiscord token:[one_time_token] \"</span><br>If that doesn't work, type in /verifydiscord to show the command, then copy and paste the token."

	//Now give them a browse window so they can't miss whatever we told them
	var/datum/browser/window = new/datum/browser(usr, "discordverification", "Discord verification", 600, 400)
	usr << browse_rsc('html/discord-verification-command.png', "meow.png")
	window.add_content("html/")
	window.set_content("<span>[message]</span><hr style='background-color: ##433d34'><img src='meow.png'/>")
	window.open()
