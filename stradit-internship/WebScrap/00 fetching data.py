import requests
from bs4 import BeautifulSoup

def fetchAndSaveFile(url,path):
    r= requests.get(url)
    with open(path, "w", encoding="utf-8") as f:
        f.write(r.text)
url ="https://timesofindia.indiatimes.com/"

fetchAndSaveFile(url,"WebScrap/times.html")