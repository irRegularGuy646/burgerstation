/mob/living/advanced/player/debug
	name = "debug player"

/mob/living/advanced/player/debug/Initialize()

	mobdata = new(null)

	. = ..()

	change_organ_visual("hair_face", desired_color = "#FFFFFF", desired_icon_state = "facial_wise_s")
	update_all_blends()
	add_outfit("wizard")
	pickup(new /obj/item/weapon/ranged/magic/staff/basic(src.loc),FALSE)
	pickup(new /obj/item/weapon/ranged/magic/tome/lightning(src.loc),TRUE)

	return .

/mob/living/advanced/player/debug/on_life()
	move_dir = pick(DIRECTIONS_ALL)
	return ..()