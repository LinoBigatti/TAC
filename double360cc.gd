# Any script that interacts with the Project Heartbeat API is licensed under the
# AGPLv3 for the general public and also gives an exclusive, royalty-free license
# for EIRTeam to incorporate it in the game

# Documentation for the scripting system can be found here: https://steamcommunity.com/sharedfiles/filedetails/?id=2398390074

# 
# Counterclockwise double 360 generator
# By Lino
#

extends ScriptRunnerScript # Do not remove this

func run_script() -> int:
	# Get selected timing points
	var selected_timing_points := get_selected_timing_points()
	
	# Invert them pokeWhat
	selected_timing_points.invert()

	# Get the note type of the first point
	var firstPoint := selected_timing_points[0] as HBTimingPoint
	var noteType = firstPoint.note_type
	
	# Variables
	var direction = 1 # -1 for clockwise, 1 for counterclockwise
	var j = 0

	# Iterate over them
	for i in range(selected_timing_points.size()):
		var point := selected_timing_points[i] as HBTimingPoint
		
		# Check for out of bounds
		if noteType > 3:
			noteType = 0

		# Set the type
		set_timing_point_property(point, "note_type", noteType)

		# Change next note
		if j:
			noteType += direction
		
		j ^= 1
	
	# Return OK to apply the script's changes, return anything else (such as -1)
	# to cancel it
	return OK
