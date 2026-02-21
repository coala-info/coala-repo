# Code example from 'QSutils-Simulation' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## ----install,message=FALSE----------------------------------------------------
BiocManager::install("QSutils")
library(QSutils)

## ----fn1----------------------------------------------------------------------
table(fn.ab(25,fn="pf"))

## ----plotfn1,fig.cap="Profile of abundances simulated with `fn.ab` with fn=pf"----
par(mfrow=c(1,2))
plot(fn.ab(25,fn="pf"),type="h")
plot(fn.ab(25,r=0.7,fn="pf"),type="h")

## ----fn2----------------------------------------------------------------------
table(fn.ab(25,r=3,fn="pcf"))

## ----fn2.2--------------------------------------------------------------------
table(fn.ab(25,r=2,fn="pcf"))

## ----plot-fn2,fig.cap="Abundances simulated with `fn.ab` with fn=pcf"---------
par(mfrow=c(1,2))
plot(fn.ab(25,r=3,fn="pcf"),type="h")
plot(fn.ab(25,r=2,fn="pcf"),type="h")

## ----fn3----------------------------------------------------------------------
table(fn.ab(25,fn="dfp"))

## ----plot-fn3,fig.cap="Abundances simulated with `fn.ab` with fn=dpf",out.width = '70%'----
par(mfrow=c(1,2))
plot(fn.ab(25,fn="dfp"),type="h")

## ----linearcomb---------------------------------------------------------------
ab <- 0.25*fn.ab(25,fn="pf")+0.75*fn.ab(25,r=3,fn="pcf")
table(ab)

## ----fig.cap="Abundances simulated with a linear combination of the functions"----
plot(ab,type="h",main="Linear combination of results")

## ----linearcomb2--------------------------------------------------------------
ab <- 0.7*fn.ab(25,fn="pf")+0.3*fn.ab(25,fn="dfp")
table(ab)

## ----fig.cap="Abundances simulated with a linear combination of the functions"----
plot(ab,type="h",main="Linear combination of results")

## ----geomseq------------------------------------------------------------------
par(mfrow=c(1,2))
ab1 <- 1e5 * geom.series(100,0.8)
plot(ab1,type="h",main="Geometric series with p=0.8",cex.main=1)
ab2 <- 1e5 * geom.series(100,0.001)
plot(ab2,type="h",main="Geometric series with p=0.001",ylim=c(0,max(ab2)),
    cex.main=1)

## ----plot-geomseq-------------------------------------------------------------
ab1 <- 1e5 * (geom.series(100,0.8)+geom.series(100,0.05))
plot(ab1,type="h",main="Combination of geometric series")

## ----randomseq----------------------------------------------------------------
set.seed(23)
m1 <- GetRandomSeq(50)
m1

## ----generatevars-------------------------------------------------------------
v1 <- GenerateVars(m1,20,2,c(10,1))
DottedAlignment(c(m1,v1))

## ----haploaccute--------------------------------------------------------------
set.seed(23)
n.genomes <- 25
m1 <- GetRandomSeq(50)
v1 <- GenerateVars(m1,n.genomes-1,2,c(10,1))
w1 <- fn.ab(n.genomes,r=3,fn="pcf")
data.frame(Hpl=DottedAlignment(c(m1,v1)),Freq=w1)

## ----plot accute,fig.cap="Simulated abundances in an acute infection"---------
qs <- DNAStringSet(c(m1,v1))
lst <- SortByMutations(qs,w1) 
qs <- lst$bseqs

cnm <- cumsum(table(lst$nm))+1 
nm.pos <- as.vector(cnm)[-length(cnm)]
names(nm.pos) <- names(cnm[-1])

bp <- barplot(lst$nr,col="lavender")
axis(1,at=bp[nm.pos],labels=names(nm.pos),cex.axis=0.7)

## ----haplo-chronic------------------------------------------------------------
set.seed(23)
n.genomes <- 40
m1 <- GetRandomSeq(50)
v1 <- GenerateVars(m1,n.genomes-1,6,c(10,3,1,0.5,2,0.5)) 
w1 <- fn.ab(n.genomes,r=1.5,fn="pcf")
data.frame(Hpl=DottedAlignment(c(m1,v1)),Freq=w1)

## ----plot-chronic,fig.cap="Simulated abundances in a chronic infection"-------
qs <- DNAStringSet(c(m1,v1)) 
lst <- SortByMutations(qs,w1)
qs <- lst$bseqs
cnm <- cumsum(table(lst$nm))+1
nm.pos <- as.vector(cnm)[-length(cnm)]
names(nm.pos) <- names(cnm[-1])
bp <- barplot(lst$nr,col="lavender")
axis(1,at=bp[nm.pos],labels=names(nm.pos),cex.axis=0.7)

## ----diverge------------------------------------------------------------------
set.seed(23)
m1 <- GetRandomSeq(50)
p2 <- Diverge(3:5,m1)
DottedAlignment(c(m1,p2))

## ----example------------------------------------------------------------------
v1 <- GenerateVars(m1,20,3,c(10,4,0.2))
wv1 <- fn.ab(length(v1),h=1000,r=1.5,fn="pcf")
wp2 <- c(600,1000,400)
v2 <- GenerateVars(p2[2],20,3,c(10,1,0.1))
wv2 <- fn.ab(length(v2),r=2,h=wp2[2]*3,fn="pcf")

qs <-DNAStringSet(c(m1,v1,p2,v2))
w <- round(c(10000,wv1,wp2,wv2))

lst <- SortByMutations(qs,w)
qs <- lst$bseqs
data.frame(Hpl=DottedAlignment(qs),nr=lst$nr)

## ----plot-example,fig.cap="Simulated abundances with diverging populations"----
cnm <- cumsum(table(lst$nm))+1
nm.pos <- as.vector(cnm)[-length(cnm)]
names(nm.pos) <- names(cnm[-1])
bp <- barplot(lst$nr,col=c("lavender","pink")[c(rep(1,22),rep(2,20))])
axis(1,at=bp[nm.pos],labels=names(nm.pos),cex.axis=0.7)

## ----echo = FALSE-------------------------------------------------------------
sessionInfo()

