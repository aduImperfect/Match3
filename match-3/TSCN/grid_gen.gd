extends Node2D

const BACKGROUND_SCENE = preload("res://TSCN/background.tscn")
const JEWEL_SCENE = preload("res://TSCN/jewel.tscn")

@export var textureJewels : Array[Texture]


@export var groundNum : int = 0
@export var groundDiv : int = 0
@export var groundArr : Array[Node2D] = []

@export var jewelNum : int = 0
@export var jewelCount : int = 0
@export var jewelArr : Array[Node2D] = []
@export var jewelTextureValArr : Array[int] = []

@export var infiniteXVal : float = 0.0
@export var infiniteYVal : float = 0.0

@export var xBeginOffset : float = 0.0
@export var yBeginOffset : float = 0.0
@export var xOffset : float = 0.0
@export var yOffset : float = 0.0

@export var initial_spawning : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	groundNum = 200
	groundDiv = 20

	jewelNum = groundNum - ((2 * groundDiv) + (int(groundNum / float(groundDiv)) - 2))
	jewelCount = 10

	infiniteXVal = -9999.0
	infiniteYVal = -9999.0

	xBeginOffset = 300.0
	yBeginOffset = 610.0
	xOffset = 70.0
	yOffset = -70.0
	initial_spawning = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if initial_spawning == false:
		_spawn_background()
		_spawn_jewels()
		_load_jewels()
		initial_spawning = true

func _spawn_background() -> void:
	var ground_instance
	var _xBegin : int = 0
	var _yBegin : int = 0

	for k in groundNum:
		ground_instance = BACKGROUND_SCENE.instantiate()
		#multiplied decrement by each increase of the yVal.
		#on being even -  make sure to take the lower valued decrement to offset the hex
		ground_instance.global_position.x = (_xBegin * xOffset) + xBeginOffset
		ground_instance.global_position.y = (_yBegin * yOffset) + yBeginOffset
		add_child(ground_instance)
		groundArr.append(ground_instance)
		_xBegin += 1
		if (_xBegin >= int(groundNum / float(groundDiv))):
			_xBegin = 0
			_yBegin += 1

func _spawn_jewels() -> void:
	var jewel_instance
	for k in jewelNum:
		jewel_instance = JEWEL_SCENE.instantiate()
		#multiplied decrement by each increase of the yVal.
		#on being even -  make sure to take the lower valued decrement to offset the hex
		jewel_instance.global_position.x = infiniteXVal
		jewel_instance.global_position.y = infiniteYVal
		add_child(jewel_instance)
		jewelArr.append(jewel_instance)
		jewelTextureValArr.append(0)

func _load_jewels() -> void:
	for k in jewelCount:
		textureJewels.append(load("res://Textures/Jewel_" + str(k) + ".png"))
