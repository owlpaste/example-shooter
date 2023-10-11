extends CharacterBody2D


signal laser_shot(pos, direction)
signal grenade_thrown(pos, direction)

var can_laser: bool = true
var can_grenade: bool = true

@export var max_speed: int = 500
var speed: int = max_speed


func _process(_delta):

	var direction := Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()

	look_at(get_global_mouse_position())
	
	var player_direction = get_player_direction()
	if (Input.is_action_pressed("primary action") and can_laser and Globals.laser_amount):
		Globals.laser_amount -= 1
		$GPUParticles2D.emitting = true
		can_laser = false
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]
		$TimerLaser.start()
		laser_shot.emit(selected_laser.global_position, player_direction)

	if (Input.is_action_pressed("secondary action") and can_grenade and Globals.grenade_amount):
		Globals.grenade_amount -= 1
		can_grenade = false
		var grenade_markers = $GrenadeStartPositions.get_children()
		var selected_grenade = grenade_markers[randi() % grenade_markers.size()]
		$TimerGrenade.start()
		grenade_thrown.emit(selected_grenade.global_position, player_direction)


func _on_timer_laser_timeout():
	can_laser = true


func _on_timer_grenade_timeout():
	can_grenade = true


func get_player_direction():
	return (get_global_mouse_position() - position).normalized()
