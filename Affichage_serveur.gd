extends Label

var ip =""


func _on_rejoindre_pressed():
	Reseau.ip=ip
	Reseau.join_server()
	get_parent().get_parent().queue_free()
