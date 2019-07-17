#!/usr/bin/env python
# Created by Varun at 16/04/19

import sys

# input comes from STDIN (standard input)
for line in sys.stdin:
    # remove leading and trailing whitespace
    line = line.strip()
    # split the line into words
    words = line.split()
    # increase counters
    for word in words:
        for w in words:
            if w != word:
                print('%s|%s\t%s' % (word, w, 1))
