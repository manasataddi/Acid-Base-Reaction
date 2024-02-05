extends CharacterBody2D

# --------- VARIABLES ---------- #

@export_category("Player Properties")
@export var move_speed : float = 300
@export var jump_force : float = 600
@export var gravity : float = 1800
var current_animation_name = ""
var attack_animation_finished = false
var attack_animation_playing = false
var attack_animation_frame_countdown = 0.0
@onready var attack_animation_duration_timer = $AttackAnimationDurationTimer
@onready var player_sprite = $AnimatedSprite2D
@onready var spawn_point = %SpawnPoint
@onready var particle_trails = $ParticleTrails
@onready var death_particles = $DeathParticles
@onready var animation_handler = $AnimationHandler

# --------- BUILT-IN FUNCTIONS ---------- #
func _process(_delta):
	# Calling functions
	attack(_delta)
	movement(_delta)
	player_animations(_delta)
	flip_player()
	
func attack(delta):
	if attack_animation_frame_countdown > 0:
		attack_animation_frame_countdown -= (5.0/3.0)*delta
		
		if not attack_animation_playing:
			player_sprite.play("Attack")
			attack_animation_playing = true
	else:
		player_sprite.play("Idle")
		pass

# <-- Player Movement Code -->
func movement(delta):
	# Gravity
	if !is_on_floor():
		velocity.y += gravity * delta
	handle_jumping()
	
	# Move Player
	var inputAxis = Input.get_axis("Left", "Right")
	velocity = Vector2(inputAxis * move_speed, velocity.y)
	move_and_slide()
# Handles jumping functionality (double jump or single jump, can be toggled from inspector)
func handle_jumping():
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		jump()

# Player jump
func jump():
	jump_tween()
	velocity.y = -jump_force

# Handle Player Animations
func player_animations(delta):
	particle_trails.emitting = false
	
	if is_on_floor():
		if abs(velocity.x) > 0:
			particle_trails.emitting = true
			player_sprite.play("Walk", 1.5)
		
		elif Input.is_action_just_pressed("Attack"):
			player_sprite.play("Attack")  # New animation for attacking
			attack_animation_finished = false
			attack_animation_frame_countdown = 1.0
		elif attack_animation_playing:
			return
		else:
			player_sprite.play("Idle")
	else:
		player_sprite.play("Jump")
		
	
func flip_player():
	if velocity.x < 0: 
		player_sprite.flip_h = true
	elif velocity.x > 0:
		player_sprite.flip_h = false

# Tween Animations
func death_tween():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2.ZERO, 0.15)
	await tween.finished
	global_position = spawn_point.global_position
	await get_tree().create_timer(0.3).timeout
	respawn_tween()

func respawn_tween():
	var tween = create_tween()
	tween.stop(); tween.play()
	tween.tween_property(self, "scale", Vector2.ONE, 0.15) 

func jump_tween():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0.7, 1.4), 0.1)
	tween.tween_property(self, "scale", Vector2.ONE, 0.1)

func _on_collision_body_entered(_body):
	if _body.is_in_group("Acid"):
		print("Hit by Acid")
		death_tween()
	elif _body.is_in_group("Base"):
		print("Hit by Base")
		death_tween()
	elif _body.is_in_group("Both"):
		print("Hit by Both")
		death_tween()
	elif _body.is_in_group("Neutral"):
		print("Hit by Neutral")
		death_tween()
