extends Node2D
const enemyProjectileScn = preload("res://enemy_projectile.tscn")
@onready var enemy_sprite = $AnimatedSprite2D
@onready var formula = $FormulaLabel
@onready var attack_timer = $AttackTimer  # Replace with the actual path to your attack timer
@onready var attack_duration_timer = $AttackDurationTimer  # Replace with the actual path to your attack duration timer
var compoundArray = [["AgCl","Neutral"],["BaCrO₄","Base"],["CCl₄","Neutral"],["HClO₄","Acid"],["CO₂H","Acid"],["HNO₂","Acid"],["C₃H₈","Neutral"],["CH₃COOH","Acid"],["MgC₂O₄","Base"],["HCN","Acid"],["CH₄","Neutral"],["CaCO₃","Base"],["Na₂S","Base"],["K₂SO₃","Base"],["CH₃-NH₂","Base"],["Mg(OH)₂","Base"],["HCl","Acid"],["HNO₃","Acid"],["K₃PO₄","Base"],["KNO₃","Neutral"],["KNO₂","Base"],["NaBr","Neutral"],["KMnO₄","Base"],["Ca(ClO₃)₂","Base"],["H₂O","Both"]]
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
	var compound = enemyProjectileScn.instantiate()
	add_to_group(compoundArray[selection][1])
	formula.text = compoundArray[selection][0]
	add_child(compound)

func _on_attack_duration_timer_timeout():
	enemy_sprite.play("Idle")
	hit_animation_playing = false
	attack_timer.start()  # Restart the attack timer for the next attack cycle
