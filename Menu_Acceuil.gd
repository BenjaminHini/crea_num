extends Control




onready var multijoueur_setup_ui = $Multijoueur_setup
onready var pseudo =$Multijoueur_setup/Saisie_pseudo

onready var adressIP_joueur =$CanvasLayer/AdressIP_joueur

func _ready() -> void:
	get_tree().connect("network_peer_connected",self,"_joueur_connecte")
	get_tree().connect("network_peer_disconnected",self,"_joueur_deconnecte")
	get_tree().connect("connected_to_server",self,"_connecte au serveur")
	
	adressIP_joueur.text= Reseau.ip

func _joueur_connecte(Id) -> void:
	print("player "+str(Id)+" est connecté")
   

func _joueur_deconnecte(Id) -> void:   
	print("player "+str(Id)+" est deconnecté")
	
func _on_heberger_pressed():
	if pseudo.text !="":
		Reseau.Pseudo_joueur = pseudo.text
		multijoueur_setup_ui.hide()
		Reseau.create_server()
	#instance player

func _on_rejoindre_pressed():
	if pseudo.text !="":
		multijoueur_setup_ui.hide()
		pseudo.hide()
			
		Global.instance_node(load("res://Recherche_serveur.tscn"),self)

