extends Node

var master_audio_bus = AudioServer.get_bus_index("Master")

func play_music():
	$Music.play()

func is_muted():
	return AudioServer.is_bus_mute(master_audio_bus)

func toggle_mute():
	AudioServer.set_bus_mute(master_audio_bus, not is_muted())
