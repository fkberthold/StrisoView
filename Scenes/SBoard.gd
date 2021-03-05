extends Control

var sel_button = null
const scales = {"Major":["P1", "M2", "M3", "P4", "P5", "M6", "M7"],
				"Natural Minor": ["P1", "M2", "m3", "P4", "P5", "m6", "m7"],
				"Harmonic Minor": ["P1", "M2", "m3", "P4", "P5", "m6", "M7"],
				"Harmonic Major":["P1","M2","M3","P4","P5","m6","M7"],
				"Double Harmonic":["P1","m2","M3","P4","P5","m6","M7"],
				"Hungarian Minor":["P1","M2","m3","A4","P5","m6","M7"],
				"Major Pentatonic":["P1","M2","M3","P5","M6"],
				"Minor Pentatonic":["P1","m3","P4","P5","m7"],
				"Blues":["P1", "m3","P4","d5","P5","m7"]}
const modes = ["Ionian", "Dorian", "Phrygian", "Lydian", "Mixolydian", "Aeolian", "Locrian"]
var sel_scale = "Major"
var sel_mode = 0
var view = "Scales"
const chord_trans = {
	"Major":"major",
	"Minor":"minor",
	"Dominant 7th":"7th",
	"Diminished":"diminished",
	"Augmented":"augmented",
	"Suspended 4th":"sus4",
	"Suspended 2nd":"sus2"
}

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for button in self.get_children():
		button.connect("selected", self, "button_selected")


func button_selected(button, degree, note_name, row, col):
	if note_name:
		sel_button = button
	else:
		sel_button = null
		
	var cur_note_name
	var base_coords = []
	var least_coord = [INF, INF]
	
	if sel_button:
		cur_note_name = sel_button.get_node("Note").text
	
	for button in self.get_children():
		button.button_selected(null, null, null, null)
		button.hide_scale()
	
	if not sel_button:
		return
	
	
	for button in self.get_children():
		button.button_selected(degree, note_name, row, col)
		if(cur_note_name == button.get_node("Note").text):
			if button.row < least_coord[0]:
				least_coord = [button.row, button.col]
			base_coords.append([button.row, button.col])

	var p8 = [2,1]
	var below_least_coord = [least_coord[0] - p8[0], least_coord[1] - p8[1]]
	base_coords.append(below_least_coord)
	var base_interval
	
	if sel_scale == "Major":
		base_interval = scales[sel_scale][sel_mode]
	else:
		base_interval = scales[sel_scale][0]
	
		
	
	for button in self.get_children():
		var b_row = button.row
		var b_col = button.col
		var mod_coords = []
		for base_coord in base_coords:
			var mod_coord = [b_row - base_coord[0], b_col - base_coord[1]]
			var interval = button.relative_int.get(mod_coord)
			if interval == base_interval:
				button.show_root()
				break
			if interval in scales[sel_scale]:
				button.show_scale()
				break
			

func set_chord(chord, state):
	for button in self.get_children():
		if state:
			button.chord_vis = chord_trans[chord]
		else:
			button.chord_vis = null
	if sel_button:
		button_selected(sel_button, sel_button.full_degree, sel_button.get_node("Note").text, sel_button.row, sel_button.col)

func set_music_scale(scale):
	sel_scale = scale
	if sel_button:
		button_selected(sel_button, sel_button.full_degree, sel_button.get_node("Note").text, sel_button.row, sel_button.col)

func set_music_mode(mode_index):
	sel_mode = mode_index
	if sel_button:
		button_selected(sel_button, sel_button.full_degree, sel_button.get_node("Note").text, sel_button.row, sel_button.col)

func _on_chkSound_toggled(button_pressed):
	for button in self.get_children():
		button.mute(not button_pressed)


func _on_chkLock_toggled(button_pressed):
	for button in self.get_children():
		button.lock(button_pressed)
