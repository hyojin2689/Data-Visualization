## Data on demographics for 437 northeastern regions of the United States.
#### 미국 동부중부 437개 지역의 인구통계 정보를 담고 있는 데이터
⠀
#### Data:Midwest
```
library(ggplot2)
head(midwest)
```
![image](https://user-images.githubusercontent.com/80669371/118924957-d4108a80-b978-11eb-8b6e-d3db5265f53e.png)

##### Package Used
```
library(ggplot2)
```
⠀
##### ①Percentage of people with university education in OH,WI
```
oh_wi<-c("OH","WI")

p<-ggplot(data=subset(midwest,state%in%oh_wi),mapping=aes(x=percollege,fill=state))

p+geom_histogram()+labs(x="Percentage of people with a college education",y="Count",
                                                            title="Percentage of people with university education in OH,WI",
                                                            caption="Source:midwest")

```
<p align="center">
  <img src="https://user-images.githubusercontent.com/80669371/118925789-4170eb00-b97a-11eb-8a84-17100a7f5a21.png" alt="factorio thumbnail"/>
</p> 

##### ②Regional Population Density by State
```
p<-ggplot(data=midwest,mapping=aes(x=area,group=state,color=state))

p+geom_density()+labs(x="Area",y="Density",
                      title="Regional Population Density by State",
                      caption="Source:midwest")
```                      
<p align="center">
  <img src="https://user-images.githubusercontent.com/80669371/118926021-9ca2dd80-b97a-11eb-8e67-bcd2d46e4e06.png" alt="factorio thumbnail"/>
</p> 

