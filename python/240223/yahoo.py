from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from bs4 import BeautifulSoup as bs
import pandas as pd
import time

driver = webdriver.Chrome()

# 네이버로 이동 
driver.get('https://www.naver.com')

# 검색어창을 선택 
element  = driver.find_element(By.ID, 'query')

# 검색어에 '야후파이낸스' 입력 
element.send_keys('야후파이낸스')

# 엔터키를 입력한다. 
element.send_keys(Keys.ENTER)
# 딜레이 
time.sleep(1)

# element가 class가 link_name인 태그를 선택
element2 = driver.find_element(By.CLASS_NAME, 'link_name')

# 태그를 클릭한다. 
element2.click()
# 딜레이 
time.sleep(1)

driver.switch_to.window(driver.window_handles[1])

element3 = driver.find_element(By.XPATH, 
                       '//*[@id="Nav-0-DesktopNav-0-DesktopNav"]/div/div[3]/div/nav/ul/li[3]/a')

element3.click()
# 딜레이 
time.sleep(1)

element4 = driver.find_element(By.XPATH, 
                               '//*[@id="SecondaryNav-0-SecondaryNav-Proxy"]/div/ul/li[3]/a')

element4.click()

# 딜레이 
time.sleep(1)

soup = bs(driver.page_source, 'html.parser')

driver.quit()

table_data = soup.find('table')

## 컬럼의 들어갈 데이터를 추출
## table 태그에서 thead 태그의 정보들을 추출 
## th마다 컬럼의 이름들이 하나씩 존재
thead_data = table_data.find('thead')

th_list = thead_data.find_all('th')

_cols = []

for col in th_list:
    # print(col)
    # print(type(col))
    # print(col.get_text())
    _cols.append(col.get_text())

## tbody의 데이터를 추출
tbody_data = table_data.find('tbody')

tr_list =  tbody_data.find_all('tr')

_values = []
for tr in tr_list:
    # print(tr)
    td_list = tr.find_all('td')
    td_data = []
    for td in td_list:
        td_data.append(td.get_text())
    _values.append(td_data)

df = pd.DataFrame(_values, columns= _cols)

df.to_csv('yfinance_data.csv', mode='a', header=False)

