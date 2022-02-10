extends Node

class Point:
	var x
	var y
	func _init(spb: StreamPeerBuffer):
		x = spb.get_float()
		y = spb.get_float()

class Player:
	var paddle
	var score
	func _init(spb: StreamPeerBuffer):
		paddle = spb.get_float()
		score = Base.get_varint(spb, spb.get_position())		

class PlayerState:
	var playerA
	var playerB
	var ball
	func _init(spb: StreamPeerBuffer):
		playerA = Player.new(spb)
		playerB = Player.new(spb)
		ball = Point.new(spb)


