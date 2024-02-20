# flask 프레임워크를 로드 
from flask import Flask, render_template

## Flask class 생성 
## Flask({파일의 이름})
## __name__ : 현재 파일의 이름
app = Flask(__name__)

# 웹서버의 주소는 localhost:8080
# api목록들을 생성 

## @? -> 네비게이터 함수 -> 연결
## 네이게이터 바로 아래의 함수와 연결
## @app.route('/') -> 웹으로 localhost:8080/ 요청이 들어왔을때
## 바로 아래의 함수를 실행
@app.route('/')
def index():
    # return "Hello World"
    return render_template('index.html')

## localhost:3000/second 요청시
## 아래의 함수를 호출
@app.route("/second")
def second():
    return "Second Page"



## class 내부의 함수 run() 호출 : 웹서버를 오픈
app.run(host = '0.0.0.0',port=3000)