extends Area2D
#Sert à identifer dans d'autre script
class_name Coin



#Il existe 2 methodes pour trouvé un autre node
#1 par lien direct
@onready var animation_player = $AnimationPlayer

#2 Définir une variable avec "@export" dans le script qui à pour object "Node" vu que c'est ce que l'on recherche
@export var game_manager = Node #le "GameManager" dans la scene est un "Node"


func _on_body_entered(body):
	if body is Player: #on viens recupéré le class_name du Player
		game_manager.add_point()
		animation_player.play("pickup")
