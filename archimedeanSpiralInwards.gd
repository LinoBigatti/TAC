# This script is licensed under the AGPLv3
# See: LICENSE.MD

# 
# Archimedean spiral
# By nairobi
# Adapted from https://stackoverflow.com/a/27528612
# 

extends ScriptRunnerScript

func run_script() -> int:
    # The only parameter
    # Smaller radius -> denser spirals
    # Relative note distance will always remain valid; more notes -> longer spirals
    var SPIRAL_RADIUS = 160.0

    var SCR_WIDTH_2 = 1920.0 / 2
    var SCR_HEIGHT_2 = 1080.0 / 2

    var sustainCompensation = 0
    var dist = 96.0
    var r = dist
    var b = SPIRAL_RADIUS / (2.0 * PI)
    var phi = r / b
    
    var selected_timing_points := get_selected_timing_points()
    var size = selected_timing_points.size()
    var z = []
    z.resize(size)
    
    # Determine the effective distances between points
    for i in range(size):
        var point := selected_timing_points[size - i - 1] as HBTimingPoint
        z[size - i - 1] = (point.time - sustainCompensation)
        
        # Compensate for sustain notes
        if point is HBSustainNote:
            sustainCompensation += point.end_time - point.time
    
    for i in range(size):
        var point := selected_timing_points[i] as HBTimingPoint
        
        var pos = Vector2(r * cos(phi) + SCR_WIDTH_2, r * sin(phi) + SCR_HEIGHT_2)
        set_timing_point_property(point, "position", pos)
        
        # Advance the spiral to the next point
        if i + 1 < size:
            dist = (z[i] - z[i + 1]) * (get_bpm_at_time(point.time) / 312.0)
            phi += dist / r
            r = b * phi
        
        # Calculate angle to the center of the screen
        var a = atan2(pos.y - SCR_HEIGHT_2, pos.x - SCR_WIDTH_2) * (180.0 / PI) + 180.0
        set_timing_point_property(point, "entry_angle", a)

    return OK