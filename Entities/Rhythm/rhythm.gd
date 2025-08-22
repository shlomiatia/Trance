class_name Rhythm extends CanvasLayer

@export var dj: DJ
@onready var line_2d: Line2D = $Line2D

var beat_scene: PackedScene = preload("res://Entities/Beat/beat.tscn")
var track_beats = {
    "singer1tosong1.wav": [0.5, 1.6, 2.5, 3.4, 4.3, 5.2, 5.65, 6.1, 6.55, 7.0, 7.45, 7.9, 8.12, 8.34, 8.56, 8.78, 9.00, 9.22, 9.44, 9.66, 9.88, 10.10, 10.32, 10.54, 10.76, 10.98, 11.20, 11.35, 11.50, 11.65, 11.80, 11.95, 12.10, 12.25, 12.40, 12.55, 12.70, 12.85, 13.00, 13.15, 13.30, 13.45, 13.60, 13.75, 13.90, 14.05, 14.20]
}

func _ready() -> void:
    line_2d.visible = true
    dj.track_changed.connect(_on_track_changed)

func _on_track_changed(track_name: String) -> void:
    if track_beats.has(track_name):
        for beat_time in track_beats[track_name]:
            create_beat(beat_time)

func create_beat(target_time: float) -> void:
    var beat = beat_scene.instantiate() as Beat
    beat.dj = dj
    beat.target_time = target_time
    add_child(beat)
