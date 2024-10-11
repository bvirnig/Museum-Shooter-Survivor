extends StaticBody2D
class_name Painting

@export var hp: int = 15
@export var painting_texture: Texture  # Individual painting texture
@export var painting_scale: float = 3.0  # Scaling factor for paintings

var sprite: Sprite2D
var collision_shape: CollisionShape2D
var hurtbox_shape: CollisionShape2D  # Reference for the hurtbox

func _ready() -> void:
	sprite = $Sprite2D  # Access the Sprite2D node
	collision_shape = $PaintingCollisionShape2D  # Access the CollisionShape2D node
	hurtbox_shape = $HurtBox/CollisionShape2D  # Access the Hurtbox CollisionShape2D node

	if sprite:
		if painting_texture:
			sprite.texture = painting_texture
			sprite.scale = Vector2(painting_scale, painting_scale)

			# Set up the collision shape
			set_collision_shape_size()
			# Set up the hurtbox shape
			set_hurtbox_shape_size()
		else:
			pass  # Handle the case where the texture is not assigned if needed
	else:
		pass  # Handle the case where the Sprite2D node is not found if needed

func set_collision_shape_size() -> void:
	if collision_shape:
		var shape = RectangleShape2D.new()
		shape.extents = Vector2(30, 40)  # Set your desired size here
		collision_shape.shape = shape

func set_hurtbox_shape_size() -> void:
	if hurtbox_shape:
		var hurtbox_shape_instance = RectangleShape2D.new()
		hurtbox_shape_instance.extents = Vector2(45, 50)  # Set your desired hurtbox size here
		hurtbox_shape.shape = hurtbox_shape_instance

func _on_hurt_box_hurt(damage: Variant) -> void:
	hp -= damage
	if hp < 0:
		queue_free()
