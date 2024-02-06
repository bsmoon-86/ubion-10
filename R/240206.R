## ifelse 함수를 생성
## ifelse( 조건식(벡터데이터), 참인경우 값, 거짓인 경우 값 )
## ifelse함수의 결과 값의 데이터 타입 -> 벡터데이터
a <- c(TRUE, FALSE, TRUE, FALSE, FALSE)
ifelse(a, "T", 'F')

## ifelse함수는 벡터 데이터를 리턴
## ifelse 함수 안에는 비어있는 벡터 데이터에 데이터를 추가하는 부분 존재

## 벡터데이터에 데이터를 추가 
result <- c()
length(result)
## 1부터 10까지 반복을 하는 반복문을 생성
for (i in 1:10){
  # print(i)
  if (i %% 2 == 0){
    # print(i)
    result[length(result)+1] <- i
  }
}
result

vector_a <- c(5, 4, 3, 2, 1)
## 벡터데이터에서 특정 위치의 데이터를 출력 
vector_a[2] <- 10
vector_a
vector_a[6] <- 11
vector_a
length(vector_a)
## ifelse함수를 생성 
## 매개변수 3개
iftest <- function(vector_bool, t, f){
  ## 되돌려주는 데이터는 벡터데이터 -> 빈 벡터를 생성 
  result <- c()
  
  ## vector_bool의 데이터 타입은 벡터
  ## 벡터의 길이만큼 반복하는 반복문을 생성
  ## while문에서 사용할 초기 값을 지정
  i <- 1
  
  # while 조건식
  while (i <= length(vector_bool)){
    ## i가 의미하는 것은? 벡터 데이터의 위치
    ## vector_bool의 i번째 데이터가 참일때
    if(vector_bool[i]){
      ## result에 t인자값(2번째 매개변수)을 추가 
      result[i] <- t
    }else{
      ## vector_bool의 i번째 데이터가 거짓인 경우
      ## result에 f인자값(3번째 매개변수)을 추가 
      result[i] <- f
    }
    i <- i + 1
  }
  return (result)
  
}
iftest(
  c(TRUE, TRUE, FALSE, FALSE), 
  'T', 
  'F'
)


## 결측치 데이터의 처리 
c1 = c(1, 2, NA, 4, 5)
c2 = c(1, 2, 3, 4, 5)
c3 = c(NA, NA, 3, 4, 5)

df = data.frame(c1, c2, c3)
df

str(df)
## 결측치 존재 유무 
is.na(df)
NA == NA
## 결측치의 개수 확인 
## TRUE의 개수를 확인
table(is.na(df))

##is.na 함수를 이용하여 데이터 필터링
is.na(df$c1) -> flag
df[flag,]
df[!flag,]

## 결측치가 포함된 컬럼 데이터는 연산이 제대로 이루어지지 않는다. 
mean(df$c1)
mean(df$c2)
min(df$c1)
max(df$c1, na.rm = T)

# 외부의 데이터 파일을 로드 (csv)
exam = read.csv("../csv/csv_exam.csv")
str(exam)
## 결측치의 개수를 확인 
table(is.na(exam))
## 결측치를 강제로 입력 
exam[c(2, 5), 'math'] <- NA
table(is.na(exam))

exam$math
library(dplyr)

# 수학 성적에서 결측치를 제거 하고 그룹화 연산 
exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math))## 결측치 존재하기때문에 연산이 NA 출력

exam %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math, na.rm=T))
exam %>% 
  filter(!is.na(math)) %>% 
  group_by(class) %>% 
  summarise(mean_math = mean(math))

## 결측치에 특정한 데이터를 대입 
## ifelse() + is.na()
is.na(exam$math)
ifelse(is.na(exam$math),  mean(exam$math, na.rm=T) , exam$math)
ifelse(is.na(exam$math), 0 , exam$math)

## 극단치 
library(ggplot2)

mpg <- ggplot2::mpg
str(mpg)
View(mpg)
## 고속도로 연비 데이터에서 극단치를 확인 
boxplot(mpg$hwy)
# 극단치를 수치화 
boxplot(mpg$hwy)$stats
## 결측치 확인 
table(is.na(mpg$hwy))

## 극단치인 데이터를 결측치로 대체
mpg$hwy < 12 | mpg$hwy > 37 -> flag
table(flag)

ifelse(flag, NA , mpg$hwy) -> mpg$hwy
table(is.na(mpg))

## 컬럼의 이름을 변경 
## manufacturer -> 제조사
## hwy -> 고속도로
## cty -> 시내
## class -> 차종
## drv -> 구동방식
mpg %>% 
  rename(
    제조사 = manufacturer, 
    고속도로 = hwy, 
    시내 = cty, 
    차종 = class, 
    구동방식 = drv
  ) -> mpg

## 제조사별 고속도로의 평균 연비가 어떠한 제조사가 가장 좋은가?

## 컬럼을 제조사, 고속도로 선택 
## 제조사로 그룹화 
## 그룹화 연산 고속도로 평균
## 평균연비 내림차순 정렬 
## 상위 5개 출력 
mpg %>% 
  select(제조사, 고속도로) %>% 
  group_by(제조사) %>% 
  summarise(평균연비 = mean(고속도로, na.rm=T)) %>% 
  arrange(desc(평균연비)) %>% 
  head(5)

mpg %>% 
  filter(!is.na(고속도로)) %>% 
  select(제조사, 고속도로) %>% 
  group_by(제조사) %>% 
  summarise(평균연비 = mean(고속도로)) %>% 
  arrange(desc(평균연비)) %>% 
  head(5)


### 데이터 시각화
### 그래프 표현

### 레이어를 하나씩 추가 하여 그래프를 완성

## 배경 레이어 생성 
ggplot(
  data = mpg, 
  aes(
    x = displ, 
    y = 고속도로
  )
) + geom_point() + xlim(3,6)

## 막대 그래프 
mpg %>% 
  group_by(구동방식) %>% 
  summarise(
    평균연비 = mean(
      고속도로, na.rm =T)) -> group_data

ggplot(
  data = group_data, 
  aes(
    x = 구동방식, 
    y = 평균연비
  )
) + geom_col()

ggplot(
  data = mpg, 
  aes(
    x = 구동방식
  )
) + geom_bar()

## 제조년도별 차량의 개수 라인 그래프
table(mpg$year)  
mpg %>% 
  group_by(year) %>% 
  summarise(count = n()) -> group_data2

ggplot(
  data = group_data2, 
  aes(
    x = year, 
    y = count
  )
) + geom_line()

ggplot(
  data = economics, 
  aes(
    x = date, 
    y = unemploy
  )
) + geom_line()
View(economics)

mpg <- ggplot2::mpg
boxplot(mpg$hwy)
ggplot(
  data = mpg, 
  aes(
    x = drv, 
    y = hwy
  )
) + geom_boxplot()

## sav 파일을 로드 
## foreign 라이브러리 설치 
install.packages('foreign')
library(foreign)

welfare <- read.spss("../csv/Koweps.sav", 
          to.data.frame = T)
str(welfare)
View(welfare)

## 컬럼의 이름을 변경 
welfare %>% 
  rename(
    gender = h10_g3, 
    birth = h10_g4, 
    income = p1002_8aq1, 
    code_job = h10_eco9
  ) -> welfare
## 특정 컬럼만 추출 
welfare_copy <- welfare[c(
  'gender', 'birth', 'income', 'code_job'
)]
## 결측치의 개수 확인 
table(is.na(welfare_copy))
table(is.na(welfare_copy$gender))
table(is.na(welfare_copy$birth))
table(is.na(welfare_copy$income))
table(is.na(welfare_copy$code_job))

## 성별 데이터에서 이상치가 존재하는가?
table(welfare_copy$gender)
## gender 컬럼의 데이터가 1이면 'male'
## 1이 아니라면 'female'
ifelse(
  welfare_copy$gender == 1, 
  'male', 
  'female'
) -> welfare_copy$gender
table(welfare_copy$gender)

##income 컬럼의 데이터가 0, 9999 라면 NA 변환

## case1
## income 0보다 크고 9999보다 작은 경우 
welfare_copy$income > 0 & welfare_copy$income < 9999 -> flag
ifelse(
  flag, 
  welfare_copy$income, 
  NA
)

## case2
## income 이 0이거나 9999라면
flag2 <- welfare_copy$income == 0 | welfare_copy$income == 9999
ifelse(
  flag2, 
  NA, 
  welfare_copy$income
)

## case3
## income 이 (0, 9999) 안에 포함되어 있으면 
flag3 <- welfare_copy$income %in% c(0, 9999)
ifelse(
  flag3, 
  NA, 
  welfare_copy$income
) -> welfare_copy$income

### 성별을 기준으로 평균 임금의 차이가 존재하는가?

# filter() : income이 결측치인 데이터를 제거 
# select() : gender, income 컬럼만 따로 추출
# group_by() : gender를 기준으로 그룹화
# summarise() : income의 평균 값을 그룹 연산
welfare_copy %>% 
  filter(!is.na(income)) %>% 
  select(gender, income) %>% 
  group_by(gender) %>% 
  summarise(mean_income = mean(income)) -> gender_data
ggplot(
  data = gender_data, 
  aes(
    x = gender, 
    y = mean_income
  )
) + geom_col()

## 나이에 따른 임금의 차이가 어느 정도인가?

## 나이(age) 컬럼을 생성 
## 데이터의 기준년도(2015) - birth
## welfare_copy에 저장
## income이 결측치인 데이터를 제거 
## age, income만 추출
## age를 기준으로 그룹화
## 평균 임금 그룹화 연산 
## 바형 그래프로 표시 
welfare_copy %>% 
  mutate(age = 2015 - birth)

2015 - welfare_copy$birth -> welfare_copy$age

welfare_copy %>% 
  filter(!is.na(income)) %>% 
  select(age, income) %>% 
  group_by(age) %>% 
  summarise(mean_income = mean(income)) -> age_data
ggplot(
  data = age_data, 
  aes(
    x = age, 
    y = mean_income
  )
) + geom_col()

## 평균 임금이 높은 상위 5개를 출력 
age_data %>% 
  arrange(desc(mean_income)) %>% 
  head(5)

## 연령대별 평균임금 

## 연령대(ageg) 컬럼을 추가
## 나이가 40미만이라면 young 
## 나이가 40이상 60 미만이라면 middle
## 나이가 60이상이라면 old
## ageg, income 컬럼을 따로 추출
## ageg을 기준으로 그룹화 
## 평균 임금을 그룹화 연산 (결측치를 제외)
ifelse(
  welfare_copy$age < 40, 
  'young', 
  ifelse(
    welfare_copy$age < 60, 
    'middle', 
    'old'
  )
)

welfare_copy %>% 
  mutate(
    ageg = ifelse(
      age < 40, 'young', 
      ifelse(
        age < 60, 'middle', 'old'
      )
    )
  ) %>% 
  select(ageg, income) %>% 
  group_by(ageg) %>% 
  summarise(
    mean_income = mean(income, na.rm = T)
  ) -> ageg_data

## 바형 그래프로 표시 (x축의 순서를 커스텀)
ggplot(
  data = ageg_data, 
  aes(
    x = ageg, 
    y = mean_income
  )
) + geom_col() + scale_x_discrete(
  limits = c('young', 'middle', 'old')
)

## excel 파일을 로드 사용할 패키지를 설치
install.packages('readxl')
library(readxl)

read_excel(
  "../csv/Koweps_Codebook.xlsx", sheet = 2
) -> code_book

## join 결합 
## welfare_copy , code_book -> 기준이 컬럼(code_job)
left_join_data <- left_join(
  welfare_copy, 
  code_book, 
  by='code_job'
)
str(left_join_data)
inner_join_data <- inner_join(
  welfare_copy, 
  code_book, 
  by='code_job'
)
str(inner_join_data)

welfare_copy %>% 
  filter(!is.na(code_job) & is.na(income))

## 직업별 평균 임금이 높은 상위 5개
head(left_join_data,1)
left_join_data %>% 
  filter(!is.na(income)) %>% 
  select(job, income) %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income)) %>% 
  arrange(-mean_income) %>% 
  head(5)
## 남성을 기준으로 
left_join_data %>% 
  filter(!is.na(income) & gender == 'male' ) %>% 
  select(job, income) %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income)) %>% 
  arrange(desc(mean_income)) %>% 
  head(5)
## 여성을 기준으로
left_join_data %>% 
  filter(!is.na(income) & gender == 'female' ) %>% 
  select(job, income) %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income)) %>% 
  arrange(desc(mean_income)) %>% 
  head(5)
### income 데이터의 결측치를 0으로 대체
ifelse(
  is.na(left_join_data$income), 
  0 ,
  left_join_data$income
) -> left_join_data$income

left_join_data %>% 
  filter(gender == 'female' & !is.na(job)) %>% 
  select(job, income) %>% 
  group_by(job) %>% 
  summarise(mean_income = mean(income)) %>% 
  arrange(-mean_income) %>% 
  head(5)
  
  
  
  
  

