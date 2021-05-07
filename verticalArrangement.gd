# Any script that interacts with the Project Heartbeat API is licensed under the
# AGPLv3 for the general public and also gives an exclusive, royalty-free license
# for EIRTeam to incorporate it in the game


# 
# Better arrangement for vertical multis and strctures that follow
# By Lino
#


extends ScriptRunnerScript # Do not remove this

func run_script() -> int:
	# Get selected timing points
	var selected_timing_points := get_selected_timing_points()
	
	var firstPos = selected_timing_points[0].position

	# Iterate over them
	for point in selected_timing_points:
		# Check if point is a normal or slide note
		if point is HBNoteData:
			# What should I even do with this one pokeWHAT
			if point.is_slide_note() or point.is_slide_hold_piece():
				break
		
		# Check if point is any type of note
		if point is HBBaseNote:
			var newPos = point.position
			newPos.y = firstPos.y
			newPos.y -= -92 * point.note_type
			set_timing_point_property(point, "position", newPos)
	
	# Return OK to apply the script's changes, return anything else (such as -1)
	# to cancel it
	return OK
