#Package Used
library(ggplot2)
library(socviz)
library(dplyr)

1.Count by Religion📊
p<-ggplot(data=gss_sm,mapping=aes(x=religion,fill=religion))

p+geom_bar()+guides(fill=FALSE)+labs(x="Religion",y="Count",
                                    title="Count by Religion",
                                    caption="Source:Gss_sm")

2.Comparison of regional religious proportions📊
p<-ggplot(data=gss_sm,mapping=aes(x=bigregion,fill=religion))

p+geom_bar(position="fill")+labs(x="Bigregion",y="Count",
                                 title="Comparison of regional religious proportions",
                                 caption="Source:Gss_sm")
                                 
3.Distribution of Religious Preferences by Region and Race📊
p<-ggplot(data=gss_sm,mapping=aes(x=bigregion,fill=religion))

p+geom_bar(position="dodge",mapping=aes(y=..prop..,group=religion))+
facet_wrap(~race,ncol=1)+labs(x="Bigregion",y="Percent",
                         title="Distribution of Religious Preferences by Region and Race",
                         caption="Source:Gss_sm")

4.Visualize with summary data📊
#Create summary data
#rel_by_region
rel_by_region<-gss_sm%>%group_by(bigregion,religion)%>%
summarize(N=n())%>%mutate(freq=N/sum(N),pct=round(freq*100,0))

#Region by bigregion
p<-ggplot(rel_by_region,aes(x=religion,y=pct,fill=religion))

p+geom_col(position="dodge2")+guides(fill=FALSE)+coord_flip()+
facet_grid(~bigregion)+labs(x="region",y="percent",fill="종교_religion",
                           title="Region by Bigregion",
                           caption="Source:gss_sm")

