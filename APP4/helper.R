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
setwd('E:/git/yanxiaoyang/ggvis/APP')
#调整日期型
user97$DATE_TIME <- as.Date(user97$DATE_TIME)

#补充线损率
lost97$LOST_R <- lost97[,4]/lost97[,2]

#制定异常标准
user97 <- user97[order(user97$DATE_TIME),]
sta <- quantile(abs(lost97[,5]),0.80)
lost97$AB <- as.factor(ifelse(abs(lost97[,5])>sta,1,0))
abdate <- subset(lost97,select='DATE_TIME',AB==1)
range(user97$DATE_TIME)
#用户id分成三段
idspl <- data.frame(do.call(rbind,strsplit(user97[,1],split = '/')),stringsAsFactors = F)
colnames(idspl) <- c('id.1','id.2','id.3')

getwd()
lost <- saveRDS(lost97,'APP/lost.rds')
user <- saveRDS(user97,'APP/user.rds')
idspl <- saveRDS(idspl,'APP/idspl.rds')

