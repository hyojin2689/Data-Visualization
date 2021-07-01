## Visualization about Domestic Animal Data
#### 1995-2021 국내 가축 질병 정보에 대한 데이터 (21.04.22기준)
⠀
#### Data: 가축+질병+발생+정보_20210429.csv
##### https://data.mafra.go.kr/opendata/data/indexOpenDataDetail.do?data_id=20151204000000000563&service_ty=&filter_ty=G&sort_id=regist_dt&s_data_nm=&cl_code=&instt_id=

![image](https://user-images.githubusercontent.com/80669371/119146221-630ac900-ba85-11eb-848a-2d714157ff5b.png)

##### Package Used
```
library(dplyr)
library(tidyverse)
library(ggplot2)
```

##### ①Donors by Year (line graph)
```
p<-ggplot(data=organdata,mapping=aes(x=year,y=donors,color=country))

p+geom_line(aes(group=country))+labs(x="Year",y="Donors",
                                          title="Donors by Year",
                                          caption="Source:organdata")
```
<p align="center">
  <img src="https://user-images.githubusercontent.com/80669371/121472242-e328ac80-c9fb-11eb-82eb-244629521e84.png" alt="factorio thumbnail"/>⠀
</p>

##### ②Donors by Year and Country (line graph)
```
p<-ggplot(data=organdata,mapping=aes(x=year,y=donors))

p+geom_line()+facet_wrap(~country)+labs(x="Year",y="Donors",
                                   title="Donors by Year and Country",
                                   caption="Source:organdata")

```
<p align="center">
  <img src="https://user-images.githubusercontent.com/80669371/119147007-27bcca00-ba86-11eb-831a-fcde9d52c7f6.png" alt="factorio thumbnail"/>
</p> 

##### ③Donors by Country (box plot)
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

