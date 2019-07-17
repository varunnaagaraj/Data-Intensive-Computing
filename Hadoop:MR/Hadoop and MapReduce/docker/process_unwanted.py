# Created by Varun at 15/04/19

import glob
from nltk.corpus import stopwords
fd = glob.glob("part*.txt")

stop_words = set(stopwords.words('english'))
word = []
for w in stop_words:
    word.append(w.encode("utf-8"))

for file in fd:
    output = open("final_"+file, "w+")
    with open(file) as input:
        lines = input.readlines()
        for line in lines:
            if line[0].isalpha() and line.split()[0] not in word:
                output.write(line)
    output.close()