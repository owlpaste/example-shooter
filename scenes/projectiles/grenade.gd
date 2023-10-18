extends RigidBody2D


const speed: int = 500
var explosion_active: bool = false
var explosion_radius: int = 250


func explode():
	$AnimationPlayer.play("Explosion")
	linear_velocity = Vector2.ZERO
	explosion_active = true


func _process(_delta):
	if explosion_active:
		var targets = get_tree().get_nodes_in_group("Entity") + get_tree().get_nodes_in_group("Container")
		for target in targets:
			var in_range = target.global_position.distance_to(global_position) < explosion_radius
			if "hit" in target and in_range:
				target.hit()
