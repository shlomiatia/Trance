class_name Bird extends Node2D

@export var dj: DJ

func _ready() -> void:
    dj.track_changed.connect(_on_track_changed)

func _on_track_changed(track_name: String) -> void:
    if track_name == "singer2tosong3.wav":
        $AnimationPlayer.play("Default")