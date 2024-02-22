import pandas as pd
import requests
from bs4 import BeautifulSoup as bs
from datetime import datetime

url = "https://finance.naver.com"

response = requests.get(url)

html_data = response.text

soup = bs(html_data, 'html.parser')

div_data = soup.find('div', attrs={
    'class' : 'section_sise_top'
})
# print(div_data)
tables = div_data.find_all('table', attrs={
    'class' : 'tbl_home'
})
# print(tables)
for index in range(len(tables)):
    now = datetime.now()
    date = now.strftime('%y-%m-%d %H-%M-%S')
    ## 컬럼에 들어갈 데이터를 만드는 구간
    th_list = tables[index].find('tr').find_all('th')

    _cols = []

    for i in th_list:
        _cols.append(i.get_text())
    # print(_cols)
        
    tr_list = tables[index].find_all('tr')
        
    _values = []

    for i in range(1, len(tr_list)):
        _val = [tr_list[i].find('th').get_text()]

        td_list = tr_list[i].find_all('td')

        for j in td_list:
            data = j.get_text().strip()
            _val.append(data)

        _values.append(_val)

    # print(_values)
    # 반복 실행 할때마다 다른 변수에 데이터를 저장
    file_list = ['거래상위', '상승', '하락', '시가총액 상위']
    # globals()[f'df_{index}'] = pd.DataFrame(_values, columns=_cols)
    pd.DataFrame(_values, columns=_cols).to_csv(
        f'{file_list[index]}_{date}.csv')

    