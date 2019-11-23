content = []					# stores the body of macro excluding the comments
name = []					# stores the name of macro so as to identify at the time of invocation
matrix = []					# stores arguments
fo = open("test1.txt","r")			# open test file
lines = fo.readlines()
obj = open("result1.txt","w")			# open result file
n = len(lines)
i = 0
def defineMacro():				# function to store the body, name, arguments and type of invocation of macro
	global i
	line = lines[i]				# function is called when #DEF is encountered
	line = line.strip("\n")
	line = line.strip("\t")
	line = line.strip(" ")
	line = line.strip("#DEF")
	line = line.strip(" ")
	nameString = line
	name.append(line)
	i = i+1
	list1 =[]				# stores parameters in particular order
	index1 = name.index(nameString)		
	while i<n and "&" in lines[i] :		# loop to store parameters
		temp = lines[i]
		temp = temp.strip("\t")
		temp = temp.strip("\n")
		temp = temp.strip(" ")
		list1.append(temp)
		i = i+1
	
	matrix.insert(index1,list1)		# storing list1 in matrix
	string = ""
	content.insert(index1,string)		
	while i<n and "END" not in lines[i]:	# loop to store content 
		temp = lines[i]
		if "#DEF" in temp:		# recursive call on finding a nested macro
			defineMacro()
			temp = temp.strip("\t")
			temp = temp.strip("\n")
			temp = temp.strip(" ")
			temp = temp.strip("#DEF")
			temp = temp.strip(" ")
			index2 = name.index(temp)
			string = string + content[index2]
			temp = ""
		elif "//" in temp:		# removing contents from the macro body 
			x = temp.index("//")
			temp = temp[0:x] + "\n"
		string = string + temp
		i = i+1
	content[index1] = string		# finally updating the content
	

def expandMacro():				#Function to expand macro on invocation
	line = lines[i]
	line = line.strip("\t")
	line = line.strip("\n")
	line = line.strip(" ")
	
	list1 = line.split(" ")
	index1 = name.index(list1[0])
	parameters = matrix[index1]		# geting parameters in one list
	string = content[index1]		# getting content in a string
	x = len(list1[0])
	line = line[x:len(line)]		#getting arguments passed in a list
	line = line.strip(" ")
	arguments = line.split(",")	
	for k in range(0,len(arguments)):
		arguments[k] = arguments[k].strip(" ")
	res = ""
	if len(parameters)>0 and "=" in parameters[0]:		# this runs in case keyword invocation of macro
		key = []
		value = []
		for k in range(0,len(parameters)):
			temp = parameters[k].split("=")
			for l in range(0,len(temp)):
				temp[l] = temp[l].strip(" ")
			key.append(temp[0])
			value.append(temp[1])
		for k in range(0,len(arguments)):
			temp = arguments[k].split("=")
			for l in range(0,len(temp)):
				temp[l] = temp[l].strip(" ")
			index3 = key.index(temp[0])
			value[index3] = temp[1]
		j = 0
		while j<len(string):
			if string[j] == "&":
				word = ""
				while j<len(string) and string[j]!=" " and string[j]!="\n" and string[j]!="\t":
					word = word + string[j]
					j = j+1
				j = j-1
				index2 = key.index(word)
				res = res + value[index2]
			else:
				res = res + string[j]
			j = j+1
		obj.write(res)
	else: 							# this runs in case of positional invocation
		j = 0
		while j<len(string):				# loop to substitute parameters in the body of macro
			if string[j] == "&":
				word = ""
				while j<len(string) and string[j]!=" " and string[j]!="\n" and string[j]!="\t":
					word = word + string[j]
					j = j+1
				j = j-1
				index2 = parameters.index(word)
				res = res + arguments[index2]
			else:
				res = res + string[j]
			j = j+1
		obj.write(res)


while i<n:							# going through the text file line by line
	line = lines[i]
	line = line.strip("\n")
	line = line.strip("\t")
	line = line.strip(" ")
	if "#DEF" in line:
		defineMacro()
		
	else:
		list1 = line.split(" ")
		if list1[0] in name:
			expandMacro()
		else:
			obj.write(lines[i])
	
	i = i+1	
obj.close()
fo.close()	
		
		
