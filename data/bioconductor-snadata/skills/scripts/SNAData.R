# Code example from 'SNAData' vignette. See references/ for full tutorial.

### R code from vignette source 'SNAData.Rnw'

###################################################
### code chunk number 1: loadlibs
###################################################

 library(graph)
 library(Rgraphviz)
 library(SNAData)



###################################################
### code chunk number 2: krackhardt
###################################################

data(advice)
data(friendship)
data(reportsTo)
data(krackhardtAttrs)

advice
friendship
reportsTo
krackhardtAttrs

plot(reportsTo)



###################################################
### code chunk number 3: padgett
###################################################

data(business)
data(marital)
data(florentineAttrs)

business
marital
florentineAttrs

adj(business,"Bischeri")
adj(marital,"Bischeri")



###################################################
### code chunk number 4: freeman
###################################################

data(acqTime1)
data(acqTime2)
data(messages)
data(freemanAttrs)

acqTime1
acqTime2
messages
freemanAttrs[1:5,]

edgeL(acqTime1,6)
edgeL(acqTime2,6)
edgeL(messages,6)



###################################################
### code chunk number 5: countries
###################################################

data(basicGoods)
data(food)
data(crudeMaterials)
data(minerals)
data(diplomats)
data(countriesAttrs)


basicGoods
food
crudeMaterials
minerals
diplomats
countriesAttrs[1:5,]

degree(basicGoods)
degree(diplomats)



###################################################
### code chunk number 6: CEOs
###################################################

data(CEOclubsBPG)
data(CEOclubsAM)

CEOclubsBPG
CEOclubsAM[1:5,1:5]

cc5 <- c(paste("CEO",1:5,sep=""),paste("Club",1:5,sep=""))
subG <- subGraph(cc5,CEOclubsBPG)
edgemode(subG) <- "directed"
plot(subG)



