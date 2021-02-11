extends Control


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

func button_selected(degree):
    for button in self.get_children():
        button.button_selected(degree)

func set_chord(chord, state):
    for button in self.get_children():
        print("chord: " + str(state and chord))
        if state:
            button.chord_vis = chord
        else:
            button.chord_vis = null
