# Code example from 'tr_2006_01' vignette. See references/ for full tutorial.

### R code from vignette source 'tr_2006_01.Rnw'

###################################################
### code chunk number 1: tr_2006_01.Rnw:49-51 (eval = FALSE)
###################################################
## q(save="no")
## 


###################################################
### code chunk number 2: tr_2006_01.Rnw:52-57
###################################################
library(Biobase)
library(twilight)
oldopt <- options(digits=3)
on.exit( {options(oldopt)} )
options(width=75)


###################################################
### code chunk number 3: tr_2006_01.Rnw:227-239
###################################################
library(OrderedList)
data(OL.data)
OL.data$breast
OL.data$prostate
OL.data$map[1:5,]

A <- prepareData(
eset1=list(data=OL.data$prostate,name="prostate",var="outcome",out=c("Rec","NRec"),paired=FALSE),
eset2=list(data=OL.data$breast,name="breast",var="Risk",out=c("high","low"),paired=FALSE),
mapping=OL.data$map
)
A


###################################################
### code chunk number 4: tr_2006_01.Rnw:273-276
###################################################
x <- OrderedList(A, empirical=TRUE)
x
x$intersect[1:5]


###################################################
### code chunk number 5: tr_2006_01.Rnw:284-295
###################################################
bitmap(file="tr_2006_01-pauc.png",width=4,height=3,res=300)
plot(x,"pauc")
dev.off()
Sys.sleep(20)
bitmap(file="tr_2006_01-scores.png",width=4,height=3, res=300)
plot(x,"scores")
dev.off()
Sys.sleep(20)
bitmap(file="tr_2006_01-overlap.png",width=4,height=3, res=300)
plot(x,"overlap")
dev.off()


###################################################
### code chunk number 6: tr_2006_01.Rnw:384-388
###################################################
list1 <- as.character(OL.data$map$prostate)
list2 <- c(sample(list1[1:500]),sample(list1[501:1000]))
y <- compareLists(list1,list2)
y


###################################################
### code chunk number 7: tr_2006_01.Rnw:407-410
###################################################
z <- getOverlap(y)
z
z$intersect[1:5]


###################################################
### code chunk number 8: tr_2006_01.Rnw:414-422
###################################################
bitmap(file="tr_2006_01-z.png",width=4,height=3,res=300)
plot(z)
dev.off()
Sys.sleep(20)
bitmap(file="tr_2006_01-density.png",width=4,height=3,res=300)
plot(z,"scores")
dev.off()
Sys.sleep(20)


