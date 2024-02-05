# 패키지 설치 
install.packages('dplyr')

# 패키지를 로드 
library(dplyr)


## 파일의 경로 
## 1. 절대 경로
##  - 절대적인 주소 값
##  - 환경이 변하더라도 같은 위치를 지정 
##  - ex) c:/users/admin/document/a.txt, https://www.google.com
## 2. 상대 경로 
##  - 상대적인 주소 값
##  - 환경이 변함에 따라 위치도 변화
##  - ./ : 현재 작업중인 디렉토리
##  - ../ : 현재 디렉토리에서 상위 디렉토리 이동
##  - 폴더명/ : 하위 디렉토리(폴더명)로 이동

## 외부의 데이터 파일 로드 
## csv 파일 로드 -> read.csv(파일의 경로)

## 상대 경로 사용
## 현재 디렉토리에서 상위 디렉토리 이동(../)
## csv 라는 하위 디렉토리 이동 (csv/)
## example.csv (example.csv)
df <- read.csv('../csv/example.csv')
df
## 절대 경로 사용
df2 <- read.csv("C:/Users/moons/Documents/GitHub/ubion-10/csv/example.csv")
df2

## 파이프 연산자 
## %>% : Ctrl(Command) + Shift + M 단축키 사용
## 왼쪽에 있는 데이터를 오른쪽의 함수에 대입 

## head(데이터프레임명, 개수) : 데이터프레임 상위 n개를 출력
head(df, 3)
df %>% head(3)

## 인덱스의 조건식으로 필터링 
## filter(조건식)
df %>% filter(Gender == 'male')

## base 함수로 필터링 
## 조건식을 생성
df$Gender == 'male' -> flag
df[flag, ]

## 특정 컬럼의 데이터만 출력
## 패키지 사용
df %>% select(Name, Phone)
df %>% select(-Gender)

# Base
df[c('Name', 'Phone')]

## 성별이 남자인 데이터 중 이름과 휴대폰 번호만 출력
## 패키지 사용
df %>% 
  filter(Gender == 'male') %>% 
  select(Name, Phone)

## Base 
df$Gender == 'male' -> flag

df[flag, c('Name', 'Phone') ]

exam <- read.csv("../csv/csv_exam.csv")
exam

## 차순 정렬 변경 (오름차순 / 내림차순)
## 수학 성적을 기준으로 오름차순 정렬 
exam %>% arrange(math)
## 수학 성적을 기준으로 내림차순 정렬
exam %>% arrange(desc(math))
exam %>% arrange(-math)

## Base 
## 오름차순 정렬
order(exam$math) -> flag2
exam[flag2,]
## 내림차순 정렬
order(exam$math, decreasing = TRUE) -> flag3
exam[flag3, ]

## 정렬 방식의 조건이 2개 이상인 경우 
## 학년 별로 내림차순 정렬 -> 수학 성적은 오름차순
exam %>% 
  arrange(desc(class), math)

### 그룹화 연산
## class 별 수학, 과학, 영어의 평균 점수를 출력
exam %>% 
  group_by(class) %>% 
  summarise(
    mean_math = mean(math), 
    mean_english = mean(english), 
    mean_science = mean(science)
  )

## 데이터프레임의 결합
## 행을 결합 -> 유니언 결합 
## 열을 결합 -> 조인 결합

## 유니언 결합 (단순한 행 결합)
df_1 <- data.frame(
  id = 1:5, 
  score = c(70, 80, 65, 80, 90)
)
df_2 <- data.frame(
  id = 3:6, 
  weight = c(60, 50, 70, 80)
)

## 행 결합 함수 ( rbind() : 데이터프레임의 구조가 같은 데이터 결합 )
rbind(df_1, df_2) ## 에러 발생 (데이터의 구조가 다른 이유)

df_3 <- data.frame(
  id = 3:8, 
  score = c(50, 70, 80, 70, 90, 50)
)
rbind(df_1, df_3)

## bind_rows() : 데이터의 구조와 상관없이 데이터를 결합
bind_rows(df_1, df_2)
bind_rows(df_1, df_2, df_3)


## 조인결합 
## 특정한 조건이 참인 경우 컬럼의 데이터를 추가 
df_4 <- data.frame(
  id = c('test', 'test2', 'test3', 'test4'), 
  item = c('A', 'B', 'B', 'D')
)
df_5 <- data.frame(
  item = c('A', 'B', 'C'), 
  price = c(1000, 2000, 3000)
)
## inner_join() : 두개의 데이터프레임에서 
## 모두 가진 데이터만 결합하여 출력
inner_join(df_4, df_5, by='item')
## left_join() : 왼쪽 데이터프레임을 기준으로 결합
left_join(df_4, df_5, by='item')

right_join(df_4, df_5, by='item')
full_join(df_4, df_5, by='item')

install.packages('ggplot2')
library(ggplot2)

## ggplot2 패키지 안에 샘플데이터를 로드 
midwest <- ggplot2::midwest

head(midwest, 3)
str(midwest)
## 데이터프레임을 뷰어창에서 확인 
View(midwest)

## 컬럼의 이름을 변경 
## rename(데이터프레임명, 새컬럼명 = 변경할 컬럼명)
## popasian컬럼을 asian
## poptotal컬럼을 total 변경 
rename(midwest, asian = popasian) -> midwest
rename(midwest, total = poptotal) -> midwest

# 복사본을 생성 
# (midwest에서 county, asian, total 데이터만 추출하여 저장)
## Base 
## 컬럼의 3개만 추출
midwest[c('county', 'asian', 'total')]

midwest %>% 
  select(county, asian, total) -> df

## 전체 인구수 대비 아시안 인구 비율이라는 컬럼을 생성
## 컬럼의 이름은 ratio 
## (아시아 인구수 / 전체 인구수) * 100 = ratio

##벡터 데이터를 이용하여 아시아 인구 비율을 생성
(df$asian / df$total) * 100 -> ratio

bind_cols(df, ratio = ratio)
cbind(df, ratio)
data.frame(df, ratio)
df$ratio <- ratio
head(df, 1)

# 패키지 이용해서 파생변수 추가 
df2 <- midwest[c('county', 'asian', 'total')]
## mutate() : 파생변수 생성 함수 
df2 %>% 
  mutate(ratio = (asian / total)* 100 )

## 히스토그램 
## hist(백터데이터)
hist(df$ratio)

## 전체 ratio의 평균 값을 출력 
mean(df$ratio) -> mean_ratio

## mean_ratio와 ratio 데이터를 비교하여 
## 평균 값보다 높은 경우 large
## 평균 값보다 이하인 경우 small
## group 컬럼명에 데이터를 추가 
df$ratio > mean_ratio -> flag4
## ifelse(조건식, 참인 경우 데이터, 거짓인 경우 데이터)
ifelse( flag4, 'large' , 'small' ) -> group_data
df$group = group_data

## 패키지 이용하여 컬럼을 추가 
df %>% 
  mutate(group = ifelse(
    ratio > mean(ratio), 
    'large', 
    'small'
    )
  ) -> df
table(df$group)

midwest <- ggplot2::midwest

## midwest 데이터에서 데이터 정제
## 컬럼의 이름을 변경 
## popadults컬럼을 adult 변경
## poptotal컬럼을 total 변경
## county, adult, total 컬럼만 따로 추출하여 변수에 저장
## "전체 인구수 대비 미성년자의 인구 비율" 컬럼(child_ratio)을 생성
##    1. 성인의 인구수와 전체 인구수가 존재하고 미성년 인구수가 존재X
##    2. 미성년자의 인구수 컬럼을 생성 (total - adult)
##    3. 미성년자의 인구수 / 총 인구수 * 100
## child_ratio 가 가장 높은 상위 5개의 지역을 출력

## Base 함수들을 이용해서 작업 
## 컬럼의 이름을 변경 
rename(midwest, adult = popadults) -> midwest
rename(midwest, total = poptotal) -> midwest

## county, adult, total 컬럼만 따로 추출 하여 변수에 저장
df <- midwest[c('county', 'adult', 'total')]

## child 컬럼을 추가하여 total - adult 데이터를 추가 
df$total - df$adult -> df$child
head(df, 2)
## child_ratio 컬럼을 추가하여 child / total * 100 데이터를 추가 
(df$child / df$total) * 100 -> df$child_ratio
## child_ratio 높은 상위 5개의 지역을 출력
## child_ratio 내림차순 정렬
## 상위 5개 지역을 출력 -> 데이터프레임에 상위 5개의 데이터를 출력
order(df$child_ratio, decreasing = TRUE) -> flag
df[flag, ] -> df
## 상위 5개의 데이터를 출력
head(df, 5)

midwest <- ggplot2::midwest

midwest %>% 
  rename(adult = popadults, total = poptotal) %>% 
  select(county, adult, total) %>% 
  mutate(child = total - adult, 
         child_ratio = child / total * 100) %>% 
  arrange(desc(child_ratio)) %>% 
  head(5)






