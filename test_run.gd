extends Node2D

var spb = StreamPeerBuffer.new()

func _ready():
	# Float Decode
	# EncodeDecode.float_from_pba([0, 0, 72, 67], spb)
	
	spb.data_array = [0, 0, 72, 67, 130, 44, 0, 0, 72, 67, 0, 0, 0, 150, 67, 0, 0, 72, 67]
	var x = Types.PlayerState.new(spb)
	print("Player A Paddle: ", x.playerA.paddle)
	print("Player A Score: ", x.playerA.score)
	print("Player B Paddle: ", x.playerB.paddle)
	print("Player B Score: ", x.playerB.score)
	print("Ball X: ", x.ball.x)
	print("Ball Y: ", x.ball.y)

