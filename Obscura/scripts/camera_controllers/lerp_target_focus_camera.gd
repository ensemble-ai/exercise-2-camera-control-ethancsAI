class_name LerpTargetFocus
extends CameraControllerBase

@export var lead_speed: float = 11.0
@export var catchup_delay_duration: float = 0.5
@export var catchup_speed: float = 5.0
@export var leash_distance: float = 10.0

var target_position: Vector3
var target_velocity_length: float
var camera_position: Vector3
var last_movement_time: float = 0.0

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
	
	if target_velocity_length > 0:
		last_movement_time = Time.get_ticks_msec() / 1000.0

	var lead_target = target_position
	if target_velocity_length > 0:
		lead_target = target_position + target.velocity.normalized() * lead_speed

	if camera_position.x < lead_target.x - leash_distance:
		camera_position.x = lead_target.x - leash_distance
	elif camera_position.x > lead_target.x + leash_distance:
		camera_position.x = lead_target.x + leash_distance
	if camera_position.z < lead_target.z - leash_distance:
		camera_position.z = lead_target.z - leash_distance
	elif camera_position.z > lead_target.z + leash_distance:
		camera_position.z = lead_target.z + leash_distance

	var current_time = Time.get_ticks_msec() / 1000.0
	var time_since_last_movement = current_time - last_movement_time
	
	if time_since_last_movement > catchup_delay_duration:
		camera_position = lerp(camera_position, target_position, catchup_speed * delta)
	else:
		if target_velocity_length > 0:
			camera_position = lerp(camera_position, lead_target, lead_speed * delta)
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
