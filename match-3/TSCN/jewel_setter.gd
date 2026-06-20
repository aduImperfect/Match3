extends Node2D

@export var gridGenNode : Node2D

@export var initialSettingOfJewels : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialSettingOfJewels = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if initialSettingOfJewels == false:
		_set_initial_jewels()
		initialSettingOfJewels = true

func _set_initial_jewels() -> void:
	var _xBegin : int = 0
	var _yBegin : int = 0
	var _i : int = 0

	for k in gridGenNode.groundNum:
		if _xBegin == 0 || _xBegin == 9 || _yBegin == 0:
			_xBegin += 1
			if (_xBegin >= int(gridGenNode.groundNum / float(gridGenNode.groundDiv))):
				_xBegin = 0
				_yBegin += 1
			continue
		var jewelSprite = gridGenNode.jewelArr[_i].get_child(0) as Sprite2D
		var textureVal : int = 1
		textureVal = randi_range(1, 9)
		jewelSprite.texture = load("res://Textures/Jewel_" + str(textureVal) + ".png")
		gridGenNode.jewelTextureValArr[_i] = textureVal
		gridGenNode.jewelArr[_i].position.x = gridGenNode.groundArr[k].position.x
		gridGenNode.jewelArr[_i].position.y = gridGenNode.groundArr[k].position.y
		_i += 1
		_xBegin += 1
		if (_xBegin >= int(gridGenNode.groundNum / float(gridGenNode.groundDiv))):
			_xBegin = 0
			_yBegin += 1
