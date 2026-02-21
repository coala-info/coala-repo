# Code example from 'CAFE-manual' vignette. See references/ for full tutorial.

### R code from vignette source 'CAFE-manual.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: CAFE-manual.Rnw:83-84
###################################################
library(CAFE)


###################################################
### code chunk number 3: CAFE-manual.Rnw:88-89 (eval = FALSE)
###################################################
## setwd("~/some/path")


###################################################
### code chunk number 4: CAFE-manual.Rnw:93-94 (eval = FALSE)
###################################################
## datalist <- ProcessCels()


###################################################
### code chunk number 5: CAFE-manual.Rnw:107-109
###################################################
data("CAFE_data")
#will put object named {\bf CAFE}_data in your global environment


###################################################
### code chunk number 6: CAFE-manual.Rnw:127-133
###################################################
#we first have to decide which samples we want to use.
names(CAFE_data[[2]]) #to see which samples we got
sam <- c(1,3) #so we use sample numbers 1, and 3 to compare against the rest
chromosomeStats(CAFE_data,chromNum=17,samples=sam,
                test="fisher",bonferroni=FALSE,enrichment="greater") 
# we are only testing 1 chromosome


###################################################
### code chunk number 7: CAFE-manual.Rnw:138-140
###################################################
chromosomeStats(CAFE_data,chromNum=17,samples=sam,
                test="chisqr",bonferroni=FALSE,enrichment="greater")


###################################################
### code chunk number 8: CAFE-manual.Rnw:147-149
###################################################
chromosomeStats(CAFE_data,chromNum="ALL",samples=sam,
                test="fisher",bonferroni=TRUE,enrichment="greater")


###################################################
### code chunk number 9: CAFE-manual.Rnw:157-160
###################################################
bandStats(CAFE_data,chromNum=17,samples=sam,test="fisher",
          bonferroni=TRUE,enrichment="greater") 
#multiple bands per chromosome, so need bonferroni!


###################################################
### code chunk number 10: CAFE-manual.Rnw:178-179
###################################################
p <- rawPlot(CAFE_data,samples=c(1,3,10),chromNum=17)


###################################################
### code chunk number 11: rawplot
###################################################
print(p)


###################################################
### code chunk number 12: rawplot1
###################################################
print(p)


###################################################
### code chunk number 13: CAFE-manual.Rnw:200-201
###################################################
p <- slidPlot(CAFE_data,samples=c(1,3,10),chromNum=17,k=100)


###################################################
### code chunk number 14: slidplot
###################################################
print(p)


###################################################
### code chunk number 15: slidplot
###################################################
print(p)


###################################################
### code chunk number 16: CAFE-manual.Rnw:228-229
###################################################
p <- discontPlot(CAFE_data,samples=c(1,3,10),chromNum=17,gamma=100)


###################################################
### code chunk number 17: discontplot
###################################################
print(p)


###################################################
### code chunk number 18: discontplot
###################################################
print(p)


###################################################
### code chunk number 19: CAFE-manual.Rnw:246-247
###################################################
p <- facetPlot(CAFE_data,samples=c(1,3,10),slid=TRUE,combine=TRUE,k=100)


###################################################
### code chunk number 20: facetplot
###################################################
print(p)


###################################################
### code chunk number 21: facetplot
###################################################
print(p)


###################################################
### code chunk number 22: CAFE-manual.Rnw:271-274 (eval = FALSE)
###################################################
## data <- ProcessCels()
## chromosomeStats(data,samples=c(1,3),chromNum="ALL")
## discontPlot(data,samples=c(1,3),chromNum="ALL",gamma=100)


###################################################
### code chunk number 23: CAFE-manual.Rnw:393-394
###################################################
str(CAFE_data$whole[[1]])


###################################################
### code chunk number 24: CAFE-manual.Rnw:403-404
###################################################
print(names(CAFE_data$whole))


