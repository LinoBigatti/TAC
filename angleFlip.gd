# Any script that interacts with the Project Heartbeat API is licensed under the
# AGPLv3 for the general public and also gives an exclusive, royalty-free license
# for EIRTeam to incorporate it in the game

# Documentation for the scripting system can be found here: https://steamcommunity.com/sharedfiles/filedetails/?id=2398390074

# 
# Angle flipper (up -> down, left -> right, etc)
# By Lino
#

extends ScriptRunnerScript # Do not remove this

func run_script() -> int:
	# Get selected timing points
	var selected_timing_points := get_selected_timing_points()

	# Iterate over them
	for i in range(selected_timing_points.size()):
		var point := selected_timing_points[i] as HBTimingPoint
		
		# Set the angle
		set_timing_point_property(point, "entry_angle", point.entry_angle - 180)
	
	# Return OK to apply the script's changes, return anything else (such as -1)
	# to cancel it
	return OK
