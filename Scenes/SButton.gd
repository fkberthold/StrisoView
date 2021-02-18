extends TextureButton

signal selected(degree, note, row, col)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var position = "center"
export var degree = 8
export var octave = 0
export var row = 0
export var col = 0
var sel_row = null
var sel_col = null
var sel_degree = null
var sel_note= null
var full_degree = null
var chord_vis = "major"
var scale_vis = "Major"
var voice = null
var mute = true
var lock = false

const pitches = {"C":1,
				 "C♯":1.059463,
				 "D♭":1.059463,
				 "D":1.122462,
				 "D♯":1.189207,
				 "E♭":1.189207,
				 "E":1.259921,
				 "F":1.33484,
				 "F♯":1.414214,
				 "G♭":1.414214,
				 "G":1.498307,
				 "G♯":1.587401,
				 "A♭":1.587401,
				 "A":1.681793,
				 "A♯":1.781797,
				 "B♭":1.781797,
				 "B":1.887749}

const chord_colors = {"root":Color.black,
					"major":Color.red,
					"augmented":Color.red,
					"minor":Color.red,
					"diminished":Color.red,
					"sus4":Color.red,
					"sus2":Color.red}
					
const relative_int =   {[0,0]:"P1",
						[1,0]:"P4",
						[1,1]:"P5",
						[2,1]:"P8",
						[0,1]:"M2",
						[0,2]:"M3",
						[1,2]:"M6",
						[1,3]:"M7",
						[-1,3]:"A1",
						[-1,4]:"A2",
						[-1,5]:"A3",
						[0,3]:"A4",
						[0,4]:"A5",
						[0,5]:"A6",
						[0,6]:"A7",
						[-2,6]:"AA1",
						[-2,7]:"AA2",
						[-1,6]:"AA4",
						[-1,7]:"AA5",
						[0,7]:"AA8",
						[1,-2]:"m2",
						[1,-1]:"m3",
						[2,-1]:"m6",
						[2,0]:"m7",
						[2,-5]:"d2",
						[2,-4]:"d3",
						[2,-3]:"d4",
						[2,-2]:"d5",
						[3,-4]:"dd6",
						[3,-3]:"d7",
						[3,-2]:"d8",
						[3,-6]:"dd4",
						[3,-5]:"dd5",
						[4,-6]:"dd7"}
						

const order = ["G♭", "D♭", "A♭", "E♭", "B♭", 
			   "F", "C",  "G", "D", "A", "E", "B", 
			   "F♯", "C♯", "G♯", "D♯", "A♯"]

const chords = {"major":["P1","P5","M3"],
				"augmented":["P1","M3","A5"],
				"minor":["P1", "P5", "m3"],
				"diminished":["P1","m3", "d5"],
				"sus4":["P1", "P4", "P5"],
				"sus2":["P1", "M2", "P5"]}
			 

const intervals = ["Uni", "m2", "M2", "m3", "M3", "P4", "A4", "P5", "m6", "M6", "m7", "M7", "P8"]
const sharp_notes = ["F", "F♯", "G", "G♯", "A", "A♯", "B", "C", "C♯", "D", "D♯", "E"]
const flat_notes = ["F", "G♭", "G", "A♭", "A", "B♭", "B", "C", "D♭", "D", "E♭", "E"]

func get_interval():
	if sel_note == null:
		return null
	var diff_coord = [row - sel_row,
					  col - sel_col]
	return relative_int.get(diff_coord)

func set_note():
	if position == "left":
		$Note.text = flat_notes[degree]
	else:
		$Note.text = sharp_notes[degree]

func set_interval():
	var interval = get_interval()
	if interval:
		$Interval.visible = true
		$Interval.text = interval
	else:
		$Interval.visible = false
		$Round1.visible = false

func set_chords():
	if chord_vis and $Interval.visible and $Interval.text in chords[chord_vis]:
		if full_degree == sel_degree:
			$Round1.visible = true
			$Round1.modulate = chord_colors["root"]
			return
		else:
			$Round1.visible = true
			$Round1.modulate = chord_colors[chord_vis]
	else:
		$Round1.visible = false
		

# Called when the node enters the scene tree for the first time.
func _ready():
	full_degree = (octave * 12) + degree
	set_note()
	set_interval()
	set_chords()
	if position == "center":
		texture_normal = load("res://Images/WhiteButton.png")
		$Note.add_color_override("font_color", Color(0,0,0))
		$Interval.add_color_override("font_color", Color(0,0,0))
	else:
		texture_normal = load("res://Images/BlackButton.png")
		$Note.add_color_override("font_color", Color(1,1,1))
		$Interval.add_color_override("font_color", Color(1,1,1))
	set_audio()
	
func set_audio():
	voice = AudioStreamPlayer.new()
	var audio_file = "res://Sounds/StrLoop - C" + str(octave + 1) + ".ogg"
	if File.new().file_exists(audio_file):
		var sfx = load(audio_file) 
		voice.stream = sfx
	voice.pitch_scale = pitches[$Note.text]
	add_child(voice)

func _on_SButton_toggled(_button_pressed):
	if lock:
		return
	if full_degree != sel_degree:
		emit_signal("selected", self, full_degree, $Note.text, row, col)
	else:
		emit_signal("selected", self, null, null, null, null)

func button_selected(new_degree, note_name, new_row, new_col):
	sel_degree = new_degree
	sel_note = note_name
	sel_row = new_row
	sel_col = new_col
	set_interval()
	set_chords()

func mute(is_on):
	mute = is_on
	
func lock(is_on):
	lock = is_on
	
func show_root():
	$Scale.visible = true
	$Scale.modulate = Color(0, 0, 1)

func show_scale():
	$Scale.visible = true
	$Scale.modulate = Color(0, 0, 1, 0.39)
	
func hide_scale():
	$Scale.visible = false

func _on_SButton_button_down():
	if not mute:
		voice.playing = true
	
func _on_SButton_button_up():
	voice.playing = false
