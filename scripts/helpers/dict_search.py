import sys, re

should_print = True
should_count = False
include_next = False
exclude_next = False

include_regex = []
exclude_regex = []

for arg in sys.argv[2:]:
	# priority:
	# - the argument of `-i .` and `-e .`
	# - standard arguments, including the first part of `-i` and `-e`
	# - anything else is assumed to be a regex
	if include_next:
		include_next = False
		include_regex.append(arg)
	elif exclude_next:
		exclude_next = False
		exclude_regex.append(arg)
	elif arg == '--only-count' or arg == '-c':
		should_print = False
		should_count = True
	elif arg == '--summary' or arg == '-s':
		should_print = True
		should_count = True
	elif arg == '--include' or arg == '-i':
		include_next = True
	elif arg == '--exclude' or arg == '-e':
		exclude_next = True
	else:
		include_regex.append(arg)

total = 0
count = 0

with open(sys.argv[1]) as words:
	for word in words:
		word = word.strip()
		
		total += 1
		
		is_good = True
		
		for regex in include_regex:
			if (not re.search(regex, word)):
				is_good = False
		for regex in exclude_regex:
			if (re.search(regex, word)):
				is_good = False
		
		if is_good:
			count += 1
			if should_print:
				print(word)

if should_count:
	print("{}/{} ({:.4f}%)".format(count, total, count / total * 100))
