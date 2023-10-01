extends ParallaxLayer

var rng = RandomNumberGenerator.new()
var RotateSpeed = rng.randf_range(0.7, 1.3)
var Radius = rng.randf_range(15, 35)
var _centre
var _angle = 0

func rotation( _angle,Radius,_centre):
	var offset = Vector2(sin(_angle), cos(_angle)) * Radius;
	var pos = _centre + offset
	return pos 

func _ready():
	_centre = self.position

func _process(delta): 
	_angle += RotateSpeed * delta;
	self.position = rotation(_angle,Radius,_centre)
