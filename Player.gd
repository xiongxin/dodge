extends Area2D
signal hit # 碰撞的信号发射出去，方便停止游戏
export (int) var speed # how fast player will move (pixels/sec);
var screensize # Size of the  game window.
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	speed = 200
	screensize = get_viewport_rect().size
	hide() # when game starts hidden it.

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	var velocity = Vector2() ## The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		# 处理动画
		if velocity.x != 0:
			$AnimatedSprite.animation = "right"
			$AnimatedSprite.flip_v = false
			$AnimatedSprite.flip_h = velocity.x < 0
		if velocity.y != 0:
			$AnimatedSprite.animation = "up"
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.flip_v = velocity.y > 0
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	position += velocity * delta
	# clamp使用该函数防止将Player跑出屏幕外边
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
	
func _on_Player_body_entered(body):
	# 当有物体碰撞到之后触发
	hide()
	emit_signal("hit")
	$CollisionShape2D.disabled = true # 关闭碰撞触发，保证碰撞事件不会触发多次。
	
func start(pos):
	position = pos # 设置当前节点位置
	show() # 显示节点
	$CollisionShape2D.disabled = false # 
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	