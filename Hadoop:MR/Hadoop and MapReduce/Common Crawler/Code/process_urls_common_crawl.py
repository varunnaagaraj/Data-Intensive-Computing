# Created by Varun at 12/04/19

import csv
import sys
from bs4 import BeautifulSoup
import requests
import os
import nltk
from nltk.stem import SnowballStemmer
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
nltk.download('punkt')

reload(sys)
sys.setdefaultencoding('utf8')


def initial_params():
    global count, stop_words, snowstem, topic
    count = 0
    stop_words = set(stopwords.words('english'))
    print(stop_words)
    stop_words = [i.encode('utf-8') for i in stop_words]
    snowstem = SnowballStemmer('english')
    topic = ["war"]


initial_params()
with open('usatoday2.csv') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    for row in csv_reader:
        if str(row[0]).startswith("https://www.usatoday"):
            resp = requests.get(row[0])
            bs = BeautifulSoup(resp.text, 'html.parser')
            paragraphs = bs.findAll("p")
            text = ""
            for para in paragraphs:
                text+=para.text
            word_tokens = word_tokenize(text)
            flag = any(i.lower() in topic for i in word_tokens)
            input_tokens = []
            if flag:
                count +=1
                for w in word_tokens:
                    if (w.lower() not in stop_words and w.isalpha()):
                        input_tokens.append(snowstem.stem(w).encode('utf8'))
                value = " ".join(input_tokens)
                file_name = 'Common_Crawl_files_{}_{}.txt'.format(count, topic[0])
                place_to_store = os.path.join("Data/CC", file_name)
                if text!= "":
                    with open(place_to_store, 'w+') as fp:
                        fp.write(value)
            if count%100 == 0:
                print(count)


