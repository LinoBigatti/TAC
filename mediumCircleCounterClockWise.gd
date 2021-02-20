# Any script that interacts with the Project Heartbeat API is licensed under the
# AGPLv3 for the general public and also gives an exclusive, royalty-free license
# for EIRTeam to incorporate it in the game

# 
# Medium CC circle script
# By Lino
#

extends ScriptRunnerScript # Do not remove this

func run_script() -> int:
	# Initialize variables
	var amp = 200
	var dir = -1 	# 1 for c, -1 for cc
	var freq = 5 * dir
	var sustainCompensation = 0

	# Get selected timing points
	var selected_timing_points := get_selected_timing_points()
	
	# Flip them pokeWHAT
	selected_timing_points.invert()

	# Iterate over them
	for i in range(selected_timing_points.size()):
		# Get point
		var point := selected_timing_points[i] as HBTimingPoint
		
		# Fancy math
		var t = point.time - sustainCompensation
		var z = t / (PI * 2)
		var x = amp * cos(freq * z)
		var y = amp * sin(freq * z)
		var pos = Vector2(x + 960, y + 540)
		
		# Compensate for sustain notes
		if point is HBSustainNote:
			sustainCompensation += point.end_time - point.time
		
		# Change position
		set_timing_point_property(point, "position", pos)
	
	# Return OK to apply the script's changes, return anything else (such as -1)
	# to cancel it
	return OK
