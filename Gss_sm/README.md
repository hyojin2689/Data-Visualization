## General Social Survey data
#### 일반 사회 조사 데이터 
⠀
#### Gss_sm
```
library(socviz)
head(gss_sm)
```
![image](https://user-images.githubusercontent.com/80669371/118790273-90624600-b8d0-11eb-8c86-600bc6849f9f.png)


##### Package Used
```
library(ggplot2)
```
⠀
##### ①Count by Religion📊
```
p<-ggplot(data=gss_sm,mapping=aes(x=religion,fill=religion))

p+geom_bar()+guides(fill=FALSE)+labs(x="Religion",y="Count",
                                    title="Count by Religion",
                                    caption="Source:Gss_sm")

```
<p align="center">
  <img src="https://user-images.githubusercontent.com/80669371/118790470-c273a800-b8d0-11eb-9094-ebdc1ba4fc23.png" alt="factorio thumbnail"/>
</p> 

##### ②Comparison of regional religious proportions📊
```
p<-ggplot(data=gss_sm,mapping=aes(x=bigregion,fill=religion))

p+geom_bar(position="fill")+labs(x="Bigregion",y="Count",
                                 title="Comparison of regional religious proportions",
                                 caption="Source:Gss_sm")
```
<p align="center">
  <img src="https://user-images.githubusercontent.com/80669371/118790834-1a121380-b8d1-11eb-8a31-67eb28913bd6.png" alt="factorio thumbnail"/>
</p> 

##### ④Distribution of Religious Preferences by Region and Race📊
```
p<-ggplot(data=gss_sm,mapping=aes(x=bigregion,fill=religion))

p+geom_bar(position="dodge",mapping=aes(y=..prop..,group=religion))+
facet_wrap(~race,ncol=1)+labs(x="Bigregion",y="Percent",
                         title="Distribution of Religious Preferences by Region and Race",
                         caption="Source:Gss_sm")
```
<p align="center">
  <img src="https://user-images.githubusercontent.com/80669371/118791248-7d9c4100-b8d1-11eb-96a4-64825c45dec6.png" alt="factorio thumbnail"/>
</p> 

##### ④Visualize with summary data📊
###### Package Used
```
library(dplyr)
```
###### Create summary data
```
rel_by_region<-gss_sm%>%group_by(bigregion,religion)%>%
summarize(N=n())%>%mutate(freq=N/sum(N),pct=round(freq*100,0))
```
###### rel_by_region
```
head(rel_by_region)
```
![image](https://user-images.githubusercontent.com/80669371/118791779-031ff100-b8d2-11eb-9ccb-c2c0f1a8b5af.png)

###### Region by bigregion
```
p<-ggplot(rel_by_region,aes(x=religion,y=pct,fill=religion))

p+geom_col(position="dodge2")+guides(fill=FALSE)+coord_flip()+
facet_grid(~bigregion)+labs(x="region",y="percent",fill="종교_religion",
                           title="Region by Bigregion",
                           caption="Source:gss_sm")
```
<p align="center">
  <img src="https://user-images.githubusercontent.com/80669371/118793336-7aa25000-b8d3-11eb-805b-888062c5ac4a.png" alt="factorio thumbnail"/>
</p> 

