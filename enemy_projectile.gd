extends RigidBody2D

var speed = 150

var compoundArray = [["AgCl","Neutral"],["BaCrO₄","Base"],["CCl₄","Neutral"],["HClO₄","Acid"],["CO₂H","Acid"],["HNO₂","Acid"],["C₃H₈","Neutral"],["CH₃COOH","Acid"],["MgC₂O₄","Base"],["HCN","Acid"],["CH₄","Neutral"],["CaCO₃","Base"],["Na₂S","Base"],["K₂SO₃","Base"],["CH₃-NH₂","Base"],["Mg(OH)₂","Base"],["HCl","Acid"],["HNO₃","Acid"],["K₃PO₄","Base"],["KNO₃","Neutral"],["KNO₂","Base"],["NaBr","Neutral"],["KMnO₄","Base"],["Ca(ClO₃)₂","Base"],["H₂O","Both"]]
@onready var formula = $FormulaLabel
# Called when the node enters the scene tree for the first time.
func _ready():
	var selection = randi_range(0, compoundArray.size() - 1)
	add_to_group(compoundArray[selection][1])
	formula.text = compoundArray[selection][0]
	pass # Replace with function body.

func _process(delta):
	move_local_x(-speed * delta)
# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		queue_free()
	 # Replace with function body.
