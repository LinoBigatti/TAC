# Any script that interacts with the Project Heartbeat API is licensed under the AGPLv3
# For more information, please read LICENSE.MD

# Documentation for the scripting system can be found here: https://steamcommunity.com/sharedfiles/filedetails/?id=2398390074

# 
# 180? generator
# By Lino
#

#meta:name:Create Alternating Pattern
#meta:description:Creates an alternating/180 pattern (Triangle -> Cross and Square -> Circle, and viceversa), starting at the first note type.
#meta:usage:Set the first note type to the start of the pattern, select all your notes, and press "Run".
#meta:preview:false

extends ScriptRunnerScript # Do not remove this

func run_script() -> int:
	# Get selected timing points
	var selected_timing_points := get_selected_timing_points()
	
	# Get the note type of the first point
	var firstPoint := selected_timing_points[0] as HBTimingPoint
	var noteType = firstPoint.note_type
	
	# Variables
	var direction: int
	if noteType <= 1:
		direction = 1
	else:
		direction = -1

	# Iterate over them
	for i in range(selected_timing_points.size()):
		var point := selected_timing_points[i] as HBTimingPoint
		
		# Set the type
		set_timing_point_property(point, "note_type", noteType)

		# Change next note
		noteType += 2 * direction
		direction *= -1
	
	# Return OK to apply the script's changes, return anything else (such as -1)
	# to cancel it
	return OK
