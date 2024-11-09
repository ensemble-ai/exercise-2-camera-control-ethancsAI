class_name FrameAutoScroll
extends CameraControllerBase

@export var top_left: Vector2 = Vector2(-10, 10)
@export var bottom_right: Vector2 = Vector2(10, -10)
@export var auto_speed: Vector3 = Vector3(7.0, 0.0, 7.0)

var top_left_x := top_left.x
var top_left_y := top_left.y
var bottom_right_x := bottom_right.x
var bottom_right_y := bottom_right.y

func _ready() -> void:
	super()
	position.x = target.position.x + 15.0
	position.z = target.position.z

func _process(delta: float) -> void:
	if !current:
		return
	if draw_camera_logic:
		draw_logic()

	var scroll_speed_x := auto_speed.x
	var scroll_speed_z := auto_speed.z
	position.x += scroll_speed_x * delta
	position.z += scroll_speed_z * delta
	
	var target_pos_x := target.position.x
	var target_pos_z := target.position.z
	
	if target_pos_x < position.x + top_left_x:
		target.position.x = position.x + top_left_x
	elif target_pos_x > position.x + bottom_right_x:
		target.position.x = position.x + bottom_right_x

	if target_pos_z < position.z + bottom_right_y:
		target.position.z = position.z + bottom_right_y
	elif target_pos_z > position.z + top_left_y:
		target.position.z = position.z + top_left_y

	super(delta)

func draw_logic() -> void:
	var mesh_instance := MeshInstance3D.new()
	var immediate_mesh := ImmediateMesh.new()
	var material := ORMMaterial3D.new()

	mesh_instance.mesh = immediate_mesh
	mesh_instance.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
	immediate_mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
	immediate_mesh.surface_add_vertex(Vector3(top_left_x, 0, top_left_y))
	immediate_mesh.surface_add_vertex(Vector3(bottom_right_x, 0, top_left_y))
	immediate_mesh.surface_add_vertex(Vector3(bottom_right_x, 0, top_left_y))
	immediate_mesh.surface_add_vertex(Vector3(bottom_right_x, 0, bottom_right_y))
	immediate_mesh.surface_add_vertex(Vector3(bottom_right_x, 0, bottom_right_y))
	immediate_mesh.surface_add_vertex(Vector3(top_left_x, 0, bottom_right_y))
	immediate_mesh.surface_add_vertex(Vector3(top_left_x, 0, bottom_right_y))
	immediate_mesh.surface_add_vertex(Vector3(top_left_x, 0, top_left_y))
	immediate_mesh.surface_end()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	material.albedo_color = Color.BLACK
	add_child(mesh_instance)
	mesh_instance.global_transform = Transform3D.IDENTITY
	mesh_instance.global_position = Vector3(global_position.x, target.global_position.y, global_position.z)
	await get_tree().process_frame
	mesh_instance.queue_free()
