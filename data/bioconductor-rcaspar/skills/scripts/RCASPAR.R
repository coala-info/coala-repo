# Code example from 'RCASPAR' vignette. See references/ for full tutorial.

### R code from vignette source 'RCASPAR.Rnw'

###################################################
### code chunk number 1: setup
###################################################
options(width = 40)


###################################################
### code chunk number 2: RCASPAR.Rnw:30-31
###################################################
library(RCASPAR)


###################################################
### code chunk number 3: pltprior
###################################################
pltprior(q=1, s=1)



###################################################
### code chunk number 4: pltgamma
###################################################
pltgamma(a=1.558,b=0.179)


###################################################
### code chunk number 5: STpredictor_BLH
###################################################
data(Bergamaschi)
data(survData)
result <- STpredictor_BLH(geDataS=Bergamaschi[1:27, 1:2], survDataS=survData[1:27, 9:10], geDataT=Bergamaschi[28:82, 1:2], 
survDataT=survData[28:82, 9:10], q = 1, s = 1, a = 1.558, b = 0.179, cut.off=15, groups = 3, method = "CG", noprior = 1, 
extras = list(reltol=1))


###################################################
### code chunk number 6: kmplt_svrl
###################################################
kmplt_svrl(long=result$long_survivors, short=result$short_survivors,title="KM plot of long and short survivors")


###################################################
### code chunk number 7: survivAURC
###################################################
survivAURC(Stime=result$predicted_STs$True_STs,status=result$predicted_STs$censored, marker=result$predicted_STs$Predicted_STs, time.max=20)


###################################################
### code chunk number 8: logrank
###################################################
logrnk(dataL=result$long_survivors, dataS=result$short_survivors)


