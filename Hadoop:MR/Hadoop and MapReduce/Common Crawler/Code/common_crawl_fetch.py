# Created by Varun at 12/04/19
# Reference : https://dmorgan.info/posts/common-crawl-python/

import StringIO
import codecs
import csv
import gzip
import json
import logging as log
import sys

import requests
from bs4 import BeautifulSoup

reload(sys)
sys.setdefaultencoding('utf8')


def set_initial_params():
    """
    Initial variables are being set here
    :return:
    """
    global record, links, prefix, count, rec
    record = []
    links = set()
    url = "http://index.commoncrawl.org/CC-MAIN-2019-09-index?url=usatoday.com&matchType=domain&output=json"
    prefix = "https://commoncrawl.s3.amazonaws.com/"
    count = 0
    get_req_response(record, url)


def get_req_response(record, url):
    """
    Send request to S3 server
    :param record: List of records
    :param url: Index link for gathering warc files
    """
    global rec
    response = requests.get(url)
    if response.status_code == 200:
        for rec in response.content.splitlines():
            if rec.__contains__("text/html"):
                record.append(json.loads(rec))
        log.info("Length of the record is:", len(record))


def get_warc_response():
    """
    Process WARC data to get response
    :return:
    """
    global resp
    if len(data):
        try:
            _, _, resp = data.strip().split('\r\n', 2)
        except:
            pass


def get_raw_data():
    """
    Get the url with filename and process the link to get the raw data
    :return: Raw data
    """
    global raw_data
    result = requests.get(prefix + str(rec['filename']), headers={'Range': 'bytes={}-{}'.format(offset, last_val)})
    raw_data = StringIO.StringIO(result.content)
    print(raw_data)


def get_text():
    """
    Method to gather all the data(URLs) from all of the links
    :return:
    """
    global count
    if link:
        for l in link:
            href = l.attrs.get("href")
            if href:
                if href not in links and href.startswith("http"):
                    links.add(href.encode('utf-8'))
                    count += 1
                    if count >= 50:
                        break


def process_records():
    """
    For each record in the index, process the record and get the text from that.
    :return:
    """
    global rec, offset, last_val, resp, data, link
    for rec in record:
        # Remove this if you want lot of urls
        if count >= 50:
            break
        offset, length = int(rec['offset']), int(rec['length'])
        last_val = offset + length - 1
        get_raw_data()
        f = gzip.GzipFile(fileobj=raw_data, mode='rb')
        resp = ""
        data = f.read()
        get_warc_response()

        bs = BeautifulSoup(resp)
        link = bs.find_all("a")
        get_text()

def write_to_csv():
    """
    Add all the URLs obtained into the csv file
    """
    global link
    with codecs.open("usatoday3.csv", "wb", encoding="utf-8") as output:
        fields = ["URL"]
        logger = csv.DictWriter(output, fieldnames=fields)
        logger.writeheader()

        for link in links:
            logger.writerow({"URL": link.encode('utf-8')})


if __name__=="__main__":
    set_initial_params()
    process_records()
    write_to_csv()
