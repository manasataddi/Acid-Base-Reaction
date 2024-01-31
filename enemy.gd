extends Node2D

@onready var enemy_sprite = $AnimatedSprite2D
@onready var formula = $FormulaLabel
@onready var attack_timer = $AttackTimer  # Replace with the actual path to your attack timer
@onready var attack_duration_timer = $AttackDurationTimer  # Replace with the actual path to your attack duration timer
var compoundArray = [["AgCl","Neutral"],["BaCrO4","Base"],["CCl4","Neutral"],["HClO4","Acid"],["CO2H","Acid"],["HNO2","Acid"],["C3H8","Neutral"],["CH3COOH","Acid"],["MgC2O4","Base"],["HCN","Acid"],["CH4","Neutral"],["CaCO3","Base"],["Na2S","Base"],["K2SO3","Base"],["CH3-NH2","Base"],["Mg(OH)2","Base"],["HCl","Acid"],["HNO3","Acid"],["K3PO4","Base"],["KNO3","Neutral"],["KNO2","Base"],["NaBr","Neutral"],["KMnO4","Base"],["Ca(ClO3)2","Base"],["H2O","Both"]]
var victory = false
var hit_animation_playing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	enemy_animations()

func enemy_animations():
	if victory: # not currently functional, as we have no victory trigger
		enemy_sprite.play("Victory")
	else:
		if hit_animation_playing:
			# Do nothing while the hit animation is playing
			pass
		else:
			enemy_sprite.play("Idle")

func _on_attack_timer_timeout():
	enemy_sprite.play("Hit")
	hit_animation_playing = true
	attack_duration_timer.start()
	attack()

func attack():
	var selection = randi_range(0, compoundArray.size() - 1)
	formula.text = compoundArray[selection][0]

func _on_attack_duration_timer_timeout():
	enemy_sprite.play("Idle")
	hit_animation_playing = false
	attack_timer.start()  # Restart the attack timer for the next attack cycle
