extends Node2D

@export var gridGenNode : Node2D

@export var _loopState : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_loopState = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _checker_for_match_3() -> void:
	pass
