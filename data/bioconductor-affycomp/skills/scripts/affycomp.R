# Code example from 'affycomp' vignette. See references/ for full tutorial.

### R code from vignette source 'affycomp.Rnw'

###################################################
### code chunk number 1: affycomp.Rnw:30-32
###################################################
library(affycomp)
library(affycompData)


###################################################
### code chunk number 2: affycomp.Rnw:135-137
###################################################
data(mas5.assessment)
data(rma.assessment)


###################################################
### code chunk number 3: affycomp.Rnw:140-141
###################################################
names(mas5.assessment)


###################################################
### code chunk number 4: affycomp.Rnw:175-176
###################################################
affycompPlot(mas5.assessment$MA)


###################################################
### code chunk number 5: affycomp.Rnw:193-194
###################################################
affycomp.figure2(mas5.assessment$Dilution)


###################################################
### code chunk number 6: affycomp.Rnw:207-208
###################################################
affycomp.figure3(mas5.assessment$Dilution)


###################################################
### code chunk number 7: affycomp.Rnw:223-226
###################################################
par(mfrow=c(2,1))
affycomp.figure4a(mas5.assessment$Signal)
affycomp.figure4b(mas5.assessment$Dilution)


###################################################
### code chunk number 8: affycomp.Rnw:240-243
###################################################
par(mfrow=c(2,1))
affycomp.figure5a(mas5.assessment$FC)
affycomp.figure5b(mas5.assessment$FC)


###################################################
### code chunk number 9: affycomp.Rnw:258-261
###################################################
par(mfrow=c(2,1))
affycomp.figure6a(mas5.assessment$FC)
affycomp.figure6b(mas5.assessment$FC)


###################################################
### code chunk number 10: affycomp.Rnw:282-284
###################################################
par(mfrow=c(2,1))
affycompPlot(mas5.assessment$MA, rma.assessment$MA)


###################################################
### code chunk number 11: affycomp.Rnw:301-303
###################################################
affycomp.compfig2(list(mas5.assessment$Dilution, rma.assessment$Dilution),
                  method.names=c("MAS 5.0","RMA"))


###################################################
### code chunk number 12: affycomp.Rnw:316-318
###################################################
affycomp.compfig3(list(mas5.assessment$Dilution, rma.assessment$Dilution),
                  method.names=c("MAS 5.0","RMA"))


###################################################
### code chunk number 13: affycomp.Rnw:333-338
###################################################
par(mfrow=c(2,1))
affycomp.compfig4a(list(mas5.assessment$Signal, rma.assessment$Signal),
                  method.names=c("MAS 5.0","RMA"))
affycomp.compfig4b(list(mas5.assessment$Dilution, rma.assessment$Dilution),
                  method.names=c("MAS 5.0","RMA"))


###################################################
### code chunk number 14: affycomp.Rnw:352-357
###################################################
par(mfrow=c(2,1))
affycomp.compfig5a(list(mas5.assessment$FC, rma.assessment$FC),
                  method.names=c("MAS 5.0","RMA"))
affycomp.compfig5b(list(mas5.assessment$FC2, rma.assessment$FC2),
                  method.names=c("MAS 5.0","RMA"))


###################################################
### code chunk number 15: affycomp.Rnw:372-377
###################################################
par(mfrow=c(2,2))
affycomp.figure6a(mas5.assessment$FC, main="a) MAS 5.0", ylim=c(-12,12))
affycomp.figure6a(rma.assessment$FC, main="a) RMA", ylim=c(-12,12))
affycomp.figure6b(mas5.assessment$FC, main="b) MAS 5.0", ylim=c(-6,6))
affycomp.figure6b(rma.assessment$FC, main="b) RMA", ylim=c(-6,6))


###################################################
### code chunk number 16: affycomp.Rnw:395-398
###################################################
data(rma.assessment)
data(mas5.assessment)
tableAll(rma.assessment, mas5.assessment)


###################################################
### code chunk number 17: affycomp.Rnw:406-407
###################################################
affycompTable(rma.assessment, mas5.assessment)


###################################################
### code chunk number 18: affycomp.Rnw:417-420
###################################################
data(rma.sd.assessment)
data(lw.sd.assessment)
tableAll(rma.sd.assessment, lw.sd.assessment)


###################################################
### code chunk number 19: affycomp.Rnw:430-431
###################################################
affycompPlot(lw.sd.assessment, rma.sd.assessment)


###################################################
### code chunk number 20: affycomp.Rnw:445-446
###################################################
affycompPlot(lw.sd.assessment)


