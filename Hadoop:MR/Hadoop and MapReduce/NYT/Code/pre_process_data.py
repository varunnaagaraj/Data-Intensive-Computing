# Created by Varun at 11/04/19

import nltk
from nltk.stem import SnowballStemmer
from nltk.corpus import stopwords
from nltk.tokenize import word_tokenize
import os


stop_words = set(stopwords.words('english'))
words_input_dir = "docker/"
snowstem = SnowballStemmer('english')
for filename in os.listdir(words_input_dir):
    input_tokens = []
    file_path = words_input_dir+filename
    with open(file_path, "r") as input_file:
        text = input_file.read()
        try:
            word_tokens = word_tokenize(text.decode('utf-8'))
        except:
            word_tokens = word_tokenize(text)
        for w in word_tokens:
            if (w not in stop_words and w.isalpha()):
                input_tokens.append(snowstem.stem(w))
    output_path = "docker/processed_data/"+filename
    with open(output_path, 'w+') as output:
        value = " ".join(input_tokens)
        output.write(value.encode('utf-8'))
