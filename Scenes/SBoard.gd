extends Control

var sel_button = null
const scales = {"Major":["P1", "M2", "M3", "P4", "P5", "M6", "M7"],
				"Minor":["P1", "M2", "m3", "P4", "P5", "m6", "m7"]}
var sel_scale = "Major"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for button in self.get_children():
		button.connect("selected", self, "button_selected")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func button_selected(button, degree, note_name, row, col):
	if note_name:
		sel_button = button
	else:
		sel_button = null
		
	var cur_note_name
	var base_coords = []
	
	if sel_button:
		cur_note_name = sel_button.get_node("Note").text
		
	for button in self.get_children():
		button.button_selected(null, null, null, null)
		button.hide_scale()
	for button in self.get_children():
		button.button_selected(degree, note_name, row, col)
		if(cur_note_name == button.get_node("Note").text):
			button.show_root()
			base_coords.append([button.row, button.col])
	
	for button in self.get_children():
		var b_row = button.row
		var b_col = button.col
		var mod_coords = []
		for base_coord in base_coords:
			var mod_coord = [b_row - base_coord[0], b_col - base_coord[1]]
			if mod_coord == [0,0]:
				button.show_root()
				break
			var interval = button.relative_int.get(mod_coord)
			if interval in scales[sel_scale]:
				button.show_scale()
				break
			

func set_chord(chord, state):
	for button in self.get_children():
		if state:
			button.chord_vis = chord
		else:
			button.chord_vis = null

func set_music_scale(scale):
	sel_scale = scale

func display_scale(scale):
	for button in self.get_children():
		pass
		

func _on_chkSound_toggled(button_pressed):
	for button in self.get_children():
		button.mute(not button_pressed)


func _on_chkLock_toggled(button_pressed):
	for button in self.get_children():
		button.lock(button_pressed)
