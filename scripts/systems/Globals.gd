class_name Global
extends Node

enum ENEMIES {
	RED_SQUARE, BLUE_CIRCLE, GREEN_TRIANGLE, PINK_RING, YELLOW_TRIANGLE, PURPLE_HEXAGON, ORANGE_SQUARE, BOSS_1
}

enum WEAPONS {
	REGULAR, TRIPLE, GROWING, HEAVY
}

enum PROJECTILES {
	REGULAR, CIRCLE, LASER
}

enum EFFECTS {
	NONE, ZAP, COLD, TOXIN, EXPLODE
}

var enemy_hp_scaling: float = 1.0
var shader_state: bool = true
var started: bool = false
var current_wave: int = 0
var wave_changed: bool = false
var player_dmg: float
var player_dmg_changed: bool = false

func toggle_shader(state: bool) -> void:
	shader_state = state
	flowerwall_pp_autoload._on_dithering_toggled(shader_state)
	flowerwall_pp_autoload._on_preblur_toggled(shader_state)
	flowerwall_pp_autoload._on_vhs_wiggle_enabled(shader_state)
	flowerwall_pp_autoload._on_chromatic_aberration_enabled(shader_state)
	flowerwall_pp_autoload._on_bloom_enabled(shader_state)
