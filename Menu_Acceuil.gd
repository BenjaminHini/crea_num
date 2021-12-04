extends Control


<<<<<<< Updated upstream


func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_heberger_pressed():
	pass # Replace with function body.


func _on_rejoindre_pressed():
	pass # Replace with function body.
=======
onready var multijoueur_setup_ui = $Multijoueur_setup
onready var adressIP_serveur =$Multijoueur_setup/AdresseIP_serveur

onready var adressIP_joueur =$CanvasLayer/AdressIP_joueur

func _ready() -> void:
	get_tree().connect("network_peer_connected",self,"_joueur_connecte")
	get_tree().connect("network_peer_disconnected",self,"_joueur_deconnecte")
	get_tree().connect("connected_to_server",self,"_connecte au serveur")
	
	adressIP_joueur.text= Reseau.ip

func _joueur_connecte(Id) -> void:
	print("player"+str(Id)+"est connecté")
   

func _joueur_deconnecte(Id) -> void:   
	print("player"+str(Id)+"est deconnecté")
	
func _on_heberger_pressed():
	multijoueur_setup_ui.hide()
	Reseau.create_server()


func _on_rejoindre_pressed():
	if adressIP_serveur.text != "":
		multijoueur_setup_ui.hide()
		Reseau.ip= adressIP_serveur.text
		Reseau.join_server()
>>>>>>> Stashed changes
