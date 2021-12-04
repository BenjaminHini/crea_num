extends Node


export (float) var interval_diffusion = 1.0
var serveur_info = {"name": "LAN Game"}

var udp
var temps_diffusion = Timer.new()
var diffusion_port = Reseau.PORT

func _enter_tree():
	temps_diffusion.wait_time = interval_diffusion 
	temps_diffusion.one_shot = false
	temps_diffusion.autostart = true
	
	if get_tree().is_network_server():
		add_child(temps_diffusion)
		temps_diffusion.connect("timeout", self, "broadcast")
		
		udp = PacketPeerUDP.new()
		udp.set_broadcast_enabled(true)
		udp.set_dest_address('255.255.255.255', diffusion_port)

func broadcast():
	serveur_info.name = Reseau.Pseudo_joueur
	var packet_message = to_json(serveur_info)
	var packet = packet_message.to_ascii()
	udp.put_packet(packet)

func _exit_tree():
	temps_diffusion.stop()
	if udp != null:
		udp.close()
