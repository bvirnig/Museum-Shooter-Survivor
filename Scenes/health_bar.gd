extends TextureProgressBar  # Make sure this matches your node type

@export var offset: Vector2 = Vector2(0, -50)  # Adjust this for your needs
@onready var player = get_parent()  # Assuming the health bar is a child of the player node

func _process(delta):
	if player:
		position = player.position + offset
