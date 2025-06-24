# Any script that interacts with the Project Heartbeat API is licensed under the AGPLv3
# For more information, please read LICENSE.MD

# Documentation for the scripting system can be found here: https://steamcommunity.com/sharedfiles/filedetails/?id=2398390074

# 
# Archimedean spiral
# Original by Nairobi, updated by Lino
# Adapted from https://stackoverflow.com/a/27528612
# 

#meta:name:Arrange as Inwards Spiral
#meta:description:Places notes in an inwards spiral.
#meta:usage:Set SPIRAL_RADIUS to your desired value inside this script file. Then, select your notes and press "Run".
#meta:preview:true

extends ScriptRunnerScript

const DISTANCE = 96.0

const SCR_WIDTH_2 = 1920.0 / 2
const SCR_HEIGHT_2 = 1080.0 / 2

# The only parameter
# Smaller radius -> denser spirals
# Relative note distance will always remain valid; more notes -> longer spirals
var SPIRAL_RADIUS = 160.0

func run_script() -> int:
	var dist = DISTANCE
	var r = dist
	var b = SPIRAL_RADIUS / TAU
	var phi = r / b
	
	var selected_timing_points := get_selected_timing_points()
	selected_timing_points.reverse()
	var size = selected_timing_points.size()
	
	for i in range(size):
		var point := selected_timing_points[i] as HBTimingPoint
		
		var pos = Vector2(r * cos(phi) + SCR_WIDTH_2, r * sin(phi) + SCR_HEIGHT_2)
		set_timing_point_property(point, "position", pos)
		
		# Advance the spiral to the next point
		if i + 1 < size:
			var next_time = selected_timing_points[i + 1].time
			
			var time = point.time
			if point is HBSustainNote:
				time = point.end_time
			
			var eight_diff = get_time_as_eight(next_time) - get_time_as_eight(time)
			
			dist = eight_diff * -DISTANCE
			phi += dist / r
			r = b * phi
		
		# Calculate angle to the center of the screen
		var a = atan2(pos.y - SCR_HEIGHT_2, pos.x - SCR_WIDTH_2) * (180.0 / PI) + 180.0
		set_timing_point_property(point, "entry_angle", a)
		
		# Set correct angle parameters
		var freq = abs(point.oscillation_frequency)
		if fmod(freq, 2.0) == 0:
			set_timing_point_property(point, "oscillation_frequency", -freq)
		else:
			set_timing_point_property(point, "oscillation_frequency", freq)
		
		set_timing_point_property(point, "oscillation_amplitude", abs(point.oscillation_amplitude))
		
	return OK