# Code example from 'ssize' vignette. See references/ for full tutorial.

### R code from vignette source 'ssize.Rnw'

###################################################
### code chunk number 1: ssize.Rnw:251-255
###################################################
library(ssize)
library(xtable)
library(gdata) # for nobs()
options(width=30)


###################################################
### code chunk number 2: ssize.Rnw:264-270
###################################################
# Load the example data
data(exp.sd)

# Use only the first 1000, 
# so examples run faster
exp.sd <- exp.sd[1:1000] 


###################################################
### code chunk number 3: SDPlot
###################################################
par(cex=2)
xlab <- c("Standard Deviation", "(for data on the log scale)")
hist(exp.sd,n=40, col="cyan", border="blue", main="", xlab=xlab, log="x")
dens <- density(exp.sd)
scaled.y <- dens$y*par("usr")[4]/max(dens$y) 
lines(dens$x,scaled.y ,col="red",lwd=2) #$


###################################################
### code chunk number 4: ssize.Rnw:309-313
###################################################
n<-6
fold.change<-2.0
power<-0.8
sig.level<-0.05


###################################################
### code chunk number 5: CumNPlot
###################################################
all.size  <- ssize(sd=exp.sd, delta=log2(fold.change),
                   sig.level=sig.level, power=power)
par(cex=1)
ssize.plot(all.size, lwd=2, col="magenta", xlim=c(1,20))
xmax <- par("usr")[2]-1; 
ymin <- par("usr")[3] + 0.05
legend(x=xmax, y=ymin,
       legend= strsplit( paste("fold change=",fold.change,",",
         "alpha=", sig.level, ",",
         "power=",power,",",
         "# genes=", nobs(exp.sd), sep=''), "," )[[1]],
       xjust=1, yjust=0, cex=0.90)
title("Sample Size to Detect 2-Fold Change")


###################################################
### code chunk number 6: CumPowerPlot
###################################################
all.power <- pow(sd=exp.sd, n=n, delta=log2(fold.change),
                 sig.level=sig.level)

par(cex=1)
power.plot(all.power, lwd=2, col="blue")
xmax <- par("usr")[2]-0.05; ymax <- par("usr")[4]-0.05
legend(x=xmax, y=ymax,
       legend= strsplit( paste("n=",n,",",
         "fold change=",fold.change,",",
         "alpha=", sig.level, ",",
         "# genes=", nobs(exp.sd), sep=''), "," )[[1]],
       xjust=1, yjust=1, cex=0.90)
title("Power to Detect 2-Fold Change")


###################################################
### code chunk number 7: CumFoldChangePlot
###################################################
all.delta  <- delta(sd=exp.sd, power=power, n=n,
                    sig.level=sig.level)
par(cex=1, mar=c(5.1,5.1,4,2))
delta.plot(all.delta, lwd=2, col="magenta", xlim=c(1,10),
	   ylab = paste("Proportion of Genes with ",
	        	"Power >= 80% \n",
			"at Fold Change of delta")
)
xmax <- par("usr")[2]-1; ymin <- par("usr")[3] + 0.05
legend(x=xmax, y=ymin,
       legend= strsplit( paste("n=",n,",",
         "alpha=", sig.level, ",",
         "power=",power,",",
         "# genes=", nobs(exp.sd), sep=''), "," )[[1]],
       xjust=1, yjust=0, cex=0.90)
title("Fold Change to Achieve 80% Power")


