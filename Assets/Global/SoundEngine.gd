extends Node

var master_audio_bus = AudioServer.get_bus_index("Master")
var rng = RandomNumberGenerator.new()

@onready var splash_players = [$Splash01, $Splash02, $Splash03, $Splash04]
@onready var got_fish_players = [$GotFish01, $GotFish02, $GotFish03, $GotFish04, $GotFish05, $GotFish06, $GotFish07, $GotFish08]
@onready var arrrrr_players = [$Arrrrr01, $Arrrrr02]

func _ready():
	rng.randomize()

func is_muted():
	return AudioServer.is_bus_mute(master_audio_bus)

func toggle_mute():
	AudioServer.set_bus_mute(master_audio_bus, not is_muted())

func play_music():
	$Music.play()

func play_splash():
	var random_index = rng.randi_range(0, splash_players.size() - 1)
	splash_players[random_index].play()

func play_got_fish():
	var random_index = rng.randi_range(0, got_fish_players.size() - 1)
	got_fish_players[random_index].play()

func play_arrrrr():
	var random_index = rng.randi_range(0, arrrrr_players.size() - 1)
	arrrrr_players[random_index].play()
