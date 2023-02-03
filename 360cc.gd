# Any script that interacts with the Project Heartbeat API is licensed under the AGPLv3
# For more information, please read LICENSE.MD

# Documentation for the scripting system can be found here: https://steamcommunity.com/sharedfiles/filedetails/?id=2398390074

# 
# Counterclockwise 360 generator
# By Lino
#

#meta:name:Create Counterclockwise 360 Pattern
#meta:description:Creates a counterclockwise 360 pattern (Triangle -> Square -> Cross -> Circle), starting at the first note type.
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
	var direction = 1 # -1 for clockwise, 1 for counterclockwise
	
	# Iterate over them
	for i in range(selected_timing_points.size()):
		var point := selected_timing_points[i] as HBTimingPoint
		
		# Check for out of bounds
		if noteType > 3:
			noteType = 0

		# Set the type
		set_timing_point_property(point, "note_type", noteType)

		# Change next note
		noteType += direction
	
	# Return OK to apply the script's changes, return anything else (such as -1)
	# to cancel it
	return OK
