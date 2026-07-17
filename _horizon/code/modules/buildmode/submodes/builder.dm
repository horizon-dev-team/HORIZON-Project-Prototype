/**
 * Builder mode - modern build mode with TGUI item browser,
 * category selection, pixel positioning, and item placement.
 *
 * This mode replaces the old basic mode as the default.
 * It provides a full item browser via TGUI, category tabs,
 * search, pixel-precise placement, and more.
 */

/datum/buildmode_mode/builder
	key = "panel"

/datum/buildmode_mode/builder/enter_mode(datum/buildmode/BM)
	BM.current_category = BM_CATEGORY_TURF
	BM.open_item_browser()

/datum/buildmode_mode/builder/exit_mode(datum/buildmode/BM)
	BM.close_item_browser()

/datum/buildmode_mode/builder/show_help(client/c)
	to_chat(c, span_notice("Builder Mode - Use the item browser to select items, then left-click to place and right-click to deselect."))

/datum/buildmode_mode/builder/handle_click(client/c, params, object)
	var/list/modifiers = params2list(params)
	var/left_click = LAZYACCESS(modifiers, LEFT_CLICK)
	var/right_click = LAZYACCESS(modifiers, RIGHT_CLICK)

	if(BM.selected_item)
		if(left_click)
			BM.place_object(get_turf(object), c, modifiers)
			return TRUE
		if(right_click)
			BM.clear_selection()
			return TRUE
	return ..()
