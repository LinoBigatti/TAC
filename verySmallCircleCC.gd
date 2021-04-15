# Any script that interacts with the Project Heartbeat API is licensed under the
# AGPLv3 for the general public and also gives an exclusive, royalty-free license
# for EIRTeam to incorporate it in the game

# 
# Very small counterclockwise circle script
# By Lino & NeoRash
# Made with Love
#

extends ScriptRunnerScript # Do not remove this

func run_script() -> int:
	# Initialize variables
	var amp = 144
	var dir = -1 	# 1 for c, -1 for cc
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
		var z = t * TAU
		var x = amp * cos(z * dir / 1650) + 960
		var y = amp * sin(z * dir / 1650) + 540
		var pos = Vector2(x, y)
		
		# Compensate for sustain notes
		if point is HBSustainNote:
			sustainCompensation += point.end_time - point.time
		
		# Set position
		set_timing_point_property(point, "position", pos)

		# Calculate angle to the center of the screen
		var a = atan2(y - 540, x - 960) 
		a *= (180 / PI) 
		a += 180

		# Set angle
		set_timing_point_property(point, "entry_angle", a)
	
	# Return OK to apply the script's changes, return anything else (such as -1)
	# to cancel it
	return OK
