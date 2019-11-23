name = []
content = []
matrix = []
fo = open("test.txt","r")
lines = fo.readlines()
obj = open("result.txt","w")
n = len(lines)
i=0


while i<n :
	line = lines[i]
	line = line.strip(" ")
	if "#DEF" in line:
		line = line.strip("#DEF")
		line = line.strip("\n")
		line = line.strip("\t")
		line = line.strip(" ")
		name.append(line)
		i=i+1
		list1 = [] 
		while i<n and "&" in lines[i]:
			temp = lines[i]
			temp = temp.strip("\t")
			temp=temp.strip("\n")
			temp=temp.strip(" ")
			list1.append(temp)
			i = i+1
		matrix.append(list1)
		string = "";
		while i<n and "END" not in lines[i]:
			temp = lines[i]
			temp = temp.strip(" ")
			if "//" in temp:
				x = temp.index("//")
				temp = temp[0:x] + "\n"
			string = string + temp
			i = i+1
		content.append(string)
	
	else: 
		line1 = line.strip("\n")
		line1 = line1.strip("\t")
		line1 = line1.strip(" ")
		list2 = line1.split(" ")
		
		if list2[0] in name:
			x = len(list2[0])
			line1 = line1[x:(len(line1))]
			line1 = line1.strip(" ")
			list3 = line1.split(",")
			for j in range(0,len(list3)):
				list3[j] = list3[j].strip(" ")
			index1 = name.index(list2[0])
			stri = content[index1]
			
			res = ""
			list4 = matrix[index1]
			print(list4)
			list5 = stri.split("\n")
			j=0
			while j<len(stri) :			
				inde=0
				if stri[j] == "&":
					word = "&"
					j=j+1
					while j<len(stri) and stri[j]!="\n" and stri[j]!=" " and stri[j]!="\t":
						word = word + stri[j]
						j = j+1
					j = j-1
					if word in list4:
						inde = list4.index(word)
					res = res + list3[inde]
					print(list3[inde])
				else :
					res = res + stri[j]
				j =j + 1
			obj.write(res)
			print(res)
		else:
			obj.write(line)
			
	i = i+1	
