class_name ViewportManager
extends Control

@export var viewports: Array[Viewport] = []  # top → bottom
@export var background: Texture2D  # Drag your image here in the Inspector
@onready var background_rect: TextureRect = $CanvasLayer/TextureRect


@onready var camera_bg: Camera3D = $BackgroundViewport/SubViewport/CameraBG
@onready var camera_behind: Camera3D = $ViewportBehindPlayer/SubViewport/CameraBehind
@onready var camera_player: Camera3D = $PlayerViewport/SubViewport/CameraPlayer
@onready var camera_foreground: Camera3D = $Foreground/SubViewport/CameraForeground


func sync_all_cameras_to(reference: Camera3D) -> void:
	var t := reference.global_transform

	var cameras: Array = [
		camera_bg,
		camera_behind,
		camera_player,
		camera_foreground
	]

	for cam in cameras:
		cam.global_transform = t


func _ready() -> void:
#	Set the fadeIn & fadeout visibility to true on runtime because otherwise editor is black
	assert (background != null)
	if background:
		background_rect.texture = background
	sync_all_cameras_to(camera_behind)
		
# We need information about the camera in order to place the animation correctly
# at the mouse position
func getCamera() -> Camera3D:
	return camera_bg


func _input(event: InputEvent) -> void:
	#print("ViewportManager: I got an input")
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var screen_pos: Vector2 = event.position
		for vp in viewports:
			var cam := _find_camera(vp)
			if cam == null:
				continue
			var hit := _raycast_from_camera(cam, screen_pos)
			if hit:
				print("Viewport:", vp.name, "Camera:", cam.name, "Hit:", hit.collider.name)
				# this collider is the 
				if hit.collider.has_method("on_cube_click"):
					print("Has method on_cube_click")
					hit.collider.on_cube_click()
				return  # stop after first visible hit

func _find_camera(vp: Viewport) -> Camera3D:
	for child in vp.get_children():
		if child is Camera3D:
			return child
	return null

func _raycast_from_camera(cam: Camera3D, screen_pos: Vector2) -> Dictionary:
	var ray_origin: Vector3 = cam.project_ray_origin(screen_pos)
	var ray_normal: Vector3 = cam.project_ray_normal(screen_pos)
	var ray_end: Vector3 = ray_origin + ray_normal * 2000.0

	var query := PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
	query.collision_mask = cam.cull_mask

	var space_state := PhysicsServer3D.space_get_direct_state(cam.get_world_3d().space)
	return space_state.intersect_ray(query)
