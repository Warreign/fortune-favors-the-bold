extends Node

signal end

var sb

@export var hair_prefab: PackedScene
@export var HAIR_NUMBER = 300
@export var CHANCE = 50
@export var MAX_CHANCE = 100

var colorRed = Color("ff0000")
var colorOrange = Color("e8680f")
var colorGreen = Color("00ff00")

# inspiration for timer: https://www.youtube.com/watch?v=HrBjzSqEpwE
var clock_format = "%02d:%02d:%02d" 

var hair_list: Array[Node]
var hair_num = 0

@export var MAX_ITERATION = 10
var current_iteration = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print(len(CHAR_LIST))
	
	#https://forum.godotengine.org/t/godot-4-0-change-progress-bar-fill-color/627
	sb = StyleBoxFlat.new()
	$"../CenterContainer/ProgressBar".add_theme_stylebox_override("fill", sb)
	sb.bg_color = colorGreen
	
	$"../CenterContainer/ProgressBar".max_value = $ThinkTimer.wait_time
	
	$"../Clock/ClockLabel".text = clock_format % [60, 0, 0]
	hair_num = HAIR_NUMBER
	spawn_hairs(hair_num)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if hair_num <= 0:
		print("em")
		#hair_num = HAIR_NUMBER
		#spawn_hairs(hair_num)
		$"../CenterContainer/Control/CorrectLabel".visible = true
		$CorrectTimer.start()
		#$ThinkTimer.start()
		#current_iteration += 1
		emit_signal("end")
	
	if Input.is_action_just_pressed("start_cut") and not $"..".is_paused:
		AudioManager.shave.play()
	
	if Input.is_action_just_released("start_cut"):
		AudioManager.shave.stop()
	
	if $"..".is_paused:
		$ThinkTimer.paused = true
	
	if not $"..".is_paused and $ThinkTimer.paused:
		$ThinkTimer.paused = false
	
	var wt = $ThinkTimer.wait_time
	var tl = $ThinkTimer.time_left
	
	var msec = fmod(tl, 1) * 1000
	var sec = fmod(tl, 60)
	var minit = tl / 60

	$"../Clock/ClockLabel".text = clock_format % [minit, sec, msec]

	$"../CenterContainer/ProgressBar".value = wt - tl
	
	if tl < wt/2:
		#red
		sb.bg_color = colorOrange.lerp(colorRed, ((wt/2-tl)/(wt/2)))
	else:
		#green
		sb.bg_color = colorGreen.lerp(colorOrange, ((wt-tl)/(wt/2)))
	
	if current_iteration > MAX_ITERATION:
		pass
	else:
		$"../Label".text = str(current_iteration)
	
	#$ThinkTimer.start()


func _on_timer_timeout() -> void:
	print("Bembelem Timer")
	$"../CenterContainer/Control/WrongLabel".visible = true
	free_hair()
	
	$WrongTimer.start()
	#$ThinkTimer.start()
	current_iteration += 1
	emit_signal("end")


func _on_correct_timer_timeout() -> void:
	$"../CenterContainer/Control/CorrectLabel".visible = false


func _on_wrong_timer_timeout() -> void:
	$"../CenterContainer/Control/WrongLabel".visible = false


func spawn_hairs(number: int):
	# var spawn_rect = $"../ReferenceRect"
	var spawn_rad = $"../Area2D/ReferenceHeadCollision".shape.radius
	var rect_center = $"../Area2D/ReferenceHeadCollision".global_position
	var pos
	var radius
	var angle
	# https://www.youtube.com/watch?v=33odP1o2N2Q
	for n in number:
		radius = randf_range(-spawn_rad, spawn_rad)
		angle = randf_range(0, 2*PI)
		pos = rect_center + Vector2(radius * cos(angle), radius * sin(angle))
		# pos = spawn_rect.position +\
		#  Vector2(randf() * spawn_rect.size.x, randf() * spawn_rect.size.y)
		spawn_hair(hair_prefab, pos)
		
	# var spawnArea = $"../Area2D/ReferenceHeadCollision".shape.radius
	# var origin = $"../Area2D/ReferenceHeadCollision".global_position -  Vector2(spawnArea, spawnArea)
	
	# var x = randf_range(origin.x, spawnArea)
	# var y = randf_range(origin.y, spawnArea)
	
	# spawn_hair(hair_prefab, Vector2(x,y))


func spawn_hair(prefab, pos):
	var inst = prefab.instantiate()
	add_child(inst)
	hair_list.append(inst)
	inst.position = pos
	inst.connect("cut", _on_hair_cut)


func free_hair():
	for d in hair_list:
		d.free()
	
	hair_list.clear()
	hair_num = HAIR_NUMBER
	spawn_hairs(hair_num)


func _on_hair_cut(drt: Node) -> void:
	var chance_current = randi() % MAX_CHANCE 
	if (Input.is_action_pressed("start_cut")) and (chance_current <= CHANCE):
		print(chance_current)
		hair_list.erase(drt)
		print(drt)
		drt.queue_free()
		hair_num -= 1
