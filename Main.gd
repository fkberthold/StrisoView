extends Control
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var scale_names = []
var button_group

func set_chords():
	var button = load("res://Scenes/SelectButton.tscn")
	for chord in $SBoard.chord_trans:
		var chordBtn = button.instance()
		if not button_group:
			button_group = chordBtn.group
		else:
			chordBtn.group = button_group
		chordBtn.text = chord
		chordBtn.connect("toggled", self, "Chord_selected")
		$Chords.add_child(chordBtn)

func set_scales():
	var button = load("res://Scenes/SelectButton.tscn")
	for scale in $SBoard.scales:
		var scaleBtn = button.instance()
		scaleBtn.group = button_group
		scaleBtn.text = scale
		scaleBtn.connect("toggled", self, "Scale_selected")
		$Scales.add_child(scaleBtn)
	$Scales.get_child(0).pressed = true
		
func set_views():
	$View.add_item("Scales")
	$View.add_item("Chords")

# Called when the node enters the scene tree for the first time.
func _ready():
	set_chords()
	set_scales()
	set_views()

func Scale_selected(_selected):
	for scaleBtn in $Scales.get_children():
		if scaleBtn.pressed:
			$SBoard.set_music_scale(scaleBtn.text)
	
func Chord_selected(_selected):
	for chordBtn in $Chords.get_children():
		if chordBtn.pressed:
			$SBoard.set_chord(chordBtn.text, true)

func _on_View_item_selected(index):
	if index == 0:
		$Scales.visible = true
		$Chords.visible = false
		$Scales.get_child(0).pressed = true
		$SBoard.view = "Scales"
		$SBoard.set_music_scale($Scales.get_child(0).text)
	else:
		$Chords.visible = true
		$Scales.visible = false
		$SBoard.view = "Chords"
		$Chords.get_child(0).pressed = true
		$SBoard.set_chord($Chords.get_child(0).text, true)
	for button in $SBoard.get_children():
		button.sel_view = $SBoard.view
