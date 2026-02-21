# Code example from 'JodaVignette' vignette. See references/ for full tutorial.

### R code from vignette source 'JodaVignette.Rnw'

###################################################
### code chunk number 1: options
###################################################
options(width=70)


###################################################
### code chunk number 2: preliminaries
###################################################
library(joda)
data(damage)


###################################################
### code chunk number 3: JodaVignette.Rnw:63-65
###################################################
head(data.healthy)
head(data.damage)


###################################################
### code chunk number 4: JodaVignette.Rnw:73-75
###################################################
print(model.healthy)
print(model.damage)


###################################################
### code chunk number 5: JodaVignette.Rnw:83-86
###################################################
str(beliefs.healthy)
str(beliefs.damage)
head(beliefs.healthy[["p53"]])


###################################################
### code chunk number 6: JodaVignette.Rnw:111-112
###################################################
probs.healthy=differential.probs(data=data.healthy, beliefs=beliefs.healthy, verbose=TRUE, plot.it=TRUE)


###################################################
### code chunk number 7: fig-healthyM
###################################################
probs.healthy=differential.probs(data=data.healthy, beliefs=beliefs.healthy, verbose=FALSE, plot.it=TRUE)


###################################################
### code chunk number 8: JodaVignette.Rnw:135-136
###################################################
probs.damage=differential.probs(data=data.damage, beliefs=beliefs.damage, verbose=TRUE, plot.it=TRUE)


###################################################
### code chunk number 9: fig-damageM
###################################################
probs.damage=differential.probs(data=data.damage, beliefs=beliefs.damage, verbose=FALSE, plot.it=TRUE)


###################################################
### code chunk number 10: JodaVignette.Rnw:165-169
###################################################
regulation.healthy= regulation.scores(probs.healthy, model.healthy, TRUE) 
head(regulation.healthy) 
regulation.damage= regulation.scores(probs.damage, model.damage, TRUE) 
head(regulation.damage) 


###################################################
### code chunk number 11: JodaVignette.Rnw:177-179
###################################################
deregulation= deregulation.scores(reg.scores1=regulation.healthy, reg.scores2=regulation.damage, TRUE) 
head(deregulation)


###################################################
### code chunk number 12: JodaVignette.Rnw:186-187
###################################################
head(rownames(deregulation)[order(deregulation[,"p53"])])


