## Data on economic and health care trends by country
#### 국가별 경제 수준과 의료 수준 동향을 정리한 데이터💰💊 

#####  ①Economic Growth and Life Expectancy 📈
```
exp <- ggplot(data=gapminder, mapping=aes(x=gdpPercap,y=lifeExp,color=continent))

exp + geom_point(alpha=0.3)+geom_smooth(color="gray",fill="gray",method="loess")+
      scale_x_log10(labels=scales::dollar)+ labs(x="GDP Per Capit", y="Life Expectancy in Years",
                                                 title="Economic Growth and Life Expectancy",
                                                 subtitle="Data points are country-years",
                                                 caption="Sourc: Gapminder,")
```
