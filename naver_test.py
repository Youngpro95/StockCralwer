from bs4 import BeautifulSoup
import requests,datetime,time
import json
import logging
logging.basicConfig(
    filename='./py_naver_saerch_warning.log',
    format= '%(asctime)s [%(levelname)s] [%(filename)s:%(lineno)s] >> %(message)s',
    datefmt= '%m/%d/%Y %I:%M:%S %p',
    level = logging.ERROR
)


def news_search():
    try:
        headers = {'User-Agent': 'Mozilla/5.0 (Windows; U; MSIE 9.0; WIndows NT 9.0; ko-KR))',} #안티 크롤링
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
        with open('news_search_data.json', 'w', encoding="utf-8") as f:  # json 파일 저장 현재경로에
            json.dump(news_dict, f, ensure_ascii=False, indent="\t")
        send_json = json.dumps(news_dict, indent='\t')
        url = 'http://localhost:8082/stock/VI_NewsReg'
        headers = {'Content-Type': 'application/json; charset=utf-8'}
        requests.post(url=url, data=send_json, headers=headers)
    except Exception as e:
        logging.error("ERROR : %s", e)


while True:
    logger = logging.getLogger('simple_example')
    logger.setLevel(logging.DEBUG)
    fh=logging.FileHandler(filename='testlog.log')
    fh.setLevel(logging.INFO)
    # logging.basicConfig(filename='logfile.log', level=logging.ERROR)
    with open('vi_data.json', 'r', encoding='utf-8') as json_result:  # json 파일 load
        try:
            json_data = json.load(json_result)
        except: #json 수정시 겹치는 오류 exception
            print("json 오류")
            print(datetime.datetime.now())
            time.sleep(2)
            continue

    for i in json_data["listDate"]: #json 파일 decoding
        print(i["stk_nm"])
        keyword = i["stk_nm"] #종목명
        vi_time=i["stk_act"]

        now = datetime.datetime.now()  # 시간
        nowDate = now.strftime('%Y년 %m월 %d일 %H시 %M분 입니다.')
        nowtime = now.strftime('%H:%M:%S')
        trans_time = '%H:%M:%S'
        time_cal = now.strptime(nowtime, trans_time) - datetime.datetime.strptime(vi_time, trans_time)

        if int(time_cal.seconds) < 120:
            print("시간계산: " + str(time_cal.seconds)) #시간초 단위로 변환
            print("크롤링 완료")
            news_search()