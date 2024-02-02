# 매개변수가 존재하지 않는 함수를 생성
func_1 <- function(){
  print('Hello R')
}
# 생성된 함수를 호출 
func_1()
func_2 <- function(){
  return ("Hello R")
}
func_2()
result1 <- func_1()
result2 <- func_2()
print(result1)
# 매개변수 존재하는 함수 생성
func_3 <- function(input_x, input_y){
  result <- input_x + input_y
  print(result)
}
result3 = func_3(10, 3)

# 변수의 종류
# 전역 변수 
#   함수 내부나 외부 어디서든 사용이 가능한 변수 
# 지역 변수 
#   함수 내부에서 생성된 변수들은 함수 내부에서만 사용이 가능
#   함수의 외부에서 지역 변수를 호출하면 호출이 되지 않는다. 
#   휘발성 변수라고 부르기도 한다. 
print(result)
# 매개변수
#   함수를 생성할 때 인자 값(입력값)이 저장되는 공간
#   지역변수와 마찬가지로 함수 내부에서만 사용이 가능


# 매개변수의 개수와 인자의 개수를 다르게 호출하는 경우 
func_3(10)
func_3(10, 3, 2)

# 인자 개수가 가변인 경우의 함수를 생성 
func_4 <- function(...){
  print(c(...))
}
func_4()
func_4(1, 2, 3, 4)
func_4(10, 20, 30, 40, 50, 60, 70)

# 함수를 이용해서 커스텀 연산자 생성 
"%s%" <- function(input_x, input_y){
  result <- input_x ^ input_y
  return (result)
}
10 %s% 5

# 매개변수에 기본값을 설정하여 함수를 생성 
func_5 <- function(input_x, input_y = 2, input_z = 3){
  result <- input_x + input_y - input_z
  return (result)
}
func_5(5, 10, 3)
func_5(5)
# func_5(5, 10, 3) 호출 
# -> input_x = 5, input_y =10, input_z = 3
# -> result = 5 + 10 - 3
# -> return (12)
# func_5(5) 호출
# -> input_x = 5, input_y = 2, input_z = 3
# -> result = 5 + 2 - 3
# -> return (4)
func_5(10, input_z = 1)

# 매개변수가 2개인 함수를 생성 
# 매개변수 사이의 값들을 모두 합하여 되돌려주는 함수 생성 
func_6 <- function(start, end){
  # start부터 end까지의 합
  # 누적합을 할수있는 데이터의 공간 생성 (변수 생성)
  result = 0
  # start부터 end까지 반복을 하는 반복문을 생성
  for (i in start:end){
    # i에 대입 되는 데이터는? -> 벡터 데이터의 각 원소들이 하나씩 
    # 대입 하여 반복 실행
    # result에 누적합 실행
    result = result + i
  }
  return (result)
}
func_6(1, 10)
func_6(1, 100)

min(5, 3, 8, 1, 10)
max(10, 3, 6, 11, 8)

## zoom 
## ID : 569 640 9247
## pass : 1227

## 함수를 생성 
## 매개변수는 2개 생성
## 첫번째 매개변수는 데이터 하나를 저장 
## 두번째 매개변수는 인자의 개수가 가변인 경우
func_8 <- function(val, ...){
  # 최소값을 되돌려주는 함수 
  result <- val
  # result와 두번째 입력 값을 비교 하여 
  # 작은 값을 result에 담아준다. 
  for (i in c(...)){
    if (result > i){
      result <- i
    } 
  }
  return (result)
}
func_8(10, 3)
func_8(3, 4)
func_8(10, 2, 5, 1, 7)
# func_8(10, 2, 5, 1, 7) 호출
# -> val = 10, ... = 2, 5, 1, 7
# -> result = 10
# -> for (i in c(2, 5, 1, 7))
# -> 첫번째 반복
#     -> i = 2
#     -> if (10 > 2)
#     -> 조건식이 참이므로 -> result = 2
# -> 두번째 반복
#     -> i = 5
#     -> if (2 > 5)
#     -> 조건식이 거짓 -> 아무 행동도 하지 않는다.
# -> 세번째 반복
#     -> i = 1
#     -> if (2 > 1)
#     -> 조건식이 참 -> result = 1
# -> 네번째 반복
#     -> i = 7
#     -> if (1 > 7)
#     -> 조건식이 거짓 -> 아무 행동도 하지 않는다.
# 반복문이 종료
# return (1)

# 평균을 구하는 함수 생성 
# 매개변수가 가변인 함수 생성 
  # 인자 값들을 모두 더한다. (반복문 사용)
  # 합계 라는 초기 데이터를 생성하여 0을 대입
  # 인자들을 백터 데이터로 변환
  # 반복문을 이용하여 모든 데이터를 누적합
  # 합계에 인자의 개수로 나눠준다. 
  # 결과를 되돌려준다.
func_9 <- function(...){
  result = 0
  cnt = 0
  for (i in c(...)){
    # print(i)
    result = result + i
    cnt = cnt + 1
  }
  avg_result = result / cnt
  return (avg_result)
}
func_9(5,3,4)

sum(5, 3, 2)
length(c(3, 2, 1))
func_10 <- function(...){
  result = sum(...) / length(c(...))
  return (result)
}
func_10(5, 3, 1)

sum()
length()

test_sum <- function(...){
  result = 0
  for (i in c(...)){
    result  = result + i
  }
  return(result)
}
test_sum(5, 3, 1)
test_sum()

test_len <- function(value){
  cnt = 0
  for (i in value){
    cnt = cnt + 1
  }
  return (cnt)
}
test_len(c(1,5,3))
test_len()

## 데이터프레임 생성 
## 벡터데이터들을 이용하여 데이터프레임 생성
name <- c('A', 'B', 'C', 'D', 'E')
grade <- c(1, 3, 2, 2, 1)
data.frame(name, grade) -> student

## 행렬 생성 
## cbind() : 열을 추가하는 함수
midturm <- c(70, 80, 75, 60, 90)
final <- c(80, 90, 70, 75, 85)
score <- cbind(midturm, final)

## 행렬과 데이터프레임을 결합
data.frame(student, score)
cbind(student, score)

## 백터데이터를 생성
gender = c('M', 'F', 'F', 'M', 'F')

## 데이터프레임과 벡터 데이터와 행렬을 결합
data.frame(student, gender, score)
cbind(student, gender, score) -> students

test_vec = c(1, 2, 3, 4)
# 길이가 다른 벡터데이터를 결합
cbind(students, test_vec)
data.frame(students, test_vec)

# 파생변수를 생성 
# 데이터프레임에서 새로운 컬럼을 추가 
# 기존에 있는 데이터에서 분석에서 
# 사용할 데이터가 존재하지 않을때
# 데이터들을 가공하여 새로운 데이터를 생성
students
# 기존에 생성했던 벡터데이터들의 합
midturm + final
# 데이터프레임에서 특정 컬럼을 선택하여 합
students$midturm + students[['final']] -> total

# cbind(), data.frame() 함수를 이용하여 파생변수 생성
cbind(students, total)
data.frame(students, total)

students$total <- students$midturm + students$final
students

### students에 파생변수를 생성
### 평균성적을 생성
### case1 : total / 2
### case2 : (midturm + final) / 2
### 컬럼의 이름은 mean

# total 컬럼의 데이터만 추출 
students$total / 2 -> mean
students$total / c(2, 2, 2, 2, 2)

data.frame(students, mean)
cbind(students, mean)

students$mean <- (students$midturm + students$final) / 2
students

# 새로운 학생 정보를 추가 
data.frame(name='F', grade=1, gender='M', midturm = 80, 
           final = 70, total=150, mean = 75) -> new_student
# 데이터프레임 행을 추가 
rbind(students, new_student)
# data.frame() 함수는 행 추가는 X
data.frame(students, new_student)

new_student2 = data.frame(name='G', gender='M', midturm = 80, 
           final = 70, total=150, grade=1, mean = 75)
rbind(students, new_student2)

# 리스트형태 데이터 
list_a = list(name = 'test', age = 20)
list_a$loc = 'seoul'
list_a

## 리스트 데이터에서 value가 벡터 데이터인 경우 
list_b = list(
  name = c('test', 'test2'), 
  age = c(20, 30)
)
list_b
## 리스트 2차원데이터에서 'test' 문자열 추출하려면
## 리스트에서 key 값을 이용하여 데이터를 추출 
list_b$name[1]
list_b[['name']][1]
### 필터
### 데이터프레임명[행의 조건, 열의 조건]
students[1,]
students[c(1, 3), ]
## 학년이 1학년인 학생의 정보만 출력
students$grade == 1 -> flag
students[flag, ]
!flag
students[!flag, ]

## 행과 열의 조건식으로 모두 이용하여 데이터 추출
## 여학생들의 중간, 기말 성적만 추출
## 여학생 -> 인덱스 조건식 (gender == 'F')
## 중간, 기말 성적 -> 컬럼 조건식 (midturm, final)
students$gender == 'F' -> flag2
students[flag2, c('midturm', 'final')]


## 전체 학생중 중간 성적이 80점 이상 그리고
## 기말 성적 80이상인 학생 정보를 출력하라

## 첫번째 조건식 : 중간 성적이 80점 이상
students$midturm >= 80 -> flag3

## 두번째 조건식 : 기말 성적이 80점 이상
students$final >= 80 -> flag4

## 두개의 조건식이 모두 만족하는 학생의 정보 출력 
students[flag3 & flag4]
flag3 & flag4
students

## 데이터의 순서를 변경하는 함수 

## 컬럼의 순서를 변경
student[c('grade', 'name')]

## 인덱스의 순서를 변경 
students[c(3, 2, 1, 5, 4), ]

## 학년을 기준으로 오름차순 정렬
## order() : 벡터데이터의 데이터들을 오름차순 정렬 위치 출력
order(students$grade) -> flag5
students[flag5,]
## 기말 성적을 기준으로 해서 내림차순 정렬
## order() 함수에서 특정 매개변수의 인자 값을 
## TRUE 변경하면 내림차순 정렬
order(students$final, decreasing = TRUE)
order(-students$final) -> flag6

order(students$name, decreasing = TRUE)

students[flag6, ]

# 외부 패키지 설치 
install.packages('dplyr')
# 패키지 로드 
library(dplyr)

# 컬럼의 이름을 변경 
# rename(데이터프레임명, 새로운 컬럼의 이름 = 변경할 컬럼의 이름)
students
rename(students, mean_score = mean) -> students

## ifelse(조건식, 참인경우 출력값, 거짓인 경우 출력값)

## 조건식을 이용하여 파생변수 생성 
ifelse(
  students$mean_score >= 75, 
  'pass', 
  'fail'
) -> res
students$result <- res
students

## 75점 초과인 경우에는 pass
## 75점 인 경우는 hold
## 75점 미만인 경우는 fail
ifelse(
  students$mean_score > 75, 
  'pass', 
  ifelse(
    students$mean_score == 75, 
    'hold', 
    'fail'
  )
)






