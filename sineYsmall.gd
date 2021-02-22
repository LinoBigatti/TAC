# Any script that interacts with the Project Heartbeat API is licensed under the
# AGPLv3 for the general public and also gives an exclusive, royalty-free license
# for EIRTeam to incorporate it in the game

# Documentation for the scripting system can be found here: https://steamcommunity.com/sharedfiles/filedetails/?id=2398390074

#
# Small sine wave Y script
# By Lino
# Original expression by NeoRash
# Vector2(note.position.x + 20 * sin(1.5 * note.position.y/100), note.position.y)
# 

extends ScriptRunnerScript # Do not remove this

func run_script() -> int:
	# Get selected timing points
	var selected_timing_points := get_selected_timing_points()
	
	# Initialize variables
	var amp = 20
	var freq = 1.5

	# Iterate over them
	for i in range(selected_timing_points.size()):
		var point := selected_timing_points[i] as HBTimingPoint
		
		# Fancy math
		var z = point.position.y / 100
		var x = amp * sin(freq * z)
		var pos = Vector2(x + 960, point.position.y)

		# Change position
		set_timing_point_property(point, "position", pos)
	
	# Return OK to apply the script's changes, return anything else (such as -1)
	# to cancel it
	return OK
