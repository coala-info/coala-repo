# Code example from 'flowTrans' vignette. See references/ for full tutorial.

### R code from vignette source 'flowTrans.Rnw'

###################################################
### code chunk number 1: loaddata
###################################################
library(flowTrans)
data(GvHD)
transformed<-lapply(as(GvHD[1:4],"list"),function(x)flowTrans(dat=x,fun="mclMultivArcSinh",dims=c("FSC-H","SSC-H"),n2f=FALSE,parameters.only=FALSE));


###################################################
### code chunk number 2: parameters
###################################################
parameters<-do.call(rbind,lapply(transformed,function(x)extractParams(x)[[1]]))
parameters;


###################################################
### code chunk number 3: plot
###################################################
par(mfrow = c(2, 2))
plot(GvHD[[2]], c("FSC-H", "SSC-H"), main = "Untransformed sample")
contour(GvHD[[2]], c("FSC-H","SSC-H"),add=TRUE);
plot(transformed[[2]]$result, c("FSC-H", "SSC-H"), main = "Transformed sample")
contour(transformed[[2]]$result,c("FSC-H","SSC-H"),add=TRUE);
plot(GvHD[[4]], c("FSC-H", "SSC-H"), main = "Untransformed sample")
contour(GvHD[[4]], c("FSC-H","SSC-H"),add=TRUE);
plot(transformed[[4]]$result, c("FSC-H", "SSC-H"), main = "Transformed sample")
contour(transformed[[4]]$result, c("FSC-H","SSC-H"),add=TRUE);


###################################################
### code chunk number 4: multivtrans
###################################################
transformed2<-flowTrans(dat=GvHD[[2]],fun="mclMultivArcSinh",dims=c("FSC-H","SSC-H"),n2f=FALSE,parameters.only=TRUE)
transformed2


