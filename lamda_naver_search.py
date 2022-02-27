import json
from bs4 import BeautifulSoup
import requests,time

def lambda_handler(event, context):
    headers = {'User-Agent': 'Mozilla/5.0 (Windows; U; MSIE 9.0; WIndows NT 9.0; ko-KR))', }  # 안티 크롤링
    search_word = "아이에이"
    url = "https://search.naver.com/search.naver?where=news&sm=tab_jum&query=" + search_word
    req = requests.get(url.format(search_word))
    soup = BeautifulSoup(req.text, 'html.parser')
    data = []

    table = soup.select('#main_pack > section > div > div.group_news > ul > li')
    for i in table:
        news_title = i.find(class_='news_tit').text
        news_href = i.find(class_='news_tit')['href']
        news_time = i.find("span", {"class": "info"}).text
        print(news_title + " " + news_time)
        print(news_href)
        news_dict = {'news_title': news_title, 'news_time': news_time, 'news_href': news_href}
        data.append(news_dict)
        news_dict = {'test': data}

        return {
        'statusCode': 200,
        'body': json.dumps(news_dict)
    }
