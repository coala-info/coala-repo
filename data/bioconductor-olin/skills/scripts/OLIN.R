# Code example from 'OLIN' vignette. See references/ for full tutorial.

### R code from vignette source 'OLIN.Rnw'

###################################################
### code chunk number 1: OLIN.Rnw:52-53
###################################################
  library(OLIN) 


###################################################
### code chunk number 2: OLIN.Rnw:87-89 (eval = FALSE)
###################################################
##   data(sw)
##   fgbg.visu(sw[,3])


###################################################
### code chunk number 3: OLIN.Rnw:94-96
###################################################
  data(sw)
  fgbg.visu(sw[,3])


###################################################
### code chunk number 4: OLIN.Rnw:111-112 (eval = FALSE)
###################################################
## plot(maA(sw[,3]),maM(sw[,3]),xlab="A",ylab="M")


###################################################
### code chunk number 5: OLIN.Rnw:118-120
###################################################
par(cex.lab=0.6)
plot(maA(sw[,3]),maM(sw[,3]),xlab="A",ylab="M",pch='.')


###################################################
### code chunk number 6: OLIN.Rnw:128-130 (eval = FALSE)
###################################################
## mxy.plot(maM(sw)[,3],Ngc=maNgc(sw),Ngr=maNgr(sw),
##                  Nsc=maNsc(sw),Nsr=maNsr(sw))


###################################################
### code chunk number 7: OLIN.Rnw:136-138
###################################################
mxy.plot(maM(sw)[,3],Ngc=maNgc(sw),Ngr=maNgr(sw),
                 Nsc=maNsc(sw),Nsr=maNsr(sw))


###################################################
### code chunk number 8: OLIN.Rnw:151-153 (eval = FALSE)
###################################################
## data(sw.xy)
## mxy.abs.plot(maM(sw)[,3],Ngc=maNgc(sw),Ngr=maNgr(sw),Nsc=maNsc(sw),Nsr=maNsr(sw))


###################################################
### code chunk number 9: OLIN.Rnw:159-162
###################################################
data(sw.xy)
mxy.abs.plot(maM(sw)[,3],Ngc=maNgc(sw),Ngr=maNgr(sw),Nsc=maNsc(sw),Nsr=maNsr(sw))



###################################################
### code chunk number 10: OLIN.Rnw:178-182 (eval = FALSE)
###################################################
## data(sw.xy)
## mxy2.plot(maM(sw)[,3],X=sw.xy$X[,3],Y=sw.xy$Y[,3],
##           Ngc=maNgc(sw),Ngr=maNgr(sw),Nsc=maNsc(sw),Nsr=maNsr(sw))
## 


###################################################
### code chunk number 11: OLIN.Rnw:188-192
###################################################
data(sw.xy)
mxy2.plot(maM(sw)[,3],X=sw.xy$X[,3],sw.xy$Y[,3],
          Ngc=maNgc(sw),Ngr=maNgr(sw),Nsc=maNsc(sw),Nsr=maNsr(sw))



###################################################
### code chunk number 12: OLIN.Rnw:301-302
###################################################
norm.olin <- olin(sw[,3],X=sw.xy$X[,3],Y=sw.xy$Y[,3])


###################################################
### code chunk number 13: OLIN.Rnw:313-318 (eval = FALSE)
###################################################
## plot(maA(norm.olin),maM(norm.olin),main="OLIN",pch=".")
## 
## mxy.plot(maM(norm.olin),Ngc=maNgc(norm.olin),Ngr=maNgr(norm.olin),
##                 Nsc=maNsc(norm.olin),Nsr=maNsr(norm.olin),main="OLIN")
## 


###################################################
### code chunk number 14: OLIN.Rnw:326-329
###################################################
par(cex.main=0.8)
par(cex.lab =0.8)
plot(maA(norm.olin),maM(norm.olin),main="OLIN",pch=".")


###################################################
### code chunk number 15: OLIN.Rnw:340-343
###################################################
 
mxy.plot(norm.olin,Ngc=maNgc(norm.olin),Ngr=maNgr(norm.olin),
                Nsc=maNsc(norm.olin),Nsr=maNsr(norm.olin),main="OLIN")


###################################################
### code chunk number 16: OLIN.Rnw:355-361 (eval = FALSE)
###################################################
## norm.olin.1 <- olin(sw[,3],X=sw.xy$X[,3],Y=sw.xy$Y[,3],iter=1)
## norm.olin.2 <- olin(norm.olin.1,X=sw.xy$X[,3],Y=sw.xy$Y[,3],iter=1)
## norm.olin.3 <- olin(norm.olin.2,X=sw.xy$X[,3],Y=sw.xy$Y[,3],iter=1)
## 
## M <- cbind(maM(sw)[,3],maM(norm.olin.1),maM(norm.olin.2),maM(norm.olin.3))
## pairs(M,labels= c("raw","1.Iter.","2.Iter.","3.Iter."))


###################################################
### code chunk number 17: OLIN.Rnw:383-384
###################################################
norm.oslin <- olin(sw[,3],X=sw.xy$X[,3],Y=sw.xy$Y[,3],alpha=c(0.1,1,0.1),OSLIN=TRUE)


###################################################
### code chunk number 18: OLIN.Rnw:394-399 (eval = FALSE)
###################################################
## plot(maA(norm.oslin),maM(norm.oslin),main="OSLIN",pch=".")
## 
## mxy.plot(norm.oslin,Ngc=maNgc(norm.oslin),Ngr=maNgr(norm.oslin),
##                 Nsc=maNsc(norm.oslin),Nsr=maNsr(norm.oslin),main="OSLIN")
## 


###################################################
### code chunk number 19: OLIN.Rnw:407-410
###################################################
par(cex.main=0.8)
par(cex.lab =0.8)
plot(maA(norm.oslin),maM(norm.oslin),main="OSLIN",pch=".")


###################################################
### code chunk number 20: OLIN.Rnw:431-434
###################################################
 
 mxy.plot(norm.oslin,Ngc=maNgc(norm.oslin),Ngr=maNgr(norm.oslin),
                Nsc=maNsc(norm.oslin),Nsr=maNsr(norm.oslin),main="OSLIN")


###################################################
### code chunk number 21: OLIN.Rnw:487-514 (eval = FALSE)
###################################################
## 
## 
## data(sw.olin)
## 
## # DISTRIBUTION OF LOGGED RATIOS BEFORE BETWEEN-ARRAY-SCALING
## col <- c("red","blue","green","orange")
## M <- maM(sw.olin)
## 
## 
## plot(density(M[,4]),col=col[4],xlim=c(-2,2))
## for (i in 1:3){
##   lines(density(M[,i]),col=col[i])
## }
## 
## 
## # BETWEEN-ARRAY SCALING   
## sw.olin.s <- bas(sw.olin,mode="var")
##   
## 
## # VISUALISATION 
## M <- maM(sw.olin.s)
## plot(density(M[,4]),col=col[4],xlim=c(-2,2))
## for (i in 1:3){
##   lines(density(M[,i]),col=col[i])
## }
## 
## 


###################################################
### code chunk number 22: OLIN.Rnw:522-531
###################################################
data(sw.olin)
par(cex.main =0.8)
par(cex.lab=0.8)
col <- c("red","blue","green","orange")
M <- maM(sw.olin)
plot(density(M[,4]),col=col[4],xlim=c(-2,2))
for (i in 1:3){
  lines(density(M[,i]),col=col[i])
}


###################################################
### code chunk number 23: OLIN.Rnw:540-549
###################################################
sw.olin.s <- bas(sw.olin,mode="var")
par(cex.main = 0.8)
par(cex.lab = 0.8)
M <- maM(sw.olin.s)
plot(density(M[,4]),col=col[4],xlim=c(-2,2))
for (i in 1:3){
  lines(density(M[,i]),col=col[i])
}



###################################################
### code chunk number 24: OLIN.Rnw:583-589
###################################################
 A <- maA(sw[,3])
 M <- maM(sw[,3])
# Averaging
 Mav <- ma.vector(A,M,av="median",delta=50)
# Correlation 
 cor(Mav,M,use="pairwise.complete.obs")


###################################################
### code chunk number 25: OLIN.Rnw:594-602
###################################################
# From Vector to Matrix
 MM <-  v2m(maM(sw)[,3],Ngc=maNgc(sw),Ngr=maNgr(sw),Nsc=maNsc(sw),Nsr=maNsr(sw),visu=FALSE)
# Averaging of matrix M 
 MMav <- ma.matrix(MM,av="median",delta= 2,edgeNA=FALSE)
# Backconversion to vector
 Mav <- m2v(MMav,Ngc=maNgc(sw),Ngr=maNgr(sw),Nsc=maNsc(sw),Nsr=maNsr(sw),visu=FALSE)
# Correlation 
 cor(Mav,M,use="pairwise.complete.obs")


###################################################
### code chunk number 26: OLIN.Rnw:617-618
###################################################
 print(anovaint(sw,index=3,N=10))


###################################################
### code chunk number 27: OLIN.Rnw:621-623
###################################################
 data(sw.olin)
 print(anovaint(sw.olin,index=3,N=10))


###################################################
### code chunk number 28: OLIN.Rnw:637-638 (eval = FALSE)
###################################################
##   anovaspatial(sw,index=3,xN=8,yN=8,visu=TRUE)


###################################################
### code chunk number 29: OLIN.Rnw:641-642 (eval = FALSE)
###################################################
##   anovaspatial(sw.olin,index=3,xN=8,yN=8,visu=TRUE) 


###################################################
### code chunk number 30: OLIN.Rnw:647-648
###################################################
s <-  anovaspatial(sw,index=3,xN=8,yN=8,visu=TRUE)


###################################################
### code chunk number 31: OLIN.Rnw:656-657
###################################################
s <- anovaspatial(sw.olin,index=3,xN=8,yN=8,visu=TRUE) 


###################################################
### code chunk number 32: OLIN.Rnw:674-675
###################################################
 print(anovapin(sw.olin,index=3))


###################################################
### code chunk number 33: OLIN.Rnw:679-680
###################################################
 print(anovaplate(sw.olin,index=3))


###################################################
### code chunk number 34: OLIN.Rnw:717-719 (eval = FALSE)
###################################################
## FDR <- fdr.int(maA(sw)[,3],maM(sw)[,3],delta=50,N=10,av="median")
## sigint.plot(maA(sw)[,3],maM(sw)[,3],FDR$FDRp,FDR$FDRn,c(-5,-5))


###################################################
### code chunk number 35: OLIN.Rnw:726-728
###################################################
FDR <- fdr.int(maA(sw)[,3],maM(sw)[,3],delta=50,N=10,av="median")
sigint.plot(maA(sw)[,3],maM(sw)[,3],FDR$FDRp,FDR$FDRn,c(-5,-5))


###################################################
### code chunk number 36: OLIN.Rnw:736-739 (eval = FALSE)
###################################################
## data(sw.olin)
## FDR <- fdr.int(maA(sw.olin)[,3],maM(sw.olin)[,3],delta=50,N=10,av="median")
## sigint.plot(maA(sw.olin)[,3],maM(sw.olin)[,3],FDR$FDRp,FDR$FDRn,c(-5,-5))


###################################################
### code chunk number 37: OLIN.Rnw:746-749
###################################################
data(sw.olin)
FDR <- fdr.int(maA(sw.olin)[,3],maM(sw.olin)[,3],delta=50,N=10,av="median")
sigint.plot(maA(sw.olin)[,3],maM(sw.olin)[,3],FDR$FDRp,FDR$FDRn,c(-5,-5))


###################################################
### code chunk number 38: OLIN.Rnw:763-768 (eval = FALSE)
###################################################
## M <- v2m(maM(sw)[,3],Ngc=maNgc(sw),Ngr=maNgr(sw),
##                 Nsc=maNsc(sw),Nsr=maNsr(sw),main="MXY plot of SW-array 1")
## 
## FDR <- fdr.spatial(M,delta=2,N=10,av="median",edgeNA=TRUE)
## sigxy.plot(FDR$FDRp,FDR$FDRn,color.lim=c(-5,5),main="FDR")


###################################################
### code chunk number 39: OLIN.Rnw:776-781
###################################################
M <- v2m(maM(sw)[,3],Ngc=maNgc(sw),Ngr=maNgr(sw),
                Nsc=maNsc(sw),Nsr=maNsr(sw),main="MXY plot of SW-array 1")

FDR <- fdr.spatial(M,delta=2,N=10,av="median",edgeNA=TRUE)
sigxy.plot(FDR$FDRp,FDR$FDRn,color.lim=c(-5,5),main="FDR")


###################################################
### code chunk number 40: OLIN.Rnw:788-792 (eval = FALSE)
###################################################
## M<- v2m(maM(sw.olin)[,3],Ngc=maNgc(sw.olin),Ngr=maNgr(sw.olin),
##                 Nsc=maNsc(sw.olin),Nsr=maNsr(sw.olin),main="MXY plot of SW-array 1")
## FDR <- fdr.spatial(M,delta=2,N=10,av="median",edgeNA=TRUE)
## sigxy.plot(FDR$FDRp,FDR$FDRn,color.lim=c(-5,5),main="FDR")


###################################################
### code chunk number 41: OLIN.Rnw:798-802
###################################################
M<- v2m(maM(sw.olin)[,3],Ngc=maNgc(sw.olin),Ngr=maNgr(sw.olin),
                Nsc=maNsc(sw.olin),Nsr=maNsr(sw.olin),main="MXY plot of SW-array 1")
FDR <- fdr.spatial(M,delta=2,N=10,av="median",edgeNA=TRUE)
sigxy.plot(FDR$FDRp,FDR$FDRn,color.lim=c(-5,5),main="FDR")


