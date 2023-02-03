# Any script that interacts with the Project Heartbeat API is licensed under the
# AGPLv3 for the general public and also gives an exclusive, royalty-free license
# for EIRTeam to incorporate it in the game

# Documentation for the scripting system can be found here: https://steamcommunity.com/sharedfiles/filedetails/?id=2398390074

# 
# Opposite note converter
# By Lino
#

#meta:name:Switch Note Types
#meta:description:Converts every note to its opposite note type (Triangle -> Cross, Square -> Circle, etc.).
#meta:usage:Select all your notes, and press "Run"
#meta:preview:false

extends ScriptRunnerScript # Do not remove this

func run_script() -> int:
	# Get selected timing points
	var selected_timing_points := get_selected_timing_points()
	
	# Iterate over them
	for i in range(selected_timing_points.size()):
		var point := selected_timing_points[i] as HBTimingPoint
		
		# get and change current note type
		var noteType = point.note_type
		match noteType:
			0, 1:		# Triangle or square
				noteType += 2
			2, 3:		# Cross or circle
				noteType -= 2
			4:		# Left slider
				noteType = 5
			5:		# Right slider
				noteType = 4
			6:		# Left slider
				noteType = 7
			7:		# Right slider
				noteType = 6
			8:		# Heart
				pass
				 

		# Set the type
		set_timing_point_property(point, "note_type", noteType)

	# Return OK to apply the script's changes, return anything else (such as -1)
	# to cancel it
	return OK
