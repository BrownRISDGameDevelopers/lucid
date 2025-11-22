extends Node

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func bgm_play1():
	audio_stream_player.stream = preload("res://music/Level1.wav")
	audio_stream_player.play()
	
func bgm_play2():
	audio_stream_player.stream = preload("res://music/Level2.wav")
	audio_stream_player.play()
	
func bgm_play3():
	audio_stream_player.stream = preload("res://music/Level3.wav")
	audio_stream_player.play()
