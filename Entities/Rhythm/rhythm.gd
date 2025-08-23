class_name Rhythm extends CanvasLayer

@export var dj: DJ
@export var player: Player
@onready var line_2d: Line2D = $Line2D

var beat_scene: PackedScene = preload("res://Entities/Beat/Beat.tscn")
var track_beats = {
    "singer1tosong1.wav": {
        0.70: "none", 1.60: "none", 2.50: "none", 3.40: "none", 4.30: "none", 5.20: "none",
        5.65: "none", 6.10: "none", 6.55: "none", 7.00: "none", 7.45: "none", 7.90: "none",
        8.12: "none", 8.34: "none", 8.56: "none", 8.78: "none", 9.00: "none", 9.22: "none",
        9.44: "none", 9.66: "none", 9.88: "none", 10.10: "none", 10.32: "none", 10.54: "none",
        10.76: "none", 10.98: "none", 11.20: "none", 11.35: "none", 11.50: "none", 11.65: "none",
        11.80: "none", 11.95: "none", 12.10: "none", 12.25: "none", 12.40: "none", 12.55: "none",
        12.70: "none", 12.85: "none", 13.00: "none", 13.15: "none", 13.30: "none", 13.45: "none",
        13.60: "none", 13.75: "none", 13.90: "none", 14.05: "none"
    },
    "song1.wav": {
        #0.40: "left", 0.84: "right", 1.26: "left", 1.68: "right", 2.12: "left", 2.56: "right", 3.00: "left", 3.44: "left",
        3.87: "right", 4.30: "left", 4.74: "right", 5.17: "left", 5.61: "right", 6.06: "left", 6.50: "right", 6.91: "right",
        7.34: "left", 7.78: "right", 8.21: "left", 8.65: "right", 9.09: "left", 9.53: "right", 9.95: "left", 10.41: "left",
        10.82: "right", 11.28: "left", 11.69: "right", 12.13: "left", 12.56: "right", 12.89: "left", 13.20: "right", 13.53: "left", 13.85: "right",
        14.73: "left", 14.95: "right", 15.59: "left", 15.82: "right", 16.36: "left", 16.68: "right", 17.33: "left", 17.57: "right", 18.20: "left", 18.43: "right",
        19.07: "left", 19.31: "right", 19.93: "left", 20.18: "right", 20.80: "left", 21.04: "right", 21.93: "left",
        22.39: "right", 22.81: "left", 23.21: "right", 23.65: "left", 24.03: "right", 24.40: "left", 24.88: "right", 25.07: "left", 25.28: "right", 25.48: "left",
        25.68: "right", 25.90: "left", 26.10: "right", 26.27: "left", 26.44: "right",
        27.12: "left", 27.35: "right", 27.56: "left", 27.79: "right", 28.21: "left",
        30.61: "right", 30.89: "left", 31.18: "right", 31.50: "left", 31.83: "right",
        34.08: "left", 34.36: "right", 34.76: "left", 35.09: "right", 35.53: "left",
        37.58: "right", 37.85: "left", 38.19: "right", 38.55: "left", 38.87: "right",
        41.04: "left", 41.28: "right", 41.55: "left", 41.84: "right", 42.14: "left",
        44.54: "right", 44.86: "left", 45.16: "right", 45.45: "left", 45.81: "right",
        48.03: "left", 48.29: "right", 48.64: "left", 48.93: "right", 49.36: "left",
        51.68: "right", 51.99: "left", 52.31: "right", 52.59: "left", 52.92: "right",
        54.95: "left", 55.18: "right", 55.42: "left", 55.61: "right", 55.00: "left"
    }
}

func _ready() -> void:
    dj.track_changed.connect(_on_track_changed)
    for track_name in track_beats:
        for beat_time in track_beats[track_name]:
            create_beat(track_name, beat_time, track_beats[track_name][beat_time])

func create_beat(track_name: String, target_time: float, direction: String) -> void:
    var beat = beat_scene.instantiate() as Beat
    beat.dj = dj
    beat.player = player
    beat.init(track_name, target_time, direction)
    if direction == "none":
        add_child(beat)
    else:
        get_parent().add_child.call_deferred(beat)


func _on_track_changed(track_name: String) -> void:
    if track_name in track_beats:
        line_2d.visible = true
    else:
        line_2d.visible = false