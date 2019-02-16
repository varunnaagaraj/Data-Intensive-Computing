library("ggmap")
library("maptools")
library(maps)
register_google(key = "AIzaSyC-auTKdwXmCaTvGwqFPBYJ7-dzDrwSDPo") 
data = read.csv(file.choose(), header = TRUE)
trim_data = data[21:72,]
trim_data$V3 = as.numeric(paste(as.numeric(as.character(trim_data$V3)),trim_data$V4, sep = ""))

barplot(as.numeric(as.character(trim_data$V6)), xlab = "Weeks", ylab="Number of Specimens", 
        names.arg=c(as.character(trim_data$V3)), main = "Influenza Positive Tests reported to CDC", 
        col = "yellow", ylim=c(0,14500))
par(new=TRUE)
barplot(as.numeric(as.character(trim_data$V7)), col = "green", yaxt = "n", ylim = c(0,14500))
# legend(30, 10000, legend = c("A","B", "Percent Positive", "% Positive Flu A", "% Positive Flu B"), 
#        col = c("yellow","green"), fill = c("yellow","green"), lty = c(1,2))
par(new=TRUE)
plot(as.numeric(as.character(trim_data$V8)), col="black", ylim=c(0,27), type="l", 
     xaxt = "n", yaxt = "n", ylab = "", xlab = "", lwd=2)
axis(side = 4)
mtext("Percent Positive", side=4, col="black")
par(new=TRUE)
plot(as.numeric(as.character(trim_data$V9)), col="yellow", ylim=c(0,27), type="l", 
     xaxt = "n", yaxt = "n", ylab = "", xlab = "", lty=4, lwd=2)
par(new=TRUE)
plot(as.numeric(as.character(trim_data$V10)), col="green", ylim=c(0,27), type="l", 
     xaxt = "n", yaxt = "n", ylab = "", xlab = "", lty=5, lwd=2)

legend(20, 27, legend = c("A","B", "Percent Positive", "% Positive Flu A", "% Positive Flu B"), 
       col = c("yellow","green","black", "yellow", "green"), cex=1, 
       fill = c("yellow","green","black","white", "white"), lwd =c("","",2, 2, 2), lty = c(1,4,5))



########################################################################################################
library(ggplot2)
library(reshape2)
data_new = read.csv(file.choose(), header = FALSE)
trimmed_data = data_new[21:72,]
trimmed_data$V3 = as.numeric(paste(as.numeric(as.character(trimmed_data$V3)),trimmed_data$V4, sep = ""))
trimmed_data_plotter <- trimmed_data[,c(3,6,7,8,9,10,11,12)]

df = data.frame(
  weeks = trimmed_data_plotter$V3,
  A1 = trimmed_data_plotter$V6,
  A2 = trimmed_data_plotter$V7,
  A3 = trimmed_data_plotter$V8,
  B1 = trimmed_data_plotter$V9,
  B2 = trimmed_data_plotter$V10,
  B3 = trimmed_data_plotter$V11,
  H = trimmed_data_plotter$V12
)

barplot(as.numeric(as.character(df$A1)), xlab = "Weeks", ylab="Number of Specimens", 
        names.arg=c(as.character(df$weeks)), main = "Influenza Positive Tests reported to CDC", 
        col = "yellow", ylim=c(0,2000), las=2)
par(new=TRUE)
barplot(as.numeric(as.character(df$A2)), col = "red", yaxt="n", ylim = c(0,2000))
par(new=T)
barplot(as.numeric(as.character(df$A3)), yaxt="n", col = "green", ylim=c(0,2000))
par(new=T)
barplot(as.numeric(as.character(df$B1)), yaxt="n", col = "black", ylim=c(0,2000))
par(new=T)
barplot(as.numeric(as.character(df$B2)), yaxt="n", col = "violet", ylim=c(0,2000))
par(new=T)
barplot(as.numeric(as.character(df$B3)), yaxt="n", col = "blue", ylim=c(0,2000))
par(new=T)
barplot(as.numeric(as.character(df$H)), yaxt="n", col = "pink", ylim=c(0,2000))
legend(10, 1800, legend = c("A (2009 H1N1)","A (H3)", "A (Subtyping not Performed)", "B (Lineage not Performed)", "B (Victorian Lineage)", "B (Yamagata Lineage)"), 
       col = c("yellow","red","green","black", "violet", "blue","pink"), cex=0.75, 
       fill = c("yellow","red","green","black", "violet", "blue","pink"))

