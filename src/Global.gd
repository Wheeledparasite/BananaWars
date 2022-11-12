extends Node

const GAME_TITLE := "Banana Wars"

const AIR_FRICTION := 10.0
const FLOOR_SLOPE_MAX_THRESHOLD := deg2rad(60)
const FLOOR_FRICTION := 60.0
const GRAVITY := -40.0
const MOUSE_SENSITIVITY := 0.1
const MOUSE_ACCELERATION_X := 10.0
const MOUSE_ACCELERATION_Y := 10.0
const MOUSE_Y_MAX := 70.0
const MOUSE_Y_MIN := -60.0

var _rng : RandomNumberGenerator
var _root_node : Node

onready var _scene_bullet := ResourceLoader.load("res://src/Bullet/Bullet.tscn")
onready var _scene_bullet_glow := ResourceLoader.load("res://src/Bullet/BulletGlow.tscn")
onready var _scene_bullet_spark := ResourceLoader.load("res://src/Bullet/BulletSpark.tscn")


func create_bullet(parent : Node, start_pos : Vector3, target_pos : Vector3, bullet_type : int) -> void:
	var bullet = _scene_bullet.instance()
	parent.add_child(bullet)
	bullet.global_transform.origin = start_pos
	bullet.look_at(target_pos, Vector3.FORWARD)
	bullet.start(bullet_type)

func create_bullet_spark(pos : Vector3) -> void:
	var spark = _scene_bullet_spark.instance()
	Global._root_node.add_child(spark)
	spark.global_transform.origin = pos

enum Layers {
	terrain,
	item,
	player,
}

enum BulletType {
	_50BMG,
	_308,
	_556,
	_45,
	_9MM,
	_762,
	_12Gauge,
}

enum Element {
	Concrete,
	Steel,
	Glass,
	Plastic,
	Rubber,
	Aluminum,
}

var DB = {
	"Bullets" : {
		BulletType._50BMG : {
			"mass" : 0.023,
			"speed" : 1219.0,
			"max_distance" : 5000.0,
		},
		BulletType._308 : {
			"mass" : 0.018,
			"speed" : 1219.0,
			"max_distance" : 5000.0,
		},
		BulletType._556 : {
			"mass" : 0.016,
			"speed" : 1219.0,
			"max_distance" : 5000.0,
		},
		BulletType._45 : {
			"mass" : 0.0099,
			"speed" : 300.0,
			"max_distance" : 2000.0,
		},
		BulletType._9MM : {
			"mass" : 0.0075,
			"speed" : 400.0,
			"max_distance" : 2000.0,
		},
		BulletType._762 : {
			"mass" : 0.025,
			"speed" : 950.0,
			"max_distance" : 5000.0,
		},
		BulletType._12Gauge : {
			"mass" : 0.0025,
			"speed" : 200.0,
			"max_distance" : 500.0,
		},
	}
}

func _ready() -> void:
	# Setup random number generator
	_rng = RandomNumberGenerator.new()
	_rng.randomize()

func distance_between(v1 : Vector3, v2 : Vector3) -> float:
	var dx := v1.x - v2.x
	var dy := v1.y - v2.y
	var dz := v1.z - v2.z
	return sqrt(dx * dx + dy * dy + dz * dz)

