extends Node2D

@onready var enemy_sprite = $AnimatedSprite2D
@onready var formula = $FormulaLabel
@onready var attack_timer = $AttackTimer  # Replace with the actual path to your attack timer
@onready var attack_duration_timer = $AttackDurationTimer  # Replace with the actual path to your attack duration timer
var compoundArray = ["HCl","NaOH","NaCL","Placeholder1","Placeholder2","Placeholder3","Placeholder4","Placeholder5","Placeholder6"]
var victory = false

var hit_animation_playing = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	enemy_animations()

func enemy_animations():
	if victory:
		enemy_sprite.play("Idle")
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
	formula.text = compoundArray[selection]

func _on_attack_duration_timer_timeout():
	enemy_sprite.play("Idle")
	hit_animation_playing = false
	attack_timer.start()  # Restart the attack timer for the next attack cycle
