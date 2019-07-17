# Created by Varun at 18/03/19

from nytimesarticle import articleAPI
import requests
import os
from bs4 import BeautifulSoup
api = articleAPI('ynC4P03PKGbsVy5rbyTHjEcAHfMyGBA7')

for iter_num in range(10):
    articles = api.search(q="obama+war", page=iter_num+1, begin_date = 20190101)
    content = list()
    try:
        for item in articles['response']['docs']:
            item_content = []
            item_content.append(item['pub_date'][0:10])
            item_content.append(item['web_url'])
            item_content.append(int(item['word_count']))
            content.append(item_content)
    except Exception:
        continue
    count = 0
    for item in content:
        try:
            url = item[1]
            print(url)
            temp = requests.get(url)
            data = BeautifulSoup(temp.text, 'html.parser')
            paragraphs=data.find_all(class_="css-1ygdjhk evys1bk0")
            text = ""
            for para in paragraphs:
                text += para.text
            file_name = 'NYT_{}_page_{}_article_{}.txt'.format("obamawar", iter_num, count)
            place_to_store = os.path.join("Data/NYT", file_name)
            if text!= "":
                with open(place_to_store, 'w') as fp:
                    fp.write(text.encode("utf8"))
                    count+=1
        except Exception:
            continue
    print("Number of items got",count)


