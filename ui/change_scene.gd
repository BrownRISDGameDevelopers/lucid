extends CanvasLayer

const level1 = ("res://scenes/levels/new_level1.tscn")
const settingsmain = ("res://ui/settingsmain.tscn")
const mainmenu = ("res://ui/main_menu.tscn")

func change_scene(scene_path):
	%AnimationPlayer.play("fade")
	await %AnimationPlayer.animation_finished
	
	get_tree().change_scene_to_file(scene_path)
	
	%AnimationPlayer.play_backwards("fade")
