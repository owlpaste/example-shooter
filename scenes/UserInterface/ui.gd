extends CanvasLayer

var green: Color = Color("6bbfa3")
var red: Color = Color(0.9, 0, 0, 1)

@onready var laser_label: Label = $AmmoCounter/VBoxContainer/Label
@onready var laser_icon: TextureRect = $AmmoCounter/VBoxContainer/TextureRect

@onready var grenade_label: Label = $GrenadeCounter/VBoxContainer/Label
@onready var grenade_icon: TextureRect = $GrenadeCounter/VBoxContainer/TextureRect

@onready var health_bar: TextureProgressBar = $Healthbar/TextureProgressBar

func _ready():
	Globals.connect("stat_change", update_stat_text)


func update_stat_text() ->void:
	update_laser_text()
	update_grenade_text()
	update_health_text()


func update_laser_text():
	laser_label.text = str(Globals.laser_amount)
	update_color(Globals.laser_amount, laser_label, laser_icon)


func update_grenade_text():
	grenade_label.text = str(Globals.grenade_amount)
	update_color(Globals.grenade_amount, grenade_label, grenade_icon)


func update_health_text():
	health_bar.value = Globals.health


func update_color(amount: int, label: Label, icon: TextureRect) -> void:
	label.modulate = green
	icon.modulate = green
	if (amount <= 0):
		label.modulate = red
		icon.modulate = red
