class_name Player extends CharacterBody2D


func _physics_process(delta: float) -> void:
    if not is_on_floor():
        velocity += get_gravity() * delta

    var direction := Input.get_axis("left", "right")
    if direction:
        velocity.x = direction * Constants.player_speed
    else:
        velocity.x = move_toward(velocity.x, 0, Constants.player_speed)

    move_and_slide()
