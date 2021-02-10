extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass


func _on_Major_toggled(button_pressed):
    $SBoard.set_chord("major", button_pressed)


func _on_Augmented_toggled(button_pressed):
    $SBoard.set_chord("augmented", button_pressed)


func _on_Minor_toggled(button_pressed):
    $SBoard.set_chord("minor", button_pressed)


func _on_Diminished_toggled(button_pressed):
    $SBoard.set_chord("diminished", button_pressed)


func _on_Suspended_4th_toggled(button_pressed):
    $SBoard.set_chord("sus4", button_pressed)


func _on_Suspended_2nd_toggled(button_pressed):
    $SBoard.set_chord("sus2", button_pressed)
