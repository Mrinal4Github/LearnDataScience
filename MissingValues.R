install.packages('mlbench')
install.packages('mice')
install.packages('Hmisc')
install.packages('DMwR')
library('Hmisc')
library(mlbench)
library(mice)
library('DMwR')
data()
data("BostonHousing", package="mlbench")  # initialize the data  # load the data 

names(BostonHousing)
attach(BostonHousing)

?BostonHousing
original <- BostonHousing  # backup original data 
set.seed(100)
BostonHousing[sample(1:nrow(BostonHousing), 40), "rad"] <- NA 
BostonHousing[sample(1:nrow(BostonHousing), 40), "ptratio"] <- NA  
head(BostonHousing) 
md.pattern(BostonHousing)  # pattern or missing values in data. 
lm(medv ~ ptratio + rad, data=BostonHousing, na.action=na.omit)  # though na.omit is default in lm() 
impute(BostonHousing$ptratio, mean)  # replace with mean 
impute(BostonHousing$ptratio, median)  # median 
impute(BostonHousing$ptratio, 20)  # replace specific number 

actuals <- original$ptratio[is.na(BostonHousing$ptratio)] 
predicteds <- rep(mean(BostonHousing$ptratio, na.rm=T), length(actuals)) 
regr.eval(actuals, predicteds) 