extends Node

var master_audio_bus = AudioServer.get_bus_index("Master")
var rng = RandomNumberGenerator.new()

@onready var got_fish_players = [$GotFish01, $GotFish02, $GotFish03, $GotFish04, $GotFish05, $GotFish06, $GotFish07, $GotFish08]

func is_muted():
	return AudioServer.is_bus_mute(master_audio_bus)

func toggle_mute():
	AudioServer.set_bus_mute(master_audio_bus, not is_muted())

func play_music():
	$Music.play()

func play_got_fish():
	var random_index = rng.randi_range(0, got_fish_players.size() - 1)
	got_fish_players[random_index].play()
