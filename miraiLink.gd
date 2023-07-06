# Any script that interacts with the Project Heartbeat API is licensed under the AGPLv3

# 
# Mirai Link
# by NeoRash & SimLate
# inspired by Mikuphile
# 
# July.2023
#

#meta:name:Mirai Link (Full)
#meta:description:Connects the Flying Icon of the first Note with the last Note. All Flying Icons in between disappear.
#meta:usage:Select your arranged notes and press "Run".
#meta:preview:true


extends ScriptRunnerScript

# Distance between x & y
func distance(x: Vector2,y: Vector2) -> float:
	return sqrt(pow(y.x - x.x,2) + pow(y.y - x.y,2));

# Connection Vector
# From v1 to v2
func connection_vector(v1: Vector2,v2: Vector2) -> Vector2:
	return Vector2((v2.x - v1.x),(v2.y - v1.y));

func run_script() -> int:
	# Note list
	var selected_timing_points := get_selected_timing_points();
	# Note count
	var selected_point_count := selected_timing_points.size();

	# Get first and last Note
	var first_note = selected_timing_points[0];
	var last_note = selected_timing_points[selected_point_count - 1];

	# First Note
	set_timing_point_property(first_note, "distance", distance(last_note.position, first_note.position));
	set_timing_point_property(first_note, "auto_time_out", false);
	set_timing_point_property(first_note, "time_out", last_note.time - first_note.time);
	set_timing_point_property(first_note, "oscillation_amplitude", 0);
	set_timing_point_property(first_note, "entry_angle", (Vector2(0,0).angle_to_point(connection_vector(first_note.position,last_note.position)) / TAU * 360));

	# Notes in between
	for i in range(1, selected_point_count - 1):
		set_timing_point_property(selected_timing_points[i],"distance", 9000000000000000000.00);
		set_timing_point_property(selected_timing_points[i], "auto_time_out", false);
		set_timing_point_property(selected_timing_points[i], "time_out", last_note.time - first_note.time);
		set_timing_point_property(selected_timing_points[i], "entry_angle", 270);
    
	# Last Note
	set_timing_point_property(last_note, "distance", distance(last_note.position, first_note.position));
	set_timing_point_property(last_note, "auto_time_out", false);
	set_timing_point_property(last_note, "time_out", last_note.time - first_note.time);
	set_timing_point_property(last_note, "oscillation_amplitude", 0);
	set_timing_point_property(last_note, "entry_angle", (Vector2(0,0).angle_to_point(connection_vector(first_note.position,last_note.position)) / TAU * 360));

	return OK;
