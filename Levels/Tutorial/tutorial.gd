class_name Tutorial extends Node2D

@onready var player: Player = $Player
@onready var label: RichTextLabel = $CanvasLayer/Label
@onready var ground: StaticBody2D = $Ground
@onready var dj: DJ = $DJ

var _step_timer: float = 0.0
var _tutorial_step := 0

func _ready() -> void:
    dj.track_changed.connect(_on_track_changed)
    dj.playlist_finished.connect(func():
        get_tree().change_scene_to_file("res://Levels/Main/Main.tscn")
    )
    label.text = "AD/arrows/gamepad to walk"

func _process(delta: float) -> void:
    if _tutorial_step == 0:
        if player._current_state is PlayerStateWalk:
            _step_timer += delta

        if _step_timer > 1.0:
            _tutorial_step += 1
            _step_timer = 0.0
            dj.advance_track()
            label.text = "Hit shift/left mouse button/gamepad x on the beat"
            player.change_state(PlayerStateEnum.Type.SPRINT)


func _on_track_changed(track_name: String) -> void:
    if track_name == "tutorial1.5.wav":
        label.hide()
        label.text = "Hit space/right mouse button/gamepad a"
    if track_name == "tutorial2.wav":
        label.text = "Hit direction + shift/left mouse button/gamepad x on the beat"
