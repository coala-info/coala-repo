# Code example from 'UNDO-vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'UNDO-vignette.Rnw'

###################################################
### code chunk number 1: packageLoad
###################################################
library(UNDO)
#load tumor stroma mixing tissue samples
data(NumericalMixMCF7HS27)
X <- NumericalMixMCF7HS27
#load mixing matrix for comparison
data(NumericalMixingMatrix)
A <- NumericalMixingMatrix


###################################################
### code chunk number 2: mixing matrix
###################################################
A


###################################################
### code chunk number 3: Deconvolution
###################################################
#load pure tumor stroma expressions 
data(PureMCF7HS27)
S <- exprs(PureMCF7HS27)

two_source_deconv(X,lowper=0.4,highper=0.1,epsilon1=0.01,
epsilon2=0.01,A,S[,1],S[,2],return=0)
											


###################################################
### code chunk number 4: Scatterplot
###################################################
# compute the estimated pure source expressions
result <- two_source_deconv(X,lowper=0.4,highper=0.1,epsilon1=0.01,
epsilon2=0.01,A,S[,1],S[,2],return=1)
Sest <- result[[5]]

#draw the scatter plots between pure and estimated expressions of 
#MCF7 and HS27
plot(S[,1],Sest[,1],main="MCF7" ,xlab="Estimated expression", 
ylab="Measured expression", xlim=c(0,15000), ylim=c(0,15000),
pch=1, col="turquoise", cex=0.5)


###################################################
### code chunk number 5: Scatterplot2
###################################################
plot(S[,2],Sest[,2],main="HS27" ,xlab="Estimated expression", 
ylab="Measured expression", xlim=c(0,15000), ylim=c(0,15000),
pch=1, col="turquoise", cex=0.5)



