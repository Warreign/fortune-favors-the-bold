extends Node

var sb

@export var dirt_prefab: PackedScene
@export var DIRT_NUMBER = 1000

var colorRed = Color("ff0000")
var colorOrange = Color("e8680f")
var colorGreen = Color("00ff00")

var dirt_list: Array[Node]
var dirt_num = 0

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
	
	dirt_num = DIRT_NUMBER
	spawn_dirts(dirt_num)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dirt_num <= 0:
		print("em")
		dirt_num = DIRT_NUMBER
		spawn_dirts(dirt_num)
		$"../CenterContainer/Control/CorrectLabel".visible = true
		$CorrectTimer.start()
		$ThinkTimer.start()
		current_iteration += 1
	
	var wt = $ThinkTimer.wait_time
	var tl = $ThinkTimer.time_left
	
	$"../CenterContainer/ProgressBar".value = wt - tl
	
	if tl < wt/2:
		#red
		sb.bg_color = colorOrange.lerp(colorRed, ((wt/2-tl)/(wt/2)))
	else:
		#green
		sb.bg_color = colorGreen.lerp(colorOrange, wt/2 - ((tl-(wt/2))/(wt/2)))
	
	if current_iteration > MAX_ITERATION:
		pass
	else:
		$"../Label".text = str(current_iteration)
	
	#$ThinkTimer.start()


func _on_timer_timeout() -> void:
	print("Bembelem Timer")
	$"../CenterContainer/Control/WrongLabel".visible = true
	free_dirt()
	
	$WrongTimer.start()
	#$ThinkTimer.start()
	current_iteration += 1


func _on_correct_timer_timeout() -> void:
	$"../CenterContainer/Control/CorrectLabel".visible = false


func _on_wrong_timer_timeout() -> void:
	$"../CenterContainer/Control/WrongLabel".visible = false


func spawn_dirts(number: int):
	var spawn_rect = $"../ReferenceRect"
	var pos
	# https://www.youtube.com/watch?v=33odP1o2N2Q
	for n in number:
		pos = spawn_rect.position +\
		 Vector2(randf() * spawn_rect.size.x, randf() * spawn_rect.size.y)
		spawn_dirt(dirt_prefab, pos)
		


func spawn_dirt(prefab, pos):
	var inst = prefab.instantiate()
	add_child(inst)
	dirt_list.append(inst)
	inst.position = pos
	inst.connect("washed", _on_dirt_washed)


func free_dirt():
	for d in dirt_list:
		d.free()
	
	dirt_list.clear()
	dirt_num = DIRT_NUMBER
	spawn_dirts(dirt_num)


func _on_dirt_washed(drt: Node) -> void:
	dirt_list.erase(drt)
	print(drt)
	drt.queue_free()
	dirt_num -= 1
