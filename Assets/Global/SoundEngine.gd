extends Node

var master_audio_bus = AudioServer.get_bus_index("Master")

func play_music():
	$Music.play()

func toggle_mute():
	AudioServer.set_bus_mute(master_audio_bus, not AudioServer.is_bus_mute(master_audio_bus))	
