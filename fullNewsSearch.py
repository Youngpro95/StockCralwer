import os
import sys
import time
from bs4 import BeautifulSoup
import requests,logging
import json

logging.basicConfig(
    filename=os.getcwd()+"\py_error_log\\news_full_error.log",
    format= '%(asctime)s [%(levelname)s] [%(filename)s:%(lineno)s] >> %(message)s',
    datefmt= '%m/%d/%Y %I:%M:%S %p',
    level = logging.ERROR
)

def full_news_search():
    try:
        with open('vi_data.json', 'r', encoding='utf-8') as json_result:
            json_data = json.load(json_result)
        headers = {'User-Agent': 'Mozilla/5.0 (Windows; U; MSIE 9.0; WIndows NT 9.0; ko-KR))',} #안티 크롤링
        for i in json_data["listDate"]:  # json 파일 decoding
            num = i["stk_id"]
            keyword = i["stk_nm"]  # 종목명
            print(num + "번째 : " + i["stk_nm"])
            url = "https://search.naver.com/search.naver?where=news&query="+keyword+"&sm=tab_opt&sort=0&photo=0&field=0&reporter_article=&pd=1&ds=&de=&docid=&nso=so%3Ar%2Cp%3A1w%2Ca%3Aall&mynews=0&refresh_start=0&related=0"
            req = requests.get(url.format(keyword))
            soup = BeautifulSoup(req.text, 'html.parser')

            news_dict = {}
            data = []

            table = soup.select('#main_pack > section > div > div.group_news > ul > li')
            for i in table:
                news_title = i.find(class_='news_tit').text
                news_href = i.find(class_='news_tit')['href']
                news_time = i.find("span", {"class": "info"}).text
                word_filter = ['일', '시간', '분']
                for x in word_filter:
                    if x in news_time:
                        news_dict = {'news_company': keyword, 'news_title': news_title, 'news_time': news_time,'news_href': news_href}
                        data.append(news_dict)  # 배열 추가
                        news_dict = {'news_Data': data}
                print(news_title + " " + news_time)
                print(news_href)
            with open('news_search_data.json', 'w', encoding="utf-8") as f:  # json 파일 저장 현재경로에
                json.dump(news_dict, f, ensure_ascii=False, indent="\t")
            # send_json = json.dumps(news_dict, indent='\t')
            # url = 'http://localhost:8082/stock/VI_NewsReg'
            # headers = {'Content-Type': 'application/json; charset=utf-8'}
            # requests.post(url=url, data=send_json, headers=headers)
        print("크롤링 끝")
        time.sleep(600)
    except Exception as e:
        logging.error("ERROR : %s", e)
        sys.exit(1)
    full_news_search()

if __name__ == '__main__':
    full_news_search()
