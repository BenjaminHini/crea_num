extends Control


onready var sereur_ann = $Recepteur
onready var ip_serveur_texte = $fond/Adresse_ip_serv
onready var serveur_vbox = $fond/VBoxContainer
onready var boutton_rejoindre = $fond/saisie_manuelle

func _ready()->void:
	ip_serveur_texte.hide()

func _on_Recepteur_nouveau_serveur(infoServ):
	var noeud_serveur = Global.instance_node(load("res://Affichage_serveur.tscn"),serveur_vbox)
	noeud_serveur.text= "%s / %s" % [infoServ.ip, infoServ.name]
	noeud_serveur.ip=str(infoServ.ip)


func _on_Recepteur_supp_server(ip_serv):
	for noeud_serveur in serveur_vbox.get_children():
		if noeud_serveur.is_in_group("Affichage_des_serveurs"):
			if noeud_serveur.ip==ip_serv:
				noeud_serveur.queue_free()
				break



func _on_saisie_manuelle_pressed():
	if boutton_rejoindre.text != "Quitter":
		ip_serveur_texte.show()
		boutton_rejoindre.text = "Quitter"
		serveur_vbox.hide()
		ip_serveur_texte.call_deferred("choix")
	else:
		ip_serveur_texte.text=""
		ip_serveur_texte.hide()
		boutton_rejoindre.text = "Saisie Manuelle"
		
	  

func _on_rejoindre_button_up():
	Reseau.ip=ip_serveur_texte.text
	hide()
	Reseau.join_server()



func _on_retour_pressed():
	get_tree().reload_current_scene()
