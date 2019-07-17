# Created by Varun at 14/04/19
from nltk.corpus import stopwords
stops = set(stopwords.words('english'))

fp = open('latest_part-00000_twt_cooc.txt').readlines()
values= dict()
for line in fp:
    items = line.split()
    if items[0] not in stops:
        try:
            values.update({items[0]:int(items[1])})
        except:
            pass

sorted_dict = sorted(values.items(), key=lambda x: x[1], reverse=True)
top_10 = []
with open('latest_part-00000_twt_cooc_top1000.txt', 'w+') as out:
    for i in range(0,2000,2):
        out.write("{}\t{}".format(sorted_dict[i][0], sorted_dict[i][1]))
        out.write("\n")
