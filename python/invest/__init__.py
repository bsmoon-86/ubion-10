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
        # _df의 결측치와 무한대 제거하고 기준이 되는 컬럼만 두고 나머지 삭제
        flag = _df.isin([np.nan, np.inf, -np.inf]).any(axis=1)
        self.df = _df.loc[flag, [_col]]
        