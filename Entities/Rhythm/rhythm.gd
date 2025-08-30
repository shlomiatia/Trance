class_name Rhythm extends CanvasLayer

@export var dj: DJ
@export var player: Player

var beat_scene: PackedScene = preload("res://Entities/Beat/Beat.tscn")
var track_stats = {}
var track_beats = {
    "tutorial1.wav": {
        1.4: "none", 1.85: "none", 2.30: "none", 2.75: "none", 3.20: "none", 3.65: "none", 4.10: "none", 4.55: "none",
    },
    "tutorial2.wav": {
        1.9: "left", 2.20: "right", 2.70: "left", 3.10: "right", 3.5: "left", 3.90: "right"
    },
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
    },
    "song2.wav": {
        4.44: "right", 4.86: "left", 5.30: "right", 5.73: "left", 6.18: "right", 6.60: "left", 7.05: "right", 7.50: "right",
        7.91: "left", 8.34: "right", 8.77: "left", 9.21: "right", 9.64: "left", 10.08: "right", 10.53: "center",
        11.38: "right", 11.82: "left", 12.25: "right", 12.69: "left",
        14.00: "right", 14.45: "right",
        14.87: "left", 15.31: "right", 15.73: "left", 16.18: "right", 16.60: "left", 17.05: "right", 17.48: "center", 17.93: "left",
        18.34: "right", 18.78: "left", 19.21: "right", 19.65: "left", 20.09: "right", 20.52: "left", 20.96: "right", 21.41: "right", 21.82: "left",
        22.26: "right", 22.69: "left", 23.13: "right", 23.56: "left", 24.06: "right", 24.44: "center", 24.89: "left",
        28.79: "right", 29.22: "right", 29.64: "right", 30.09: "right", 30.52: "right", 30.96: "right", 31.38: "right", 31.83: "right",
        32.26: "left", 32.69: "left", 33.13: "left", 33.57: "left", 34.00: "left", 34.44: "left", 34.86: "left", 35.31: "left",
        35.74: "right", 36.17: "right", 36.60: "right", 37.05: "right", 37.47: "right", 37.92: "right", 38.34: "right", 38.78: "right",
        39.22: "left", 39.64: "right", 40.09: "left", 40.52: "right",
        42.70: "left", 43.13: "left", 43.57: "left", 44.00: "left", 44.44: "left", 44.87: "left", 45.29: "left", 45.74: "left",
        46.18: "right", 46.60: "right", 47.04: "right", 47.48: "right", 47.91: "right", 48.35: "right", 48.78: "right",
        49.64: "center", 49.96: "center", 50.23: "center", 50.52: "center", 50.85: "center", 51.12: "center", 51.39: "center", 51.72: "center", 51.99: "center", 52.26: "center", 52.5: "center",
        53.00: "center", 53.23: "center", 53.45: "center", 53.68: "center", 53.91: "center", 54.14: "center", 54.36: "center", 54.59: "center", 54.82: "center", 55.05: "center", 55.27: "center", 55.59: "center", 55.81: "center", 56.03: "center"
    },
    "singer2tosong3.wav": {
        0.50: "none", 0.89: "none", 1.28: "none", 1.67: "none", 2.06: "none", 2.44: "none", 2.83: "none", 3.22: "none", 3.61: "none", 4.00: "none", 4.32: "none", 4.64: "none", 4.95: "none", 5.27: "none", 5.59: "none", 5.91: "none", 6.23: "none", 6.55: "none", 6.86: "none", 7.18: "none", 7.50: "none", 7.79: "none", 8.08: "none", 8.38: "none", 8.67: "none", 8.96: "none", 9.25: "none", 9.54: "none", 9.83: "none", 10.12: "none", 10.42: "none", 10.71: "none", 11.00: "none", 11.25: "none", 11.50: "none", 11.75: "none", 12.00: "none", 12.25: "none", 12.50: "none", 12.75: "none", 13.00: "none", 13.25: "none", 13.50: "none", 13.75: "none", 14.00: "none", 14.25: "none", 14.50: "none", 14.75: "none", 15.00: "none", 15.25: "none", 15.50: "none", 15.75: "none", 16.00: "none", 16.25: "none", 16.50: "none", 16.75: "none", 17.00: "none", 17.25: "none", 17.50: "none", 17.69: "none", 17.89: "none", 18.08: "none", 18.28: "none", 18.47: "none", 18.67: "none", 18.86: "none", 19.06: "none", 19.25: "none", 19.44: "none", 19.64: "none", 19.83: "none", 20.03: "none", 20.22: "none", 20.42: "none", 20.61: "none", 20.81: "none", 21.00: "none", 21.16: "none", 21.32: "none", 21.48: "none", 21.64: "none", 21.80: "none", 21.95: "none", 22.11: "none", 22.27: "none", 22.43: "none", 22.59: "none", 22.75: "none", 22.91: "none", 23.07: "none", 23.23: "none", 23.39: "none", 23.55: "none", 23.70: "none", 23.86: "none", 24.02: "none", 24.18: "none", 24.34: "none", 24.50: "none", 24.65: "none", 24.81: "none", 24.96: "none", 25.12: "none", 25.27: "none", 25.42: "none", 25.58: "none", 25.73: "none", 25.88: "none", 26.04: "none", 26.19: "none", 26.35: "none", 26.50: "none", 26.65: "none", 26.81: "none", 26.96: "none", 27.12: "none", 27.27: "none", 27.42: "none", 27.58: "none", 27.73: "none", 27.88: "none", 28.04: "none", 28.19: "none", 28.35: "none", 28.50: "none"
    },
    "song3.wav": {
        1.82: "right", 2.36: "left", 2.79: "right", 3.23: "left", 3.66: "right", 4.10: "left", 4.53: "right", 4.99: "center", 5.42: "left", 5.84: "right", 6.27: "left", 6.71: "right", 7.14: "left", 7.58: "right", 8.01: "left",
        8.88: "right", 9.32: "left", 9.75: "right", 10.19: "left", 10.62: "right", 11.06: "left", 11.49: "right", 11.95: "center", 12.38: "left", 12.79: "right", 13.23: "left", 13.66: "right", 14.10: "left", 14.42: "right",
        15.73: "left", 16.28: "right", 16.71: "left", 17.12: "right", 17.58: "left", 18.02: "right", 18.45: "center", 18.88: "left", 19.32: "right", 19.75: "left", 20.19: "right", 20.62: "left", 21.06: "right", 21.38: "left", 21.88: "right", 22.30: "right",
        22.77: "left", 23.23: "right", 23.67: "left", 24.08: "right", 24.54: "left", 24.97: "right", 25.38: "center", 25.82: "left", 26.27: "right", 26.71: "left", 27.15: "right", 27.58: "left", 28.9: "center",
        29.73: "right", 30.19: "left", 30.62: "right", 30.96: "left", 31.49: "right", 31.93: "left", 32.36: "center", 32.79: "right", 33.23: "left", 33.67: "right", 34.10: "left", 34.54: "right", 34.97: "left", 35.40: "right", 35.80: "left", 36.15: "left",
        36.69: "right", 37.14: "left", 37.58: "right", 38.01: "left", 38.45: "right", 38.88: "left", 39.32: "center", 39.75: "right", 40.14: "left", 40.62: "right", 41.06: "left", 41.49: "right",
        42.9: "center", 43.35: "center", 43.8: "center",
        46.3: "center", 46.75: "center", 47.2: "center",
        49.5: "center", 49.95: "center",
        50.5: "center", 51.4: "center", 52.3: "center", 53.2: "center",
        54.3: "center", 54.69: "center", 55.08: "center", 55.47: "center", 55.86: "center", 56.25: "center", 56.64: "center", 57.03: "center",
        57.5: "center", 57.65: "center", 57.8: "center", 57.95: "center", 58.1: "center", 58.25: "center", 58.4: "center", 58.55: "center", 58.7: "center", 58.85: "center", 59: "center", 59.15: "center", 59.3: "center", 59.45: "center", 59.6: "center", 59.75: "center", 59.9: "center", 60.05: "center", 60.2: "center", 60.35: "center", 60.5: "center", 60.65: "center", 60.8: "center", 60.95: "center", 61.1: "center", 61.25: "center", 61.4: "center", 61.55: "center", 61.7: "center", 61.85: "center", 62: "center", 62.15: "center", 62.3: "center", 62.45: "center", 62.6: "center", 62.75: "center", 62.9: "center", 63: "center",
        63.1: "center", 63.2: "center", 63.3: "center", 63.4: "center", 63.5: "center", 63.6: "center", 63.7: "center", 63.8: "center", 63.9: "center", 64: "center"
    }
}

func _ready() -> void:
    for track_name in track_beats:
        create_track_beats(track_name)

func create_track_beats(track_name: String) -> void:
    track_stats[track_name] = 0
    for beat_time in track_beats[track_name]:
        create_beat(track_name, beat_time, track_beats[track_name][beat_time])

func create_beat(track_name: String, target_time: float, direction: String) -> void:
    var beat = beat_scene.instantiate() as Beat
    beat.dj = dj
    beat.player = player
    beat.init(track_name, target_time, direction)
    beat.beat_result.connect(_on_beat_result)
    if direction == "none":
        add_child(beat)
    else:
        get_parent().add_child.call_deferred(beat)

func get_total_beats(track_name: String) -> int:
    return track_beats[track_name].keys().size()

func _on_beat_result(track_name: String) -> void:
    track_stats[track_name] += 1