# Any script that interacts with the Project Heartbeat API is licensed under the AGPLv3
# For more information, please read LICENSE.MD

# Documentation for the scripting system can be found here: https://steamcommunity.com/sharedfiles/filedetails/?id=2398390074

# 
# Comfy copy
# By Lino
#

#meta:name:Copy notes to Comfy
#meta:description:Copies notes into your clipboard in a format Comfy Studio can understand
#meta:usage:Select the notes to be copied, and press "Run"
#meta:preview:false

extends ScriptRunnerScript # Do not remove this

const note_types_to_csfm = {
	HBBaseNote.NOTE_TYPE.UP: 0x00,
	HBBaseNote.NOTE_TYPE.LEFT: 0x01,
	HBBaseNote.NOTE_TYPE.DOWN: 0x02,
	HBBaseNote.NOTE_TYPE.RIGHT: 0x03,
	HBBaseNote.NOTE_TYPE.SLIDE_LEFT: 0x04,
	HBBaseNote.NOTE_TYPE.SLIDE_RIGHT: 0x05,
	HBBaseNote.NOTE_TYPE.SLIDE_CHAIN_PIECE_LEFT: 0x04,
	HBBaseNote.NOTE_TYPE.SLIDE_CHAIN_PIECE_RIGHT: 0x05,
}  

func run_script() -> int:
	# Get selected timing points
	var selected_timing_points := get_selected_timing_points()
	
	# Comfy only accepts pastes from its own build version. This string has to be changed for different builds of Comfy
	var commit_hash = "bfb491cc" 
	
	# Magic string
	var clipboard_text = "#Comfy::Studio::ChartEditor Clipboard " + commit_hash
	var data = []
	
	# Iterate over them
	for note in selected_timing_points:
		# We only want modern notes
		# or (note.note_type == HBBaseNote.NOTE_TYPE.HEART)
		if not note is HBNoteData or note.note_type == HBBaseNote.NOTE_TYPE.HEART:
			continue
		
		# Comfy uses 192ths ¯\_(ツ)_/¯
		var tick: int = round(get_time_as_eight(note.time) * 24)
		var note_type: int = note_types_to_csfm[note.note_type]
		var pos_modified: int = 1 if note.pos_modified else 0
		var hold: int = 1 if note.hold else 0
		var is_chain: int = 1 if note.note_type in [HBBaseNote.NOTE_TYPE.SLIDE_CHAIN_PIECE_LEFT, HBBaseNote.NOTE_TYPE.SLIDE_CHAIN_PIECE_LEFT] else 0
		var angle: float = note.entry_angle + 90.0
		
		# First slide is also part of chain
		if is_chain and data[-1][1] in [4, 5]:
			data[-1][4] = 1
		
		data.append([tick, note_type, pos_modified, hold, is_chain, 0, note.position.x, note.position.y, angle, note.oscillation_frequency, note.oscillation_amplitude, note.distance])
	
	for entry in data:
		# Format:
		# Target { tick note_type pos_modified is_hold is_chain is_chance_note x y angle frequency amplitude distance };
		clipboard_text += "\n"
		clipboard_text += "Target { %d %d %d %d %d %d %.2f %.2f %.2f %.2f %.2f %.2f };" % entry
	
	# Copy to clipboard
	DisplayServer.clipboard_set(clipboard_text)
	
	# Return OK to apply the script's changes, return anything else (such as -1)
	# to cancel it
	return OK
