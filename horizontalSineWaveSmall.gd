# Any script that interacts with the Project Heartbeat API is licensed under the
# AGPLv3 for the general public and also gives an exclusive, royalty-free license
# for EIRTeam to incorporate it in the game

# Documentation for the scripting system can be found here: https://steamcommunity.com/sharedfiles/filedetails/?id=2398390074

#
# Horizontal Sine Wave
# original by Lino
# revisioned by NeoRash & SimLate (July.2023)
#
# original expression by NeoRash
# Sine: Vector2(note.position.x, note.position.y + 24 * sin(1 * note.position.x/100))
# Chainsaw: Vector2(note.position.x, note.position.y + 48 * abs(fmod(0.6 * note.position.x/100, 2.0 ) -1))
# 
# Update July.2023, What is new?
# The Script takes "rad" into Account.
# This allows you to align the Wave with the Grid.
# Also you can now place the Wave anywhere on the Screen, you'll get the same Result.
#

#meta:name:Horizontal Sine Wave (Small)
#meta:description:Arranges notes following a horizontal sine wave.
#meta:usage:Select your horizontally arranged notes and press "Run".
#meta:preview:true


extends ScriptRunnerScript # Do not remove this

# Variables (changeable)
var grid_size = 96 # Arranger Separation, for Example: 8th = 96px, 12th = 128px
var amp = 24 # influences y, 24px is quarter y Spacing.
var freq = 0.66 # influences x, stretches or compresses the Sine.


func run_script() -> int:
	# Note List
	var selected_timing_points := get_selected_timing_points()

	# Get first Note
	var first_note = selected_timing_points[0]

	# Iterate over them
	for i in range(selected_timing_points.size()):
		# get selected Timing Points.
		var point := selected_timing_points[i] as HBTimingPoint
		
		# Even fancier Math =D
		# Sine Pos and Scale Math
		# (point.position.x - first_note.position.x) is that the Sine starts at Pos 0.
		# 90 / grid_size is the Grid Factor. It converts from current Grid Size to Degree, for Example: 90deg / 96px. It is for scaling the Sine to the Grid.
		var x = deg2rad((point.position.x - first_note.position.x) * 90 / grid_size)
		# Sine Math
		# Calculates the Sine. Math: amp * sin(frq * pos_x)
		var y = amp * sin(freq * x)
		# Note Pos
		# Places Notes on the Sine.
		var pos = Vector2(point.position.x, y + first_note.position.y)

		# Change Note Positions.
		set_timing_point_property(point, "position", pos)
	
	# Return OK to apply the Script's changes, return anything else (such as -1)
	# to cancel it.
	return OK
