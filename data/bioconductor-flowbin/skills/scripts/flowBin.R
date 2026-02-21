# Code example from 'flowBin' vignette. See references/ for full tutorial.

### R code from vignette source 'flowBin.Rnw'

###################################################
### code chunk number 1: stagea
###################################################
library(flowBin)
library(flowFP)
data(fs1)
show(fs1)


###################################################
### code chunk number 2: stageb
###################################################
fsApply(fs1, function(x){x@parameters@data[,'desc']})


###################################################
### code chunk number 3: stagex
###################################################
aml.sample <- new('FlowSample',
				  			name='Example flowSample', 
                            tube.set=as.list(fs1@frames), 
                            control.tubes=c(1), 
                            bin.pars=c(1,2,5), 
                            measure.pars=list(c(3,4,6,7)))
show(aml.sample)



###################################################
### code chunk number 4: examineTubes
###################################################
data(amlsample)
tube1.frame <- tube.set(aml.sample)[[1]]
show(tube1.frame)
plot(exprs(tube1.frame)[,c(5,2)], pch=16, cex=0.6, xlim=c(0,4), ylim=c(0,4))


###################################################
### code chunk number 5: examineTubes2
###################################################
plot(exprs(tube1.frame)[,c(3,6)], pch=16, cex=0.6, xlim=c(0,4), ylim=c(0,4))


###################################################
### code chunk number 6: examineTubes
###################################################
tube7.frame <- tube.set(aml.sample)[[7]]
show(tube7.frame)
plot(exprs(tube7.frame)[,c(3,6)], pch=16, cex=0.6, xlim=c(0,4), ylim=c(0,4))


###################################################
### code chunk number 7: stage1
###################################################
normed.sample <- quantileNormalise(aml.sample)


###################################################
### code chunk number 8: stage2
###################################################
qnorm.check <- checkQNorm(aml.sample, normed.sample, do.plot=F)
plot(qnorm.check$sd.before, type='l', lwd=2, 
	 ylim=c(0, max(qnorm.check$sd.before)), 
	 xlab='Tubes', 
	 ylab='Standard deviation of bin densities', 
	 main='SD before and after normalisation')
lines(qnorm.check$sd.after, lwd=2, col='blue')
legend(x=5.5, y=0.35, legend=c('Before', 'After'), lwd=2, col=c('black', 'blue'))


###################################################
### code chunk number 9: flowBinRun
###################################################
tube.combined <- flowBin(tube.list=aml.sample@tube.set, 
bin.pars=aml.sample@bin.pars, 
control.tubes=aml.sample@control.tubes, 
expr.method='medianFIDist', 
scale.expr=T)


###################################################
### code chunk number 10: flowBinPlot
###################################################
heatmap(tube.combined, scale='none')


###################################################
### code chunk number 11: flowBinRun2
###################################################
tube.propPos <- flowBin(tube.list=aml.sample@tube.set, 
bin.pars=aml.sample@bin.pars, 
control.tubes=aml.sample@control.tubes, 
expr.method='propPos', 
scale.expr=T)


###################################################
### code chunk number 12: flowBinPlot2
###################################################
heatmap(tube.propPos, scale='none')


