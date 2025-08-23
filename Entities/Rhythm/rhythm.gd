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
        #0.40: "right", 0.84: "left", 1.26: "right", 1.68: "left", 2.12: "right", 2.56: "left", 3.00: "right", 3.44: "right",
        3.87: "left", 4.30: "right", 4.74: "left", 5.17: "right", 5.61: "left", 6.06: "right", 6.50: "left", 6.91: "left",
        7.34: "right", 7.78: "left", 8.21: "right", 8.65: "left", 9.09: "right", 9.53: "left", 9.95: "right", 10.41: "right",
        10.82: "left", 11.28: "right", 11.69: "left", 12.13: "right", 12.56: "left", 12.89: "right", 13.20: "left", 13.53: "right", 13.85: "left",
        14.73: "right", 14.95: "left", 15.59: "right", 15.82: "left", 16.36: "right", 16.68: "left", 17.33: "right", 17.57: "left", 18.20: "right", 18.43: "left",
        19.07: "right", 19.31: "left", 19.93: "right", 20.18: "left", 20.80: "right", 21.04: "left", 21.93: "right",
        22.39: "left", 22.81: "right", 23.21: "left", 23.65: "right", 24.03: "left", 24.40: "right", 24.88: "left", 25.07: "right", 25.28: "left", 25.48: "right",
        25.68: "left", 25.90: "right", 26.10: "left", 26.27: "right", 26.44: "left",
        27.12: "right", 27.35: "left", 27.56: "right", 27.79: "left", 28.21: "right",
        30.61: "left", 30.89: "right", 31.18: "left", 31.50: "right", 31.83: "left",
        34.08: "right", 34.36: "left", 34.76: "right", 35.09: "left", 35.53: "right",
        37.58: "left", 37.85: "right", 38.19: "left", 38.55: "right", 38.87: "left",
        41.04: "right", 41.28: "left", 41.55: "right", 41.84: "left", 42.14: "right",
        44.54: "left", 44.86: "right", 45.16: "left", 45.45: "right", 45.81: "left",
        48.03: "right", 48.29: "left", 48.64: "right", 48.93: "left", 49.36: "right",
        51.68: "left", 51.99: "right", 52.31: "left", 52.59: "right", 52.92: "left",
        54.95: "right", 55.18: "left", 55.42: "right", 55.61: "left", 55.00: "right"
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