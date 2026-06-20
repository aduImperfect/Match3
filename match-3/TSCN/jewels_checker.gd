extends Node2D

@export var gridGenNode : Node2D

@export var _jewelsDiv : int = 0
@export var _loopState : int = 0
@export var _maxResetLayer : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_loopState = 0
	_jewelsDiv = 8
	_maxResetLayer = 12

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_checker_updater_for_match_3()

func _checker_updater_for_match_3() -> void:
	var _xBegin : int = 0
	var _yBegin : int = 0
	var _i : int = 0

	for k in gridGenNode.groundNum:
		if int(_i / float(_jewelsDiv)) > _maxResetLayer:
			break

		if _xBegin == 0 || _xBegin == 9 || _yBegin == 0:
			_xBegin += 1
			if (_xBegin >= int(gridGenNode.groundNum / float(gridGenNode.groundDiv))):
				_xBegin = 0
				_yBegin += 1
			continue

		var iHeight : int = (_i % _jewelsDiv)

		#The below section is to check for horizontal states.
		var iSameHorizState1 : bool = (_i % _jewelsDiv) == ((_i + 1) % _jewelsDiv)
		var iSameHorizState2 : bool = (_i % _jewelsDiv) == ((_i + 2) % _jewelsDiv)
		var iSameHorizStateMain : bool = iSameHorizState1 && iSameHorizState2

		var iTextureSameHoriz1 : bool = (gridGenNode.jewelTextureValArr[_i] == gridGenNode.jewelTextureValArr[_i + 1])
		var iTextureSameHoriz2 : bool = (gridGenNode.jewelTextureValArr[_i] == gridGenNode.jewelTextureValArr[_i + 2])
		var iTextureSameHorizMain : bool = iTextureSameHoriz1 && iTextureSameHoriz2

		#The below section is to update if horizontal match-3 occurs.
		if iSameHorizStateMain && iTextureSameHorizMain: 
			#shift everything tied above that row down till about the 12th row (hidden above)
			for j in range(iHeight, _maxResetLayer, 1):
				gridGenNode.jewelArr[_i] = gridGenNode.jewelArr[_i + _jewelsDiv]
				gridGenNode.jewelArr[_i + 1] = gridGenNode.jewelArr[(_i + 1) + _jewelsDiv]
				gridGenNode.jewelArr[_i + 2] = gridGenNode.jewelArr[(_i + 2) + _jewelsDiv]

				gridGenNode.jewelTextureValArr[_i] = gridGenNode.jewelTextureValArr[_i + _jewelsDiv]
				gridGenNode.jewelTextureValArr[_i + 1] = gridGenNode.jewelTextureValArr[(_i + 1) + _jewelsDiv]
				gridGenNode.jewelTextureValArr[_i + 2] = gridGenNode.jewelTextureValArr[(_i + 2) + _jewelsDiv]

			#update everything above 12th row with new values!
			for j in range(_maxResetLayer, int(gridGenNode.groundNum / float(gridGenNode.groundDiv)) - 1, 1):
				var textureVal : int = 1
				textureVal = randi_range(1, 9)
				gridGenNode.jewelArr[_i].texture = load("res://Textures/Jewel_" + str(textureVal) + ".png")
				gridGenNode.jewelTextureValArr[_i] = textureVal
			_loopState += 1

		_i += 1
		_xBegin += 1
		if (_xBegin >= int(gridGenNode.groundNum / float(gridGenNode.groundDiv))):
			_xBegin = 0
			_yBegin += 1
