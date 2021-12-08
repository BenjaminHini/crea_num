extends Control

onready var chatlog = get_node("VBoxContainer/RichTextLabel")
onready var input = get_node("VBoxContainer/HBoxContainer/LineEdit")


var pseudo = Reseau.Pseudo_joueur
var user = {"username": pseudo, "color": ""}

func _ready():
	get_random_color(user)
	input.connect("text_entered", self, "text_entered")
	
func get_random_color(user):
	var colors = ['#920000', '#d97c03', '#2019ee', '#ffffff', '#fb1bfd', '#1a441f', '#000000']
	randomize()
	user.color = colors[randi()%colors.size()]
	
func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_T:
			input.grab_focus()
		if event.pressed and event.scancode == KEY_ESCAPE:
			input.text = ''
			input.release_focus()

func send_message(user, text):
	var msg = '\n' +'[color=' + user.color+'] ['+user.username+']: ' + text + '[/color]'
	rpc("get_messages", msg)


sync func get_messages(msg):
	chatlog.bbcode_text += msg

func text_entered(text):
	if text != '':
		input.text = ''
		input.release_focus()
		send_message(user, text)
	
