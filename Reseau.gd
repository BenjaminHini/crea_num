extends Node


const PORT = 25014
const JOUEUR_MAX = 5

var client = null
var serveur = null

var ip = ""
var Pseudo_joueur = ""

func _ready() -> void:
	
	ip=IP.get_local_addresses()[3]
	

	for ip2 in IP.get_local_addresses():
		if ip2.begins_with("192.168."):
			ip=ip2

			
	get_tree().connect("connected_to_server", self, "_on_connected_to_server")
	get_tree().connect("server_disconnected", self, "_on_server_disconnected")

func create_server()-> void:
	serveur = NetworkedMultiplayerENet.new()
	serveur.create_server(PORT, JOUEUR_MAX)
	get_tree().set_network_peer(serveur)	
	Global.instance_node(load("res://Serveur_Ann.tscn"),get_tree().current_scene)
	
func join_server()-> void:	
	client = NetworkedMultiplayerENet.new()
	client.create_client(ip, PORT)
	get_tree().set_network_peer(client)	
	 
func _on_connected_to_server()-> void:
	print("Connection au serveur effectué")

func _on_server_disconnected()-> void:
	print("Deconnecté du serveur")
