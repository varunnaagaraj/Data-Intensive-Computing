## SUB-TASK 1
sales1 = c(12,33,21,40,15,25,32,11,70,55,34,19)
sales2 = rpois(12,34)
par(bg="cornsilk")

plot(sales1, col="blue", type="o", ylim=c(0,100), xlab="Month", ylab="Sales" )
title(main="Sales by Month")

lines(sales2, type="o", pch=22, lty=2, col="red")
grid(nx=NA, ny=NULL)
legend("topright", inset=.05, c("Sales1","Sales2"), fill=c("blue","red"), horiz=TRUE)

###################################################

## SUB-TASK 2

sales<-read.table(file.choose(), header=T)
sales  # to verify that data has been read
barplot(as.matrix(sales), main="Sales Data", ylab= "Total",beside=T, col=rainbow(5))

###################################################

## SUB-TASK 3

fn<-boxplot(sales,col=c("orange","green"))$stats
print(fn)
text(1.45, fn[3,2], paste("Median =", fn[3,2]), adj=0, cex=.7)
text(0.45, fn[3,1],paste("Median =", fn[3,1]), adj=0, cex=.9)
grid(nx=NA, ny=NULL)

###################################################

## SUB-TASK 4

fb1<-read.csv(file.choose())
aapl1<-read.csv(file.choose())
par(bg="cornsilk")
plot(aapl1$Adj.Close, col="blue", type="o", ylim=c(0,100), xlab="Days", ylab="Price")
title("Histogram of Apple/FB")
lines(fb1$Adj.Close, type="o", pch=22, lty=2, col="red")
legend("topright", inset=.05, c("Apple","Facebook"), fill=c("blue","red"), horiz=TRUE)
hist(fb1$Adj.Close, col=rainbow(8))
hist(aapl1$Adj.Close, col=rainbow(8))

###################################################

## SUB-TASK 5

data(uspop)
attach(uspop)
summary(uspop)
detach(uspop)
library (help=datasets)
library(datasets)
head(uspop)
plot(uspop)
plot(USJudgeRatings)


###################################################

## SUB-TASK 6

library("ggmap")
library("maptools")
library(maps)
register_google(key = "AIzaSyC-auTKdwXmCaTvGwqFPBYJ7-dzDrwSDPo") 
visited <- c("SFO", "New York", "Buffalo", "Dallas, TX")
ll.visited <- geocode(visited)
visit.x <- ll.visited$lon
visit.y <- ll.visited$lat
map("state", fill=TRUE, col=rainbow(50), bg="lightblue", mar=c(0,0,0,0))
points(visit.x,visit.y, col="yellow", pch=36)

###################################################

## SUB-TASK 7

attach(mtcars)
head(mtcars)
plot(mtcars[c(1,3,4,5,6)], main="MTCARS Data", col=rainbow(5))
plot(mtcars[c(1,3,4,6)], main="MTCARS Data", col=rainbow(4))

###################################################

## SUB-TASK 8

library(ggplot2)
ggplot(mtcars, aes(x=qsec, y=wt)) + geom_point()



