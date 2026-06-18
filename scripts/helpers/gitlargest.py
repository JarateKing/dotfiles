import fileinput, re

index = 0
lines = ['', '', '', '']

commits = []

for line in fileinput.input():
	lines[index] = line.strip()
	index = (index + 1) % 4
	
	if index == 2:
		# remove the field markers
		lines[0] = lines[0][1:]
		lines[1] = lines[1][1:]
		
		filestring = re.search(r'\d+ f', lines[2])
		insertstring = re.search(r'\d+ i', lines[2])
		deletestring = re.search(r'\d+ d', lines[2])
		
		files = 0
		if filestring != None:
			files = int(filestring.group()[:-2])
		
		inserts = 0
		if insertstring != None:
			inserts = int(insertstring.group()[:-2])
			
		deletions = 0
		if deletestring != None:
			deletions = int(deletestring.group()[:-2])
			
		total = inserts + deletions
		delta = inserts - deletions
		
		commits.append((lines[0], lines[1], files, inserts, deletions, total, delta))

ordered = sorted(commits, key=lambda x: -x[5])

for commit in ordered:
	print('{} {} [f{} +{} -{} #{} ={}]'.format(commit[0], commit[1], commit[2], commit[3], commit[4], commit[5], commit[6]))
