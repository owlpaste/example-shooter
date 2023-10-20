extends CharacterBody2D

var active: bool = false
var vulnerable: bool = true
var max_speed: int = 600
var speed: int = 0
var speed_Multiplier: int = 1
var health: int = 50
var explosion_active: bool = false
var explosion_radius: int = 250


func _ready():
	$Explosion.hide()
	$Sprite2D.show()


func _process(delta):
	if active:
		look_at(Globals.player_pos)
		var direction = (Globals.player_pos - position).normalized()
		velocity = direction * speed * speed_Multiplier
		var collision = move_and_collide(velocity * delta)
		if collision:
			$AnimationPlayer.play("explosion")
			explosion_active = true
	if explosion_active:
		var targets = get_tree().get_nodes_in_group("Entity") + get_tree().get_nodes_in_group("Container")
		for target in targets:
			var in_range = target.global_position.distance_to(global_position) < explosion_radius 
			if "hit" in target and in_range:
				target.hit()

func hit():
	if vulnerable:
		$Sprite2D.material.set_shader_parameter("progress", 1)
		health -= 10
		vulnerable = false
		$HitTimer.start()
		if health <= 0:
			explosion_active = true
			$AnimationPlayer.play("explosion")


func stop_movement():
	speed_Multiplier = 0


func _on_notice_area_body_entered(_body):
	active = true
	var tween = create_tween()
	tween.tween_property(self, "speed", max_speed, 6)


func _on_hit_timer_timeout():
	vulnerable = true
	$Sprite2D.material.set_shader_parameter("progress", 0)
