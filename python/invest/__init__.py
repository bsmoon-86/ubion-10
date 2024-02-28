# 4개의 투자전략 모듈을 로드 
from invest.quant import bnh
from invest.quant import bollinger as boll
from invest.quant import halloween as hw
from invest.quant import momentum as mmt
from datetime import datetime
import pandas as pd
import numpy as np
class Invest:
    # 생성자 함수 : class를 생성할때 최초로 한번 실행이 되는 함수
    def __init__(
            self, 
            _df, 
            _col = 'Adj Close', 
            _start = "2010-01-01",
            _end = datetime.now()
    ):
        # Date가 컬럼에 포함되어있다면 인덱스로 변경 
        if 'Date' in _df.columns:
            _df.set_index('Date', inplace=True)
        # 인덱스를 시계열 데이터로 변경 
        _df.index = pd.to_datetime(_df.index, format='%Y-%m-%d')
        # _df의 결측치와 무한대 제거하고 기준이 되는 컬럼만 두고 나머지 삭제
        flag = _df.isin([np.nan, np.inf, -np.inf]).any(axis=1)
        self.df = _df.loc[~flag, [_col]]
        # _start, _end는 시계열 데이터로 변경해서 객체 변수에 대입 
        try:
            self.start = datetime.strptime(_start, "%Y-%m-%d")
            if type(_end) == 'str':
                self.end = datetime.strptime(_end, '%Y-%m-%d')
            else:
                self.end = _end
        except:
            print('투자기간 인자값의 포멧이 잘못되었습니다. (YYYY-mm-dd)')
        self.col = _col

        