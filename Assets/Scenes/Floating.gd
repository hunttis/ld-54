extends "res://Assets/Scenes/Item.gd"

var _centre
var RotateSpeed = 1
var Radius = 5
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
