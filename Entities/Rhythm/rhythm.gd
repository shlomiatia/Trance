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
        14.73: "right", 14.95: "right", 15.59: "left", 15.82: "left", 16.36: "right", 16.68: "right", 17.33: "left", 17.57: "left", 18.20: "right", 18.43: "right", 19.07: "left", 19.31: "left", 19.93: "right", 20.18: "right", 20.80: "left", 21.04: "left",
        21.93: "right", 22.39: "left", 22.81: "right", 23.21: "left", 23.65: "right", 24.03: "left", 24.40: "right",
        24.88: "center", 25.07: "center", 25.28: "center", 25.48: "center", 25.68: "center", 25.90: "center", 26.10: "center", 26.27: "center", 26.44: "center",
        30.81: "right", 30.95: "right", 31.09: "right", 31.38: "left", 31.70: "right",
        34.28: "left", 34.41: "left", 34.56: "left", 34.96: "right", 35.29: "left",
        37.78: "right", 37.91: "right", 38.05: "right", 38.39: "left", 38.75: "right",
        41.44: "left", 41.56: "left", 41.68: "left", 41.95: "right", 42.24: "left",
        44.74: "right", 44.90: "right", 45.06: "right", 45.36: "left", 45.65: "right",
        48.23: "left", 48.35: "left", 48.49: "left", 48.84: "right", 49.13: "left",
        51.88: "right", 52.03: "right", 52.19: "right", 52.51: "left", 52.79: "right",
        56: "center", 57: "center", 58: "center", 59: "center",
        59.4: "center", 59.871: "center", 60.343: "center", 60.814: "center", 61.286: "center", 61.757: "center", 62.229: "center", 62.7: "center",
        63.173: "center", 63.411: "center", 63.649: "center", 63.887: "center", 64.125: "center", 64.363: "center", 64.601: "center", 64.839: "center", 65.077: "center", 65.315: "center", 65.553: "center", 65.791: "center", 66.029: "center", 66.267: "center", 66.5: "center",
        66.735: "center", 66.885: "center", 67.035: "center", 67.185: "center", 67.335: "center", 67.485: "center", 67.635: "center", 67.785: "center", 67.935: "center", 68.085: "center", 68.235: "center", 68.385: "center", 68.535: "center", 68.685: "center", 68.835: "center", 68.985: "center", 69.135: "center", 69.285: "center", 69.435: "center", 69.585: "center", 69.735: "center", 69.885: "center"
    },
    "sahi2.wav": {
        1.00: "none", 1.43: "none", 1.86: "none", 2.29: "none", 2.71: "none", 3.14: "none", 3.57: "none", 4.00: "none",
        4.32: "none", 4.64: "none", 4.95: "none", 5.27: "none", 5.59: "none", 5.91: "none", 6.23: "none", 6.55: "none", 6.86: "none", 7.18: "none",
        7.73: "none", 7.96: "none", 8.19: "none", 8.42: "none", 8.65: "none", 8.88: "none", 9.12: "none", 9.35: "none", 9.58: "none", 9.81: "none", 10.04: "none", 10.27: "none",
        10.65: "none", 10.80: "none", 10.95: "none", 11.10: "none", 11.25: "none", 11.40: "none", 11.55: "none", 11.70: "none", 11.85: "none", 12.00: "none", 12.15: "none", 12.30: "none", 12.45: "none", 12.60: "none", 12.75: "none", 12.90: "none"
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