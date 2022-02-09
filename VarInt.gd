extends Node2D

# varint_to_base_ten_binary(NUMBER) returns bytes in base 10
# some refactoring needed

func _ready():
	#example
	base_ten_binary_to_varint([130, 44])
	varint_to_base_ten_binary(300)
	

func base_ten_binary_to_varint(pba : PoolByteArray):
	var steps = []
	steps.append(["initial PBA: ", pba])
	#get back reversed seven groups
	var rev_svn_grps : Array = []	
	for byte in pba:
		rev_svn_grps.append(int2bin(byte))
	steps.append(["convert to binary 2: ", rev_svn_grps.duplicate()])
	
	
	
	# add the leading zeros if any
	for i in range (rev_svn_grps.size()):
		var num_zeros = 8 - rev_svn_grps[i].length()
		if num_zeros != 0:
			for j in range (num_zeros):
				rev_svn_grps[i] = "0" + rev_svn_grps[i]
	
	steps.append(["re add the leading zeros: ", rev_svn_grps.duplicate()])
	
	
	# remove the classifier
	for i in range(rev_svn_grps.size()):
		rev_svn_grps[i] = rev_svn_grps[i].right(1)
		
	steps.append(["remove classifier: ", rev_svn_grps.duplicate()])

	
	# make one long binary string and convert to int to remove leading zeros
	var combined_binary = ""
	for bytes in rev_svn_grps:
		combined_binary += bytes
	combined_binary = int(combined_binary)
	
	steps.append(["put binary together and convert to int: ", combined_binary])
	
	# convert binary back to number
	var number = int(bin2int(str(combined_binary)))
	steps.append(["binary to final number: ", number])
	
	
	
	for step in steps:
		print(step)
	print("           ")
			
	
func varint_to_base_ten_binary(num : int):
	var steps = []
	steps.append(["Initial number", num])
	if num == 0: 
		return 0
	var raw_binary : String = int2bin(num)
	steps.append(["raw binary from number", raw_binary])
	var reversed_binary : String = reverse_str(raw_binary)
	steps.append(["reversed the binary", reversed_binary])
	#split into groups of 7
	var svn_grps : Array = []
	var bit_count = 0
	var current_grp = ""
	
	for i in range(reversed_binary.length()):
		if bit_count < 7:
			current_grp = reversed_binary[i] + current_grp
			bit_count += 1
		else: 
			svn_grps.append(current_grp)
			current_grp = reversed_binary[i]
			bit_count = 1
		if i == reversed_binary.length() - 1 and int(current_grp) != 0:
			svn_grps.append(current_grp)
			var zero = "0"
			for j in range(7 - svn_grps[-1].length()):
				svn_grps[-1] = zero + svn_grps[-1]
	steps.append(["split groups into 7", svn_grps])
	

	var rev_svn_grps : Array = []
	for byte in svn_grps:
		rev_svn_grps.push_front(byte)
	steps.append(["reversed the array", rev_svn_grps.duplicate()])


	#add classifier
	if rev_svn_grps.size() > 1:
		for i in range(rev_svn_grps.size()-1):
			rev_svn_grps[i] = "1" + rev_svn_grps[i]
		rev_svn_grps[-1] = "0" + rev_svn_grps[-1]
	else:
		rev_svn_grps[0] = "0" + rev_svn_grps[0]


	steps.append(["add classifier", rev_svn_grps])
		
		
	
	var pba = []
	for byte in rev_svn_grps:
		pba.append(bin2dec(int(byte)))
	
	steps.append(["final pba form base 10", pba])
	
	for step in steps:
		print(step)
	print("           ")
	return pba

func bin2dec(var binary_value):
	var decimal_value = 0
	var count = 0
	var temp
	while(binary_value != 0):
		temp = binary_value % 10
		binary_value /= 10
		decimal_value += temp * pow(2, count)
		count += 1
	return decimal_value

func reverse_str(num : String) -> String:
	var inverted_string : String = ""
	for i in num:
		inverted_string = inverted_string.insert(0,i)
	return inverted_string

func int2bin(value : int):
	var out : String = ""
	while (value > 0):
		out = str(value & 1) + out
		value = (value >> 1)
	return out

func bin2int(bin_str):
	var out = 0
	for c in bin_str:
		out = (out << 1) + int(c == "1")
	return out

