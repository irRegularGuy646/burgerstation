/obj/hud/button/stat/mana
	name = "mana"
	desc = "Mana for your soul"
	id = "mana"

	icon = 'icons/hud/mana.dmi'
	icon_state = "mana"

	screen_loc = "RIGHT,CENTER-1"

	user_colors = FALSE

	layer = 1

	appearance_flags = NO_CLIENT_COLOR | PIXEL_SCALE | LONG_GLIDE | TILE_BOUND | KEEP_TOGETHER


/obj/hud/button/stat/mana/update_underlays()
	. = ..()
	var/image/I = new/image(initial(icon),"mana_outline")
	I.appearance_flags = appearance_flags | RESET_COLOR | RESET_ALPHA
	add_underlay(I)

/obj/hud/button/stat/mana/update_owner(var/mob/desired_owner)
	color = "#000000"
	. = ..()

/obj/hud/button/stat/mana/update()

	if(!is_living(owner))
		return FALSE

	var/mob/living/L = owner

	var/good_color = "#00FF00"
	var/good_color_outline = "#0000FF"
	var/good_color_text = "#FF0000"

	var/bad_color = "#FF0000"
	var/bad_color_outline = "#FFFFFF"
	var/bad_color_text = "#000000"

	if(L && L.client)
		var/color_scheme = L.client.settings.loaded_data["hud_colors"]
		good_color = color_scheme[3]
		bad_color = color_scheme[6]
		good_color_outline = color_scheme[2]
		bad_color_outline = color_scheme[5]
		good_color_text = color_scheme[4]
		bad_color_text = color_scheme[5]

	var/mana_percent = L.health.mana_current/L.health.mana_max

	var/list/color_mod = list(
		blend_colors(bad_color,good_color,mana_percent),
		blend_colors(bad_color_outline,good_color_outline,mana_percent),
		blend_colors(bad_color_text,good_color_text,mana_percent)
	)


	var/text_to_use = "[FLOOR(mana_percent*100,1)]%"

	if(color == "#000000")
		color=color_mod
	else
		animate(src,color=color_mod,time=TICKS_TO_DECISECONDS(LIFE_TICK_FAST))

	icon_state = "mana_[clamp(CEILING(mana_percent*19,1),0,19)]"

	if(text_to_use)
		maptext = "<font color='#0000FF'>[text_to_use]</font>"
	else
		maptext = null


	. = ..()

/obj/hud/button/stat/mana/get_examine_list(var/mob/examiner)
	return examiner.get_examine_list(examiner)