extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    $Chords/ChordsList.add_item("Major")
    $Chords/ChordsList.add_item("Augmented")
    $Chords/ChordsList.add_item("Minor")
    $Chords/ChordsList.add_item("Diminished")
    $Chords/ChordsList.add_item("Suspended 4th")
    $Chords/ChordsList.add_item("Suspended 2nd")



func _on_Chords_item_selected(index):
    var chord_names = ["major","augmented","minor", "diminished", "sus4", "sus2"]
    $SBoard.set_chord(chord_names[index], true)
