extends Area2D


func _init() -> void:
	monitoring = true
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node2D) -> void:
	#verify if is colled with player
	if body.is_class("CharacterBody2D"):
		var platform_spawner : PlatformSpawner = PlatformSpawner.instance;
		platform_spawner.spawn_plataform()
	
