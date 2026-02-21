# Code example from 'panp' vignette. See references/ for full tutorial.

### R code from vignette source 'panp.Rnw'

###################################################
### code chunk number 1: LibraryPreload
###################################################
library(gcrma)
library(panp)


###################################################
### code chunk number 2: load.ExpressionSet
###################################################
data(gcrma.ExpressionSet)


###################################################
### code chunk number 3: usage.info
###################################################
pa.calls()


###################################################
### code chunk number 4: run.pa.calls
###################################################
PA <- pa.calls(gcrma.ExpressionSet)


###################################################
### code chunk number 5: extract.PAcalls
###################################################
PAcalls <- PA$Pcalls
Pvalues <- PA$Pvals

write.table(PAcalls, file="PAcalls_gcrma.csv", sep=",", col.names=NA)
write.table(Pvalues, file="Pvalues_gcrma.csv", sep=",", col.names=NA)


###################################################
### code chunk number 6: show.some.output
###################################################
head(PAcalls[,1])

head(Pvalues[,1])


###################################################
### code chunk number 7: extract.names
###################################################
P_list_1 <-rownames(PAcalls)[PAcalls[,1]=="P"]
M_list_1 <-rownames(PAcalls)[PAcalls[,1]=="M"]
A_list_1 <-rownames(PAcalls)[PAcalls[,1]=="A"]


###################################################
### code chunk number 8: panp.Rnw:136-188
###################################################
data(NSMPnames.hgu133a)	# read in the NSMP names list
# create x and y ranges for NSMP intensities
NSMP_x <- sort(exprs(gcrma.ExpressionSet)[NSMPnames.hgu133a,1], decreasing=TRUE)
NSMP_y <- seq(0,1,1/(length(NSMP_x)-1))

# Plot expression densities of all probesets, then just NSMPs
plot(density(exprs(gcrma.ExpressionSet)[,1]),
	col="blue",
	xlim = c(1,13),
	ylim = c(0,.8),
	main = "Expression density: NSMPs vs. all, and NSMP survivor curve",
	xlab = "Log2(Intensity)",
	ylab = "Probability density")
lines(density(NSMP_x), col=6)

# interpolate over the NSMP exprs to draw survivor function
interp <- approxfun(NSMP_x, NSMP_y, yleft=1, yright=0) 
x = NSMP_x
curve(interp(x),add=TRUE, lwd=2)	 #add it to the plot

# reverse interpolate to get intensity values at p-value cutoffs
revInterp <- approxfun(NSMP_y, NSMP_x, yleft=1, yright=0)
rev01=revInterp(0.01)
rev02=revInterp(0.02)
# Pinpoint the x-y locations
# points(rev01, .01, pch=21, cex=2, lwd=2,col=1)
# points(rev02, .02, pch=21, cex=2, lwd=2,col=1)

# Draw horiz. lines & labels for both Pval cutoffs: tightCutoff, looseCutoff:
abline(h = 0.01, col = 1, lty = 2)
abline(h = 0.02, col = 1, lty = 2)
text(2.4, 0.01, pos=3, offset=0.1, cex=.7, as.character(0.01))
text(1.7, 0.02, pos=3, offset=0.1, cex=.7, as.character(0.02))

# vertical lines & labels for interpolated intensities at cutoffs
revTight=revInterp(0.01)
revLoose=revInterp(0.02)
abline(v = revTight, col = 1, lty = 2)
abline(v = revLoose, col = 1, lty = 2)
text(revLoose, .35, pos=2, offset=0.1, cex=.7, format.pval(revLoose,digits=3))
text(revTight, .30, pos=2, offset=0.1, cex=.7, format.pval(revTight,digits=3))
text(revLoose, .35, pos=4, cex=.8, "Log(intensity)")
text(revTight, .30, pos=4, cex=.8, "Log(intensity)")

lines(density(exprs(gcrma.ExpressionSet)[,1][PAcalls[,1]=="P"], bw=.1, n=512),col=2, lty=2, lwd=1)
lines(density(exprs(gcrma.ExpressionSet)[,1][PAcalls[,1]=="A"], bw=.1, n=512),col=3, lty=2, lwd=1)

legend(7.5,.8, c("NSMP exprs, survivor fcn.","NSMP exprs, density","All probesets, density","'Present' probesets, density","'Absent' probesets, density"),
col = c(1,6,4,2,3), lty=c(1,1,1,2,2), lwd=c(2,1,1,1,1), cex=.75,
 	text.col= "darkgreen",
 	bg='gray90')



