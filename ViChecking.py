import os
from selenium import webdriver
import datetime,time
import json,requests,logging

logging.basicConfig(
    filename=os.getcwd()+"\py_error_log\\vi_error.log",
    format= '%(asctime)s [%(levelname)s] [%(filename)s:%(lineno)s] >> %(message)s',
    datefmt= '%m/%d/%Y %I:%M:%S %p',
    level = logging.ERROR
)



def inner_scroll():
    scroll_bar = driver.find_element_by_class_name('CI-FREEZE-SCROLLER-INNER')
    scroll_height = scroll_bar.size['height']
    last_index = driver.find_element_by_xpath('//*[@id="jsMdiContent"]/div/div[1]/div[1]/div[2]')
    scroll_range = 540
    while True:
        try:
            driver.execute_script('arguments[0].scrollTop = arguments[0].scrollHeight=' + str(scroll_range) + '',
                                  last_index)
            scroll_range += 540
        except Exception as e:
            print("실패")
        show_VI()
        if scroll_range >= scroll_height:  # 총 스크롤길이 넘어가면 멈춤
            break
    print("스크롤링 끝")


def show_VI():
    vi_body = driver.find_element_by_xpath('//*[@id="jsMdiContent"]/div/div[1]/div[1]/div[1]/div[2]/div/div/table/tbody').text  # 텍스트 다 긁어오기
    transfer_list = vi_body.split("\n")  # \n 개행문자로 나누기
    vi_result.extend(transfer_list)  # append 를 안한 이유는 텍스트를 리스트로 바꾸는 작업을 하기때문에 append가아닌 extend로 확장시킴


def check_overlap():
    count = 0
    for i in vi_result:
        if vi_result.count(i) == 2:
            count += 1
            vi_result.remove(i)  # 중복값 제거


def setting_vi():
    stock_info_array = []
    convertJson_array = []
    convertJson_dic = {}

    count = 0
    for i in range(len(vi_result)):
        vi_split = vi_result[i].split()  # 공백으로 나눔
        stock_info_array.extend(vi_split)  # 각 배열에 11개로 저장
        stk_id = stock_info_array[0 + count]  # 번호
        stk_cd = stock_info_array[2 + count]  # 종목코드
        stk_nm = stock_info_array[3 + count]  # 종목이름
        if stock_info_array[4 + count] != "KOSPI":  # 띄어쓰기되어 있는 종목 이름 붙이기
            if stock_info_array[4 + count] != "KOSDAQ":
                stk_nm = stock_info_array[3 + count] + " " + stock_info_array[4 + count]
                del stock_info_array[4 + count]
                if stock_info_array[4 + count] != "KOSPI":  # 띄어쓰기되어 있는 종목 이름 붙이기
                    if stock_info_array[4 + count] != "KOSDAQ":
                        stk_nm = stk_nm + " " + stock_info_array[4 + count]
                        del stock_info_array[4 + count]

        stk_pri = stock_info_array[6 + count]  # 가격
        stk_inc = stock_info_array[7 + count]  # 상승률
        stk_act = stock_info_array[9 + count]  # 발동시각

        try:
            stk_rel = stock_info_array[10 + count]  # 해제시각
        except:
            stock_info_array.append("00:00:00") #해제시각이 null값이기에 값 입력
            stk_rel = '00:00:00'
            print(stk_nm + "종목 해제시각 null 대신 00:00:00 입력")

        result_dic = {'stk_id': stk_id, 'stk_cd': stk_cd, 'stk_nm': stk_nm, 'stk_pri': stk_pri, 'stk_inc': stk_inc,
                      'stk_act': stk_act, 'stk_rel': stk_rel}  # 딕셔너리 key:Value 값 입력
        convertJson_array.append(result_dic)  # 딕셔너리를 배열에 추가
        convertJson_dic = {'listDate': convertJson_array}  # 다시 배열을 딕셔너리로 다중 key:value를 이용하기 위하여
        count += 11 #파싱하는 갯수가 10개라서 +=를 11로

    print("json 저장중")
    with open('vi_data.json', 'w', encoding="utf-8") as f:  # json 파일 저장 현재경로에
        json.dump(convertJson_dic, f, ensure_ascii=False, indent="\t")
    with open('vi_data.json', 'r', encoding='utf-8') as json_result:  # json 파일 load
        json_data = json.load(json_result)
    # send_json = json.dumps(json_data, indent='\t')
    # url = 'http://localhost:8082/stock/VI_ListReg'
    # headers = {'Content-Type': 'application/json; charset=utf-8'}
    # requests.post(url=url, data=send_json, headers=headers)

while True:
    test_dir = os.getcwd()+"\py_error_log"
    if os.path.exists(os.getcwd()+"\py_error_log"):
        print("있음")
    else:
        os.makedirs('py_error_log')
    start_timer = time.time()
    now = datetime.datetime.now() #시간
    nowDate = now.strftime('%Y년 %m월 %d일 %H시 %M분 입니다.')
    print(nowDate)
    chrome_options = webdriver.ChromeOptions()
    chrome_options.add_argument('--headless')  # 백그라운드화
    chrome_options.add_argument('--no-sandbox') # Bypass OS security model
    chrome_options.add_argument('--disable-dev-shm-usage')
    chrome_options.add_argument("--disable-setuid-sandbox")
    chrome_options.add_argument('window-size=1920x1080')  # 윈도우 사이즈 크기 조절
    driver = webdriver.Chrome(chrome_options=chrome_options)  # 웹은 크롬&옵션사용
    driver.maximize_window()
    try:
        driver.get('http://data.krx.co.kr/contents/MDC/MDI/mdiLoader/index.cmd?menuId=MDC02021501')  # 크롤링할 url
        time.sleep(1.5)
        full = driver.find_element_by_xpath('//*[@id="jsViewSizeButton"]').click()  # 전체화면 vi해제시각 까지 불러오려고
        time.sleep(2)
        driver.find_element_by_xpath('//*[@id="jsMdiContent"]/div/div[1]/div[1]/div[1]/div[1]/div/div/table/thead/tr[1]/td[9]/div/div/a').click()  # sort 버튼 클릭
        driver.find_element_by_xpath('//*[@id="jsMdiContent"]/div/div[1]/div[1]/div[1]/div[1]/div/div/table/thead/tr[1]/td[9]/div/div/a').click()  # sort 버튼 클릭
    except Exception as e:
        logging.error('ERROR : %s', e)
        time.sleep(2)
        driver.find_element_by_xpath('//*[@id="jsMdiContent"]/div/div[1]/div[1]/div[1]/div[1]/div/div/table/thead/tr[1]/td[9]/div/div/a').click()  # sort 버튼 클릭
        driver.find_element_by_xpath('//*[@id="jsMdiContent"]/div/div[1]/div[1]/div[1]/div[1]/div/div/table/thead/tr[1]/td[9]/div/div/a').click()  # sort 버튼 클릭
    vi_result = []  # 결과값 담을 배열

    show_VI()
    inner_scroll()
    check_overlap()
    setting_vi()

    print(vi_result)

    driver.close() # chrome not reachable 을 해결하려고 close 시도중
    driver.quit()
    print("time :", time.time() - start_timer) #실행시간
    time.sleep(5) # 숫자 = sec 만 수정
    print("드라이버 종료")
