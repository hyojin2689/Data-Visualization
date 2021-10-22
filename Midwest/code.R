#Package Used
library(ggplot2)
⠀
1.Percentage of people with university education in OH,WI 📊

oh_wi<-c("OH","WI")
p<-ggplot(data=subset(midwest,state%in%oh_wi),mapping=aes(x=percollege,fill=state))
om_histogram()+labs(x="Percentage of people with a college education",y="Count",
                                                            title="Percentage of people with university education in OH,WI",
                                                            caption="Source:midwest")

2. Regional Population Density by State🌎

p<-ggplot(data=midwest,mapping=aes(x=area,group=state,color=state))
p+geom_density()+labs(x="Area",y="Density",
                      title="Regional Population Density by State",
                      caption="Source:midwest")

