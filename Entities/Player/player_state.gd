class_name PlayerState extends RefCounted

var player: Player

func _init(p_player: Player) -> void:
	player = p_player

func enter() -> void:
	pass

func exit() -> void:
	pass

func _physics_process(_delta: float) -> void:
	pass
