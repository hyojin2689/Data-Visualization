#Package Used
library(socviz)
head(organdata)
library(ggplot2)
library(dplyr)

1.Donors by Year (line graph)
p<-ggplot(data=organdata,mapping=aes(x=year,y=donors,color=country))

p+geom_line(aes(group=country))+labs(x="Year",y="Donors",
                                          title="Donors by Year",
                                          caption="Source:organdata")

2.Donors by Year and Country (line graph)
p<-ggplot(data=organdata,mapping=aes(x=year,y=donors))

p+geom_line()+facet_wrap(~country)+labs(x="Year",y="Donors",
                                   title="Donors by Year and Country",
                                   caption="Source:organdata")

3.Donors by Country (box plot)
p<-ggplot(data=organdata,mapping=aes(x=reorder(country,donors,na.rm=TRUE),y=donors))

p+geom_boxplot()+coord_flip()+labs(x=NULL)+labs(x=NULL,y="Donors", 
                                                title="Donors by Country",
                                                caption="Source:organdata")

4.Donors by Country and Welfare (dot plot)
p<-ggplot(data=organdata,mapping=aes(x=reorder(country,donors,na.rm=TRUE),y=donors,color=world))

p+geom_jitter(position=position_jitter(width=0.15))+labs(x=NULL)+coord_flip()+theme(legend.position="top")+
  labs(x="Year",y="Donors",title="Donors by Country and Welfare", caption="Source:organdata")


5.Road accident fatalities per 100,000 population by Donors
p<-ggplot(data=organdata,mapping=aes(x=roads,y=donors))

p+geom_point()+annotate(geom="rect",xmin=125,xmax=155,ymin=30,ymax=35,fill="red",alpha=0.2)+
  annotate(geom="text",x=157,y=33,label="A surprisingly high \n recovery rate.",hjust=0)+
  labs(title="Road accident fatalities per 100,000 population by Donors",
      x="Roads", y="Donors", caption="Source:organdata")

6.Visualize with summary data📊
# Create summary data
by_country<-organdata%>%group_by(consent_law,country)%>%
summarize_if(is.numeric,funs(mean,sd),na.rm=TRUE)%>%ungroup()

# Donor Procurement Rate by Country and Consent Law
p<-ggplot(data=by_country,mapping=aes(x=donors_mean,y=reorder(country,donors_mean),color=consent_law))

p+geom_point(size=3)+labs(title="Donor Procurement Rate by Country and Consent Law",
                          x="Donor Procurement Rate",y="",color="Consent Law",
                          caption="Source:organdata")+theme(legend.position="top")



