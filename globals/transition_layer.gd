extends CanvasLayer


func change_scene(target: String) -> void:
	fade_to_black()
	get_tree().change_scene_to_file(target)
	reveal()


func fade_to_black() -> void:
	$AnimationPlayer.play("fade_to_black")
	await $AnimationPlayer.animation_finished


func reveal() -> void:
	$AnimationPlayer.play_backwards("fade_to_black")
