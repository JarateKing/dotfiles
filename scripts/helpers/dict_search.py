import sys, re

should_print = True
should_count = False

for arg in sys.argv[2:]:
	if arg == '--only-count' or arg == '-c':
		should_print = False
		should_count = True
	if arg == '--summary' or arg == '-s':
		should_print = True
		should_count = True

total = 0
count = 0

with open(sys.argv[1]) as words:
	for word in words:
		word = word.strip()
		
		total += 1
		
		if (re.search(sys.argv[2], word)):
			count += 1
			if should_print:
				print(word)

if should_count:
	print("{}/{} ({:.4f}%)".format(count, total, count / total * 100))
