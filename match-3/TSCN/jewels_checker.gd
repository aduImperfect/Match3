extends Node2D

@export var gridGenNode : Node2D

@export var _jewelsDiv : int = 0
@export var _loopState : int = 0
@export var _maxResetLayer : int = 0

@export var _delayAccumulation : float = 0.0
@export var _delaySeconds : float = 3.0

@export var _delayAccumulation1 : float = 0.0
@export var _delaySeconds1 : float = 3.0

@export var _delayAccumulation2 : float = 0.0
@export var _delaySeconds2 : float = 3.0

@export var _updateI : int = 0
@export var updationInProgress : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_loopState = 0
	_jewelsDiv = 8
	_maxResetLayer = 12
	_delayAccumulation = 0.0
	_delaySeconds = 1.0
	_delayAccumulation1 = 0.0
	_delaySeconds1 = 1.0
	_delayAccumulation2 = 0.0
	_delaySeconds2 = 1.0
	_updateI = -1
	updationInProgress = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_delayAccumulation += _delta
	if _delayAccumulation > _delaySeconds:
		updationInProgress = true
		_checker_updater_for_match_3()
		_delayAccumulation = 0.0

	_remove_horizontal_find(_delta)
	_move_down_horizontals(_delta)

func _checker_updater_for_match_3() -> void:
	if updationInProgress == false:
		return

	var _xBegin : int = 0
	var _yBegin : int = 0
	var _i : int = 0
	_updateI = -1

	for k in gridGenNode.groundNum:
		var iHeight : int = int(_i / float(_jewelsDiv))
		if iHeight > _maxResetLayer:
			break

		if _xBegin == 0 || _xBegin == 9 || _yBegin == 0:
			_xBegin += 1
			if (_xBegin >= int(gridGenNode.groundNum / float(gridGenNode.groundDiv))):
				_xBegin = 0
				_yBegin += 1
			continue

		#The below section is to check for horizontal states.
		var iSameHorizState1 : bool = iHeight == int((_i + 1) / float(_jewelsDiv))
		var iSameHorizState2 : bool = iHeight == int((_i + 2) / float(_jewelsDiv))
		var iSameHorizStateMain : bool = iSameHorizState1 && iSameHorizState2

		var iTextureSameHoriz1 : bool = (gridGenNode.jewelTextureValArr[_i] == gridGenNode.jewelTextureValArr[_i + 1])
		var iTextureSameHoriz2 : bool = (gridGenNode.jewelTextureValArr[_i] == gridGenNode.jewelTextureValArr[_i + 2])
		var iTextureSameHorizMain : bool = iTextureSameHoriz1 && iTextureSameHoriz2

		#The below section is to update if horizontal match-3 occurs.
		if iSameHorizStateMain && iTextureSameHorizMain: 
			_loopState += 1
			_updateI = _i
			break

		_i += 1
		_xBegin += 1
		if (_xBegin >= int(gridGenNode.groundNum / float(gridGenNode.groundDiv))):
			_xBegin = 0
			_yBegin += 1

func _remove_horizontal_find(_delta : float) -> void:
	if _updateI == -1:
		return

	_delayAccumulation1 += _delta
	if _delayAccumulation1 <= _delaySeconds1:
		return

	gridGenNode.jewelArr[_updateI].get_child(0).texture = gridGenNode.textureJewels[0]
	gridGenNode.jewelArr[_updateI + 1].get_child(0).texture = gridGenNode.textureJewels[0]
	gridGenNode.jewelArr[_updateI + 2].get_child(0).texture = gridGenNode.textureJewels[0]

	gridGenNode.jewelTextureValArr[_updateI] = 0
	gridGenNode.jewelTextureValArr[_updateI + 1] = 0
	gridGenNode.jewelTextureValArr[_updateI + 2] = 0

func _move_down_horizontals(_delta : float) -> void:
	if _updateI == -1:
		return

	var iHeight : int = int(_updateI / float(_jewelsDiv))

	if _delayAccumulation1 <= _delaySeconds1:
		return

	_delayAccumulation2 += _delta
	if _delayAccumulation2 <= _delaySeconds2:
		return

	#shift everything tied above that row down till about the 12th row (hidden above)
	for j in range(iHeight, _maxResetLayer, 1):
		gridGenNode.jewelArr[_updateI].get_child(0).texture = gridGenNode.jewelArr[_updateI + _jewelsDiv].get_child(0).texture
		gridGenNode.jewelArr[_updateI + 1].get_child(0).texture = gridGenNode.jewelArr[(_updateI + 1) + _jewelsDiv].get_child(0).texture
		gridGenNode.jewelArr[_updateI + 2].get_child(0).texture = gridGenNode.jewelArr[(_updateI + 2) + _jewelsDiv].get_child(0).texture

		gridGenNode.jewelTextureValArr[_updateI] = gridGenNode.jewelTextureValArr[_updateI + _jewelsDiv]
		gridGenNode.jewelTextureValArr[_updateI + 1] = gridGenNode.jewelTextureValArr[(_updateI + 1) + _jewelsDiv]
		gridGenNode.jewelTextureValArr[_updateI + 2] = gridGenNode.jewelTextureValArr[(_updateI + 2) + _jewelsDiv]

	#update everything above 12th row with new values!
	for j in range(_maxResetLayer, int(gridGenNode.groundNum / float(gridGenNode.groundDiv)) - 1, 1):
		var textureVal : int = 1
		textureVal = randi_range(1, 9)
		gridGenNode.jewelArr[_updateI].texture = gridGenNode.textureJewels[textureVal]
		gridGenNode.jewelTextureValArr[_updateI] = textureVal

	updationInProgress = false
	_delayAccumulation1 = 0.0
	_delayAccumulation2 = 0.0
