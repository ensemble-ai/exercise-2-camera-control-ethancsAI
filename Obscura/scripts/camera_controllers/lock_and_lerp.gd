class_name LockAndLerp
extends CameraControllerBase

@export var follow_speed: float = 0.1
@export var catchup_speed: float = 3.0
@export var leash_distance: float = 10.0

var target_position: Vector3
var target_velocity_length: float
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
	target_velocity_length = target.velocity.length()

	if camera_position.x < target_position.x - leash_distance:
		camera_position.x = target_position.x - leash_distance
	elif camera_position.x > target_position.x + leash_distance:
		camera_position.x = target_position.x + leash_distance
	if camera_position.z < target_position.z - leash_distance:
		camera_position.z = target_position.z - leash_distance
	elif camera_position.z > target_position.z + leash_distance:
		camera_position.z = target_position.z + leash_distance

	if target_velocity_length == 0:
		camera_position = lerp(camera_position, target_position, catchup_speed * delta)
	else:
		camera_position = lerp(camera_position, target_position, follow_speed * target_velocity_length * delta)

	position = camera_position
	super(delta)

func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()
	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(-2.5, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(2.5, 0, 0))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, -2.5))
	immediate_mesh.surface_add_vertex(Vector3(0, 0, 2.5))
	immediate_mesh.surface_end()
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	await get_tree().process_frame
	mesh_instance.queue_free()
