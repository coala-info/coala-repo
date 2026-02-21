# Code example from 'quick-start' vignette. See references/ for full tutorial.

### R code from vignette source 'quick-start.Rnw'

###################################################
### code chunk number 1: read
###################################################
library(SBMLR)
curto=readSBML(system.file("models", "curto.xml", package = "SBMLR"))  
head(summary(curto)$reactions)


###################################################
### code chunk number 2: save
###################################################
saveSBML(curto,"curto.xml")
saveSBMLR(curto,"curto.r")


###################################################
### code chunk number 3: equality
###################################################
curtoX=readSBML("curto.xml")
curtoR=readSBMLR("curto.r")
head((curtoX==curtoR)$species)
head((curtoX==curtoR)$reactions)


###################################################
### code chunk number 4: simulation
###################################################
out1=sim(curto,seq(-20,0,1))
curto$species$PRPP$ic=50
out2=sim(curto,0:70)
outs=data.frame(rbind(out1,out2))
attach(outs) 
par(mfrow=c(2,1))
plot(time,IMP,type="l",xlab="minutes",ylab="IMP (uM)")
plot(time,HX,type="l",xlab="minutes",ylab="HX (uM)")
par(mfrow=c(1,1))
detach(outs)


###################################################
### code chunk number 5: bumpLessXfer
###################################################
curto$species$PRPP$ic=5  # return PRPP IC to its original value
sim(curto,(-10):10,modulator=rep(2,37)) # bumpless transfer in concentrations since all V increase by 2


###################################################
### code chunk number 6: unstable
###################################################
sim(curto,(-10):10,modulator=c(rep(1.1,20),rep(0.9,17))) # half up, half down, not bumpless


###################################################
### code chunk number 7: folateSim
###################################################
morr=readSBML(file.path(system.file(package="SBMLR"), "models/morrison.xml"))  
out1=sim(morr,seq(-20,0,1))
morr$species$EMTX$ic=1 # bolus of methotrexate to 1 uM
out2=sim(morr,0:30)
outs=data.frame(rbind(out1,out2))
attach(outs)
par(mfrow=c(3,4))
plot(time,FH2b,type="l",xlab="Hours")
plot(time,FH2f,type="l",xlab="Hours")
plot(time,DHFRf,type="l",xlab="Hours")
plot(time,DHFRtot,type="l",xlab="Hours")
plot(time,CHOFH4,type="l",xlab="Hours")
plot(time,FH4,type="l",xlab="Hours")
plot(time,CH2FH4,type="l",xlab="Hours")
plot(time,CH3FH4,type="l",xlab="Hours")
plot(time,AICARsyn,type="l",xlab="Hours")
plot(time,MTR,type="l",xlab="Hours")
plot(time,TYMS,type="l",xlab="Hours")
#plot(time,EMTX,type="l",xlab="Hours")
plot(time,DHFReductase,type="l",xlab="Hours")
par(mfrow=c(1,1))
detach(outs)


###################################################
### code chunk number 8: summaryDump
###################################################
summary(curto)
curto


