extends Control


var joueur= load("res://world.tscn")

onready var multijoueur_setup_ui = $Multijoueur_setup
onready var pseudo =$Multijoueur_setup/Saisie_pseudo

onready var adressIP_joueur =$CanvasLayer/AdressIP_joueur

func _ready() -> void:
	get_tree().connect("network_peer_connected",self,"_joueur_connecte")
	get_tree().connect("network_peer_disconnected",self,"_joueur_deconnecte")
	get_tree().connect("connected_to_server",self,"_connecte_au_serveur")
	
	adressIP_joueur.text= Reseau.ip

func _joueur_connecte(Id) -> void:
	print("player "+str(Id)+" est connecté")
#	instance_joueur(Id)
   

func _joueur_deconnecte(Id) -> void:   
	print("player "+str(Id)+" est deconnecté")
	
func _connecte_au_serveur() -> void: 
	yield( get_tree().create_timer(0.1),"timeout")
	#instance_joueur(get_tree().get_network_unique_id())
	
func _on_heberger_pressed():
	if pseudo.text !="":
		Reseau.Pseudo_joueur = pseudo.text
		multijoueur_setup_ui.hide()
		Reseau.create_server()
	#instance_joueur(get_tree().get_network_unique_id())

func _on_rejoindre_pressed():
	if pseudo.text !="":
		multijoueur_setup_ui.hide()
		pseudo.hide()
			
		Global.instance_node(load("res://Recherche_serveur.tscn"),self)

#func instance_joueur(id) -> void:
#	var instance_joueur=Global.instance_node_at_location(joueur.player,Players,Vector2(rand_range(0,1920),rand_range(0,1080))) 
#	instance_joueur.name=str(id)
#	instance_joueur.set_network_master(id)
