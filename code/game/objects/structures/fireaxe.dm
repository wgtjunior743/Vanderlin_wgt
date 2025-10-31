/obj/structure/fireaxecabinet
	name = "sword rack"
	desc = ""
	icon = 'icons/obj/wallmounts.dmi'
	icon_state = "fireaxe"
	anchored = TRUE
	density = FALSE
	armor = list("blunt" = 50, "slash" = 50, "stab" = 50,  "piercing" = 20, "fire" = 90, "acid" = 50)
	max_integrity = 150
	integrity_failure = 0
	var/open = TRUE
	var/obj/item/weapon/sword/long/heirloom

/obj/structure/fireaxecabinet/Initialize()
	. = ..()
	heirloom = new /obj/item/weapon/sword/long/heirloom(src)
	update_appearance(UPDATE_ICON_STATE)

/obj/structure/fireaxecabinet/Destroy()
	if(heirloom)
		QDEL_NULL(heirloom)
	return ..()

/obj/structure/fireaxecabinet/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/weapon/sword/long/heirloom) && !heirloom)
		var/obj/item/weapon/sword/long/heirloom/F = I
		if(HAS_TRAIT(F, TRAIT_WIELDED))
			to_chat(user, "<span class='warning'>Unwield the [F.name] first.</span>")
			return
		if(!user.transferItemToLoc(F, src))
			return
		heirloom = F
		to_chat(user, "<span class='notice'>I place the [F.name] back in the [name].</span>")
		update_appearance(UPDATE_ICON_STATE)
		return
	return ..()

/obj/structure/fireaxecabinet/attack_hand(mob/user)
	. = ..()
	if(.)
		return
	if(heirloom)
		user.put_in_hands(heirloom)
		heirloom = null
		to_chat(user, "<span class='notice'>I take the sword from the [name].</span>")
		src.add_fingerprint(user)
		update_appearance(UPDATE_ICON_STATE)
		return

/obj/structure/fireaxecabinet/attack_paw(mob/living/user)
	return attack_hand(user)

/obj/structure/fireaxecabinet/update_icon_state()
	. = ..()
	icon_state = "fireaxe"
	if(heirloom)
		icon_state = "axe"

/obj/structure/fireaxecabinet/south
	dir = SOUTH
	SET_BASE_PIXEL(0, 32)


/obj/structure/fireaxecabinet/verb/toggle_open()
	set name = "Open/Close"
	set hidden = 1
	set src in oview(1)

	open = !open
	update_appearance()
	return

/obj/structure/fireaxecabinet/unforgotten
	name = "unforgotten blade mantle"
	desc = "A fitting resting place for a Psydonian sword etched and scratched by endurance long past."
	icon = 'icons/obj/wallmounts.dmi'
	icon_state = "fireaxe"
	heirloom = /obj/item/weapon/sword/long/greatsword/broadsword/psy/unforgotten/

/obj/structure/fireaxecabinet/unforgotten/Initialize()
	. = ..()
	heirloom = new /obj/item/weapon/sword/long/greatsword/broadsword/psy/unforgotten
	desc = heirloom.desc
	update_icon()

/obj/structure/fireaxecabinet/unforgotten/south
	dir = SOUTH
	pixel_y = 32

/obj/structure/fireaxecabinet/unforgotten/attackby(obj/item/I, mob/user, params)
	if(open || obj_broken)
		if(istype(I, /obj/item/weapon/sword/long/greatsword/broadsword/psy/unforgotten/) && !heirloom)
			var/obj/item/weapon/sword/long/greatsword/broadsword/psy/unforgotten/F = I
			if(!user.transferItemToLoc(F, src))
				return
			heirloom = F
			to_chat(user, "<span class='notice'>I place the [F.name] back in the [name].</span>")
			desc = F.desc
			update_appearance()
			return
		else if(!obj_broken)
			desc = initial(desc)
			toggle_open()
	else
		return ..()

/obj/structure/fireaxecabinet/unforgotten/update_icon()
	. = ..()
	cut_overlays()
	if(heirloom)
		add_overlay("axe_forgotten")
	if(!open)
		add_overlay("unlocked")
	else
		add_overlay("glass_raised")
