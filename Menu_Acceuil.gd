extends Control


var joueur= load("res://Joueur.tscn")
var world = load("res://world.tscn")

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
	instance_joueur(Id)
   

func _joueur_deconnecte(Id) -> void:   
	print("player "+str(Id)+" est deconnecté")
	
	if Players.has_node(str(Id)):
		Players.get_node(str(Id)).queue_free()
	
func _connecte_au_serveur() -> void: 
	yield( get_tree().create_timer(0.1),"timeout")
	instance_joueur(get_tree().get_network_unique_id())
	
func _on_heberger_pressed():
	if pseudo.text !="":
		Reseau.Pseudo_joueur = pseudo.text
		multijoueur_setup_ui.hide()
		Reseau.create_server()
		var instance_joueur=Global.instance_node_at_location(world,Players,Vector2(0,0)) 
		instance_joueur(get_tree().get_network_unique_id())

func _on_rejoindre_pressed():
	if pseudo.text !="":
		multijoueur_setup_ui.hide()
		Reseau.Pseudo_joueur = pseudo.text
		pseudo.hide()
			
		Global.instance_node(load("res://Recherche_serveur.tscn"),self)

func instance_joueur(id) -> void:
	var instance_joueur=Global.instance_node_at_location(joueur,Players,Vector2(rand_range(500,1300),rand_range(200,300))) 
	instance_joueur.name=str(id)
	instance_joueur.set_network_master(id)
