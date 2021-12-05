extends Camera2D

var Joueur_controle = null

func _ready() -> void:
	Joueur_controle=Global.Joueur_controle

func _process(delta: float) -> void:
	if Global.Joueur_controle != null:
		global_position = lerp(global_position, Global.Joueur_controle.global_position, delta * 10)

