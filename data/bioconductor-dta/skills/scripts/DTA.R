# Code example from 'DTA' vignette. See references/ for full tutorial.

### R code from vignette source 'DTA.Rnw'

###################################################
### code chunk number 1: Loading library
###################################################
library(DTA)


###################################################
### code chunk number 2: Loading Miller2011
###################################################
data(Miller2011)


###################################################
### code chunk number 3: Loading datamat
###################################################
colnames(Sc.datamat)[1:6]
rownames(Sc.datamat)[1:6]
Sc.datamat[1:6,1:3]


###################################################
### code chunk number 4: Loading phenomat
###################################################
head(Sc.phenomat)


###################################################
### code chunk number 5: Loading tnumber
###################################################
head(Sc.tnumber)


###################################################
### code chunk number 6: Total expression histogram
###################################################
Totals = Sc.datamat[,which(Sc.phenomat[,"fraction"]=="T")]
Total = apply(log(Totals),1,median)
plotsfkt = function(){
par(mar = c(5,4,4,2)+0.1+1)
par(mai = c(1.1,1.1,1.3,0.7))
hist(Total,breaks = seq(0,ceiling(max(Total)),1/4),
cex.main=1.5,cex.lab=1.25,cex.axis=1.125,
main="Histogram of log(Total)",
xlab="gene-wise median of total samples")
hist(Total[Total >= 5],breaks = seq(0,ceiling(max(Total)),1/4),
col = "#08306B",add = TRUE)
}
DTA.plot.it(filename = "histogram_cut_off",plotsfkt = plotsfkt,
saveit = TRUE,notinR = TRUE)


###################################################
### code chunk number 7: Loading reliable
###################################################
head(Sc.reliable)


###################################################
### code chunk number 8: Estimation procedure
###################################################
res = DTA.estimate(Sc.phenomat,Sc.datamat,Sc.tnumber,
ccl = 150,mRNAs = 60000,reliable = Sc.reliable, 
condition = "real_data",save.plots = TRUE,notinR = TRUE,folder = ".")


###################################################
### code chunk number 9: Entries of res
###################################################
names(res)


###################################################
### code chunk number 10: Entries of res6
###################################################
names(res[["6"]])


###################################################
### code chunk number 11: plot half-lives/sythesis rates
###################################################
data(Sc.ribig.ensg)
data(Sc.rpg.ensg)
data(Sc.tf.ensg)
data(Sc.stress.ensg)


###################################################
### code chunk number 12: plot half-lives/sythesis rates
###################################################
plotsfkt = function(){
par(mar = c(5,4,4,2)+0.1+1)
par(mai = c(1.1,1.1,1.3,0.7))
x=res[["6"]][["hl"]][c(Sc.reliable,Sc.rpg.ensg)]
y=res[["6"]][["Rsr"]][c(Sc.reliable,Sc.rpg.ensg)]
ellipsescatter(x,y,
groups = list("Stress"=Sc.stress.ensg,"RiBi-genes"=Sc.ribig.ensg,
"Rp-genes"=Sc.rpg.ensg,"TF"=Sc.tf.ensg),
colors = c("darkred","darkgreen","darkblue","grey20"),
xlim=c(0,150),ylim=c(0,600),xlab="half-lives",ylab="synthesis rates",
cex.main=1.5,cex.lab=1.25,cex.axis=1.125,main="Ellipsescatter")}
DTA.plot.it(filename = "ellipse_scatter",plotsfkt = plotsfkt,
saveit = TRUE,notinR = TRUE)


###################################################
### code chunk number 13: Estimation procedure (no bias correction)
###################################################
res.nobias = DTA.estimate(Sc.phenomat,Sc.datamat,Sc.tnumber,
ccl = 150, mRNAs = 60000,reliable = Sc.reliable,save.plots = TRUE,
notinR = TRUE,folder = ".",bicor = FALSE,condition="no_bias_correction")


###################################################
### code chunk number 14: Creating simulation object
###################################################
sim.object = DTA.generate(timepoints=rep(c(6,12),2))


###################################################
### code chunk number 15: Entries of sim.object
###################################################
names(sim.object)


###################################################
### code chunk number 16: Estimation procedure for simulated data
###################################################
res.sim = DTA.estimate(ratiomethod = "bias",save.plots = TRUE,
notinR = TRUE,folder = ".",simulation = TRUE,sim.object = sim.object,
condition = "simulation")


###################################################
### code chunk number 17: Estimation procedure for simulated data
###################################################
res.sim = DTA.estimate(ratiomethod = "bias",save.plots = TRUE,
notinR = TRUE,folder = ".",simulation = TRUE,sim.object = sim.object,
bicor = FALSE,condition = "simulation_no_bias_correction")


###################################################
### code chunk number 18: Loading Miller2011dynamic
###################################################
data(Miller2011dynamic)


###################################################
### code chunk number 19: Estimation procedure
###################################################
timecourse.res = DTA.dynamic.estimate(Sc.phenomat.dynamic,Sc.datamat.dynamic,
Sc.tnumber,ccl = 150,mRNAs = 60000,reliable = Sc.reliable.dynamic,
LtoTratio = rep(0.1,7),save.plots = TRUE,notinR = TRUE,folder = ".",
condition = "timecourse")


###################################################
### code chunk number 20: Entries of timecourse.res
###################################################
names(timecourse.res)


###################################################
### code chunk number 21: Entries of timecourse.res1
###################################################
names(timecourse.res[["1"]])


###################################################
### code chunk number 22: Creating timecourse simulation
###################################################
nrgenes = 5000
truesynthesisrates = rf(nrgenes,5,5)*18
steady = rep(1,nrgenes)
shock = 1/pmax(rnorm(nrgenes,mean = 8,sd = 4),1)
induction = pmax(rnorm(nrgenes,mean = 8,sd = 4),1)
changes.mat = cbind(steady,shock,shock*induction)
mu.values.mat = changes.mat*truesynthesisrates
mu.breaks.mat = cbind(rep(12,nrgenes),rep(18,nrgenes))
truehalflives = rf(nrgenes,15,15)*12
truelambdas = log(2)/truehalflives
changes.mat = cbind(steady,shock,shock*induction,steady)
lambda.values.mat = changes.mat*truelambdas
lambda.breaks.mat = cbind(rep(12,nrgenes),rep(18,nrgenes),rep(27,nrgenes))


###################################################
### code chunk number 23: Creating timecourse simulation object
###################################################
timecourse.sim.object = DTA.dynamic.generate(duration = 36,lab.duration = 6,
nrgenes = nrgenes,mu.values.mat = mu.values.mat,mu.breaks.mat = mu.breaks.mat,
lambda.values.mat = lambda.values.mat,lambda.breaks.mat = lambda.breaks.mat)


###################################################
### code chunk number 24: Entries of timecourse.sim.object
###################################################
names(timecourse.sim.object)


###################################################
### code chunk number 25: Estimation procedure for simulated timecourse data
###################################################
timecourse.res.sim = DTA.dynamic.estimate(save.plots = TRUE,notinR = TRUE,
simulation = TRUE,sim.object = timecourse.sim.object,ratiomethod = "tls",
folder = ".",condition = "simulation_timecourse",check = FALSE)


###################################################
### code chunk number 26: Loading Doelken2008 (eval = FALSE)
###################################################
## data(Doelken2008)


###################################################
### code chunk number 27: Mm map tnumber (eval = FALSE)
###################################################
## Mm.tnumber = DTA.map.it(Mm.tnumber,Mm.enst2ensg)


###################################################
### code chunk number 28: Mm DTA estimation procedure (eval = FALSE)
###################################################
## res = DTA.estimate(Mm.phenomat,Mm.datamat,Mm.tnumber,
## ccl = 24*60,reliable = Mm.reliable,ratiomethod = "tls")


###################################################
### code chunk number 29: Hs map tnumber (eval = FALSE)
###################################################
## Hs.tnumber = DTA.map.it(Hs.tnumber,Hs.enst2ensg)


###################################################
### code chunk number 30: Hs DTA estimation procedure (eval = FALSE)
###################################################
## res = DTA.estimate(Hs.phenomat,Hs.datamat,Hs.tnumber,
## ccl = 50*60,reliable = Hs.reliable,ratiomethod = "tls",
## bicor = FALSE)


###################################################
### code chunk number 31: sessionInfo
###################################################
toLatex(sessionInfo())


