#Package Used
library(gapminder)
library(ggplot2)
head(gapminder)

1.Economic Growth and Life Expectancy📈
exp <- ggplot(data=gapminder, mapping=aes(x=gdpPercap,y=lifeExp,color=continent))

exp + geom_point(alpha=0.3)+geom_smooth(color="gray",fill="gray",method="loess")+
      scale_x_log10(labels=scales::dollar)+ labs(x="GDP Per Capit", y="Life Expectancy in Years",
                                                 title="Economic Growth and Life Expectancy",
                                                 subtitle="Data points are country-years",
                                                 caption="Sourc: Gapminder,")
                                                 
2.GDP Growth by Continent📈
growth <- ggplot(data=gapminder,mapping=aes(x=year,y=gdpPercap))

growth + geom_line(aes(group=country))+facet_wrap(~continent,ncol=5)+
         theme(axis.text.x=element_text(angle=90))+labs(x="Year(1950~2000)",y="GDP Growth in Years",
                                                        title="GDP Growth by Continent",
                                                        caption="Source:Gapminder") 

3.Linear Regression model
p <- ggplot(data=gapminder,mapping=aes(x=log(gdpPercap),y=lifeExp))

p+geom_point(alpha=0.1)+geom_smooth(color="steelblue",fill="steelblue",method="lm")+
  labs(title="Life Expectancy by GDP", 
       X="gdpPercap", y="LifeExpectancy",
       caption="Source:gapminder")

