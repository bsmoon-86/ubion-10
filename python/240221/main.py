## flask 프레임워크 로드 (특정 기능만 호출)
from flask import Flask, render_template, request, redirect
## custom database module 로드 
import database
import pandas as pd
## database에 있는 MyDB1 class 생성 
mydb = database.MyDB(
    _host = '172.16.12.155', 
    _port = 3306, 
    _user = 'ubion', 
    _password = '1234', 
    _database = 'ubion10'
)
## Flask class  생성
## __name__ : 현재 파일의 이름을 출력
app = Flask(__name__)

##네비게이터 생성
@app.route("/")
def index():
    # return "Hello World"
    return render_template('index.html')

@app.route('/login')
def login():
    # 유저가 보낸 데이터를 서버가 변수에 저장
    user_id = request.args['input_id']
    user_pass = request.args['_password']
    print(request.args)
    print('ID :', user_id)
    print("PASS :", user_pass)
    # Database에서 user table에서 유저가 입력한 
    # 아이디 패스워드가 존재하는가?
    sql = """
        select * from 
        user 
        where id = %s and password = %s
    """
    result = mydb.sql_query(sql, user_id, user_pass)
    print(result)
    if result:
        return "로그인 성공"
    else:
        return "로그인 실패"

# localhost:8080:/login2 주소로 post 방식으로 요청을 보냈을때    
@app.route("/login2", methods=['POST'])
def login2():
    # post 방식으로 유저가 서버에게 데이터를 보낼때 
    user_id = request.form['input_id']
    user_pass = request.form['input_password']
    # print(request.form)
    # print(user_id)
    # print(user_pass)
    # Database에서 user table에서 유저가 입력한 
    # 아이디 패스워드가 존재하는가?
    sql = """
        select * from 
        user 
        where id = %s and password = %s
    """
    result = mydb.sql_query(sql, user_id, user_pass)
    # print(result)
    # result -> [{'id' : test, 'password' : 1234, 'name' : 'ubion', 'loc' : Guro}]
    # result[0] -> {'id' : test, 'password' : 1234, 'name' : 'ubion', 'loc' : Guro}
    # result[0]['name'] -> 'ubion'
    if result:
        user_name = result[0]['name']
        # 로그인이 성공했을때 새로운 페이지를 보여주고 해당 페이지에 
        # 로그인을 한 유저의 이름과 인사문구 출력
        return render_template('main.html', _name = user_name)
    else:
        # 로그인이 실패했을때 로그인 화면으로 되돌아간다. 
        # redirect({api})
        return redirect("/")

@app.route('/view_corona')
def view_corona():
    # corona 데이터를 로드 
    df = pd.read_csv("corona.csv", index_col=0)
    # 필요한 컬럼들만 추출 ['createDt', 'deathCnt', 'decideCnt', 'stateDt']
    df = df[ [ 'createDt', 'deathCnt', 'decideCnt', 'stateDt' ] ]
    # 컬럼의 이름 변경 
    df.columns = ['등록일시', '총사망자', '총확진자', '기준일']
    # 기준일 데이터를 기준으로 하여 오름차순 정렬
    df.sort_values('기준일', inplace=True)
    # 인덱스를 초기화하고 기존의 인덱스를 제거 
    df.reset_index(drop=True, inplace=True)
    # 파생변수 생성 
    df['일일사망자'] = df['총사망자'].diff().fillna(0)
    df['일일확진자'] = ( df['총확진자'] - df['총확진자'].shift() ).fillna(0)
    result = df.tail(20)
    cols = result.columns
    val = result.values
    colsCnt = len(cols)
    valCnt = len(val)
    x = result['기준일'].to_list()
    y = result['일일사망자'].to_list()
    print(cols)
    print(val)
    return render_template('corona.html', 
                           columns = cols, 
                           values= val, 
                           c_cnt = colsCnt, 
                           v_cnt = valCnt, 
                           axis_x = x, 
                           axis_y = y)

    
## openapi의 방식 api 생성
@app.route('/corona')
def corona():
    # serviceKey를 체크 
    serviceKey = request.args['serviceKey']
    # 데이터의 개수를 체크
    _limit = request.args["_limit"]
    print(_limit)
    if serviceKey == "aaa":
        # Database에서 corona 데이터를 로드 
        sql = f"select * from corona limit {_limit}"
        result = mydb.sql_query(sql)
        return result
    else:
        return "Service Key Error"
# http://127.0.0.1:8080/corona?serviceKey=aaa&_limit=1
    # http://172.16.12.155:8080
## 웹 서버를 시작 
app.run(host="0.0.0.0" , port = 8080, debug=True)