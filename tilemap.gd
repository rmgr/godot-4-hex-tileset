extends Node2D

@onready var tilemap: TileMap = $Tilemap

const arc_origin = Vector2i(0,1)

# Artfully ripped from here: https://stackoverflow.com/a/18394812
func hex_distance(start:Vector2, dest:Vector2) -> int:
	var distance = max(max(abs(dest.y-start.y), abs(ceil(dest.y / -2) + dest.x - ceil(start.y / -2) - start.x)),abs(-dest.y - ceil(dest.y / -2) - dest.x + start.y  + ceil(start.y / -2) + start.x))
	return distance
	
func _input(event):
	if event is InputEventMouseButton:
		if (event as InputEventMouseButton).button_index == MOUSE_BUTTON_LEFT:
			tilemap.clear_layer(1)
			var map_mouse_pos = tilemap.local_to_map(get_global_mouse_position())
			for neighbour in tilemap.get_surrounding_cells(map_mouse_pos):
				tilemap.set_cell(1, neighbour, 0, Vector2i(6,2))

		elif (event as InputEventMouseButton).button_index == MOUSE_BUTTON_RIGHT:
			tilemap.clear_layer(1)
			var map_mouse_pos = tilemap.local_to_map(get_global_mouse_position())
			if hex_distance(map_mouse_pos, arc_origin) == 1:
				var dir = Vector2(map_mouse_pos - arc_origin)
				var mouse_arc = tilemap.get_surrounding_cells(map_mouse_pos)
				tilemap.set_cell(1, map_mouse_pos, 0, Vector2i(6,2))
				for point in mouse_arc:
					if hex_distance(Vector2(point), arc_origin) == 1:
						tilemap.set_cell(1, Vector2(point), 0, Vector2i(6,2))
