extends Node

@onready var music_stream_player: AudioStreamPlayer = $MusicStreamPlayer
@onready var sfx_stream_player: AudioStreamPlayer = $SfxStreamPlayer
func bgm_play1():
	music_stream_player.stream = preload("res://music/Level1.wav")
	music_stream_player.play()
	
func bgm_play2():
	music_stream_player.stream = preload("res://music/Level2.wav")
	music_stream_player.play()
	
func bgm_play3():
	music_stream_player.stream = preload("res://music/Level3.wav")
	music_stream_player.play()

func play_tile_select():
	sfx_stream_player.stream = preload("res://sfx/path_to_final.mp3")
	sfx_stream_player.play()
	
func play_ui_select():
	sfx_stream_player.stream = preload("res://sfx/ui_select_final.mp3")
	sfx_stream_player.play()
	
func play_teleport():
	sfx_stream_player.stream = preload("res://sfx/teleport_final.mp3")
	sfx_stream_player.play()
	
func play_jump():
	sfx_stream_player.stream = preload("res://sfx/jump_final.mp3")
	sfx_stream_player.play()
