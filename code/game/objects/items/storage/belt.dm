/obj/item/storage/belt
	name = "not actually a toolbelt"
	desc = "Can hold various things. This is the base type of /belt, are you sure you should have this?"
	icon = 'icons/obj/clothing/belts.dmi'
	icon_state = "utility"
	inhand_icon_state = "utility"
	worn_icon_state = "utility"
	lefthand_file = 'icons/mob/inhands/equipment/belt_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/belt_righthand.dmi'
	abstract_type = /obj/item/storage/belt
	slot_flags = ITEM_SLOT_BELT
	attack_verb_continuous = list("whips", "lashes", "disciplines")
	attack_verb_simple = list("whip", "lash", "discipline")
	max_integrity = 300
	equip_sound = 'sound/items/equip/toolbelt_equip.ogg'
	w_class = WEIGHT_CLASS_BULKY
	var/content_overlays = FALSE //If this is true, the belt will gain overlays based on what it's holding

/obj/item/storage/belt/suicide_act(mob/living/user)
	user.visible_message(span_suicide("[user] begins belting [user.p_them()]self with \the [src]! It looks like [user.p_theyre()] trying to commit suicide!"))
	return BRUTELOSS

/obj/item/storage/belt/update_overlays()
	. = ..()
	if(!content_overlays)
		return
	for(var/obj/item/I in contents)
		. += I.get_belt_overlay()

/obj/item/storage/belt/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/attack_equip)
	update_appearance()

/obj/item/storage/belt/utility
	name = "toolbelt" //Carn: utility belt is nicer, but it bamboozles the text parsing.
	desc = "Holds tools."
	icon_state = "utility"
	inhand_icon_state = "utility"
	worn_icon_state = "utility"
	content_overlays = TRUE
	custom_premium_price = PAYCHECK_CREW * 2
	drop_sound = 'sound/items/handling/toolbelt_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbelt_pickup.ogg'
	storage_type = /datum/storage/utility_belt

/obj/item/storage/belt/utility/chief
	name = "chief engineer's toolbelt"
	desc = "Holds tools, looks snazzy."
	icon_state = "utility_ce"
	inhand_icon_state = "utility_ce"
	worn_icon_state = "utility_ce"

/obj/item/storage/belt/utility/chief/full
	preload = TRUE

/obj/item/storage/belt/utility/chief/full/PopulateContents()
	SSwardrobe.provide_type(/obj/item/screwdriver/power, src)
	SSwardrobe.provide_type(/obj/item/crowbar/power, src)
	SSwardrobe.provide_type(/obj/item/weldingtool/experimental, src)
	SSwardrobe.provide_type(/obj/item/multitool, src)
	SSwardrobe.provide_type(/obj/item/stack/cable_coil, src)
	SSwardrobe.provide_type(/obj/item/extinguisher/mini, src)
	SSwardrobe.provide_type(/obj/item/analyzer, src)
	//much roomier now that we've managed to remove two tools

/obj/item/storage/belt/utility/chief/full/get_types_to_preload()
	var/list/to_preload = list() //Yes this is a pain. Yes this is the point
	to_preload += /obj/item/screwdriver/power
	to_preload += /obj/item/crowbar/power
	to_preload += /obj/item/weldingtool/experimental
	to_preload += /obj/item/multitool
	to_preload += /obj/item/stack/cable_coil
	to_preload += /obj/item/extinguisher/mini
	to_preload += /obj/item/analyzer
	return to_preload

/obj/item/storage/belt/utility/full/PopulateContents()
	SSwardrobe.provide_type(/obj/item/screwdriver, src)
	SSwardrobe.provide_type(/obj/item/wrench, src)
	SSwardrobe.provide_type(/obj/item/weldingtool, src)
	SSwardrobe.provide_type(/obj/item/crowbar, src)
	SSwardrobe.provide_type(/obj/item/wirecutters, src)
	SSwardrobe.provide_type(/obj/item/multitool, src)
	SSwardrobe.provide_type(/obj/item/stack/cable_coil, src)

/obj/item/storage/belt/utility/full/get_types_to_preload()
	var/list/to_preload = list() //Yes this is a pain. Yes this is the point
	to_preload += /obj/item/screwdriver
	to_preload += /obj/item/wrench
	to_preload += /obj/item/weldingtool
	to_preload += /obj/item/crowbar
	to_preload += /obj/item/wirecutters
	to_preload += /obj/item/multitool
	to_preload += /obj/item/stack/cable_coil
	return to_preload

/obj/item/storage/belt/utility/full/powertools
	preload = FALSE

/obj/item/storage/belt/utility/full/powertools/PopulateContents()
	new /obj/item/screwdriver/power(src)
	new /obj/item/crowbar/power(src)
	new /obj/item/weldingtool/experimental(src)
	new /obj/item/multitool(src)
	new /obj/item/holosign_creator/atmos(src)
	new /obj/item/extinguisher/mini(src)
	new /obj/item/stack/cable_coil(src)

/obj/item/storage/belt/utility/full/powertools/rcd/PopulateContents()
	new /obj/item/screwdriver/power(src)
	new /obj/item/crowbar/power(src)
	new /obj/item/weldingtool/experimental(src)
	new /obj/item/multitool(src)
	new /obj/item/construction/rcd/loaded/upgraded(src)
	new /obj/item/extinguisher/mini(src)
	new /obj/item/stack/cable_coil(src)

/obj/item/storage/belt/utility/full/engi/PopulateContents()
	SSwardrobe.provide_type(/obj/item/screwdriver, src)
	SSwardrobe.provide_type(/obj/item/wrench, src)
	SSwardrobe.provide_type(/obj/item/weldingtool/largetank, src)
	SSwardrobe.provide_type(/obj/item/crowbar, src)
	SSwardrobe.provide_type(/obj/item/wirecutters, src)
	SSwardrobe.provide_type(/obj/item/multitool, src)
	SSwardrobe.provide_type(/obj/item/stack/cable_coil, src)

/obj/item/storage/belt/utility/full/engi/get_types_to_preload()
	var/list/to_preload = list() //Yes this is a pain. Yes this is the point
	to_preload += /obj/item/screwdriver
	to_preload += /obj/item/wrench
	to_preload += /obj/item/weldingtool/largetank
	to_preload += /obj/item/crowbar
	to_preload += /obj/item/wirecutters
	to_preload += /obj/item/multitool
	to_preload += /obj/item/stack/cable_coil
	return to_preload

/obj/item/storage/belt/utility/atmostech/PopulateContents()
	SSwardrobe.provide_type(/obj/item/screwdriver, src)
	SSwardrobe.provide_type(/obj/item/wrench, src)
	SSwardrobe.provide_type(/obj/item/weldingtool, src)
	SSwardrobe.provide_type(/obj/item/crowbar, src)
	SSwardrobe.provide_type(/obj/item/wirecutters, src)
	SSwardrobe.provide_type(/obj/item/t_scanner, src)
	SSwardrobe.provide_type(/obj/item/extinguisher/mini, src)

/obj/item/storage/belt/utility/atmostech/get_types_to_preload()
	var/list/to_preload = list() //Yes this is a pain. Yes this is the point
	to_preload += /obj/item/screwdriver
	to_preload += /obj/item/wrench
	to_preload += /obj/item/weldingtool
	to_preload += /obj/item/crowbar
	to_preload += /obj/item/wirecutters
	to_preload += /obj/item/t_scanner
	to_preload += /obj/item/extinguisher/mini
	return to_preload

/obj/item/storage/belt/utility/full/inducer/PopulateContents()
	SSwardrobe.provide_type(/obj/item/screwdriver, src)
	SSwardrobe.provide_type(/obj/item/wrench, src)
	SSwardrobe.provide_type(/obj/item/weldingtool, src)
	SSwardrobe.provide_type(/obj/item/crowbar/red, src)
	SSwardrobe.provide_type(/obj/item/wirecutters, src)
	SSwardrobe.provide_type(/obj/item/multitool, src)
	SSwardrobe.provide_type(/obj/item/inducer, src)

/obj/item/storage/belt/utility/full/inducer/get_types_to_preload()
	var/list/to_preload = list() //Yes this is a pain. Yes this is the point
	to_preload += /obj/item/screwdriver
	to_preload += /obj/item/wrench
	to_preload += /obj/item/weldingtool
	to_preload += /obj/item/crowbar
	to_preload += /obj/item/wirecutters
	to_preload += /obj/item/multitool
	to_preload += /obj/item/inducer
	return to_preload

/obj/item/storage/belt/utility/syndicate
	preload = FALSE

/obj/item/storage/belt/utility/syndicate/PopulateContents()
	new /obj/item/screwdriver/nuke(src)
	new /obj/item/wrench/combat(src)
	new /obj/item/weldingtool/largetank(src)
	new /obj/item/crowbar(src)
	new /obj/item/wirecutters(src)
	new /obj/item/multitool(src)
	new /obj/item/inducer/syndicate(src)

/obj/item/storage/belt/medical
	name = "medical belt"
	desc = "Can hold various medical equipment."
	icon_state = "medical"
	inhand_icon_state = "medical"
	worn_icon_state = "medical"
	drop_sound = 'sound/items/handling/toolbelt_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbelt_pickup.ogg'
	storage_type = /datum/storage/medical_belt

/obj/item/storage/belt/medical/paramedic
	name = "EMT belt"
	icon_state = "emt"
	inhand_icon_state = "security"
	worn_icon_state = "emt"
	preload = TRUE

/obj/item/storage/belt/medical/paramedic/PopulateContents()
	SSwardrobe.provide_type(/obj/item/sensor_device, src)
	SSwardrobe.provide_type(/obj/item/stack/medical/wrap/gauze/twelve, src)
	SSwardrobe.provide_type(/obj/item/tourniquet, src)
	SSwardrobe.provide_type(/obj/item/bonesetter, src)
	SSwardrobe.provide_type(/obj/item/reagent_containers/syringe, src)
	SSwardrobe.provide_type(/obj/item/reagent_containers/cup/bottle/ammoniated_mercury, src)
	SSwardrobe.provide_type(/obj/item/reagent_containers/cup/bottle/formaldehyde, src)
	update_appearance()

/obj/item/storage/belt/medical/paramedic/get_types_to_preload()
	var/list/to_preload = list() //Yes this is a pain. Yes this is the point
	to_preload += /obj/item/sensor_device
	to_preload += /obj/item/stack/medical/wrap/gauze/twelve
	to_preload += /obj/item/tourniquet
	to_preload += /obj/item/bonesetter
	to_preload += /obj/item/reagent_containers/syringe
	to_preload += /obj/item/reagent_containers/cup/bottle/ammoniated_mercury
	to_preload += /obj/item/reagent_containers/cup/bottle/formaldehyde
	return to_preload

/obj/item/storage/belt/medical/ert
	icon_state = "emt"
	inhand_icon_state = "security"
	worn_icon_state = "emt"
	preload = TRUE

/obj/item/storage/belt/medical/ert/PopulateContents()
	SSwardrobe.provide_type(/obj/item/sensor_device, src)
	SSwardrobe.provide_type(/obj/item/pinpointer/crew, src)
	SSwardrobe.provide_type(/obj/item/scalpel/advanced, src)
	SSwardrobe.provide_type(/obj/item/retractor/advanced, src)
	SSwardrobe.provide_type(/obj/item/stack/medical/bone_gel, src)
	SSwardrobe.provide_type(/obj/item/cautery/advanced, src)
	SSwardrobe.provide_type(/obj/item/surgical_drapes, src)
	update_appearance()

/obj/item/storage/belt/medical/ert/get_types_to_preload()
	var/list/to_preload = list()
	to_preload += /obj/item/sensor_device
	to_preload += /obj/item/pinpointer/crew
	to_preload += /obj/item/scalpel/advanced
	to_preload += /obj/item/retractor/advanced
	to_preload += /obj/item/stack/medical/bone_gel
	to_preload += /obj/item/cautery/advanced
	to_preload += /obj/item/surgical_drapes
	return to_preload

/obj/item/storage/belt/security
	name = "security belt"
	desc = "Can hold security gear like handcuffs and flashes."
	icon_state = "security"
	inhand_icon_state = "security"//Could likely use a better one.
	worn_icon_state = "security"
	content_overlays = TRUE
	storage_type = /datum/storage/security_belt

/obj/item/storage/belt/security/full/PopulateContents()
	new /obj/item/reagent_containers/spray/pepper(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/grenade/flashbang(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/melee/baton/security/loaded(src)
	update_appearance()

/obj/item/storage/belt/security/webbing
	name = "security webbing"
	desc = "Unique and versatile chest rig, can hold security gear."
	icon_state = "securitywebbing"
	inhand_icon_state = "securitywebbing"
	worn_icon_state = "securitywebbing"
	content_overlays = FALSE
	custom_premium_price = PAYCHECK_COMMAND * 3
	storage_type = /datum/storage/security_belt/webbing

/obj/item/storage/belt/mining
	name = "explorer's webbing"
	desc = "A versatile chest rig, cherished by miners and hunters alike."
	icon_state = "explorer1"
	inhand_icon_state = "explorer1"
	worn_icon_state = "explorer1"
	w_class = WEIGHT_CLASS_BULKY
	storage_type = /datum/storage/mining_belt

/obj/item/storage/belt/mining/vendor/PopulateContents()
	new /obj/item/survivalcapsule(src)

/obj/item/storage/belt/mining/alt
	icon_state = "explorer2"
	inhand_icon_state = "explorer2"
	worn_icon_state = "explorer2"

/obj/item/storage/belt/mining/healing/PopulateContents()
	for(var/i in 1 to 2)
		new /obj/item/reagent_containers/hypospray/medipen/survival/luxury(src)
	for(var/i in 1 to 2)
		new /obj/item/reagent_containers/hypospray/medipen/survival(src)
	for(var/i in 1 to 2)
		var/obj/item/organ/monster_core/core = new /obj/item/organ/monster_core/regenerative_core/legion(src)
		core.preserve()

/obj/item/storage/belt/mining/primitive
	name = "hunter's belt"
	desc = "A versatile belt, woven from sinew."
	icon_state = "ebelt"
	inhand_icon_state = "ebelt"
	worn_icon_state = "ebelt"
	storage_type = /datum/storage/mining_belt/primitive

/obj/item/storage/belt/soulstone
	name = "soul stone belt"
	desc = "Designed for ease of access to the shards during a fight, as to not let a single enemy spirit slip away."
	icon_state = "soulstonebelt"
	inhand_icon_state = "soulstonebelt"
	worn_icon_state = "soulstonebelt"
	drop_sound = 'sound/items/handling/toolbelt_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbelt_pickup.ogg'
	storage_type = /datum/storage/soulstone_belt

/obj/item/storage/belt/soulstone/full/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/soulstone/mystic(src)

/obj/item/storage/belt/soulstone/full/chappy/PopulateContents()
	for(var/i in 1 to 6)
		new /obj/item/soulstone/anybody/chaplain(src)

/obj/item/storage/belt/champion
	name = "championship belt"
	desc = "Proves to the world that you are the strongest!"
	icon_state = "championbelt"
	inhand_icon_state = "championbelt"
	worn_icon_state = "championbelt"
	custom_materials = list(/datum/material/gold=SMALL_MATERIAL_AMOUNT *4)
	storage_type = /datum/storage/champion_belt

/obj/item/storage/belt/champion/Initialize(mapload)
	. = ..()

	AddElement(/datum/element/adjust_fishing_difficulty, -2)

/obj/item/storage/belt/military
	name = "chest rig"
	desc = "A set of tactical webbing worn by Syndicate boarding parties."
	icon_state = "militarywebbing"
	inhand_icon_state = "militarywebbing"
	worn_icon_state = "militarywebbing"
	resistance_flags = FIRE_PROOF
	storage_type = /datum/storage/military_belt

/obj/item/storage/belt/military/snack
	name = "tactical snack rig"
	storage_type = /datum/storage/military_belt/snack

/obj/item/storage/belt/military/snack/Initialize(mapload)
	. = ..()
	var/sponsor = pick("Donk Co.", "Waffle Corp.", "Roffle Co.", "Gorlex Marauders", "Tiger Cooperative")
	desc = "A set of snack-tical webbing worn by athletes of the [sponsor] VR sports division."

/obj/item/storage/belt/military/snack/full/Initialize(mapload)
	. = ..()
	var/amount = 5
	var/rig_snacks
	while(contents.len <= amount)
		rig_snacks = pick(list(
			/obj/item/food/candy,
			/obj/item/food/cheesiehonkers,
			/obj/item/food/cheesynachos,
			/obj/item/food/chips,
			/obj/item/food/cubannachos,
			/obj/item/food/donkpocket,
			/obj/item/food/nachos,
			/obj/item/food/nugget,
			/obj/item/food/rofflewaffles,
			/obj/item/food/sosjerky,
			/obj/item/food/spacetwinkie,
			/obj/item/food/spaghetti/pastatomato,
			/obj/item/food/syndicake,
			/obj/item/reagent_containers/cup/glass/drinkingglass/filled/nuka_cola,
			/obj/item/reagent_containers/cup/glass/dry_ramen,
			/obj/item/reagent_containers/cup/soda_cans/cola,
			/obj/item/reagent_containers/cup/soda_cans/dr_gibb,
			/obj/item/reagent_containers/cup/soda_cans/lemon_lime,
			/obj/item/reagent_containers/cup/soda_cans/pwr_game,
			/obj/item/reagent_containers/cup/soda_cans/space_mountain_wind,
			/obj/item/reagent_containers/cup/soda_cans/space_up,
			/obj/item/reagent_containers/cup/soda_cans/starkist,
		))
		new rig_snacks(src)

/obj/item/storage/belt/military/abductor
	name = "agent belt"
	desc = "A belt used by abductor agents."
	icon = 'icons/obj/antags/abductor.dmi'
	icon_state = "belt"
	inhand_icon_state = "security"
	worn_icon_state = "security"
	content_overlays = TRUE

/obj/item/storage/belt/military/abductor/full/PopulateContents()
	new /obj/item/screwdriver/abductor(src)
	new /obj/item/wrench/abductor(src)
	new /obj/item/weldingtool/abductor(src)
	new /obj/item/crowbar/abductor(src)
	new /obj/item/wirecutters/abductor(src)
	new /obj/item/multitool/abductor(src)
	new /obj/item/stack/cable_coil(src)

/obj/item/storage/belt/military/army
	name = "army belt"
	desc = "A belt used by military forces."
	icon_state = "military"
	inhand_icon_state = "security"
	worn_icon_state = "military"

/obj/item/storage/belt/military/assault
	name = "assault belt"
	desc = "A tactical assault belt."
	icon_state = "assault"
	inhand_icon_state = "security"
	worn_icon_state = "assault"
	storage_type = /datum/storage/military_belt/assault

/obj/item/storage/belt/military/assault/full/PopulateContents()
	generate_items_inside(list(
		/obj/item/ammo_box/magazine/wt550m9 = 4,
		/obj/item/ammo_box/magazine/wt550m9/wtap = 2,
	), src)

/obj/item/storage/belt/grenade
	name = "grenadier belt"
	desc = "A belt for holding grenades."
	icon_state = "grenadebeltnew"
	inhand_icon_state = "security"
	worn_icon_state = "grenadebeltnew"
	drop_sound = 'sound/items/handling/toolbelt_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbelt_pickup.ogg'
	storage_type = /datum/storage/grenade_belt

/obj/item/storage/belt/grenade/full/PopulateContents()
	generate_items_inside(list(
		/obj/item/grenade/chem_grenade/incendiary = 2,
		/obj/item/grenade/empgrenade = 2,
		/obj/item/grenade/frag = 10,
		/obj/item/grenade/flashbang = 2,
		/obj/item/grenade/gluon = 4,
		/obj/item/grenade/smokebomb = 4,
		/obj/item/grenade/syndieminibomb = 2,
		/obj/item/multitool = 1,
		/obj/item/screwdriver = 1,
	), src)


/obj/item/storage/belt/wands
	name = "wand belt"
	desc = "A belt designed to hold various rods of power. A veritable fanny pack of exotic magic."
	icon_state = "soulstonebelt"
	inhand_icon_state = "soulstonebelt"
	worn_icon_state = "soulstonebelt"
	storage_type = /datum/storage/wands_belt

/// Put some wands in that bad boy
/obj/item/storage/belt/wands/full/proc/create_wands()
	new /obj/item/gun/magic/wand/death(src)
	new /obj/item/gun/magic/wand/resurrection(src)
	new /obj/item/gun/magic/wand/polymorph(src)
	new /obj/item/gun/magic/wand/teleport(src)
	new /obj/item/gun/magic/wand/door(src)
	new /obj/item/gun/magic/wand/fireball(src)
	new /obj/item/gun/magic/wand/shrink(src)

/obj/item/storage/belt/wands/full/PopulateContents()
	create_wands()
	for(var/obj/item/gun/magic/wand/W in contents) //All wands in this pack come in the best possible condition
		W.max_charges = initial(W.max_charges)
		W.charges = W.max_charges

/// Filled with budget wands instead of cool ones
/obj/item/storage/belt/wands/full/discount
	/// Which wands can appear?
	var/static/list/possible_options = list(
		/obj/item/gun/magic/wand/animate,
		/obj/item/gun/magic/wand/babel,
		/obj/item/gun/magic/wand/bald,
		/obj/item/gun/magic/wand/door,
		/obj/item/gun/magic/wand/fireball,
		/obj/item/gun/magic/wand/freeze,
		/obj/item/gun/magic/wand/hallucination,
		/obj/item/gun/magic/wand/levitate,
		/obj/item/gun/magic/wand/pax,
		/obj/item/gun/magic/wand/pizza,
		/obj/item/gun/magic/wand/plague,
		/obj/item/gun/magic/wand/prank,
		/obj/item/gun/magic/wand/rebel,
		/obj/item/gun/magic/wand/repulse,
		/obj/item/gun/magic/wand/swap,
		/obj/item/gun/magic/wand/teleport,
		/obj/item/gun/magic/wand/tentacles,
		/obj/item/gun/magic/wand/zap,
	)

/obj/item/storage/belt/wands/full/discount/create_wands()
	var/list/available_options = possible_options.Copy()
	for (var/i in 1 to 6)
		if (!length(available_options))
			break
		var/wand_path = pick_n_take(available_options)
		new wand_path(src)

/// Not a subtype of bandolier because it acts pretty differently
/obj/item/storage/belt/wand_bandolier
	name = "wand bandolier"
	desc = "A bandolier for holding a whole lot of wands. If worn on your suit, swaps expended wands for fresh ones on the fly."
	icon_state = "bandolier"
	inhand_icon_state = "bandolier"
	worn_icon_state = "bandolier"
	storage_type = /datum/storage/wands_belt
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/belt/wand_bandolier/equipped(mob/user, slot)
	. = ..()
	if (!(slot & ITEM_SLOT_SUITSTORE))
		return
	ADD_CLOTHING_TRAIT(user, TRAIT_GUNFLIP)
	RegisterSignal(user, COMSIG_MOB_FIRED_GUN, PROC_REF(on_gun_fired))

/obj/item/storage/belt/wand_bandolier/dropped(mob/user)
	. = ..()
	REMOVE_CLOTHING_TRAIT(user, TRAIT_GUNFLIP)
	UnregisterSignal(user, COMSIG_MOB_FIRED_GUN)

/// After we fire a gun, check if it's a wand. If it is and it's empty, do a swap
/obj/item/storage/belt/wand_bandolier/proc/on_gun_fired(mob/living/wizard, obj/item/gun/magic/wand/old_wand)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(equip_new_wand), wizard, old_wand)

/obj/item/storage/belt/wand_bandolier/proc/equip_new_wand(mob/living/wizard, obj/item/gun/magic/wand/old_wand)
	if (!istype(old_wand))
		return
	if (!atom_storage.real_location.contents.len) // no other wands
		return
	if (old_wand.charges > 1) // It hasn't subtracted yet
		return

	var/obj/item/fresh_wand
	for (var/obj/item/gun/magic/wand/checked in atom_storage.real_location.contents)
		if (checked.charges)
			fresh_wand = checked
			break
	if (!fresh_wand || fresh_wand.on_found())
		return // Nothing to swap with

	wizard.temporarilyRemoveItemFromInventory(old_wand)
	if (!wizard.put_in_hands(fresh_wand))
		return
	to_chat(wizard, span_notice("You quickly draw [fresh_wand]."))
	if (atom_storage.attempt_insert(old_wand, wizard))
		return
	old_wand.forceMove(wizard.drop_location())
	to_chat(wizard, span_warning("...and drop [old_wand] on the ground."))

/obj/item/storage/belt/janitor
	name = "janibelt"
	desc = "A belt used to hold most janitorial supplies."
	icon_state = "janibelt"
	inhand_icon_state = "janibelt"
	worn_icon_state = "janibelt"
	drop_sound = 'sound/items/handling/toolbelt_drop.ogg'
	pickup_sound = 'sound/items/handling/toolbelt_pickup.ogg'
	storage_type = /datum/storage/janitor_belt

/obj/item/storage/belt/janitor/full/PopulateContents()
	new /obj/item/lightreplacer(src)
	new /obj/item/reagent_containers/spray/cleaner(src)
	new /obj/item/soap/nanotrasen(src)
	new /obj/item/holosign_creator(src)
	new /obj/item/melee/flyswatter(src)

/obj/item/storage/belt/bandolier
	name = "bandolier"
	desc = "A bandolier for holding rifle shotgun, and bigger revolver caliber ammunition."
	icon_state = "bandolier"
	inhand_icon_state = "bandolier"
	worn_icon_state = "bandolier"
	storage_type = /datum/storage/bandolier_belt

/obj/item/storage/belt/bandolier/china_lake_extra/PopulateContents()
	generate_items_inside(list(
		/obj/item/ammo_casing/a40mm = 12,
	), src)

/obj/item/storage/belt/fannypack
	name = "fannypack"
	desc = "A dorky fannypack for keeping small items in. Concealed enough, or ugly enough to avert their eyes, that others won't see what you put in or take out easily."
	icon_state = "fannypack_leather"
	inhand_icon_state = null
	worn_icon_state = "fannypack_leather"
	dying_key = DYE_REGISTRY_FANNYPACK
	custom_price = PAYCHECK_CREW * 2
	storage_type = /datum/storage/fanny_pack

/obj/item/storage/belt/fannypack/black
	name = "black fannypack"
	icon_state = "fannypack_black"
	worn_icon_state = "fannypack_black"

/obj/item/storage/belt/fannypack/red
	name = "red fannypack"
	icon_state = "fannypack_red"
	worn_icon_state = "fannypack_red"

/obj/item/storage/belt/fannypack/purple
	name = "purple fannypack"
	icon_state = "fannypack_purple"
	worn_icon_state = "fannypack_purple"

/obj/item/storage/belt/fannypack/blue
	name = "blue fannypack"
	icon_state = "fannypack_blue"
	worn_icon_state = "fannypack_blue"

/obj/item/storage/belt/fannypack/orange
	name = "orange fannypack"
	icon_state = "fannypack_orange"
	worn_icon_state = "fannypack_orange"

/obj/item/storage/belt/fannypack/white
	name = "white fannypack"
	icon_state = "fannypack_white"
	worn_icon_state = "fannypack_white"

/obj/item/storage/belt/fannypack/green
	name = "green fannypack"
	icon_state = "fannypack_green"
	worn_icon_state = "fannypack_green"

/obj/item/storage/belt/fannypack/pink
	name = "pink fannypack"
	icon_state = "fannypack_pink"
	worn_icon_state = "fannypack_pink"

/obj/item/storage/belt/fannypack/cyan
	name = "cyan fannypack"
	icon_state = "fannypack_cyan"
	worn_icon_state = "fannypack_cyan"

/obj/item/storage/belt/fannypack/yellow
	name = "yellow fannypack"
	icon_state = "fannypack_yellow"
	worn_icon_state = "fannypack_yellow"

/obj/item/storage/belt/fannypack/cummerbund
	name = "cummerbund"
	desc = "A pleated sash that pairs well with a suit jacket."
	icon_state = "cummerbund"
	inhand_icon_state = null
	worn_icon_state = "cummerbund"

/obj/item/storage/belt/fannypack/yellow/bee_terrorist/PopulateContents()
	new /obj/item/grenade/c4 (src)
	new /obj/item/reagent_containers/applicator/pill/cyanide(src)
	new /obj/item/grenade/chem_grenade/facid(src)

/obj/item/storage/belt/fannypack/black/rogue
	name = "fannypack of ULTIMATE DESPAIR"

/obj/item/storage/belt/fannypack/black/rogue/PopulateContents()
	new /obj/item/food/drug/saturnx(src)
	new /obj/item/reagent_containers/cup/blastoff_ampoule(src)
	new /obj/item/reagent_containers/hypospray/medipen/methamphetamine(src)

/obj/item/storage/belt/sheath
	desc = "holds like, blades and stuff. You should not be seeing this."
	w_class = WEIGHT_CLASS_BULKY
	interaction_flags_click = parent_type::interaction_flags_click | NEED_DEXTERITY | NEED_HANDS
	var/stored_blade
	actions_types = list(/datum/action/innate/blade_counter)
	action_slots = ITEM_SLOT_BELT | ITEM_SLOT_SUITSTORE
	COOLDOWN_DECLARE(resheath_cooldown)
	COOLDOWN_DECLARE(full_ability_cooldown)

/obj/item/storage/belt/sheath/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob, action_slots)
	RegisterSignal(src, COMSIG_ATOM_STORED_ITEM, PROC_REF(post_resheath))

/obj/item/storage/belt/sheath/Destroy(force)
	. = ..()
	UnregisterSignal(src, COMSIG_ATOM_STORED_ITEM)

/obj/item/storage/belt/sheath/examine(mob/user)
	. = ..()
	if(length(contents))
		. += span_notice("Alt-click it to quickly draw the blade.")

/obj/item/storage/belt/sheath/click_alt(mob/user)
	if(!length(contents))
		balloon_alert(user, "it's empty!")
		return CLICK_ACTION_BLOCKING
	var/obj/item/stored_item = contents[1]
	user.visible_message(span_notice("[user] takes [stored_item] out of [src]."), span_notice("You take [stored_item] out of [src]."))
	user.put_in_hands(stored_item)
	update_appearance()
	return CLICK_ACTION_SUCCESS

/obj/item/storage/belt/sheath/update_icon_state()
	icon_state = initial(icon_state)
	inhand_icon_state = initial(inhand_icon_state)
	worn_icon_state = initial(worn_icon_state)
	if(contents.len)
		icon_state += "-full"
		inhand_icon_state += "-full"
		worn_icon_state += "-full"
	return ..()

/obj/item/storage/belt/sheath/PopulateContents()
	if(stored_blade)
		new stored_blade(src)
		update_appearance()

/obj/item/storage/belt/sheath/proc/post_resheath()
	SIGNAL_HANDLER
	COOLDOWN_START(src, resheath_cooldown, 10 SECONDS)

/datum/action/innate/blade_counter
	name = "Counterattack"
	desc = "Anticipate an enemy's attack and strike back with your sheathed blade."
	button_icon = 'icons/mob/actions/actions_spells.dmi'
	button_icon_state = "declaration"
	ranged_mousepointer = 'icons/effects/mouse_pointers/honorbound.dmi'

	enable_text = "You prepare to counterattack a target..."
	disable_text = "You relax your stance."

	click_action = TRUE

	var/datum/weakref/eyed_fool

/datum/action/innate/blade_counter/IsAvailable(feedback = TRUE)
	if(!isliving(owner))
		return FALSE
	var/obj/item/storage/belt/sheath/owners_sheath = target
	if(!COOLDOWN_FINISHED(owners_sheath, full_ability_cooldown))
		if(feedback)
			to_chat(owner, span_warning("You failed a counterattack too recently!"))
		return FALSE
	if(!length(owners_sheath.contents))
		if(feedback)
			to_chat(owner, span_warning("Your sheath is empty!"))
		return FALSE
	if(!COOLDOWN_FINISHED(owners_sheath, resheath_cooldown))
		if(feedback)
			to_chat(owner, span_warning("You only just resheathed your blade!"))
		return FALSE
	return TRUE

/datum/action/innate/blade_counter/proc/final_checks(atom/cast_on)
	if(!isliving(cast_on))
		return FALSE
	if(owner == cast_on)
		to_chat(owner, span_warning("You can't counterattack yourself!"))
		return FALSE
	var/mob/living/target = cast_on
	if(!target.mind)
		to_chat(owner, span_warning("They are too unpredictable to counterattack!"))
		return FALSE
	var/obj/item/storage/belt/sheath/oursheath = target
	if(!length(oursheath.contents))
		return FALSE
	return TRUE

/datum/action/innate/blade_counter/do_ability(mob/living/swordsman, mob/living/cast_on)
	if(!final_checks(cast_on))
		return TRUE
	var/obj/item/storage/belt/sheath/used_sheath = target
	RegisterSignal(swordsman, COMSIG_LIVING_CHECK_BLOCK, PROC_REF(counter_attack))
	swordsman.Immobilize(1 SECONDS)
	eyed_fool = WEAKREF(cast_on)
	swordsman.visible_message(span_danger("[swordsman] widens [swordsman.p_their()] stance, [swordsman.p_their()] hand hovering over \the [used_sheath]!"), span_notice("You prepare to counterattack [cast_on]!"))
	addtimer(CALLBACK(src, PROC_REF(relax), swordsman, used_sheath), 1 SECONDS)
	COOLDOWN_START(used_sheath, full_ability_cooldown, 60 SECONDS)
	unset_ranged_ability(swordsman)
	return TRUE

#define COUNTERMULTIPLIER 3

/datum/action/innate/blade_counter/proc/counter_attack(mob/living/forward_thinker, atom/attackingthing, damage, attack_text, attack_type)
	SIGNAL_HANDLER
	var/obj/item/storage/belt/sheath/used_sheath = target
	if(!used_sheath || !length(used_sheath.contents) || (attack_type != MELEE_ATTACK && attack_type != UNARMED_ATTACK))
		return FAILED_BLOCK

	var/obj/item/justicetool = used_sheath.contents[1]
	var/mob/living/fool = isliving(attackingthing) ? attackingthing : attackingthing.loc
	if(used_sheath.loc != forward_thinker || fool != eyed_fool.resolve() || !forward_thinker.put_in_active_hand(justicetool))
		return FAILED_BLOCK
	do_strike(fool, forward_thinker, justicetool)
	playsound(forward_thinker, 'sound/items/unsheath.ogg', 50, TRUE)
	COOLDOWN_RESET(used_sheath, full_ability_cooldown)
	return SUCCESSFUL_BLOCK

/datum/action/innate/blade_counter/proc/do_strike(mob/living/fool, mob/living/forward_thinker, obj/item/justicetool)
	var/obj/item/bodypart/offending_hand = fool.get_active_hand()
	forward_thinker.visible_message(span_danger("[forward_thinker] swiftly draws \the [justicetool] and strikes [fool] during [fool.p_their()] attack!"), span_notice("You swiftly draw \the [justicetool] and counter-attack [fool]!"))
	fool.apply_damage(
		damage = justicetool.force * COUNTERMULTIPLIER,
		damagetype = justicetool.damtype,
		def_zone = offending_hand,
		blocked = fool.run_armor_check(offending_hand, MELEE, armour_penetration = justicetool.armour_penetration, silent = TRUE),
		wound_bonus = justicetool.wound_bonus * COUNTERMULTIPLIER,
		exposed_wound_bonus = justicetool.exposed_wound_bonus * COUNTERMULTIPLIER,
		sharpness = justicetool.sharpness,
		attack_direction = get_dir(forward_thinker, fool),
		attacking_item = justicetool,
	)


/datum/action/innate/blade_counter/proc/relax(mob/living/holder, obj/item/storage/belt/sheath/active_sheath)
	UnregisterSignal(holder, COMSIG_LIVING_CHECK_BLOCK)

/datum/action/innate/blade_counter/gunpowered
	name = "Powered Counterattack"
	desc = "Anticipate an enemy's attack and attempt to strike back, at great risk to yourself. The firing angle requires it be held on your hip."

	/// Whether the currently relevant counterattack succeeded.
	var/succeeded_attempt = FALSE

/datum/action/innate/blade_counter/gunpowered/do_ability(mob/living/swordsman, mob/living/cast_on)
	. = ..()
	succeeded_attempt = FALSE


/datum/action/innate/blade_counter/gunpowered/do_strike(mob/living/fool, mob/living/forward_thinker, obj/item/justicetool)
	if(forward_thinker.get_slot_by_item(target) == ITEM_SLOT_SUITSTORE)
		return ..()
	succeeded_attempt = TRUE
	var/obj/item/bodypart/offending_hand = fool.get_active_hand()
	var/obj/item/bodypart/risked_hand = forward_thinker.get_active_hand()
	if(iscarbon(fool) && offending_hand.dismember(BRUTE, FALSE, WOUND_SLASH))
		forward_thinker.visible_message(span_danger("[forward_thinker] swiftly draws \the [justicetool] and strikes [fool] during [fool.p_their()] attack, sending [fool.p_their()] arm flying!"),
										span_notice("You swiftly draw \the [justicetool] and cut off [fool]'s arm!"))
	else
		fool.apply_damage(
			damage = justicetool.force * COUNTERMULTIPLIER,
			damagetype = justicetool.damtype,
			def_zone = offending_hand,
			blocked = fool.run_armor_check(offending_hand, MELEE, armour_penetration = justicetool.armour_penetration, silent = TRUE),
			wound_bonus = justicetool.wound_bonus * COUNTERMULTIPLIER,
			exposed_wound_bonus = justicetool.exposed_wound_bonus * COUNTERMULTIPLIER,
			sharpness = justicetool.sharpness,
			attack_direction = get_dir(forward_thinker, fool),
			attacking_item = justicetool,
		)
		forward_thinker.visible_message(span_danger("[forward_thinker] swiftly draws \the [justicetool] and strikes [fool] during [fool.p_their()] attack!"),
										span_notice("You swiftly draw \the [justicetool] and strike them mid-attack!"))
	if(!IS_ROBOTIC_LIMB(risked_hand))
		forward_thinker.visible_message(span_danger("[forward_thinker]'s arm is unable to withstand the force of the attack!"),
										span_danger("You feel a sharp pain as your arm is mutilated by the force of the attack!"))
		forward_thinker.apply_damage(
		damage = 50,
		damagetype = BRUTE,
		def_zone = risked_hand,
		wound_bonus = 50,
		wound_clothing = FALSE,
	)


/datum/action/innate/blade_counter/gunpowered/relax(mob/living/holder, obj/item/storage/belt/sheath/active_sheath)
	..()
	if(succeeded_attempt || holder.get_slot_by_item(target) == ITEM_SLOT_SUITSTORE)
		return

	if(length(active_sheath.contents))
		var/obj/item/denied_weapon = active_sheath.contents[1]
		denied_weapon.forceMove(get_turf(holder))
		denied_weapon.throw_at(pick(RANGE_TURFS(3, denied_weapon)), 3, 3)

	// We can assume that the holder is a carbon, and thus has an actual arm, because they have a belt slot.
	var/obj/item/bodypart/worthless_hand = holder.get_active_hand()
	if(!worthless_hand)
		worthless_hand = holder.get_inactive_hand()
		if(!worthless_hand)
			holder.visible_message(span_danger("[holder]'s sheath misfires, sending their blade flying!"),
									span_danger("Your sheath misfires, sending your blade flying!"))
			return

	if(IS_ROBOTIC_LIMB(worthless_hand) || !worthless_hand.dismember(BRUTE, FALSE, WOUND_BLUNT))
		holder.visible_message(span_danger("[holder]'s arm is mutilated as they misfire [holder.p_their()] sheathed blade!"),
								span_danger("Your arm is mutilated as you fail to safely fire your blade!"))
		holder.apply_damage(
			damage = 50,
			damagetype = BRUTE,
			def_zone = worthless_hand,
			wound_bonus = 50,
			wound_clothing = FALSE,
		)
		return

	holder.visible_message(span_danger("[holder]'s arm is violently torn off as they misfire [holder.p_their()] sheathed blade!"),
							span_danger("Your arm is torn off as you fail to safely fire your blade!"))

#undef COUNTERMULTIPLIER

/obj/item/storage/belt/sheath/sabre
	name = "sabre sheath"
	desc = "An ornate sheath designed to hold an officer's blade."
	icon_state = "sheath"
	inhand_icon_state = "sheath"
	worn_icon_state = "sheath"
	storage_type = /datum/storage/sabre_belt
	stored_blade = /obj/item/melee/sabre

/obj/item/storage/belt/sheath/grass_sabre
	name = "sabre sheath"
	desc = "A simple grass sheath designed to hold a sabre of... some sort. An actual metal one might be too sharp, though..."
	icon_state = "grass_sheath"
	inhand_icon_state = "grass_sheath"
	worn_icon_state = "grass_sheath"
	storage_type = /datum/storage/green_sabre_belt

/obj/item/storage/belt/sheath/gladius
	name = "gladius scabbard"
	desc = "A fun-sized sheath for a fun-sized sword."
	icon_state = "gladius_sheath"
	inhand_icon_state = "gladius_sheath"
	worn_icon_state = "gladius_sheath"
	storage_type = /datum/storage/gladius_belt
	stored_blade = /obj/item/claymore/gladius

/obj/item/storage/belt/sheath/katana
	name = "katana sheath"
	desc = "A sheath that houses the nimble katana."
	icon_state = "katana_sheath"
	inhand_icon_state = "katana_sheath"
	worn_icon_state = "katana_sheath"
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_BELT
	storage_type = /datum/storage/katana_sheath
	stored_blade = /obj/item/katana

/obj/item/storage/belt/sheath/katana/empty
	stored_blade = NONE

/obj/item/storage/belt/sheath/katana/toy
	action_slots = NONE
	storage_type = /datum/storage/toy_sheath
	stored_blade = /obj/item/toy/katana

/obj/item/storage/belt/sheath/katana/toy/empty
	stored_blade = NONE

/obj/item/storage/belt/sheath/ninja
	name = "energy katana sheath"
	desc = "A high tech katana sheath that allows for quick blade movements."
	icon_state = "ninja_sheath"
	inhand_icon_state = "ninja_sheath"
	worn_icon_state = "ninja_sheath"
	storage_type = /datum/storage/ninja_sheath
	stored_blade = /obj/item/energy_katana

/obj/item/storage/belt/sheath/hanzo_katana
	name = "hanzo katana sheath"
	desc = "A normal black sheath meant to house the legendary hanzo steel."
	icon_state = "hanzo_sheath"
	inhand_icon_state = "hanzo_sheath"
	worn_icon_state = "hanzo_sheath"
	slot_flags = ITEM_SLOT_BACK|ITEM_SLOT_BELT
	storage_type = /datum/storage/hanzo_sheath
	stored_blade = /obj/item/nullrod/claymore/katana

/obj/item/storage/belt/sheath/hanzo_katana/empty
	stored_blade = NONE

/obj/item/storage/belt/plant
	name = "botanical belt"
	desc = "A sturdy leather belt used to hold most hydroponics supplies."
	icon_state = "plantbelt"
	inhand_icon_state = "utility"
	worn_icon_state = "plantbelt"
	content_overlays = TRUE
	storage_type = /datum/storage/plant_belt

/obj/item/storage/belt/sheath/sabre/gunpowered
	name = "modified sabre sheath"
	desc = "An imitation of a design made by the infamous Cold Space Wind. Has a trigger mechanism to more forcefully draw the blade."
	icon_state = "gunsheath"
	actions_types = list(/datum/action/innate/blade_counter/gunpowered)
	stored_blade = null

/obj/item/storage/belt/sheath/grass_sabre/gunpowered
	name = "modified sabre sheath"
	desc = "An imitation of a design grown by the infamous Tiziran Plasma Fire. Has a trigger mechanism to more forcefully draw the blade."
	icon_state = "grass_gunsheath"
	actions_types = list(/datum/action/innate/blade_counter/gunpowered)

/obj/item/storage/belt/utility/full/powertools
	name = "\improper Nullspace Tech's belt"
	w_class = WEIGHT_CLASS_TINY
	//storage_type = /datum/storage/debug
	desc = "Can hold a boatload of things...  Why do you have this?!"
	icon = '_horizon/icons/obj/belt.dmi'
	icon_state = "admeme_satchel"
	worn_icon = '_horizon/icons/obj/in_mob/belt_mob.dmi'
	worn_icon_state = "admeme_satchel"

// MARK: Трикодер
/obj/item/multitool/tricorder
	name = "tricorder"
	desc = "A multifunctional device that can perform a wide range of tasks."
	icon = '_horizon/icons/obj/tools.dmi'
	icon_state = "tricorder"
	lefthand_file = '_horizon/icons/obj/in_hands/tools_lefthand.dmi'
	righthand_file = '_horizon/icons/obj/in_hands/tools_righthand.dmi'
	usesound = 'sound/items/weapons/etherealhit.ogg'
	custom_materials = list(/datum/material/iron = 500, /datum/material/silver = 300, /datum/material/gold = 300)
	item_flags = NOBLUDGEON
	tool_behaviour = TOOL_MULTITOOL
	toolspeed = 0.2
	var/ranged_scan_distance = 1
	var/medicalTricorder = FALSE	//Set to TRUE for normal medical scanner, set to FALSE for a gutted version

/obj/item/multitool/tricorder/afterattack(atom/target, mob/user, proximity_flag)
	. = ..()
	if(mode > 0 && !istype(target, /mob/living))
		return
	if(istype(target, /turf/closed/))
		return
//	user.changeNext_move(CLICK_CD_RANGE)
	if(target in view(ranged_scan_distance, get_turf(user)))
		switch(mode)
			if(0)
				atmos_scan(user, (target.return_analyzable_air() ? target : get_turf(target)))
				playsound(get_turf(user), 'sound/effects/pop.ogg', 50)
			if(1)
				healthscan(user, target, scanpower = SCANPOWER_ADVANCED)
				playsound(src, 'sound/items/healthanalyzer.ogg', 10)
				if(!proximity_flag)
					target.Beam(user, icon_state = "medbeam", time = 5, beam_color = "#9ce")
			if(2)
				chemscan(user, target)
				playsound(src, 'sound/items/healthanalyzer.ogg', 10)
				if(!proximity_flag)
					target.Beam(user, icon_state = "medbeam", time = 5, beam_color = "#9ce")

// MARK: Дебаг-Аутфит
/obj/item/multitool/tricorder/ranged
	name = "long-range tricorder"
	desc = "A multifunctional device that can perform a wide range of tasks. A hand-held long-range environmental scanner which reports current gas levels."
	icon_state = "tricorder_ranged"
	medicalTricorder = TRUE
	ranged_scan_distance = 15
	var/modes = "atmos"

/obj/item/multitool/tricorder/ranged/Initialize()
	. = ..()
	update_appearance(UPDATE_ICON)

/obj/item/multitool/tricorder/ranged/examine()
	. = ..()
	. += span_notice("The mode is: [modes] scan")

/obj/item/multitool/tricorder/ranged/attack_self(mob/user)
	mode++
	switch(mode)
		if(1)
			modes = "health"
		if(2)
			modes = "chem"
		if(3)
			mode = 0
			modes = "atmos"

	playsound(get_turf(user), 'sound/machines/click.ogg', 50, TRUE)
	balloon_alert(user, "[modes] scan")
	update_appearance(UPDATE_ICON)

/obj/item/multitool/tricorder/ranged/update_overlays()
	. = ..()
	if(modes)
		switch(mode)
			if(0)
				. += "atmos_overlay"
			if(1)
				. += "health_overlay"
			if(2)
				. += "chem_overlay"

/obj/item/construction/rcd/arcd/debug
	max_matter = INFINITY
	matter = INFINITY
	construction_upgrades = RCD_UPGRADE_FRAMES | RCD_UPGRADE_SIMPLE_CIRCUITS
	delay_mod = 0.3

/obj/item/inducer/adv
	icon_state = "inducer-adv"
	desc = "A tool for inductively charging internal power cells. This one has a white-bluespace color scheme, and seems to be rigged to transfer charge at a much faster rate."
	power_transfer_multiplier = 5
	powerdevice = /obj/item/stock_parts/power_store/battery/bluespace

// MARK: Респрайты

/obj/item/multitool
	//icon_state = "multitool"
	icon = '_horizon/icons/obj/tools.dmi'
	//lefthand_file = '_horizon/icons/obj/in_hands/tools_lefthand.dmi'
	//righthand_file = '_horizon/icons/obj/in_hands/tools_righthand.dmi'

/obj/item/construction/rcd/arcd
	icon = '_horizon/icons/obj/tools.dmi'
/*
/obj/item/construction/plumbing
	icon = '_horizon/icons/obj/tools.dmi'
*/

// MARK: Мед-Сканер

/obj/item/healthanalyzer
	var/ranged_scan_distance

/obj/item/healthanalyzer/range
	name = "long-range health analyzer"
	desc = "A handheld body scanner capable of accurately detecting the patient's vital signs from a distance."
	icon = '_horizon/icons/obj/tools.dmi'
	lefthand_file = '_horizon/icons/obj/in_hands/tools_lefthand.dmi'
	righthand_file = '_horizon/icons/obj/in_hands/tools_righthand.dmi'
	icon_state = "ranged_analyzer"
//	item_state = "ranged_analyzer"
//	healthmode = "ranged_analyzer"
//	reagentmode = "ranged_reagent_analyzer"
//	healthmodeinhand = "ranged_analyzer"
//	reagentmodeinhand = "ranged_reagent_analyzer"
	ranged_scan_distance = 15
	custom_premium_price = 1000

/obj/item/healthanalyzer/afterattack(mob/living/M, mob/living/carbon/human/user, adjacent, params)
	if(adjacent || !istype(M))
		return ..()
	if(ranged_scan_distance)
		M.Beam(user, icon_state = "med_scan", time = 5)
		attack(M, user)
		//playsound(src, 'white/Feline/sounds/pip.ogg', 25, FALSE, 2)
		return
	return ..()

/obj/item/healthanalyzer/advanced
	ranged_scan_distance = 15

/obj/item/healthanalyzer/afterattack(mob/living/M, mob/living/carbon/human/user, adjacent, params)
	. = ..()
	if(adjacent || !ranged_scan_distance)
		return .
	if(!istype(M))
		return
	if(can_see(user, M, ranged_scan_distance))
//		user.changeNext_move(CLICK_CD_RANGE)
		M.Beam(user, icon_state = "medbeam", time = 5, beam_color = "#9ce")
		attack(M, user)
		return

// MARK: Bluespace-RPD
/*
#define BSRPD_CAPAC_MAX 50
#define BSRPD_CAPAC_USE 1
#define BSRPD_CAPAC_NEW 5

/obj/item/pipe_dispenser/bluespace
	name = "Bluespace-RPD"
	desc = "A breakthrough in pipe-laying technology prevents you from being burned to a crisp while building yet another engine."
	icon_state = "rpd_ranged"
	icon = '_horizon/icons/obj/tools.dmi'
	lefthand_file = '_horizon/icons/obj/in_hands/tools_lefthand.dmi'
	righthand_file = '_horizon/icons/obj/in_hands/tools_righthand.dmi'
	var/bs_capac = BSRPD_CAPAC_MAX
	var/bs_use = BSRPD_CAPAC_USE
	var/bs_prog = 0
	bluespace = TRUE

/obj/item/pipe_dispenser/bluespace/attackby(obj/item/item, mob/user, param)
	if(istype(item, /obj/item/stack/sheet/bluespace_crystal) || istype(item, /obj/item/stack/ore/bluespace_crystal))
		if(BSRPD_CAPAC_NEW > (BSRPD_CAPAC_MAX - bs_capac) || bs_use == 0)
			to_chat(user, span_warning("[src] is at maximum charge capacity!"))
			return
		item.use(1)
		to_chat(user, span_notice("Recharging the bluespace capacitor inside [src]"))
		bs_capac += BSRPD_CAPAC_NEW
		return
	if(istype(item, /obj/item/assembly/signaler/anomaly/bluespace))
		if(bs_use)
			to_chat(user, span_notice("Installing [item] into [src]; now this thing will work much forever!"))
			bs_use = 0
			qdel(item)
		else
			to_chat(user, span_warning("Where to charge [src] more then!"))
		return
	return ..()

/obj/item/pipe_dispenser/bluespace/examine(mob/user)
	. = ..()
	if(user.Adjacent(src))
		. += span_notice("Currently it has [bs_use == 0 ? "INFINITY" : bs_capac / bs_use] of charges.")
		if(bs_use != 0)
			. += span_notice("\nThe bluespace core is not installed.")
	else
		. += "I can't see charge from here."

/obj/item/pipe_dispenser/bluespace/afterattack(atom/A, mob/user, proximity_flag)
	if(!range_check(A, user))
		return FALSE

	if(proximity_flag)
		return ..()

	if(bs_capac < bs_use)
		to_chat(user, span_warning("[src] has no charge."))
		return FALSE
//	user.changeNext_move(CLICK_CD_RANGE)
	user.Beam(A, icon_state = "rped_upgrade", time = 1 SECONDS)

	if(pre_attack(target, user))
		bs_capac -= bs_use
		return TRUE

	return FALSE

/obj/item/pipe_dispenser/bluespace/proc/range_check(atom/A, mob/user)
	if(!(A in view(7, get_turf(user))))
		to_chat(user, span_warning("The \'Out of Range\' light on [src] blinks red."))
		return FALSE
	else
		return TRUE

#undef BSRPD_CAPAC_MAX
#undef BSRPD_CAPAC_USE
#undef BSRPD_CAPAC_NEW
*/
/obj/item/storage/belt/utility/full/powertools/holding
	name = "belt of holding"
	desc = "The greatest in pants-supporting bluespace technology."
	icon = '_horizon/icons/obj/belt.dmi'
	worn_icon = '_horizon/icons/obj/in_mob/belt_mob.dmi'
	icon_state = "holdingbelt"
	worn_icon_state = "holdingbelt"
	content_overlays = FALSE
	storage_type = /datum/storage/utility_belt/holding

/obj/item/storage/belt/utility/full/powertools/holding/PopulateContents()
	new /obj/item/screwdriver/power(src)
	new /obj/item/crowbar/power(src)
	new /obj/item/weldingtool/experimental(src)
	new /obj/item/multitool(src)
	new /obj/item/holosign_creator/atmos(src)
	new /obj/item/extinguisher/mini(src)
	new /obj/item/stack/cable_coil(src)
	new /obj/item/analyzer/ranged(src)
	new /obj/item/geiger_counter(src)
	new /obj/item/pipe_dispenser(src)
	new /obj/item/construction/rcd/arcd/debug(src)
	new /obj/item/inducer(src)

// /obj/item/storage/belt/medical/surgery_belt_adv

// MARK: Тактический Кислородный Баллон

/obj/item/tank/internals/tactical
	name = "Тактический кислородный баллон"
	desc = "Кислородный баллон военно-космического назначения. Конструкция весьма массивна и может быть закреплена только на скафандрах и тяжелой верхней одежде. Представляет собой систему магнитных креплений и стабилизирующих ремней для фиксации большинства стандартных видов вооружения. В комплект также входит универсальный оружейный кейс для нестандартных образцов."
	icon = '_horizon/icons/obj/tank_tactical.dmi'
	icon_state = "tank"
	worn_icon = '_horizon/icons/obj/in_mob/tank_tactical_back.dmi'
	worn_icon_state = "empty"
	tank_holder_icon_state = null
	distribute_pressure = TANK_DEFAULT_RELEASE_PRESSURE
	force = 15
	dog_fashion = null
	w_class = WEIGHT_CLASS_BULKY
	slot_flags = ITEM_SLOT_SUITSTORE
	equip_sound = 'sound/items/equip/toolbelt_equip.ogg'
	//allowed = list(/obj/item/flashlight, /obj/item/tank/internals/emergency_oxygen)
	var/static/list/holdable_weapons_list = list(
		/obj/item/kinetic_crusher = "crusher",
		/obj/item/gun/ballistic/shotgun/automatic/combat = "auto_shotgun",
		/obj/item/gun/ballistic/shotgun/riot = "shotgun",
		/obj/item/gun/ballistic/shotgun/doublebarrel = "doublebarrel",
		/obj/item/gun/grenadelauncher = "grenadelauncher",
		/obj/item/gun/ballistic/automatic/pistol = "pistol",
		/obj/item/gun/ballistic/revolver = "pistol",
		/obj/item/gun/ballistic/automatic/wt550 = "wt550",
		/obj/item/gun/ballistic/automatic/c20r = "c20",
		/obj/item/gun/ballistic/automatic/m90 = "m90",
		/obj/item/gun/ballistic/rocketlauncher = "rocket",
		/obj/item/gun/ballistic/shotgun/bulldog = "bulldog",
		/obj/item/gun/energy/recharge/kinetic_accelerator = "kinetic",
		/obj/item/gun/energy/laser = "laser",
		/obj/item/gun/energy/laser/captain = "cap",
		/obj/item/gun/energy/e_gun = "egun",
		/obj/item/gun/energy/e_gun/nuclear = "nuke",
		/obj/item/gun/energy/e_gun/hos = "hos",
		/obj/item/gun/energy/e_gun/stun = "egun_taser",
		/obj/item/gun/energy/e_gun/mini = "pistol",
		/obj/item/gun/energy/pulse = "pulse",
		/obj/item/gun/energy/pulse/pistol = "pistol",
	)

/obj/item/tank/internals/tactical/Initialize(mapload)
	. = ..()
	create_storage(storage_type = /datum/storage/pockets/tactical)

//Наполнение баллона воздухом (стандарт)
/obj/item/tank/internals/tactical/populate_gas()
	air_contents.set_gas(/datum/gas/oxygen, (6*ONE_ATMOSPHERE)*volume/(R_IDEAL_GAS_EQUATION*T20C))

//Параметры кармана
/datum/storage/pockets/tactical
	max_slots = 1
	max_specific_storage = WEIGHT_CLASS_BULKY
	rustle_sound = FALSE
	attack_hand_interact = TRUE

//Тип хранимого
/datum/storage/pockets/tactical/New(atom/parent, max_slots, max_specific_storage, max_total_storage, numerical_stacking, allow_quick_gather, allow_quick_empty, collection_mode, attack_hand_interact)
	. = ..()
	set_holdable(list(
		/obj/item/gun/ballistic,
		/obj/item/gun/energy,
		/obj/item/kinetic_crusher,
		/obj/item/gun/grenadelauncher
	))

//Спавн оружия в чехле, так можно задать пресеты, по умолчанию /obj/item/tank/internals/tactical/ должен быть пуст, а пресеты устанавливаются через наследников
/obj/item/tank/internals/tactical/Initialize(mapload)			//Эскадрон Смерти, шаттл Рейнджеров, Лазутчик Синдиката (корабль), Syndicate Operative - Full Kit (Лонер)
	. = ..()
	update_appearance()

/obj/item/tank/internals/tactical/wt550/Initialize(mapload)
	. = ..()
	new /obj/item/gun/ballistic/automatic/wt550(src)
	update_appearance()

/obj/item/tank/internals/tactical/pulse/Initialize(mapload)
	. = ..()
	new /obj/item/gun/energy/pulse(src)
	update_appearance()

/obj/item/tank/internals/tactical/e_gun/Initialize(mapload)	//ERT Commander, ERT Medic, ERT Engineer,
	. = ..()
	new /obj/item/gun/energy/e_gun(src)
	update_appearance()

/obj/item/tank/internals/tactical/e_gun_taser/Initialize(mapload)	//ERT Security, Охранник Инвизиторов
	. = ..()
	new /obj/item/gun/energy/e_gun/stun(src)
	update_appearance()

//Быстрое извлечение через ЛКМ, быстрое разоружение через "E" тут code\modules\mob\inventory.dm
/obj/item/tank/internals/tactical/attack_hand(mob/user)
	if(loc != user || user.get_item_by_slot(ITEM_SLOT_SUITSTORE) != src || !user.can_perform_action(src)) //!user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY, FALSE, TRUE))
		return ..()

	if(length(contents))
		var/obj/item/I = contents[1]
		user.visible_message(span_notice("[user] достаёт [I] из [src]."), span_notice("Достаю [I] из [src]."))
		user.put_in_hands(I)
		update_appearance()
		user.update_suit_storage()
	else
		to_chat(user, span_warning("Крепления расстегнуты, [capitalize(src.name)] пуст."))
	return ..()

//Изменение картинки в зависимости от содержания
/obj/item/tank/internals/tactical/update_icon_state()
	icon_state = initial(icon_state)
	worn_icon_state = initial(worn_icon_state)
	if(!length(contents))
		cut_overlays()
		return ..()
	var/obj/item/I = contents[1]
	worn_icon_state = "full"
	playsound(I, 'sound/items/equip/toolbelt_equip.ogg', 25, TRUE)

	if(I.type in holdable_weapons_list)
		icon_state = holdable_weapons_list[I.type]
	else
		var/mutable_appearance/gun_overlay = mutable_appearance(I.icon, I.icon_state)
		var/matrix/M = matrix()
		M.Turn(-90)
		M.Translate(-4, 0)
		gun_overlay.transform = M
		add_overlay(gun_overlay)
		icon_state = "box"

	return ..()

// MARK: Пеналы

/obj/item/storage/belt/medipenal
	name = "пенал для медипенов"
	desc = "Компактный и очень удобный пенал вмещающий до 5 медипенов, специальная клипса позволяет закрепить его на карманах или поясе, а с его маленькими габаритами он поместится в коробке или аптечке."
	icon = '_horizon/icons/obj/medipenal.dmi'
	icon_state = "penal"
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_POCKETS
	w_class = WEIGHT_CLASS_SMALL
	max_integrity = 300
	equip_sound = 'sound/items/equip/toolbelt_equip.ogg'

/obj/item/storage/belt/medipenal/Initialize()
	. = ..()
	atom_storage.max_slots = 5
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_total_storage = 10
	atom_storage.set_holdable(list(
		/obj/item/reagent_containers/hypospray/medipen,
		/obj/item/reagent_containers/syringe
		))

/obj/item/storage/belt/medipenal/update_icon_state()
	. = ..()
	icon_state = initial(icon_state)
	worn_icon_state = initial(worn_icon_state)
	if(length(contents))
		icon_state = "penal[length(contents)]"

/obj/item/storage/belt/medipenal/attack_hand(mob/user, list/modifiers)
	if(loc == user)
		if((user.get_item_by_slot(ITEM_SLOT_BELT) == src) || (user.get_item_by_slot(ITEM_SLOT_LPOCKET) == src) || (user.get_item_by_slot(ITEM_SLOT_RPOCKET) == src))
			if(!user.can_perform_action(src)) // !user.canUseTopic(src, BE_CLOSE, NO_DEXTERITY, FALSE, TRUE))
				return
			atom_storage?.show_contents(user)
	else ..()
	return

/obj/item/storage/medkit/field_surgery
	name = "укладка полевого хирурга"
	desc = "Компактный набор самых необходимых медицинских инструментов для неотложного хирургического вмешательства в полевых условиях."
	icon_state = "medkit_tactical"
	inhand_icon_state = "medkit-tactical"
	damagetype_healed = HEAL_ALL_DAMAGE
	storage_type = /datum/storage/medkit/surgery/holding

/obj/item/storage/medkit/field_surgery/PopulateContents()
	if(empty)
		return
	var/static/items_inside = list(
		/obj/item/scalpel/advanced = 1,
		/obj/item/retractor/advanced = 1,
		/obj/item/cautery/advanced = 1,
		/obj/item/surgical_drapes = 1,
		/obj/item/reagent_containers/medigel/sterilizine = 1,
		/obj/item/bonesetter = 1,
		/obj/item/blood_filter = 1,
		/obj/item/breathing_bag=1,
		/obj/item/defibrillator/compact/loaded = 1,
		/obj/item/stack/medical/bone_gel = 1,
		/obj/item/stack/medical/wrap/sticky_tape/surgical = 1,
		/obj/item/healthanalyzer/super = 1)
	generate_items_inside(items_inside,src)

// MARK: Дыхательная груша
/obj/item/breathing_bag
	name = "дыхательная груша"
	desc = "Она же мешок Амбу — механическое ручное устройство для выполнения искусственной вентиляции лёгких."
	icon = '_horizon/icons/obj/med_items.dmi'
	icon_state = "breathing_bag"
	lefthand_file = 'icons/mob/inhands/clothing/masks_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/clothing/masks_righthand.dmi'
	inhand_icon_state = "m_mask"
	custom_materials = list(/datum/material/iron=5000, /datum/material/glass=2500)
	w_class = WEIGHT_CLASS_SMALL
	toolspeed = 1

/obj/item/breathing_bag/attack(mob/living/M, mob/user)
	if(M == user)
		return
	if (M.is_mouth_covered())
		to_chat(user, span_warning("Для произведения ИВЛ с пациента надо снять маску!"))
		return
	to_chat(user, span_notice("Прикладываю дыхательную маску к лицу [M.name].")) // [skloname(M.name, RODITELNI, M.gender)]."))
	if(!do_after(user, 30, user))
		to_chat(user, span_warning("Не получается!"))
		return
	. = ..()
	playsound(user,'_horizon/sound/breathing_bag.ogg', 100, TRUE)
	for(var/ivl in 1 to 15)
		if(!do_after(user, 10, user))
			return
		to_chat(user, span_notice("Произвожу искуственную вентиляцию легких!"))
		M.adjust_oxy_loss(-15)

/obj/item/storage/box/traitorbundledebug
	name = "box of traitor"
	icon_state = "syndiebox"
	illustration = "writing_syndie"

/obj/item/storage/box/traitorbundledebug/PopulateContents()
	var/static/items_inside = list(
		/obj/item/card/emag=1,\
		/obj/item/uplink/debug=1,\
		/obj/item/uplink/nuclear/debug=1,\
		/obj/item/flashlight/emp/debug=1,\
	)
	generate_items_inside(items_inside,src)
