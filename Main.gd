extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func set_chords():
	$Chords/ChordsList.add_item("Major")
	$Chords/ChordsList.add_item("Augmented")
	$Chords/ChordsList.add_item("Minor")
	$Chords/ChordsList.add_item("Diminished")
	$Chords/ChordsList.add_item("Suspended 4th")
	$Chords/ChordsList.add_item("Suspended 2nd")
	
func set_scales():
	$Scales/ScalesList.add_item("Major")
	$Scales/ScalesList.add_item("Minor")
	
func set_modes():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	set_chords()
	set_scales()
	set_modes()



func _on_Chords_item_selected(index):
	var chord_names = ["major","augmented","minor", "diminished", "sus4", "sus2"]
	$SBoard.set_chord(chord_names[index], true)

func _on_ScalesList_item_selected(index):
	var scale_names = ["Major", "Minor"]
	$SBoard.set_music_scale(scale_names[index])
