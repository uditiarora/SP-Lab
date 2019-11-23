content = []
content2 = []					# stores the body of macro excluding the comments
name = []					# stores the name of macro so as to identify at the time of invocation
name2 = []
matrix = []
matrix2 = []					# stores arguments
fo = open("test2.txt","r")			# open test file
lines = fo.readlines()
obj = open("result2.txt","w")			# open result file
n = len(lines)
i = 0


def define(string):
	global i
	#string = line[i]
	string = string.strip("\n")
	string = string.strip("\t")
	string = string.strip(" ")
	string = string.strip("$DEF")
	string = string.strip(" ")
	word=""
	j = 0
	
	while j<len(string) and  string[j]!=" " and string[j]!="(":
		word = word+string[j]
		j = j+1
	
	name2.append(word)
	string = string.strip(word)
	string = string.strip(" ")
	string = string.strip("(")
	word = ""
	j = 0
	while j<len(string) and string[j]!=")":
		word = word + string[j]
		j = j+1
	list_first = word.split(",")
	j = 0
	while j<len(list_first):
		list_first[j] = list_first[j].strip(" ")
		j =j +1
	matrix2.append(list_first)
	string = string.strip(word)
	string = string.strip(")")
	string = string.strip(" ")
	string = string.strip("{")
	string = string.strip("}")
	content2.append(string)
	i = i+1
def check_if(string):
	string = string.strip("\t")
	string = string.strip("#IF")
	ans = ""
	expr = ""
	k=0
	while k<len(string) and string[k]!=":":
		expr = expr + string[k]
		k=k+1
	boolean = eval(expr)
	index4 = string.find(":")
	index6 = string.rfind("#ENIF")
	index3 = string.find("#ELSE")
	index5 = string.rfind("#ENELSE")
	
	if boolean==True:
		string = string[index4 + 1:index6]
		
		if "#IF" in string:
			index = string.find("#IF")
			index2 = string.rfind("#ENIF")
			ans = string[0:index] + check_if(string[index:index2])
		else:
			ans = ans + string
	else:
		string = string[index3+6:index5]
		if "#IF" in string:
			index = string.find("#IF")
			index2 = string.rfind("#ENFIF")
			ans = string[0:index] + check_if(string[index:index2])
		else:
			ans = string
	return ans
	
	

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
	

def expand():
	global i
	line = lines[i]
	line = line.strip("\t")
	line = line.strip("\n")
	line = line.strip(" ")
	
	list1 = line.split(" ")
	index1 = name2.index(list1[0])
	param = matrix2[index1]
	string = content2[index1]
	x = len(list1[0])
	line = line[x:len(line)]
	line = line.strip(" ")
	argu = line.split(",")
	for k in range(0,len(argu)):
		argu[k] = argu[k].strip(" ")
	res=""
	j = 0
	while j<len(string) :
		if string[j]=="&":
			word=""
			while j<len(string) and string[j]!=" " and string[j]!="\n" and string[j]!="\t":
				word = word + string[j]
				j = j+1
			j = j-1
			index2 = param.index(word)
			res = res + argu[index2]
		else:
			res = res + string[j]
		j = j+1
	obj.write(res)
	i = i+1
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
		
	final=res
	if "#IF" in res:
		ind = res.find("#IF")
		ind2 = res.rfind("#ENELSE")
		final = res[0:ind] + check_if(res[ind:ind2]) + res[ind2+8 : len(res)]
	obj.write(final)
	

while i<n:							# going through the text file line by line
	line = lines[i]
	line = line.strip("\n")
	line = line.strip("\t")
	line = line.strip(" ")
	if "$DEF" in line:
		define(line)
	elif "#DEF" in line:
		defineMacro()
		
	else:
		list1 = line.split(" ")
		if list1[0] in name:
			expandMacro()
			i=i+1
		if list1[0] in name2:
			expand()
		else:
			obj.write(lines[i])
	
	i = i+1	
obj.close()
fo.close()	
		
		
