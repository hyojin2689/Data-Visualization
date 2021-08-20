## Data on economic and health care trends by country
#### 국가별 경제 수준과 의료 수준 동향을 정리한 데이터 💰💊 
⠀
#### Data:Gapminder
```
library(gapminder)
head(gapminder)
```
![image](https://user-images.githubusercontent.com/80669371/118664414-69eacf00-b82c-11eb-9251-385cc68b5560.png)

##### Package Used
```
library(ggplot2)
```
⠀
##### ①Economic Growth and Life Expectancy📈
```
exp <- ggplot(data=gapminder, mapping=aes(x=gdpPercap,y=lifeExp,color=continent))

exp + geom_point(alpha=0.3)+geom_smooth(color="gray",fill="gray",method="loess")+
      scale_x_log10(labels=scales::dollar)+ labs(x="GDP Per Capit", y="Life Expectancy in Years",
                                                 title="Economic Growth and Life Expectancy",
                                                 subtitle="Data points are country-years",
                                                 caption="Sourc: Gapminder,")
```
<p align="center">
  <img src="https://user-images.githubusercontent.com/80669371/118661813-6fdfb080-b82a-11eb-88c2-a9bb324837ea.png" alt="factorio thumbnail"/>
</p> 

##### ② GDP Growth by Continent📈
```
growth <- ggplot(data=gapminder,mapping=aes(x=year,y=gdpPercap))

growth + geom_line(aes(group=country))+facet_wrap(~continent,ncol=5)+
         theme(axis.text.x=element_text(angle=90))+labs(x="Year(1950~2000)",y="GDP Growth in Years",
                                                        title="GDP Growth by Continent",
                                                        caption="Source:Gapminder")
```
<p align="center">
  <img src="https://user-images.githubusercontent.com/80669371/118665103-fe553180-b82c-11eb-85b6-d751d4fad3fe.png" alt="factorio thumbnail"/>
</p> 

##### ③ Linear Regression model
```
p <- ggplot(data=gapminder,mapping=aes(x=log(gdpPercap),y=lifeExp))

p+geom_point(alpha=0.1)+geom_smooth(color="steelblue",fill="steelblue",method="lm")+
  labs(title="Life Expectancy by GDP", 
       X="gdpPercap", y="LifeExpectancy",
       caption="Source:gapminder")
```
<p align="center">
  <img src="https://user-images.githubusercontent.com/80669371/121481675-5552be80-ca07-11eb-8bbf-55f770f928a2.png" alt="factorio thumbnail"/>
</p> 
