extends Node

signal animation_finished_signal(animation_name)

func _on_animation_finished(animation_name):
	emit_signal("animation_finished_signal", animation_name)
