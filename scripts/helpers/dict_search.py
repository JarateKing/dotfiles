import sys, re

with open(sys.argv[1]) as words:
	for word in words:
		word = word.strip()
		
		if (re.search(sys.argv[2], word)):
			print(word)

