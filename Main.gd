extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var scale_names = []

func set_chords():
	$Chords/ChordsList.add_item("Major")
	$Chords/ChordsList.add_item("Augmented")
	$Chords/ChordsList.add_item("Minor")
	$Chords/ChordsList.add_item("Diminished")
	$Chords/ChordsList.add_item("Suspended 4th")
	$Chords/ChordsList.add_item("Suspended 2nd")
	
func set_scales():
	for scale in $SBoard.scales:
		scale_names.append(scale)
		$Scales/ScalesList.add_item(scale)



func set_modes():
	for mode in $SBoard.modes:
		$Scales/ModesList.add_item(mode)

# Called when the node enters the scene tree for the first time.
func _ready():
	set_chords()
	set_scales()
	set_modes()


func _on_Chords_item_selected(index):
	var chord_names = ["major","augmented","minor", "diminished", "sus4", "sus2"]
	$SBoard.set_chord(chord_names[index], true)

func _on_ScalesList_item_selected(index):
	$SBoard.set_music_scale(scale_names[index])
	if scale_names[index] == "Major":
		$Scales/ModesList.visible = true
	else:
		$Scales/ModesList.visible = false

func _on_ModesList_item_selected(index):
	$SBoard.set_music_mode(index)
