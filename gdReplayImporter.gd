# Any script that interacts with the Project Heartbeat API is licensed under the
# AGPLv3 for the general public and also gives an exclusive, royalty-free license
# for EIRTeam to incorporate it in the game

# Documentation for the scripting system can be found here: https://steamcommunity.com/sharedfiles/filedetails/?id=2398390074

#
# Geometry dash ZBot replay importer
# By Lino
#

extends ScriptRunnerScript # Do not remove this

func run_script() -> int:
	var file = File.new()
	file.open("user://editor_scripts/replay.txt", File.READ)
	var content = file.get_as_text()
	var lines = content.split('\n')
	file.close()
	
	# FORMAT SPECIFICATIONS
	#
	#	We will be dealing with plain text replays
	#	converted from a .zbf (ZBot frame) file.
	#	To get the correct format, use this converter:
	#	https://matcool.github.io/gd-macro-converter/frame.html
	#
	#	The first line states the fps the replay is recording
	#	at. This is important since the timings are frame-based 
	#	rather than ms-based, and we need to convert them.
	#
	#	Afterwards, the format looks like this:
	#
	#			int					 bool				bool
	#	FRAME NUMBER | PLAYER 1 | PLAYER 2
	
	var fps = float(lines[0])
	var ms_per_frame = 1000/fps

	for i in range(1, lines.size() - 1):
		var line = lines[i]
		var data = line.split(' ')
		
		var frame = int(data[0])
		var time = frame * ms_per_frame
		
		var player_1_input = true if data[1] == "1" else false
		var player_2_input = true if data[2] == "1" else false
		var any_input = player_1_input or player_2_input

		if any_input:
			var new_timing_point = HBNoteData.new()
			new_timing_point.time = time
			new_timing_point.note_type = 0

			create_timing_point(new_timing_point)
	
	# Return OK to apply the script's changes, return anything else (such as -1)
	# to cancel it
	return OK
