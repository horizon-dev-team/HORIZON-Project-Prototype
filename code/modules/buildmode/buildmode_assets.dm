/// Global list of all placeable atoms grouped by category.
/// Built once at world init, consumed by the spritesheet and ui_static_data.
GLOBAL_LIST_INIT(buildmode_items, build_buildmode_items())

/proc/build_buildmode_items()
	var/list/categories = list()

	// Turfs
	var/list/turfs = list()
	for(var/turf/T as anything in subtypesof(/turf))
		if(!initial(T.icon) || ispath(T, /turf/template_noop))
			continue
		turfs += list(list("path" = T, "name" = initial(T.name) || "[T]"))
	categories += list(list("id" = BM_CATEGORY_TURF, "name" = "Turfs", "items" = turfs))

	// Objects (non-item, non-effect, non-abstract)
	var/list/objs = list()
	for(var/obj/O as anything in subtypesof(/obj))
		if(IS_ABSTRACT(O))
			continue
		if(ispath(O, /obj/item) || ispath(O, /obj/effect))
			continue
		if(!initial(O.icon))
			continue
		objs += list(list("path" = O, "name" = initial(O.name) || "[O]"))
	categories += list(list("id" = BM_CATEGORY_OBJ, "name" = "Objects", "items" = objs))

	// Mobs (exclude dead)
	var/list/mobs = list()
	for(var/mob/M as anything in subtypesof(/mob))
		if(!initial(M.icon) || ispath(M, /mob/dead))
			continue
		mobs += list(list("path" = M, "name" = initial(M.name) || "[M]"))
	categories += list(list("id" = BM_CATEGORY_MOB, "name" = "Mobs", "items" = mobs))

	// Items (general — exclude clothing, reagent containers, food, guns)
	var/list/items = list()
	for(var/obj/item/I as anything in subtypesof(/obj/item))
		if(ispath(I, /obj/item/clothing) || ispath(I, /obj/item/reagent_containers) || ispath(I, /obj/item/food) || ispath(I, /obj/item/gun))
			continue
		if(!initial(I.icon))
			continue
		items += list(list("path" = I, "name" = initial(I.name) || "[I]"))
	categories += list(list("id" = BM_CATEGORY_ITEM, "name" = "Items", "items" = items))

	// Weapons
	var/list/weapons = list()
	for(var/obj/item/gun/G as anything in subtypesof(/obj/item/gun))
		if(!initial(G.icon))
			continue
		weapons += list(list("path" = G, "name" = initial(G.name) || "[G]"))
	categories += list(list("id" = BM_CATEGORY_WEAPON, "name" = "Weapons", "items" = weapons))

	// Clothing
	var/list/clothing = list()
	for(var/obj/item/clothing/C as anything in subtypesof(/obj/item/clothing))
		if(!initial(C.icon))
			continue
		clothing += list(list("path" = C, "name" = initial(C.name) || "[C]"))
	categories += list(list("id" = BM_CATEGORY_CLOTHING, "name" = "Clothing", "items" = clothing))

	// Reagent containers (exclude food)
	var/list/containers = list()
	for(var/obj/item/reagent_containers/R as anything in subtypesof(/obj/item/reagent_containers))
		if(ispath(R, /obj/item/food) || !initial(R.icon))
			continue
		containers += list(list("path" = R, "name" = initial(R.name) || "[R]"))
	categories += list(list("id" = BM_CATEGORY_REAGENT_CONTAINERS, "name" = "Liquid Vessels", "items" = containers))

	// Food
	var/list/food = list()
	for(var/obj/item/food/F as anything in subtypesof(/obj/item/food))
		if(!initial(F.icon))
			continue
		food += list(list("path" = F, "name" = initial(F.name) || "[F]"))
	categories += list(list("id" = BM_CATEGORY_FOOD, "name" = "Food", "items" = food))

	return categories

/**
 * Spritesheet for buildmode item browser icons.
 * Pre-renders all item icons into a single batched spritesheet,
 * matching the RapidDecorationDevice approach.
 */
/datum/asset/spritesheet_batched/buildmode
	name = "buildmode"

/datum/asset/spritesheet_batched/buildmode/create_spritesheets()
	var/id = 1
	for(var/list/category in GLOB.buildmode_items)
		for(var/list/item in category["items"])
			var/atom/path = item["path"]
			var/datum/universal_icon/icon = uni_icon(path::icon, path::icon_state)
			icon.scale(32, 32)
			insert_icon("bm_[id]", icon)
			item["icon"] = "bm_[id]"
			id++

