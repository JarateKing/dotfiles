import sys, re

should_print = True
should_count = False
include_next = False
exclude_next = False
pool_next = False
sort_type = "none"

include_regex = []
exclude_regex = []
letterpool = ""

def print_help():
    print('a utility to search through a wordlist with regex')
    print('usage: dict_search [options/regex]')
    print('')
    print('options:')
    print('--help/-h        prints this help text')
    print('--exclude/-e     excludes any words that match the following regex')
    print('--include/-i     only include words that match the following regex')
    print('--summary/-s     also list count/percent of words matched')
    print('--only-count/-c  only list count/percent of words matched')
    print('--pool           limit words to a set number of letters by argument')
    print('                 a ? character indicates a wildcard')
    print('--ascending      sort in ascending alphabetical order')
    print('--descending     sort in descending alphabetical order')
    print('--smallest       sort in ascending order by string length')
    print('--largest        sort in descending order by string length')
    print('')
    print('examples:')
    print('dict_search hi               words that contain "hi"')
    print('dict_search ^h.*i$           words that start with "h" and end with "i"')
    print('dict_search q --exclude qu   words with "q" but no "qu"')
    print('dict_search --pool aboo      words with at most 1 a, 1 b, 2 o')

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
    elif pool_next:
        pool_next = False
        letterpool = arg.lower()
    elif arg == '--help' or arg == '-h':
        print_help()
        exit()
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
    elif arg == "--ascending":
        sort_type = "ascending"
    elif arg == "--descending":
        sort_type = "descending"
    elif arg == "--smallest":
        sort_type = "smallest"
    elif arg == "--largest":
        sort_type = "largest"
    elif arg == "--pool":
        pool_next = True
    else:
        include_regex.append(arg)

total = 0
count = 0

wordlist = []

with open(sys.argv[1]) as words:
    for word in words:
        word = word.strip()
        lowercase = word.lower()
        
        total += 1
        
        is_good = True
        
        for regex in include_regex:
            if (not re.search(regex, word)):
                is_good = False
        for regex in exclude_regex:
            if (re.search(regex, word)):
                is_good = False
        
        if letterpool != "":
            if not word.isalpha():
                is_good = False
            else:
                letterpool = letterpool.lower()
                wildcards = letterpool.count('?')
                
                for char in 'abcdefghijklmnopqrstuvwxyz':
                    curcount = lowercase.count(char) - letterpool.count(char)
                    if curcount > 0:
                        wildcards -= curcount
                
                if wildcards < 0:
                    is_good = False
        
        if is_good:
            count += 1
            if should_print:
                wordlist.append(word)

if should_print:
    if sort_type == "ascending":
        wordlist = sorted(wordlist, key=str.lower)
    elif sort_type == "descending":
        wordlist = reversed(sorted(wordlist, key=str.lower))
    elif sort_type == "smallest":
        wordlist = sorted(wordlist, key=len)
    elif sort_type == "largest":
        wordlist = reversed(sorted(wordlist, key=len))
    
    print('\n'.join(wordlist))

if should_count:
    if (should_print):
        print() # bit of spacing for summaries
    print("{}/{} ({:.4f}%)".format(count, total, count / total * 100))
