# Any script that interacts with the Project Heartbeat API is licensed under the
# AGPLv3 for the general public and also gives an exclusive, royalty-free license
# for EIRTeam to incorporate it in the game

# Documentation for the scripting system can be found here: https://steamcommunity.com/sharedfiles/filedetails/?id=2398390074

#
# Large sine wave Y script
# By Lino
# Original expression by NeoRash
# Vector2(note.position.x, note.position.y + 20 * sin(1.5 * note.position.x/100))
# 

extends ScriptRunnerScript # Do not remove this

func run_script() -> int:
	# Get selected timing points
	var selected_timing_points := get_selected_timing_points()
	
	# Initialize variables
	var amp = 40
	var freq = 1.5

	# Iterate over them
	for i in range(selected_timing_points.size()):
		var point := selected_timing_points[i] as HBTimingPoint
		
		# Fancy math
		var z = point.position.x / 100
		var y = amp * sin(freq * z)
		var pos = Vector2(point.position.x, y + 540)

		# Change position
		set_timing_point_property(point, "position", pos)
	
	# Return OK to apply the script's changes, return anything else (such as -1)
	# to cancel it
	return OK
