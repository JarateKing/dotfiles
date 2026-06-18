import re, sys

index = 0
lines = ['', '', '', '']

commits = []

for line in sys.stdin:
	lines[index] = line.strip()
	index = (index + 1) % 4
	
	if index == 3:
		print(lines)
	
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

sorttype = 5
sortorder = -1
for arg in sys.argv[1:]:
	if arg == '--reversed' or arg == '-r':
		sortorder = 1
	
	if arg == '--files' or arg == '-f':
		sorttype = 2
	
	if arg == '--added' or arg == '-a':
		sorttype = 3
	
	if arg == '--deleted' or arg == '-d':
		sorttype = 4
	
	if arg == '--total' or arg == '-t':
		sorttype = 5
	
	if arg == '--delta' or arg == '-x':
		sorttype = 6

ordered = sorted(commits, key=lambda x: sortorder * x[sorttype])

for commit in ordered:
	print('f\033[0;33m{}\033[0m\t+\033[0;32m{}\033[0m\t-\033[0;31m{}\033[0m\t#\033[0;36m{}\033[0m\t=\033[0;35m{}\033[0m\t {} \033[0;34m{}\033[0m'.format(commit[2], commit[3], commit[4], commit[5], commit[6], commit[0], commit[1]))
