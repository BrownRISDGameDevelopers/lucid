extends CanvasLayer

const level1 = ("res://scenes/levels_final/tutorial.tscn")
const settingsmain = ("res://ui/settingsmain.tscn")
const mainmenu = ("res://ui/main_menu.tscn")
const credits = ("res://ui/credits.tscn")

func change_scene(scene_path):
	%AnimationPlayer.play("fade")
	await %AnimationPlayer.animation_finished
	
	get_tree().change_scene_to_file(scene_path)
	
	%AnimationPlayer.play_backwards("fade")
