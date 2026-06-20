extends Node2D

@export var gridGenNode : Node2D

@export var _loopState : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_loopState = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	_checker_for_match_3()

func _checker_for_match_3() -> void:
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
