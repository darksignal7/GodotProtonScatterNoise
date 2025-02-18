@tool
extends "base_modifier.gd"

@export var noise = FastNoiseLite.new()  # Godot'un kendi gürültü sistemi
@export var noise_scale := 4.0  # Gürültü ölçeği (büyüklüğü)
@export var noise_threshold := 0.0  # Gürültü eşiği (siyah-beyaz ayrımı)
@export var except_density : bool = false
@export var except_density_threshold : float = 0.3
@export var except_chance : int = 3

@export var amount := 10

var _rng: RandomNumberGenerator

func _init() -> void:
	display_name = "Create Inside (Noise)"
	category = "Create"
	warning_ignore_no_transforms = true
	warning_ignore_no_shape = false
	can_override_seed = true
	global_reference_frame_available = true
	local_reference_frame_available = true
	use_local_space_by_default()

	documentation.add_paragraph(
		"Randomly place new transforms inside the area defined by
		the ScatterShape nodes.")

	var p := documentation.add_parameter("Amount")
	p.set_type("int")
	p.set_description("How many transforms will be created.")
	p.set_cost(2)

	documentation.add_warning(
		"In some cases, the amount of transforms created by this modifier
		might be lower than the requested amount (but never higher). This may
		happen if the provided ScatterShape has a huge bounding box but a tiny
		valid space, like a curved and narrow path.")



func _process_transforms(transforms, domain, random_seed) -> void:
	_rng = RandomNumberGenerator.new()
	_rng.set_seed(random_seed)
	noise.seed = random_seed

	var gt: Transform3D = domain.get_global_transform()
	var center: Vector3 = domain.bounds_local.center
	var half_size: Vector3 = domain.bounds_local.size / 2.0
	var height: float = domain.bounds_local.center.y

	var t: Transform3D
	var pos: Vector3
	var new_transforms: Array[Transform3D] = []
	var max_retries = amount * 10  # Fazla deneme sınırı
	var tries := 0

	while new_transforms.size() < amount:
		t = Transform3D()
		pos = _random_vec3() * half_size + center

		if restrict_height:
			pos.y = height

		if is_using_global_space():
			t.basis = gt.affine_inverse().basis

		# 🌟 Noise tabanlı yoğunluk kontrolü
		var noise_value = noise.get_noise_2d(pos.x * noise_scale, pos.z * noise_scale)
		if domain.is_point_inside(pos):
			if noise_value >= noise_threshold:
				t.origin = pos
				new_transforms.push_back(t)
				continue
			elif except_density:
				if noise_value >= noise_threshold - except_density_threshold:
					var chance = randi_range(1,except_chance)
					if chance == 1:
						t.origin = pos
						new_transforms.push_back(t)
						continue
		

		# Sonsuz döngüyü engelle
		tries += 1
		if tries > max_retries:
			break

	transforms.append(new_transforms)

func _random_vec3() -> Vector3:
	var vec3 = Vector3.ZERO
	vec3.x = _rng.randf_range(-1.0, 1.0)
	vec3.y = _rng.randf_range(-1.0, 1.0)
	vec3.z = _rng.randf_range(-1.0, 1.0)
	return vec3
