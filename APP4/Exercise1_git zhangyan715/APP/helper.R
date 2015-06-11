#设计UI
library(ggvis)
library(magrittr)
library(shiny)
load('user97.rda')
load('lost97.rda')
str(user97)
str(lost97)
head(user97)
head(lost97)
unique(user97[,4])
#调整日期型
user97$DATE_TIME <- as.Date(user97$DATE_TIME)

#补充线损率
lost97$LOST_R <- lost97[,4]/lost97[,2]

#制定异常标准
user97 <- user97[order(user97$DATE_TIME),]
sta <- quantile(abs(lost97[,5]),0.80)
lost97$Normal <- as.factor(ifelse(abs(lost97[,5])<=sta,1,0))
abdate <- subset(lost97,select='DATE_TIME',Normal==0)
range(user97$DATE_TIME)
#用户id分成三段
idspl <- data.frame(do.call(rbind,strsplit(user97[,1],split = '/')),stringsAsFactors = F)
colnames(idspl) <- c('id.1','id.2','id.3')
user97 <- data.frame(idspl,user97)
head(idspl)
names(idspl)
getwd()
saveRDS(lost97,'lost.rds')
saveRDS(user97,'user.rds')
saveRDS(idspl,'idspl.rds')

