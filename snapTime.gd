# Any script that interacts with the Project Heartbeat API is licensed under the
# AGPLv3 for the general public and also gives an exclusive, royalty-free license
# for EIRTeam to incorporate it in the game

extends ScriptRunnerScript;

#
# Time Snapping script
# By Lino
#

#meta:name:Quantize Notes
#meta:description:Snap selected notes to the nearest grid line.
#meta:usage:Select all your notes, and press "Run".
#meta:preview:false

func run_script() -> int:
	var timing_map := get_timing_map()
	
	var selected_timing_points := get_selected_timing_points()
	for point in selected_timing_points:
		# Get closest grid snap
		var beat_i = min(closest_bound(timing_map, point.time), timing_map.size() - 1)
		var time = timing_map[beat_i]
		
		set_timing_point_property(point, "time", time)
	
	return OK
