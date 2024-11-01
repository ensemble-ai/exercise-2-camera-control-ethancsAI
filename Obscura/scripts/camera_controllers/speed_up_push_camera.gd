class_name SpeedUpPushCamera
extends CameraControllerBase

@export var follow_speed: float = 0.1
@export var catchup_speed: float = 3.0
@export var leash: float = 10.0
@export var slowdown_factor: float = 0.5
@export var box_width: float = 10.0
@export var box_height: float = 10.0
@export var pushbox_width: float = 20.0
@export var pushbox_height: float = 20.0

@export var push_ratio: float = 0.5
@export var pushbox_top_left: Vector2 = Vector2(-5.0, 5.0)
@export var pushbox_bottom_right: Vector2 = Vector2(5.0, -5.0)
@export var speedup_zone_top_left: Vector2 = Vector2(-5.0, 5.0)
@export var speedup_zone_bottom_right: Vector2 = Vector2(5.0, -5.0)

var target_position: Vector3
var target_velocity_len: float
var camera_position: Vector3

func _ready() -> void:
	super()
	target_position = target.position
	camera_position = position

func _process(delta: float) -> void:
	if !current:
		return

	if draw_camera_logic:
		draw_logic()

	target_position = target.position
	target_velocity_len = target.velocity.length()

	if camera_position.x < target_position.x - leash:
		camera_position.x = target_position.x - leash
	elif camera_position.x > target_position.x + leash:
		camera_position.x = target_position.x + leash
	if camera_position.z < target_position.z - leash:
		camera_position.z = target_position.z - leash
	elif camera_position.z > target_position.z + leash:
		camera_position.z = target_position.z + leash

	if is_in_inner_box(target_position, camera_position):
		position = camera_position
	elif is_in_speedup_zone(target_position, camera_position):
		camera_position = lerp(camera_position, target_position, slowdown_factor * follow_speed * target_velocity_len * delta)
		camera_position = lerp(camera_position, target_position, (catchup_speed / 2) * delta)
	else:
		camera_position = lerp(camera_position, target_position, catchup_speed * delta * push_ratio)

	position = camera_position
	super(delta)

func is_in_inner_box(tpos: Vector3, cpos: Vector3) -> bool:
	return abs(tpos.x - cpos.x) <= box_width / 2.0 and abs(tpos.z - cpos.z) <= box_height / 2.0

func is_in_speedup_zone(tpos: Vector3, cpos: Vector3) -> bool:
	var within_outer_box = abs(tpos.x - cpos.x) < pushbox_width / 2.0 and abs(tpos.z - cpos.z) < pushbox_height / 2.0
	var outside_inner_box = abs(tpos.x - cpos.x) > box_width / 2.0 or abs(tpos.z - cpos.z) > box_height / 2.0
	return within_outer_box and outside_inner_box

func draw_logic() -> void:
	draw_box(box_width, box_height, Color.BLACK)
	draw_box(pushbox_width, pushbox_height, Color.RED)

func draw_box(width: float, height: float, color: Color) -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	
	var left: float = -width / 2
	var right: float = width / 2
	var top: float = -height / 2
	var bottom: float = height / 2
	
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, bottom))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(left, 0, top))
	immediate_mesh.surface_add_vertex(Vector3(right, 0, top))
	immediate_mesh.surface_end()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = color
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	await get_tree().process_frame
	mesh_instance.queue_free()
