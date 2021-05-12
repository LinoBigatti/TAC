# Any script that interacts with the Project Heartbeat API is licensed under the
# AGPLv3 for the general public and also gives an exclusive, royalty-free license
# for EIRTeam to incorporate it in the game


# 
# Better arrangement for vertical multis and strctures that follow
# By Lino
#


extends ScriptRunnerScript # Do not remove this

# Find the earliest, highest point
# We need this because the editor inverts get_selected_timing_points 
# if they're selected manually (not right after using the autoarranger)???
func find_min(arr):
    var min_id = 0
    for i in range(1, arr.size()):
        var a = arr[i]
        var b = arr[min_id]
        if a.time != b.time:
            min_id = min_id if b.time < a.time else i
        else:
            min_id = min_id if b.note_type < a.note_type else i
    return arr[min_id]

func run_script() -> int:
    # Get selected timing points
    var selected_timing_points := get_selected_timing_points()
    var firstPoint = find_min(selected_timing_points)
    
    # Iterate over all points
    for point in selected_timing_points:
        # Ignore slide notes
        if point is HBNoteData:
            if point.is_slide_note() or point.is_slide_hold_piece():
                continue

        if point is HBBaseNote:
            var newPos = point.position
            newPos.y = firstPoint.position.y
            newPos.y += 96 * (point.note_type - firstPoint.note_type)
            set_timing_point_property(point, "position", newPos)

    # Return OK to apply the script's changes, return anything else (such as -1)
    # to cancel it
    return OK