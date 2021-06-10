## Data on national health and welfare policies
#### 국가별 건강 및 복지정책에 대한 데이터
⠀
#### Data:Organdata
```
library(socviz)
head(organdata)
```
![image](https://user-images.githubusercontent.com/80669371/119146221-630ac900-ba85-11eb-848a-2d714157ff5b.png)

##### Package Used
```
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

##### ⑤
