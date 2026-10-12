import re
import sys

with open(sys.argv[1], 'r', encoding='utf-8') as data:
	text = data.read()
	
	with open(sys.argv[2], 'r', encoding='utf-8') as replacements:
		for replacement in replacements:
			replacement = replacement.strip().split('\t')
			
			text = re.sub(replacement[0], replacement[1], text)

	print(text, end='')
