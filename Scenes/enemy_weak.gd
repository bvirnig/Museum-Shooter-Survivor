extends CharacterBody2D

@export var movement_speed = 20.0
@export var hp = 10 
@export var knockback_recovery = 3.5
@export var experience = 1
@export var enemy_damage = 1

var knockback = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("Player")
@onready var loot_base = get_tree().get_first_node_in_group("loot")
@onready var sprite = $CharacterSprite
@onready var anim = $AnimationPlayer
@onready var hitBox = $HitBox

var death_anim = preload("res://Scenes/explosion.tscn")
var exp_gem = preload("res://Scenes/experience_gem.tscn")

signal remove_from_array(object)

@export var max_y_position: float = 0  # Set your desired maximum Y position

func _ready() -> void:
	anim.play("run_left")
	hitBox.damage = enemy_damage

func _physics_process(_delta):
	knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * movement_speed
	velocity += knockback
	move_and_slide()
	
	# Constrain the Y position
	if position.y < max_y_position:
		position.y = max_y_position
	
	if direction.x > 0.1:
		sprite.flip_h = false
	elif direction.x < -0.1:
		sprite.flip_h = true
	
func death():
	emit_signal("remove_from_array", self)
	
	var enemy_death = death_anim.instantiate()
	enemy_death.scale = sprite.scale * 1.8  # Increase scale by 20%
	enemy_death.global_position = global_position 
	get_parent().call_deferred("add_child", enemy_death)
	
	var new_gem = exp_gem.instantiate()
	# Set the gem's position to be 310 pixels higher than the enemy's position
	new_gem.global_position = global_position + Vector2(-200, -310)  
	new_gem.experience = experience
	
	if loot_base:
		loot_base.call_deferred("add_child", new_gem)
	
	queue_free()


func _on_hurt_box_hurt(damage, angle, knockback_amount):
	hp -= damage
	knockback = angle * knockback_amount
	if hp <= 0:
		death()
