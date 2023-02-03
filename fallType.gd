# Any script that interacts with the Project Heartbeat API is licensed under the
# AGPLv3 for the general public and also gives an exclusive, royalty-free license
# for EIRTeam to incorporate it in the game

# 
# The power of the dark side in one script
# By Lino
#

#meta:name:Arrange Notes like Fall Type games
#meta:description:Arranges the notes in 4 vertical columns, with the angles coming from the top. Hearts and slides are unaffected.
#meta:usage:Select all your notes, and press "Run".
#meta:preview:true

extends ScriptRunnerScript # Do not remove this

func run_script() -> int:
	# Get selected timing points
	var selected_timing_points := get_selected_timing_points()
	
	# First row
	var firstRow = 672 
	
	var yPos = 918

	# Iterate over them
	for point in selected_timing_points:
		var newPos = point.position
		newPos.x = firstRow
		newPos.x += 192 * point.note_type
		newPos.y = yPos
		set_timing_point_property(point, "position", newPos)
		set_timing_point_property(point, "entry_angle", -90)
		set_timing_point_property(point, "oscillation_amplitude", 0)
	
	# Return OK to apply the script's changes, return anything else (such as -1)
	# to cancel it
	return OK
