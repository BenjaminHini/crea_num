extends Node

signal nouveau_serveur
signal supp_server

var refresh_time = Timer.new()
var udp = PacketPeerUDP.new()
var reception_port = Reseau.PORT
var serveurs_connus = {}

export (int) var refresh_serveur_threshold = 3

func _init():
	refresh_time.wait_time = refresh_serveur_threshold
	refresh_time.one_shot = false
	refresh_time.autostart = true
	refresh_time.connect("timeout", self, 'clean_up')
	add_child(refresh_time)

func _ready():
	serveurs_connus.clear()
	if udp.listen(reception_port) != OK:
		print("LAN: Erreurr de reception du port: " + str(reception_port))
	else:
		print("LAN: reception du port: " + str(reception_port))

func _process(delta):
	if udp.get_available_packet_count() > 0:
		var serveur_ip = udp.get_packet_ip()
		var serveur_port = udp.get_packet_port()
		var array_bytes = udp.get_packet()
		if serveur_ip != '' and serveur_port > 0:
			if not serveurs_connus.has(serveur_ip):
				var MessageServ = array_bytes.get_string_from_ascii()
				var infoJeu = parse_json(MessageServ)
				infoJeu.ip = serveur_ip
				infoJeu.lastSeen = OS.get_unix_time()
				serveurs_connus[serveur_ip] = infoJeu
				emit_signal("new_server", infoJeu)
				print(udp.get_packet_ip())
			else:
				var infoJeu = serveurs_connus[serveur_ip]
				infoJeu.lastSeen = OS.get_unix_time()

func clean_up():
	var mtn = OS.get_unix_time()
	for serveur_ip in serveurs_connus:
		var serveurInfo = serveurs_connus[serveur_ip]
		if (mtn - serveurInfo.lastSeen) > refresh_serveur_threshold:
			serveurs_connus.erase(serveur_ip)
			print('Remove old server: %s' % serveur_ip)
			emit_signal("remove_server", serveur_ip)

func _exit_tree():
	udp.close()
