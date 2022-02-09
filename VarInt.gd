extends Node2D

# varint_to_base_ten_binary(NUMBER) returns bytes in base 10
# some refactoring needed
	
func varint_to_base_ten_binary(num : int):
	if num == 0: 
		return 0
	var raw_binary : String = int2bin(num)
	var reversed_binary : String = reverse_str(raw_binary)
	
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
	
	var rev_svn_grps : Array = []
	for byte in svn_grps:
		rev_svn_grps.push_front(byte)
	
	#add classifier
	if rev_svn_grps.size() > 1:
		for i in range(rev_svn_grps.size()-1):
			rev_svn_grps[i] = "1" + rev_svn_grps[i]
		rev_svn_grps[-1] = "0" + rev_svn_grps[-1]
	else:
		rev_svn_grps[0] = "0" + rev_svn_grps[0]
		
		
			
	var pba = []
	for byte in rev_svn_grps:
		pba.append(bin2dec(int(byte)))
		

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


