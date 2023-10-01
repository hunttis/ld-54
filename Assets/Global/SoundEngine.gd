extends Node

var master_audio_bus = AudioServer.get_bus_index("Master")
var rng = RandomNumberGenerator.new()

@onready var splash_players = [$Splash01, $Splash02, $Splash03, $Splash04]
@onready var got_fish_players = [$GotFish01, $GotFish02, $GotFish03, $GotFish04, $GotFish05, $GotFish06, $GotFish07, $GotFish08]
@onready var arrrrr_players = [$Arrrrr01, $Arrrrr02]
@onready var oh_no_players = [$OhNo01, $OhNo02, $OhNo03, $OhNo04, $OhNo05, $OhNo06]
@onready var thats_it_players = [$ThatsIt01, $ThatsIt02, $ThatsIt03, $ThatsIt04]

func _ready():
	rng.randomize()

func is_muted():
	return AudioServer.is_bus_mute(master_audio_bus)

func toggle_mute():
	AudioServer.set_bus_mute(master_audio_bus, not is_muted())

func play_menu_music():
	$GameMusic.stop()
	$MenuMusic.play()

func play_game_music():
	$MenuMusic.stop()
	$GameMusic.play()

func play_splash():
	var random_index = rng.randi_range(0, splash_players.size() - 1)
	splash_players[random_index].play()

func play_got_fish():
	var random_index = rng.randi_range(0, got_fish_players.size() - 1)
	got_fish_players[random_index].play()

func play_arrrrr():
	var random_index = rng.randi_range(0, arrrrr_players.size() - 1)
	arrrrr_players[random_index].play()

func play_oh_no():
	var random_index = rng.randi_range(0, oh_no_players.size() - 1)
	oh_no_players[random_index].play()

func play_thats_it():
	var random_index = rng.randi_range(0, thats_it_players.size() - 1)
	thats_it_players[random_index].play()
