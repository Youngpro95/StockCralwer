import requests,time
start_timer = time.time()
url = 'https://gwi613lhf4.execute-api.ap-northeast-2.amazonaws.com/test'

data = requests.get(url)
print(data.status_code)
print(data.text)
print("time :", time.time() - start_timer)  # 실행시간