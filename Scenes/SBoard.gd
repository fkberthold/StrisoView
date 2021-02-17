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

func button_selected(degree, note_name, row, col):
    print([degree, note_name, row, col])
    for button in self.get_children():
        button.button_selected(null, null, null, null)
    for button in self.get_children():
        button.button_selected(degree, note_name, row, col)
    print("=========================")

func set_chord(chord, state):
    for button in self.get_children():
        if state:
            button.chord_vis = chord
        else:
            button.chord_vis = null

func set_music_scale(scale, state):
    for button in self.get_children():
        if state:
            button.scale_vis = scale
        else:
            button.scale_vis = null

func _on_chkSound_toggled(button_pressed):
    for button in self.get_children():
        button.mute(not button_pressed)


func _on_chkLock_toggled(button_pressed):
    for button in self.get_children():
        button.lock(button_pressed)
