extends Node


# This file can be reference to encode or decode packets

###### Float ######

# Decode
func float_from_pba(pool_byte_array : PoolByteArray, spb : StreamPeerBuffer):
	spb.data_array = pool_byte_array
	return spb.get_float()
