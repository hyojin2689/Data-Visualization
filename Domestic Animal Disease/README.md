## Visualization about Domestic Animal Data
#### 1995-2021 국내 가축 질병 정보에 대한 데이터 (21.04.22기준)
⠀
#### Data: 가축+질병+발생+정보_20210429.csv
##### https://data.mafra.go.kr/opendata/data/indexOpenDataDetail.do?data_id=20151204000000000563&service_ty=&filter_ty=G&sort_id=regist_dt&s_data_nm=&cl_code=&instt_id=
![image](https://user-images.githubusercontent.com/80669371/124048296-f6ee8e00-da50-11eb-8012-f738c6bc9573.png)

##### Package Used
```
library(dplyr)
library(tidyverse)
library(ggplot2)
```
##### Preprocess Data
```
#결측치 확인
is.na(df)
sum(is.na(df))

#결측치 제거: 종식일 칼럼 제거
df <- subset(df, select = -종식일)
str(df)
sum(is.na(df))

head(df,n=20)

#가축전염병명: 띄어쓰기 제거
df$가축전염병명 <- gsub(' ','', df$가축전염병명 )

#가축전염병명: 가금티푸스, 가금티프스 같은 병명임으로 획일화
df$가축전염병명 <- gsub('가금티프스','가금티푸스', df$가축전염병명 )

#축종.품종. 소분류까지 확인
df$축종.품종. %>% unique() %>% sort()

#축종.품종. 대대분류까지 확인
class_df = df$축종.품종. %>% strsplit(split = '-') 
class_df

class <- c()
for(i in 1:length(class_df)){
  class <- c(class, class_df[[i]][1])
}

#대품종 카테고리 확인
classnames <- class %>% unique() %>% sort()


#데이터 대분류 칼럼 생성: class이름 칼럼으로 붙여주고, ' '으로 들어간 행 삭제
df$대품종 <- class
df <- df[-grep(" ",df$대품종),]

#df에 년, 월, 일로 나누어 칼럼생성
df <- transform(df, yy = substr(df$발생일자.진단일.,1,4))
df <- transform(df, mm = substr(df$발생일자.진단일.,5,6))
df <- transform(df, dd = substr(df$발생일자.진단일.,7,8))
```
![image](https://user-images.githubusercontent.com/80669371/124049256-08389a00-da53-11eb-84c8-4aa2af394571.png)

##### ①대품종별 가출전염병에 걸린 두 수
###### 분석을 위한 d1 데이터 프레임 생성
```
d1 <- df  %>%
  select('가축전염병명', '대품종', '발생두수.마리.') %>% 
  group_by(대품종,가축전염병명) %>% summarise(sum = sum(발생두수.마리.)) %>%
  arrange(대품종)
d1

```
![image](https://user-images.githubusercontent.com/80669371/124049505-901ea400-da53-11eb-9834-7f680f6968bd.png)

##### ①-1 대품종별 가출전염병에 걸린 두 수
```
p1 <- ggplot(data = d1, mapping = aes(x=대품종, y=sum, fill=가축전염병명))
p1 + geom_col(position = 'dodge', width=0.8) + scale_y_log10() + 
  geom_text(aes(label = sum), vjust = 1, color = "black") + 
  labs(title = '대품종별 가출전염병에 걸린 두 수',
       x = '두 수',
       y = '가축 전염병명') +  theme(axis.title=element_text(size=17),title=element_text(size=20)) 
```
<p align="center">
  <img src="https://user-images.githubusercontent.com/80669371/124048957-729d0a80-da52-11eb-805e-4df6b2c27739.png" alt="factorio thumbnail"/>⠀
</p>
##### ①-2 대품종별 가출전염병에 걸린 두 수
```
p1 <- ggplot(data = d1, mapping = aes(x=reorder(가축전염병명,sum), y=sum, fill=가축전염병명))
p1 + geom_col(position = 'dodge', width=0.8) + scale_y_log10() + 
  geom_text(aes(label = sum), vjust = 1, color = "black") + 
  labs(title = '대품종별 가출전염병에 걸린 두 수',
       x = '두 수',
       y = '가축 전염병명')+coord_flip()+facet_wrap(~대품종,ncol=10)+  theme(axis.title=element_text(size=17),title=element_text(size=20))  

```
<p align="center">
  <img src="https://user-images.githubusercontent.com/80669371/124049051-a6783000-da52-11eb-8bde-3c09a1001757.png" alt="factorio thumbnail"/>⠀
</p>
##### ①-3 가축 전염병별 감염된 대품종의 비율
```
p1 <- ggplot(data = d1, mapping = aes(x=가축전염병명, y=sum, fill=대품종))
p1 + geom_bar(stat='identity',position="fill") +
  labs(title = '가축 전염병별 감염된 대품종의 비율',
       x = '대품종',
       y = '두 수')+coord_flip()+ theme(axis.title=element_text(size=17),title=element_text(size=20))
```
<p align="center">
  <img src="https://user-images.githubusercontent.com/80669371/124049125-c7d91c00-da52-11eb-9f13-974d67960985.png" alt="factorio thumbnail"/>⠀
</p>

##### ②최근 5년/10년 사이의 월별 평균 발생 두 수 
###### ②-1 2016년부터 2020년까지 최근 5년간 월별 평균 마리수
```
d2 <- df  %>% select('yy', 'mm', '발생두수.마리.') %>% 
  subset(yy>=2016 & yy<=2020) %>%
  group_by(mm) %>% summarise(mean = mean(발생두수.마리.)) 

p2 <- ggplot(data = d2, mapping = aes(x=mm, y=mean, group = 1))
p2 + geom_line() + geom_point(size = 2) + 
  labs(title = '최근 5년(2016~2020) 사이의 월별 평균 발생 두수',
       x = '월',
       y = '평균 두 수')+ theme(axis.title=element_text(size=17),title=element_text(size=20))
```
<p align="center">
  <img src="https://user-images.githubusercontent.com/80669371/124049603-cd833180-da53-11eb-81d4-a295822f0c6c.png" alt="factorio thumbnail"/>
</p> 
###### ②-2 2011년부터 2020년까지 최근 10년간 월별 평균 마리수
```
d3 <- df  %>% select('yy', 'mm', '발생두수.마리.') %>% 
  subset(yy>=2011 & yy<=2020) %>%
  group_by(mm) %>% summarise(mean2 = mean(발생두수.마리.)) 


p3 <- ggplot(data = d3, mapping = aes(x=mm, y=mean2, group = 1))
p3 + geom_line() + geom_point(size = 2) + 
  labs(title = '최근 10년(2011~2020) 사이의 월별 평균 발생 두수',
       x = '월',
       y = '평균 두 수')+ theme(axis.title=element_text(size=17),title=element_text(size=20))  
```
<p align="center">
  <img src="https://user-images.githubusercontent.com/80669371/124049802-3bc7f400-da54-11eb-93a6-37696ba194cc.png" alt="factorio thumbnail"/>
</p> 

###### ②-1과 ②-2 한 번에 시각화 2011년부터 2020년까지 최근 10년간 월별 평균 마리수
```
#d2,d3 월을 기준으로 합치기
d4 <- merge(d2,d3,by="mm")

p4 <- ggplot(d4,aes(x=mm,y=mean,group=1))
p4+geom_line(size=1,color="blue")+geom_line(aes(x=mm,y=mean2,group=1),size=1,color="red")+
  labs(title = '최근 5/10년(2016~2020/2011~2020) 사이의 월별 평균 발생 두수',x = '월',y = '평균 두 수')+
  annotate(geom="text",x=03.3,y=1600,label="2011-2020",hjust=0)+annotate(geom="text",x=03,y=200,label="2016-2020",hjust=0)+
  theme(axis.title=element_text(size=17),title=element_text(size=20))  
```
<p align="center">
  <img src="https://user-images.githubusercontent.com/80669371/124049880-5b5f1c80-da54-11eb-86e5-243ee1d31e31.png" alt="factorio thumbnail"/>
</p> 

##### ③지역별 가축 전염병에 걸린 두 수
```
p<-ggplot(data=organdata,mapping=aes(x=reorder(country,donors,na.rm=TRUE),y=donors))

p+geom_boxplot()+coord_flip()+labs(x=NULL)+labs(x=NULL,y="Donors", 
                                                title="Donors by Country",
                                                caption="Source:organdata")
```
<p align="center">
  <img src="https://user-images.githubusercontent.com/80669371/119147659-c1847700-ba86-11eb-8183-9ce97a8a7cd0.png" alt="factorio thumbnail"/>
</p> 

##### ④Donors by Country and Welfare (dot plot)
```
p<-ggplot(data=organdata,mapping=aes(x=reorder(country,donors,na.rm=TRUE),y=donors,color=world))

p+geom_jitter(position=position_jitter(width=0.15))+labs(x=NULL)+coord_flip()+theme(legend.position="top")+
  labs(x="Year",y="Donors",title="Donors by Country and Welfare", caption="Source:organdata")
```
<p align="center">
  <img src="https://user-images.githubusercontent.com/80669371/121473474-b37aa400-c9fd-11eb-8401-01d52b5554f8.png" alt="factorio thumbnail"/>
</p> 

##### ⑤Road accident fatalities per 100,000 population by Donors
```
p<-ggplot(data=organdata,mapping=aes(x=roads,y=donors))

p+geom_point()+annotate(geom="rect",xmin=125,xmax=155,ymin=30,ymax=35,fill="red",alpha=0.2)+
  annotate(geom="text",x=157,y=33,label="A surprisingly high \n recovery rate.",hjust=0)+
  labs(title="Road accident fatalities per 100,000 population by Donors",
      x="Roads", y="Donors", caption="Source:organdata")
```
<p align="center">
  <img src="https://user-images.githubusercontent.com/80669371/121477216-854b9300-ca02-11eb-889a-202dbebfa488.png" alt="factorio thumbnail"/>
</p> 

##### ⑥Visualize with summary data📊
###### Package Used
```
library(dplyr)
```
###### Create summary data
```
by_country<-organdata%>%group_by(consent_law,country)%>%
summarize_if(is.numeric,funs(mean,sd),na.rm=TRUE)%>%ungroup()
```
###### by_country
```
head(by_country)
```
![image](https://user-images.githubusercontent.com/80669371/121474284-d48fc480-c9fe-11eb-8038-f108643e81d5.png)

###### Donor Procurement Rate by Country and Consent Law
```
p<-ggplot(data=by_country,mapping=aes(x=donors_mean,y=reorder(country,donors_mean),color=consent_law))

p+geom_point(size=3)+labs(title="Donor Procurement Rate by Country and Consent Law",
                          x="Donor Procurement Rate",y="",color="Consent Law",
                          caption="Source:organdata")+theme(legend.position="top")
```
<p align="center">
  <img src="https://user-images.githubusercontent.com/80669371/121475082-f2a9f480-c9ff-11eb-8af5-00819022a936.png" alt="factorio thumbnail"/>
</p> 

