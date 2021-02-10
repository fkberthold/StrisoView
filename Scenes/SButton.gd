extends TextureButton

signal selected(degree)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var position = "center"
export var degree = 8
export var octave = 0
var sel_degree = null
var full_degree = null
var rounds = []
var chord_vis = {"root":true,
                    "major":true,
                    "augmented":false,
                    "minor":false,
                    "diminished":false,
                    "sus4":false,
                    "sus2":false}
const chord_colors = {"root":Color.black,
                    "major":Color.red,
                    "augmented":Color.orange,
                    "minor":Color.yellow,
                    "diminished":Color.green,
                    "sus4":Color.blue,
                    "sus2":Color.purple}
const chords = [[null, "root", null, "root"],
                [null, null, null, null],
                ["sus2", null, null, null],
                ["minor", "diminished", null, null],
                ["major", "augmented", null, null],
                ["sus4", null, null, null],
                ["diminished", null, null, null],
                ["major", "minor", "sus4", "sus2"],
                ["augmented", null, null, null],
                [null, null, null, null],
                [null, null, null, null],
                [null, null, null, null],
                [null, null, null, null]]
const intervals = ["Uni", "m2", "M2", "m3", "M3", "P4", "A4", "P5", "m6", "M6", "m7", "M7", "P8"]
const sharp_notes = ["F", "F♯", "G", "G♯", "A", "A♯", "B", "C", "C♯", "D", "D♯", "E"]
const flat_notes = ["F", "G♭", "G", "A♭", "A", "B♭", "B", "C", "D♭", "D", "E♭", "E"]

func set_note():
    if position == "left":
        $Note.text = flat_notes[degree]
    else:
        $Note.text = sharp_notes[degree]

func set_interval():
    if sel_degree == null or sel_degree > full_degree or (full_degree - sel_degree) > (len(intervals) - 1):
        $Interval.visible = false
    else:
        $Interval.visible = true
        var diff = full_degree - sel_degree
        $Interval.text = intervals[diff]

func set_chords():
    if sel_degree == null or sel_degree > full_degree or (full_degree - sel_degree) > (len(intervals) - 1):
        for cur_round in rounds:
            cur_round.visible = false
        return
    
    var cur_chord = chords[full_degree - sel_degree]
    
    for i in range(0, 4):
        if cur_chord[i] and chord_vis[cur_chord[i]]:
            rounds[i].visible = true
            rounds[i].modulate = chord_colors[cur_chord[i]]
        else:
            rounds[i].visible = false
        

# Called when the node enters the scene tree for the first time.
func _ready():
    full_degree = (octave * 12) + degree
    set_note()
    set_interval()
    rounds = [$Round1, $Round2, $Round3, $Round4]
    set_chords()
    if position == "center":
        texture_normal = load("res://Images/WhiteButton.png")
        $Note.add_color_override("font_color", Color(0,0,0))
        $Interval.add_color_override("font_color", Color(0,0,0))
    else:
        texture_normal = load("res://Images/BlackButton.png")
        $Note.add_color_override("font_color", Color(1,1,1))
        $Interval.add_color_override("font_color", Color(1,1,1))
        

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    set_interval()
    set_chords()


func _on_SButton_toggled(button_pressed):
    if button_pressed:
        emit_signal("selected", full_degree)
    else:
        emit_signal("selected", null)
        
func button_selected(new_degree):
    sel_degree = new_degree