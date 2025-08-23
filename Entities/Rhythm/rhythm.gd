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
        3.87: "right", 4.30: "left", 4.74: "right", 5.17: "left", 5.61: "right", 6.06: "left", 6.50: "right", 6.91: "right",
        7.34: "left", 7.78: "right", 8.21: "left", 8.65: "right", 9.09: "left", 9.53: "right", 9.95: "left", 10.41: "left",
        10.82: "right", 11.28: "left", 11.69: "right", 12.13: "left", 12.56: "right",
        14.73: "left", 14.95: "right", 15.59: "left", 15.82: "right", 16.36: "left", 16.68: "right", 17.33: "left", 17.57: "right", 18.20: "left", 18.43: "right", 19.07: "left", 19.31: "right", 19.93: "left", 20.18: "right", 20.80: "left", 21.04: "right",
        21.93: "left", 22.39: "right", 22.81: "left", 23.21: "right", 23.65: "left", 24.03: "right", 24.40: "left",
        24.88: "center", 25.07: "center", 25.28: "center", 25.48: "center", 25.68: "center", 25.90: "center", 26.10: "center", 26.27: "center", 26.44: "center",
        30.81: "right", 31.09: "left", 31.38: "right", 31.70: "left",
        34.28: "left", 34.56: "right", 34.96: "left", 35.29: "right",
        37.78: "right", 38.05: "left", 38.39: "right", 38.75: "left",
        41.34: "left", 41.58: "right", 41.85: "left", 42.14: "right",
        44.74: "right", 45.06: "left", 45.36: "right", 45.65: "left",
        48.23: "left", 48.49: "right", 48.84: "left", 49.13: "right",
        51.88: "right", 52.19: "left", 52.51: "right", 52.79: "left",
        56: "center", 57: "center", 58: "center", 59: "center",
        59.4: "center", 59.8: "center", 60.2: "center", 60.6: "center", 61: "center", 61.4: "center", 61.8: "center", 62.2: "center",
        62.733: "center", 62.967: "center", 63.2: "center", 63.433: "center", 63.667: "center", 63.9: "center", 64.133: "center", 64.367: "center", 64.6: "center", 64.833: "center", 65.067: "center", 65.3: "center", 65.533: "center", 65.767: "center", 66.0: "center",
        66.15: "center", 66.3: "center", 66.45: "center", 66.6: "center", 66.75: "center", 66.9: "center", 67.05: "center", 67.2: "center", 67.35: "center", 67.5: "center", 67.65: "center", 67.8: "center", 67.95: "center", 68.1: "center", 68.25: "center", 68.4: "center", 68.55: "center", 68.7: "center", 68.85: "center", 69.0: "center"
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