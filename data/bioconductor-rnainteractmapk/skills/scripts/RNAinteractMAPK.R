# Code example from 'RNAinteractMAPK' vignette. See references/ for full tutorial.

### R code from vignette source 'RNAinteractMAPK.Rnw'

###################################################
### code chunk number 1: installation (eval = FALSE)
###################################################
## if (!requireNamespace("BiocManager", quietly=TRUE))
##     install.packages("BiocManager")
## BiocManager::install("RNAinteractMAPK")


###################################################
### code chunk number 2: library
###################################################
library("RNAinteractMAPK")


###################################################
### code chunk number 3: load interaction data
###################################################
data("Dmel2PPMAPK", package="RNAinteractMAPK")
PI <- getData(Dmel2PPMAPK, type="pi", format="targetMatrix", screen="mean", withoutgroups = c("pos", "neg"))


###################################################
### code chunk number 4: sourecode (eval = FALSE)
###################################################
## Stangle(system.file("doc", "RNAinteractMAPK.Rnw", package="RNAinteractMAPK"))


###################################################
### code chunk number 5: inputpath
###################################################
inputpath = system.file("extdata", "Dmel2PPMAPK",package="RNAinteractMAPK")
inputpath


###################################################
### code chunk number 6: createRNAinteract
###################################################
Dmel2PPMAPK = createRNAinteractFromFiles(name="Pairwise PPMAPK screen", path = inputpath)


###################################################
### code chunk number 7: channelnames
###################################################
getScreenNames(Dmel2PPMAPK)
getChannelNames(Dmel2PPMAPK)


###################################################
### code chunk number 8: main effects
###################################################
Dmel2PPMAPK <- estimateMainEffect(Dmel2PPMAPK)
Dmel2PPMAPK <- normalizeMainEffectQuery(Dmel2PPMAPK,batch=rep(1:4,each=48))
Dmel2PPMAPK <- normalizeMainEffectTemplate(Dmel2PPMAPK, channel="intensity")


###################################################
### code chunk number 9: pairwise interaction term
###################################################
Dmel2PPMAPK <- computePI(Dmel2PPMAPK)


###################################################
### code chunk number 10: summarize and combine screens
###################################################
Dmel2PPMAPKmean <- summarizeScreens(Dmel2PPMAPK, screens=c("1","2"))
Dmel2PPMAPK <- bindscreens(Dmel2PPMAPK, Dmel2PPMAPKmean)


###################################################
### code chunk number 11: compute p-values
###################################################
library(qvalue)
p.adj.fct <- function(x) {
  I = which(is.finite(x))
  qjob = qvalue(x[I])
  q.value = rep(NA,length(x))
  q.value[I] = qjob$qvalues
}
Dmel2PPMAPK <- computePValues(Dmel2PPMAPK, p.adjust.function = p.adj.fct, verbose = FALSE)
Dmel2PPMAPKT2 <- computePValues(Dmel2PPMAPK, method="HotellingT2", p.adjust.function = p.adj.fct, verbose = FALSE)
Dmel2PPMAPKlimma <- computePValues(Dmel2PPMAPK, method="limma", p.adjust.function = p.adj.fct, verbose = FALSE)


###################################################
### code chunk number 12: Fig. 4 cd 5 a: double RNAi plos for CG10376 Gap1 Cka
###################################################
pdf(width=8,height=8,file="Figure-4c-doubleRNAi-CG10376.pdf")
grid::pushViewport(grid::viewport(layout=grid::grid.layout(2, 2,
                        widths = grid::unit(c(0.4, 1), c("lines", "null")), 
                        heights = grid::unit(c(1, 0.7), c("null", "lines")), 
                        respect = TRUE)))
grid::pushViewport(grid::viewport(layout.pos.row = 1, 
                      layout.pos.col = 2, clip = FALSE))


###################################################
### code chunk number 13: Fig. 4 cd 5 a: double RNAi plos for CG10376 Gap1 Cka
###################################################
plotDoublePerturbation(Dmel2PPMAPK, screen="mean", channel="nrCells", target="CG10376",
                       main="CG10376", range=c(-1, 0.05), 
                       axisOnOrigin=FALSE, drawBox=FALSE, show.labels="q.value",
                       xlab="rel. nuclear count [log2]", ylab="rel. nuclear count [log2]")


###################################################
### code chunk number 14: Fig. 4 cd 5 a: double RNAi plos for CG10376 Gap1 Cka
###################################################
grid::grid.text("double RNAi effect",x=grid::unit(-3.5,"lines"),y=grid::unit(0.5,"npc"),just=c("center","bottom"),vp=grid::vpPath("dplayout","dpvp"),rot=90)
grid::grid.text("single RNAi effect",x=grid::unit(0.5,"npc"),y=grid::unit(-3.8,"lines"),just=c("center","top"),vp=grid::vpPath("dplayout","dpvp"))
dev.off()

pdf(width=8,height=8,file="Figure-4d-doubleRNAi-Gap1.pdf")
grid::pushViewport(grid::viewport(layout=grid::grid.layout(2, 2,
                        widths = grid::unit(c(0.4, 1), c("lines", "null")), 
                        heights = grid::unit(c(1, 0.7), c("null", "lines")), 
                        respect = TRUE)))
grid::pushViewport(grid::viewport(layout.pos.row = 1, 
                      layout.pos.col = 2, clip = FALSE))


###################################################
### code chunk number 15: Fig. 4 cd 5 a: double RNAi plos for CG10376 Gap1 Cka
###################################################
plotDoublePerturbation(Dmel2PPMAPK, screen="mean", channel="nrCells", target="Gap1",
                       main="Gap1 (CG6721)", range=c(-2.3, 1.0), 
                       axisOnOrigin=FALSE, drawBox=FALSE, show.labels="q.value",
                       xlab="rel. nuclear count [log2]", ylab="rel. nuclear count [log2]")


###################################################
### code chunk number 16: Fig. 4 cd 5 a: double RNAi plos for CG10376 Gap1 Cka
###################################################
grid::grid.text("double RNAi effect",x=grid::unit(-3.5,"lines"),y=grid::unit(0.5,"npc"),just=c("center","bottom"),vp=grid::vpPath("dplayout","dpvp"),rot=90)
grid::grid.text("single RNAi effect",x=grid::unit(0.5,"npc"),y=grid::unit(-3.8,"lines"),just=c("center","top"),vp=grid::vpPath("dplayout","dpvp"))
dev.off()

pdf(width=8,height=8,file="Figure-5a-doubleRNAi-Cka.pdf")
grid::pushViewport(grid::viewport(layout=grid::grid.layout(2, 2,
                        widths = grid::unit(c(0.4, 1), c("lines", "null")), 
                        heights = grid::unit(c(1, 0.7), c("null", "lines")), 
                        respect = TRUE)))
grid::pushViewport(grid::viewport(layout.pos.row = 1, 
                      layout.pos.col = 2, clip = FALSE))


###################################################
### code chunk number 17: Fig. 4 cd 5 a: double RNAi plos for CG10376 Gap1 Cka
###################################################
plotDoublePerturbation(Dmel2PPMAPK, screen="mean", channel="nrCells", target="Cka",
                       main="Cka (CG7392)", range=c(-2.3, 1.0), 
                       axisOnOrigin=FALSE, drawBox=FALSE, show.labels="q.value",
                       xlab="rel. nuclear count [log2]", ylab="rel. nuclear count [log2]")


###################################################
### code chunk number 18: Fig. 4 cd 5 a: double RNAi plos for CG10376 Gap1 Cka
###################################################
grid::grid.text("double RNAi effect",x=grid::unit(-3.5,"lines"),y=grid::unit(0.5,"npc"),just=c("center","bottom"),vp=grid::vpPath("dplayout","dpvp"),rot=90)
grid::grid.text("single RNAi effect",x=grid::unit(0.5,"npc"),y=grid::unit(-3.8,"lines"),just=c("center","top"),vp=grid::vpPath("dplayout","dpvp"))
dev.off()


###################################################
### code chunk number 19: Fig. 4: Classification
###################################################
traingroups = list(RasMapK = c("csw","drk","Sos","Ras85D","phl","Dsor1","rl","pnt"),
  RasMapKInh = c("Gap1","PTP-ER","Mkp3","aop","Pten"),
  JNK = c("Gadd45","Btk29A","msn","slpr","bsk","Jra","kay"),
  others = c("CG10376","CG42327","CG13197","CG12746","CG3530","CG17029","CG17598",
    "CG9391","CG9784","CG10089"))
groupcol = c(RasMapK = "blue", RasMapKInh = "orange", JNK = "green", others = "white")
sgi <- sgisubset(Dmel2PPMAPK, screen=c("1","2"))
CV <- MAPK.cv.classifier(sgi, traingroups)


###################################################
### code chunk number 20: Fig. 4: Classification
###################################################
pdf(width=9,file="Figure-4-a-classifier-training.pdf")


###################################################
### code chunk number 21: Fig. 4: Classification
###################################################
MAPK.plot.classification(CV$CVposterior, y=CV$y,
                         classes = c("RasMapKInh", "JNK", "RasMapK"),
                         classnames = c("RasMAPK-Inhibitors","JNK","RasMAPK"),
                         classcol = c("orange", "#389e33", "blue"),
                         main = "Cross-Validated Posterior Probabilities",
                         textToLeft = c("Ras85D","Sos","Dsor1")
                   )


###################################################
### code chunk number 22: Fig. 4: Classification
###################################################
dev.off()
pdf(width=9,file="Figure-4-b-classifier-prediction.pdf")


###################################################
### code chunk number 23: Fig. 4: Classification
###################################################
prediction <- MAPK.predict.classification(sgi, traingroups)
MAPK.plot.classification(prediction$posteriornew,
                         classes = c("RasMapKInh", "JNK", "RasMapK"),
                         classnames = c("RasMAPK-Inhibitors","JNK","RasMAPK"),
                         classcol = c("orange", "#389e33", "blue"),
                         main = "Posterior Probabilities of genes outside training set",
                         textToRight = c("stg","Cka"),
                         threshText = 0.4)


###################################################
### code chunk number 24: Fig. 4: Classification
###################################################
dev.off()


###################################################
### code chunk number 25: Fig. S1: Validation of mRNA levels for single RNAi knockdowns
###################################################
data("mRNAsingleKDefficiency", package = "RNAinteractMAPK")
hh <- apply(as.matrix(mRNAsingleKDefficiency[,c("MeanDesign1","MeanDesign2")]),1,mean)
I <- order(-hh)
D <- data.frame(mRNAlevel=c(mRNAsingleKDefficiency[,"MeanDesign1"],mRNAsingleKDefficiency[,"MeanDesign2"]),
                sd=c(mRNAsingleKDefficiency[,"StderrDesign1"],mRNAsingleKDefficiency[,"StderrDesign2"]),
                Gene=factor(c(mRNAsingleKDefficiency[,"Symbol"],mRNAsingleKDefficiency[,"Symbol"]), 
                  levels=mRNAsingleKDefficiency[I,"Symbol"]),
                design=factor(rep(c("design 1","design 2"),each=89),
                  levels=c("design 1","design 2")))
library(lattice)
bc <- barchart(mRNAlevel ~ Gene, data = D,
         layout = c(1,1), origin = 1, stack = FALSE, 
         group = D$design, col = c("lightblue", "red"),
         auto.key = list(points=FALSE, rectangles = TRUE, corner = c(0.97,0.97)),
         par.settings = list(superpose.polygon = list(col=c("lightblue", "red"))),
         xlab="Gene", ylab = "mRNA level",
         sub = "error bars: standard deviation", col.sub = "gray30",
         scales = list(x = list(cex=0.7,rot = 45), y=list(tick.number=9)),
         ylim=c(0,1.82), main = "mRNA Knock Down Efficiency",
         panel=function(...) {
           panel.abline(h=seq(0.2, 1.9, by=0.2),lty="dotted")
           panel.abline(h=1)
           panel.barchart(...)
           x = (as.integer(D$Gene) + 0.375 * (as.integer(D$design) - (2 + 1)/2))
           y1 = D$mRNAlevel - D$sd
           y2 = D$mRNAlevel + D$sd
           panel.arrows(x,y1,x,y2,code=3,angle=90,length=0.03,col="gray30")
         } )



###################################################
### code chunk number 26: Fig. S1: Validation of mRNA levels for single RNAi knockdowns
###################################################
pdf(width=13,height=7,file="Figure-S01-knockdownValidation.pdf")
print(bc)
dev.off()


###################################################
### code chunk number 27: Fig. S2: Validation of mRNA levels for double RNAi knockdowns
###################################################
data("mRNAdoubleKDefficiency", package="RNAinteractMAPK")


###################################################
### code chunk number 28: Fig. S2: Validation of mRNA levels for double RNAi knockdowns
###################################################
pdf(width=10,height=15, file="Figure-S02-knockdownValidation.pdf")
trellis.par.set(list(layout.heights = list(bottom.padding = 0, axis.xlab.padding = -2, xlab = 4), 
                     superpose.symbol = list(col = c("red","blue"))))


###################################################
### code chunk number 29: Fig. S2: Validation of mRNA levels for double RNAi knockdowns
###################################################
dp <- dotplot(100-(mRNAdoubleKDefficiency$RNAi) ~ mRNAdoubleKDefficiency$template | 
  mRNAdoubleKDefficiency$query, groups = mRNAdoubleKDefficiency$passage,  ylim=c(-5,105),
              main="co-RNAi efficiency", layout = c(2,4),
              xlab="template dsRNA", ylab="query gene mRNA levels [% remaining after RNAi]",
              scales=list(x=list(rot=45)),
              key = simpleKey(c("biol. replicate 1", "biol. replicate 2"),space = "bottom"))


###################################################
### code chunk number 30: Fig. S2: Validation of mRNA levels for double RNAi knockdowns
###################################################
print(dp)
dev.off()


###################################################
### code chunk number 31: Fig. S3: single RNAi phenotypes
###################################################
data("singleKDphenotype", package="RNAinteractMAPK")
singleKDphenotype[,"nrcells"] <- log2(singleKDphenotype[,"nrcells"])
singleKDphenotype[,"area"] <- log2(singleKDphenotype[,"area"])
# inputfile <- system.file("extdata","singleKnockDownPhenotype/annoSingleKnockDownEffect.csv",
#                          package="RNAinteractMAPK")
# Anno <- read.csv(inputfile,sep=";",stringsAsFactors = FALSE)
# Anno$Symbol <- substr(Anno$Symbol,1,12)
# exclude csw, PTP-ER, and puc, because they are measured twice
# F <- factor(Anno$Symbol[!(Anno$Symbol %in% c("csw_exp2","PTP-ER_exp2","puc_exp2"))])
# F = factor(Anno$Symbol, levels = unique(Anno$Symbol[!(Anno$Symbol %in% c("csw_exp2","PTP-ER_exp2","puc_exp2"))]))


###################################################
### code chunk number 32: Fig. S3: single RNAi phenotypes
###################################################
Mean <- list()
DRho1 <- list()
Dpnt <- list()
for (ds in colnames(singleKDphenotype)) {
  D <- matrix(singleKDphenotype[,ds],nr=384,nc=4)
  Mean[[ds]] <- matrix(0.0,nr=nlevels(singleKDphenotypeAnno$Symbol),nc=4)
  row.names(Mean[[ds]]) = levels(singleKDphenotypeAnno$Symbol)
  DRho1[[ds]] <- D[which(singleKDphenotypeAnno$Symbol == "Rho1"),]
  Dpnt[[ds]] <- D[which(singleKDphenotypeAnno$Symbol == "pnt"),]
  for (i in 1:4) {
    mm <- genefilter:::shorth(D[,i],tie.limit=0.5)
    DRho1[[ds]][,i] <- DRho1[[ds]][,i] - mm
    Dpnt[[ds]][,i] <- Dpnt[[ds]][,i] - mm
    Mean[[ds]][,i] <- tapply(D[,i]-mm,singleKDphenotypeAnno$Symbol,mean)
  }
}


###################################################
### code chunk number 33: Fig. S3: single RNAi phenotypes
###################################################
t.test(as.vector(DRho1[["nrcells"]]))


###################################################
### code chunk number 34: Fig. S3: single RNAi phenotypes
###################################################
t.test(as.vector(DRho1[["area"]]))


###################################################
### code chunk number 35: Fig. S3: single RNAi phenotypes
###################################################
t.test(as.vector(Dpnt[["nrcells"]]))


###################################################
### code chunk number 36: Fig. S3: single RNAi phenotypes
###################################################
t.test(as.vector(Dpnt[["area"]]))


###################################################
### code chunk number 37: Fig. S3: single RNAi phenotypes
###################################################
M2 <- list()
SD2 <- list()
M3 <- list()
SD3 <- list()

for (ds in colnames(singleKDphenotype)) {
  M2[[ds]] <- matrix(NA,nr=nrow(Mean[[ds]]),nc=2)
  SD2[[ds]] <- matrix(NA,nr=nrow(Mean[[ds]]),nc=2)
  M2[[ds]][,1] <- apply(Mean[[ds]][,1:2],1,mean)
  M2[[ds]][,2] <- apply(Mean[[ds]][,3:4],1,mean)
  SD2[[ds]][,1] <- apply(Mean[[ds]][,1:2],1,sd)
  SD2[[ds]][,2] <- apply(Mean[[ds]][,3:4],1,sd)

  M3[[ds]] <- apply(M2[[ds]],1,mean)
  SD3[[ds]] <- apply(M2[[ds]],1,sd)
}


###################################################
### code chunk number 38: Fig. S3: single RNAi phenotypes
###################################################
ds <- "nrcells"
I <- order(-M3[[ds]])
D <- data.frame(level=c(M2[[ds]][,1],M2[[ds]][,2]),sd=c(SD2[[ds]][,1],SD2[[ds]][,2]), 
                Gene=factor(rep(row.names(Mean[[ds]]),2), levels=row.names(Mean[[ds]])[I]),
                design=factor(rep(c("design 1","design 2"),each=nrow(Mean[[ds]])),
                  levels=c("design 1","design 2")))
bc <- barchart(level ~ Gene, data = D,
               layout = c(1,1), origin=0, stack = FALSE, 
               groups=D$design, col = c("lightblue", "red"),
               auto.key = list(points = FALSE, rectangles = TRUE, corner=c(0.97,0.97)),
               par.settings = list(superpose.polygon=list(col=c("lightblue", "red"))),
               ylab =  "rel. nuclear count [log2]",
               scales = list(x = list(cex=0.7,rot = 45), y=list(tick.number=9)),
               xlab="Gene",
               sub = "error bars: standard deviation", col.sub = "gray40",
               main = "Phenotypic Knock-Down Effect (viability)",
               panel=function(...) {
                 panel.abline(h=c(-2,-1.5,-1,-0.5,0,0.5),lty="dotted")
                 panel.abline(h=0)
                 pbc = panel.barchart(...)
                 x = (as.integer(D$Gene) + 0.375 * (as.integer(D$design) - (2 + 1)/2))
                 y1 = D$level - D$sd
                 y2 = D$level + D$sd
                 panel.arrows(x,y1,x,y2,code=3,angle=90,length=0.03,col="gray40")
               } )


###################################################
### code chunk number 39: Fig. S3: single RNAi phenotypes
###################################################
pdf(width=13,height=7,file="Figure-S03-singleKnockdownPhenotypeNrCells.pdf")
print(bc)
dev.off()


###################################################
### code chunk number 40: Fig. S3: single RNAi phenotypes
###################################################
ds <- "area"
I <- order(-M3[[ds]])
D <- data.frame(level=c(M2[[ds]][,1],M2[[ds]][,2]),sd=c(SD2[[ds]][,1],SD2[[ds]][,2]), 
                Gene=factor(rep(row.names(Mean[[ds]]),2), levels=row.names(Mean[[ds]])[I]),
                design=factor(rep(c("design 1","design 2"),each=nrow(Mean[[ds]])),
                  levels=c("design 1","design 2")))
bc <- barchart(level ~ Gene, data = D,
               layout = c(1,1), origin=0,stack = FALSE, 
               groups=D$design, col = c("lightblue", "red"),
               auto.key = list(points = FALSE, rectangles = TRUE, corner=c(0.97,0.97)),
               par.settings = list(superpose.polygon=list(col=c("lightblue", "red"))),
               ylab = "relative area [log2]",
               scales = list(x = list(cex=0.7,rot = 45), y=list(tick.number=9)),
               xlab="Gene",
               sub = "error bars: standard deviation", col.sub = "gray40",
               main = "Phenotypic Knock Down Effect (area)",
               panel=function(...) {
                 panel.abline(h=c(-2,-1.5,-1,-0.5,0,0.5),lty="dotted")
                 panel.abline(h=0)
                 pbc = panel.barchart(...)
                 x = (as.integer(D$Gene) + 0.375 * (as.integer(D$design) - (2 + 1)/2))
                 y1 = D$level - D$sd
                 y2 = D$level + D$sd
                 panel.arrows(x,y1,x,y2,code=3,angle=90,length=0.03,col="gray40")
         } )



###################################################
### code chunk number 41: Fig. S3: single RNAi phenotypes
###################################################
pdf(width=13,height=7,file="Figure-S03-singleKnockdownPhenotypeArea.pdf")
print(bc)
dev.off()


###################################################
### code chunk number 42: Fig. S4: Correlation of different features
###################################################
D <- getData(Dmel2PPMAPK,type="data",screen="mean")[,1,c("nrCells","area","intensity")]
PI <- getData(Dmel2PPMAPK,type="pi",screen="mean")[,1,c("nrCells","area","intensity")]
set.seed(491127)
I <- sample(1:nrow(D),5000)


###################################################
### code chunk number 43: Fig. S4: Correlation of different features
###################################################
pdf(width=15,height=10,file="Figure-S04-correlationBetweenFeatures.pdf")
vp <- grid::viewport(layout=grid::grid.layout(2,3))
grid::pushViewport(vp)
grid::pushViewport(grid::viewport(layout.pos.row=1, layout.pos.col=1))


###################################################
### code chunk number 44: Fig. S4: Correlation of different features
###################################################
MAPK.smooth.scatter(D[I,"nrCells"], D[I,"area"], respect=FALSE, nrpoints=300,
                xlab="cell number [log2]", ylab="nuclear area [log2]")


###################################################
### code chunk number 45: Fig. S4: Correlation of different features
###################################################
grid::popViewport()
grid::pushViewport(grid::viewport(layout.pos.row=1, layout.pos.col=2))


###################################################
### code chunk number 46: Fig. S4: Comparison of different features
###################################################
MAPK.smooth.scatter(D[I,"nrCells"], D[I,"intensity"], respect=FALSE, nrpoints=300,
                xlab="cell number [log2]", ylab="mean intensity [log2]")


###################################################
### code chunk number 47: Fig. S4: Correlation of different features
###################################################
grid::popViewport()
grid::pushViewport(grid::viewport(layout.pos.row=1, layout.pos.col=3))


###################################################
### code chunk number 48: Fig. S4: Correlation of different features
###################################################
MAPK.smooth.scatter(D[I,"intensity"], D[I,"area"], respect=FALSE, nrpoints=300,
                xlab="mean intensity [log2]", ylab="nuclear area [log2]")


###################################################
### code chunk number 49: Fig. S4: Correlation of different features
###################################################
grid::popViewport()
grid::pushViewport(grid::viewport(layout.pos.row=2, layout.pos.col=1))


###################################################
### code chunk number 50: Fig. S4: Correlation of different features
###################################################
MAPK.smooth.scatter(PI[I,"nrCells"], PI[I,"area"], respect=FALSE, nrpoints=300,
                xlab="pi-score cell number [log2]", ylab="pi-score nuclear area [log2]")


###################################################
### code chunk number 51: Fig. S4: Correlation of different features
###################################################
grid::popViewport()
grid::pushViewport(grid::viewport(layout.pos.row=2, layout.pos.col=2))


###################################################
### code chunk number 52: Fig. S4: Correlation of different features
###################################################
MAPK.smooth.scatter(PI[I,"nrCells"], PI[I,"intensity"], respect=FALSE, nrpoints=300,
                xlab="pi-score cell number [log2]", ylab="pi-score mean intensity [log2]")


###################################################
### code chunk number 53: Fig. S4: Correlation of different features
###################################################
grid::popViewport()
grid::pushViewport(grid::viewport(layout.pos.row=2, layout.pos.col=3))


###################################################
### code chunk number 54: Fig. S4: Correlation of different features
###################################################
MAPK.smooth.scatter(PI[I,"intensity"], PI[I,"area"], respect=FALSE, nrpoints=300,
                xlab="pi-score mean intensity [log2]", ylab="pi-score nuclear area [log2]")


###################################################
### code chunk number 55: Fig. S4: Correlation of different features
###################################################
grid::popViewport()
grid::popViewport()
dev.off()


###################################################
### code chunk number 56: Fig. S5: Genetic interaction surfaces
###################################################
data("dsRNAiDilutionSeries")
dsRNAiDilutionSeries[,"nrCells"] <- log2(dsRNAiDilutionSeries[,"nrCells",drop=FALSE])
A <- MAPK.screen.as.array(dsRNAiDilutionSeries, dsRNAiDilutionSeriesAnno)


###################################################
### code chunk number 57: Fig. S5: Genetic interaction surfaces (eval = FALSE)
###################################################
## set.seed(491127)
## # warning: Very time consuming. Go on with next code chunk and load precomputed values.
## dsRNAiDilutionSeriesDF <- MAPK.cv.TPS(A)
## write.table(dsRNAiDilutionSeriesDF, file="Figure-S06-resCV.txt", sep="\t", quote=FALSE)


###################################################
### code chunk number 58: Fig. S5: Genetic interaction surfaces
###################################################
TPSmodel <- MAPK.estimate.TPS(A, DF=dsRNAiDilutionSeriesDF, n.out=50)


###################################################
### code chunk number 59: Fig. S5: Genetic interaction surfaces
###################################################
pdf(file="Figure-1-a-Ras85D-CG13197.pdf")


###################################################
### code chunk number 60: Fig. S5: Genetic interaction surfaces
###################################################
print(MAPK.plot.TPS.single(gene1="Ras85D", gene2="CG13197", TPSmodel=TPSmodel, range=c(-2,2)))


###################################################
### code chunk number 61: Fig. S5: Genetic interaction surfaces
###################################################
dev.off()
pdf(file="Figure-1-b-Ras85D-Gap1.pdf")


###################################################
### code chunk number 62: Fig. S5: Genetic interaction surfaces
###################################################
print(MAPK.plot.TPS.single(gene1="Ras85D", gene2="Gap1", TPSmodel=TPSmodel, range=c(-2,2)))


###################################################
### code chunk number 63: Fig. S5: Genetic interaction surfaces
###################################################
dev.off()
pdf(file="Figure-1-c-Ptp69D-Gap1.pdf")


###################################################
### code chunk number 64: Fig. S5: Genetic interaction surfaces
###################################################
print(MAPK.plot.TPS.single(gene1="Ptp69D", gene2="Gap1", TPSmodel=TPSmodel, range=c(-2,2)))


###################################################
### code chunk number 65: Fig. S5: Genetic interaction surfaces
###################################################
dev.off()


###################################################
### code chunk number 66: Fig. S5: Genetic interaction surfaces
###################################################
TPSmodel <- MAPK.estimate.TPS(A, DF=dsRNAiDilutionSeriesDF, n.out=25)


###################################################
### code chunk number 67: Fig. S5: Genetic interaction surfaces
###################################################
pdf(width=12, height=12, file="Figure-S05-geneticInteractionSurfaces.pdf")


###################################################
### code chunk number 68: Fig. S5: Genetic interaction surfaces
###################################################
print(MAPK.plot.TPS.all(TPSmodel=TPSmodel, range=c(-2,2)))


###################################################
### code chunk number 69: Fig. S5: Genetic interaction surfaces
###################################################
dev.off()


###################################################
### code chunk number 70: Fig. S6 S7 S8 2: Heatmaps
###################################################
PInrcells <- getData(Dmel2PPMAPK,type="pi",format="targetMatrix",screen="mean",
                     channel="nrCells",withoutgroups=c("pos","neg"))
PIarea <- getData(Dmel2PPMAPK,type="pi",format="targetMatrix",screen="mean",
                  channel="area",withoutgroups=c("pos","neg"))
PIintensity <- getData(Dmel2PPMAPK,type="pi",format="targetMatrix",screen="mean",
                       channel="intensity",withoutgroups=c("pos","neg"))

PC = embedPCA(Dmel2PPMAPK, screen="mean", channel="nrCells", dim=4, withoutgroups=c("pos","neg"))
hc = hclust(dist(PC))
hc <- RNAinteract:::swaptree(hc, 92)

subset1 <- row.names(PInrcells)[hc$order[1:6]]
subset2 <- row.names(PInrcells)[hc$order[74:93]]
allgenes <- row.names(PInrcells)[hc$order]


###################################################
### code chunk number 71: Fig. S6 S7 S8 2: Heatmaps
###################################################
pdf(width=7, height=0.5, file="Figure-2-a-dendrogram.pdf")


###################################################
### code chunk number 72: Fig. S6 S7 S8 2: Heatmaps
###################################################
RNAinteract:::grid.sgiDendrogram(hc = hc)


###################################################
### code chunk number 73: Fig. S6 S7 S8 2: Heatmaps
###################################################
dev.off()
pdf(width=7,height=7,file="Figure-2-b-heatmap-nrCells.pdf")


###################################################
### code chunk number 74: Fig. S6 S7 S8 2: Heatmaps
###################################################
MAPK.plot.heatmap.raster(PInrcells, subset=allgenes, hc.row = hc, hc.col=hc, pi.max=0.05)


###################################################
### code chunk number 75: Fig. S6 S7 S8 2: Heatmaps
###################################################
dev.off()
pdf(width=7,height=7*20/93,file="Figure-2-c-heatmap-area-RasMAPK.pdf")


###################################################
### code chunk number 76: Fig. S6 S7 S8 2: Heatmaps
###################################################
MAPK.plot.heatmap.raster(PIarea, subset=subset2, hc.row = hc, hc.col=hc, pi.max=0.02)


###################################################
### code chunk number 77: Fig. S6 S7 S8 2: Heatmaps
###################################################
dev.off()
pdf(width=7,height=7*6/93,file="Figure-2-d-heatmap-area-JNK.pdf")


###################################################
### code chunk number 78: Fig. S6 S7 S8 2: Heatmaps
###################################################
MAPK.plot.heatmap.raster(PIarea, subset=subset1, hc.row = hc, hc.col=hc, pi.max=0.02)


###################################################
### code chunk number 79: Fig. S6 S7 S8 2: Heatmaps
###################################################
dev.off()
pdf(width=7,height=7*20/93,file="Figure-2-e-heatmap-intensity-RasMAPK.pdf")


###################################################
### code chunk number 80: Fig. S6 S7 S8 2: Heatmaps
###################################################
MAPK.plot.heatmap.raster(PIintensity, subset=subset2, hc.row = hc, hc.col=hc, pi.max=0.02)


###################################################
### code chunk number 81: Fig. S6 S7 S8 2: Heatmaps
###################################################
dev.off()
pdf(width=7,height=7*6/93,file="Figure-2-f-heatmap-intensity-JNK.pdf")


###################################################
### code chunk number 82: Fig. S6 S7 S8 2: Heatmaps
###################################################
MAPK.plot.heatmap.raster(PIintensity, subset=subset1, hc.row = hc, hc.col=hc, pi.max=0.02)


###################################################
### code chunk number 83: Fig. S6 S7 S8 2: Heatmaps
###################################################
dev.off()


###################################################
### code chunk number 84: Fig. S6 S7 S8 2: Heatmaps
###################################################
pdf(width=19, height=17, file="Figure-S6-heatmap-nrCells.pdf")


###################################################
### code chunk number 85: Fig. S6 S7 S8 2: Heatmaps
###################################################
grid.sgiHeatmap(PInrcells, pi.max=0.2, 
                main=expression(paste("number cells ", pi,"-score")), hc.row = hc, hc.col = hc)


###################################################
### code chunk number 86: Fig. S6 S7 S8 2: Heatmaps
###################################################
dev.off()
pdf(width=19, height=17, file="Figure-S7-heatmap-area.pdf")


###################################################
### code chunk number 87: Fig. S6 S7 S8 2: Heatmaps
###################################################
grid.sgiHeatmap(PIarea, pi.max=0.5, 
                main=expression(paste("area ", pi,"-score")), hc.row = hc, hc.col = hc)


###################################################
### code chunk number 88: Fig. S6 S7 S8 2: Heatmaps
###################################################
dev.off()
pdf(width=19, height=17, file="Figure-S8-heatmap-intensity.pdf")


###################################################
### code chunk number 89: Fig. S6 S7 S8 2: Heatmaps
###################################################
grid.sgiHeatmap(PIintensity, pi.max=0.5, 
                main=expression(paste("intensity ", pi,"-score")), hc.row = hc, hc.col = hc)


###################################################
### code chunk number 90: Fig. S6 S7 S8 2: Heatmaps
###################################################
dev.off()


###################################################
### code chunk number 91: Fig. S9: Correlation of features across replicates
###################################################
D <- getData(Dmel2PPMAPK, normalized = TRUE)
Main <- getMainNeg(Dmel2PPMAPK)
RepData <- getReplicateData(Dmel2PPMAPK, screen="1", channel="nrCells", type="data",
                            normalized = TRUE)
IndDesignData <- getIndDesignData(Dmel2PPMAPK, screen="1", channel="nrCells", type="data",
                                  normalized = TRUE)


###################################################
### code chunk number 92: Fig. S9: Correlation of features across replicates
###################################################
pdf(width=15,height=18,file="Figure-S09-correlationOfFeaturesBetweenReplicates.pdf")
vp <- grid::viewport(layout=grid::grid.layout(3,3))
grid::pushViewport(vp)
grid::pushViewport(grid::viewport(layout.pos.row=1, layout.pos.col=1))


###################################################
### code chunk number 93: Fig. S9: Correlation of features across replicates
###################################################
MAPK.smooth.scatter(RepData$x-Main["1","nrCells"], RepData$y-Main["1","nrCells"], 
                    nrpoints=300,
                xlab=c("rel. cell number [log2]", "replicate 1", 
                  sprintf("cor = %0.3f", cor(RepData$x,RepData$y))),
                ylab=c("rel. cell number [log2]", "replicate 2"),respect=TRUE)


###################################################
### code chunk number 94: Fig. S9: Correlation of features across replicates
###################################################
grid::popViewport()
grid::pushViewport(grid::viewport(layout.pos.row=1, layout.pos.col=2))


###################################################
### code chunk number 95: Fig. S9: Correlation of features across replicates
###################################################
MAPK.smooth.scatter(IndDesignData$x-Main["1","nrCells"], IndDesignData$y-Main["1","nrCells"], 
                    nrpoints=300,
                xlab=c("rel. cell number [log2]", "RNAi design 1", 
                  sprintf("cor = %0.3f", cor(IndDesignData$x,IndDesignData$y))),
                ylab=c("rel. cell number [log2]", "RNAi design 2"),respect=TRUE)


###################################################
### code chunk number 96: Fig. S9: Correlation of features across replicates
###################################################
grid::popViewport()
grid::pushViewport(grid::viewport(layout.pos.row=1, layout.pos.col=3))


###################################################
### code chunk number 97: Fig. S9: Correlation of features across replicates
###################################################
MAPK.smooth.scatter(D[,"1","nrCells"]-Main["1","nrCells"], D[,"2","nrCells"]-Main["2","nrCells"], 
                    nrpoints=300,
                xlab=c("rel. cell number [log2]", "screen 1", 
                  sprintf("cor = %0.3f", cor(D[,"1","nrCells"],D[,"2","nrCells"]))),
                ylab=c("rel. cell number [log2]", "screen 2"),respect=TRUE)


###################################################
### code chunk number 98: Fig. S9: Correlation of features across replicates
###################################################
grid::popViewport()


###################################################
### code chunk number 99: Fig. S9: Correlation of features across replicates
###################################################
# scatter plots for area feature
RepData <- getReplicateData(Dmel2PPMAPK, screen="1", channel="area", type="data",
                            normalized = TRUE)
IndDesignData <- getIndDesignData(Dmel2PPMAPK, screen="1", channel="area", type="data",
                                  normalized = TRUE)
grid::pushViewport(grid::viewport(layout.pos.row=2, layout.pos.col=1))
MAPK.smooth.scatter(RepData$x-Main["1","area"], RepData$y-Main["1","area"], nrpoints=300,
                xlab=c("rel. cell number [log2]", "replicate 1", 
                  sprintf("cor = %0.3f", cor(RepData$x,RepData$y))),
                ylab=c("rel. cell number [log2]", "replicate 2"),respect=TRUE)
grid::popViewport()


###################################################
### code chunk number 100: Fig. S9: Correlation of features across replicates
###################################################
grid::pushViewport(grid::viewport(layout.pos.row=2, layout.pos.col=2))
MAPK.smooth.scatter(IndDesignData$x-Main["1","area"], IndDesignData$y-Main["1","area"], nrpoints=300,
                xlab=c("rel. cell number [log2]", "RNAi design 1", 
                  sprintf("cor = %0.3f", cor(IndDesignData$x,IndDesignData$y))),
                ylab=c("rel. cell number [log2]", "RNAi design 2"),respect=TRUE)
grid::popViewport()


###################################################
### code chunk number 101: Fig. S9: Correlation of features across replicates
###################################################
grid::pushViewport(grid::viewport(layout.pos.row=2, layout.pos.col=3))
MAPK.smooth.scatter(D[,"1","area"]-Main["1","area"], D[,"2","area"]-Main["2","area"], nrpoints=300,
                xlab=c("rel. cell number [log2]", "screen 1", 
                  sprintf("cor = %0.3f", cor(D[,"1","area"],D[,"2","area"]))),
                ylab=c("rel. cell number [log2]", "screen 2"),respect=TRUE)
grid::popViewport()


###################################################
### code chunk number 102: Fig. S9: Correlation of features across replicates
###################################################
# scatter plots for intensity feature
RepData <- getReplicateData(Dmel2PPMAPK, screen="1", channel="intensity", type="data",
                            normalized = TRUE)
IndDesignData <- getIndDesignData(Dmel2PPMAPK, screen="1", channel="intensity", type="data",
                                  normalized = TRUE)
grid::pushViewport(grid::viewport(layout.pos.row=3, layout.pos.col=1))
MAPK.smooth.scatter(RepData$x-Main["1","intensity"], RepData$y-Main["1","intensity"], nrpoints=300,
                xlab=c("rel. cell number [log2]", "replicate 1", 
                  sprintf("cor = %0.3f", cor(RepData$x,RepData$y))),
                ylab=c("rel. cell number [log2]", "replicate 2"),respect=TRUE)
grid::popViewport()


###################################################
### code chunk number 103: Fig. S9: Correlation of features across replicates
###################################################
grid::pushViewport(grid::viewport(layout.pos.row=3, layout.pos.col=2))
MAPK.smooth.scatter(IndDesignData$x-Main["1","intensity"], IndDesignData$y-Main["1","intensity"], nrpoints=300,
                xlab=c("rel. cell number [log2]", "RNAi design 1", 
                  sprintf("cor = %0.3f", cor(IndDesignData$x,IndDesignData$y))),
                ylab=c("rel. cell number [log2]", "RNAi design 2"),respect=TRUE)
grid::popViewport()


###################################################
### code chunk number 104: Fig. S9: Correlation of features across replicates
###################################################
grid::pushViewport(grid::viewport(layout.pos.row=3, layout.pos.col=3))
MAPK.smooth.scatter(D[,"1","intensity"]-Main["1","intensity"], D[,"2","intensity"]-Main["2","intensity"], nrpoints=300,
                xlab=c("rel. cell number [log2]", "screen 1", 
                  sprintf("cor = %0.3f", cor(D[,"1","intensity"],D[,"2","intensity"]))),
                ylab=c("rel. cell number [log2]", "screen 2"),respect=TRUE)
grid::popViewport(2)
dev.off()


###################################################
### code chunk number 105: Fig. S10: Correlation of interactions across replicates
###################################################
D <- getData(Dmel2PPMAPK, type="pi", normalized = TRUE)
RepData <- getReplicateData(Dmel2PPMAPK, screen="1", channel="nrCells", type="pi",
                            normalized = TRUE)
IndDesignData <- getIndDesignData(Dmel2PPMAPK, screen="1", channel="nrCells", type="pi", 
                                  normalized = TRUE)


###################################################
### code chunk number 106: Fig. S10: Correlation of interactions across replicates
###################################################
pdf(width=15,height=6,file="Figure-S10-correlationOfInteractionsBetweenReplicates.pdf")
vp <- grid::viewport(layout=grid::grid.layout(1,3))
grid::pushViewport(vp)
grid::pushViewport(grid::viewport(layout.pos.row=1, layout.pos.col=1))


###################################################
### code chunk number 107: Fig. S10: Correlation of interactions across replicates
###################################################
MAPK.smooth.scatter(RepData$x, RepData$y,nrpoints=300,
                xlab=c("rel. cell number [log2]", "replicate 1", 
                  sprintf("cor = %0.3f", cor(RepData$x, RepData$y))),
                ylab=c("rel. cell number [log2]", "replicate 2"),respect=TRUE)


###################################################
### code chunk number 108: Fig. S10: Correlation of interactions across replicates
###################################################
grid::popViewport()
grid::pushViewport(grid::viewport(layout.pos.row=1, layout.pos.col=2))


###################################################
### code chunk number 109: Fig. S10: Correlation of interactions across replicates
###################################################
MAPK.smooth.scatter(IndDesignData$x, IndDesignData$y,nrpoints=300,
                xlab=c("rel. cell number [log2]", "RNAi design 1",
                  sprintf("cor = %0.3f", cor(IndDesignData$x, IndDesignData$y))),
                ylab=c("rel. cell number [log2]", "RNAi design 2"),respect=TRUE)



###################################################
### code chunk number 110: Fig. S10: Correlation of interactions across replicates
###################################################
grid::popViewport()
grid::pushViewport(grid::viewport(layout.pos.row=1, layout.pos.col=3))


###################################################
### code chunk number 111: Fig. S10: Correlation of interactions across replicates
###################################################
MAPK.smooth.scatter(D[,"1","nrCells"], D[,"2","nrCells"], nrpoints=300,
                xlab=c("rel. cell number [log2]", "screen 1", 
                  sprintf("cor = %0.3f", cor(D[,"1","nrCells"], D[,"2","nrCells"]))),
                ylab=c("rel. cell number [log2]", "screen 2"),respect=TRUE)


###################################################
### code chunk number 112: Fig. S10: Correlation of interactions across replicates
###################################################
grid::popViewport(2)
dev.off()


###################################################
### code chunk number 113: Fig. S11: Node degree distributions
###################################################
screen = "mean"
for (channel in c("nrCells","area","intensity")) {
  filename <- switch(channel,
                     nrCells="Figure-4-b-nodeDegreeNrCells.pdf",
                     area="Figure-S11-a-nodeDegreeArea.pdf",
                     intensity="Figure-S11-b-nodeDegreeIntensity.pdf")
  main <- sprintf("node degree distribution (%s)",
                  switch(channel, nrCells = "nuclear count", area = "area", intensity = "intensity"))

  q = 0.05
  by = 3
  col = c("blue","yellow")

  QV = getData(Dmel2PPMAPK, type="q.value", format="targetMatrix", screen=screen, channel=channel, 
    withoutgroups=c("pos","neg"))
  PI = getData(Dmel2PPMAPK, type="pi",      format="targetMatrix", screen=screen, channel=channel, 
    withoutgroups=c("pos","neg"))
  M = getMain(Dmel2PPMAPK,type="main",design="template",summary="target",
    withoutgroups=c("pos","neg"), screen=screen,channel=channel)

  A.pos = (QV <= q) & (PI > 0)
  A.neg = (QV <= q) & (PI < 0)
  
  diag(A.pos) = FALSE
  diag(A.neg) = FALSE
  
  a.pos = apply(A.pos,1,sum)
  a.neg = apply(A.neg,1,sum)
  A = A.pos | A.neg
  a = apply(A,1,sum)

  pdf(width=4.5,height=4.5,file=filename)
  mv = max(c(a.pos,a.neg))
  breaks = c(-0.5,seq(0.5,mv-0.5,by=3),mv+0.5)
  h=0
  T = matrix(c(0,1),nr=1,nc=2)
  z=1
  if (by > 1) {
    names.arg = c("0")
    for (i in 3:length(breaks)) {
      names.arg = c(names.arg,sprintf("%d-%d",h+1,h+by))
      z=z+1
      for (j in 1:by) {
        T = rbind(T, c(h+j,z))
      }
      h = h + by
    }
  }
  h.a.pos = hist(a.pos,breaks=breaks,plot=FALSE)
  h.a.neg = hist(a.neg,breaks=breaks,plot=FALSE)
  df = data.frame(pos = h.a.pos$counts/92, neg = h.a.neg$counts/92, names=names.arg)
  df[1,1] = df[1,2] = 0
  bp=barplot(t(as.matrix(df[,c(2,1)])),beside=TRUE,col=col,main=main, 
    xlab="number of interactions per gene", ylab="fraction of genes",
    cex.axis=1,cex.names=1,yaxt="n")
  axis(2,at=c(0,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4),
       labels=c("0%","","10%","","20%","","30%","",""))
  rect(1.5,0,2.5,sum(a==0)/92,col="black")
  mtext(names.arg,side=1,at=apply(bp,2,mean),cex=1,line=c(1.5,0.5))
  legend("topright",c("neg. interactions", "pos. interactions"), fill=col)
  dev.off()
}


###################################################
### code chunk number 114: Fig. S12: Comparison to known interactions from DroID
###################################################
data("Networks", package="RNAinteractMAPK")
reportNetworks(sgisubset(Dmel2PPMAPK, screen="mean"), Networks = Networks)


###################################################
### code chunk number 115: Fig. S12: Comparison to known interactions from DroID
###################################################
print(read.table("networks/networks-pv-mean-nrCells.txt", sep="\t", header=TRUE))
print(read.table("networks/networks-pv-mean-area.txt", sep="\t", header=TRUE))
print(read.table("networks/networks-pv-mean-intensity.txt", sep="\t", header=TRUE))


###################################################
### code chunk number 116: Fig. S13: Known protein-protein interactions are overrepresented
###################################################
PI <- getData(Dmel2PPMAPK, type="pi", format="targetMatrix", 
              screen="mean", channel="nrCells", withoutgroups=c("pos","neg"))
QV <- getData(Dmel2PPMAPK, type="q.value", format="targetMatrix", 
              screen="mean", channel="nrCells", withoutgroups=c("pos","neg"))
INT <- matrix(0, nr=93, nc=93)
INT[QV <= 0.05] = 1
INT[(QV <= 0.05) & (PI < 0)] = -1
diag(INT) <- NA


###################################################
### code chunk number 117: Fig. S13: Known protein-protein interactions are overrepresented
###################################################
data("pathwayMembership", package="RNAinteractMAPK")
G1 <- matrix(pathwayMembership[row.names(PI)], nr=93, nc=93)
G2 <- t(G1)
diag(G1) <- diag(G2) <- NA


###################################################
### code chunk number 118: Fig. S13: Known protein-protein interactions are overrepresented
###################################################
data("PhysicalInteractions", package="RNAinteractMAPK")
isPP <- matrix(0, nr=93, nc=93, dimnames = list(row.names(PI),row.names(PI)))
for (i in 1:nrow(PhysicalInteractions)) {
  isPP[PhysicalInteractions[i,1], PhysicalInteractions[i,2]] <- 1
  isPP[PhysicalInteractions[i,2], PhysicalInteractions[i,1]] <- 1
}
diag(isPP) <- NA


###################################################
### code chunk number 119: Fig. S13: Known protein-protein interactions are overrepresented
###################################################
df <- data.frame(int = as.vector(INT), G1 = as.vector(G1), G2 = as.vector(G2), 
                 isPP = as.vector(isPP))
df <- df[!is.na(df$G1),]
df <- df[((df$G1 == "RASMAPK" & df$G2 == "RASMAPK") | (df$G1 == "JNK" & df$G2 == "JNK")),]


###################################################
### code chunk number 120: Fig. S13: Known protein-protein interactions are overrepresented
###################################################
t <- table(df[,c(1,4)])
print(t)
t3 <- t[2:3,]
t3[2,] <- t3[2,] + t[1,]
t3 <- t3 / 2 # the matrix is symetric and contains each gene pair twice
print(t3)
fisher.test(t3, alternative="greater")


###################################################
### code chunk number 121: Fig. S13: Known protein-protein interactions are overrepresented
###################################################
pdf(file="Figure-S13-overlapWithPhysicalInteractions.pdf")


###################################################
### code chunk number 122: Fig. S13: Known protein-protein interactions are overrepresented
###################################################
t2 <- t
t2[,1] <- t2[,1] / sum(t2[,1])
t2[,2] <- t2[,2] / sum(t2[,2])
t2 <- t2[c(1,3,2),]
colnames(t2) <- c("no PP interaction", "PP interaction")
barplot(t2, col=c("blue", "yellow", "gray"), main="overlap with physical interactions")


###################################################
### code chunk number 123: Fig. S13: Known protein-protein interactions are overrepresented
###################################################
dev.off()


###################################################
### code chunk number 124: Fig. S14: Correlation profiles of Cka Ras85D and bsk
###################################################
PI <- getData(Dmel2PPMAPK, type="pi", format="targetMatrix", screen="mean", channel="nrCells",
              withoutgroups = c("pos", "neg"))
C = cor(PI)


###################################################
### code chunk number 125: Fig. S14: Correlation profiles of Cka Ras85D and bsk
###################################################
pdf(width=10,height=10,file="Figure-S14-a-correlationProfile-Cka-Ras85D.pdf")


###################################################
### code chunk number 126: Fig. S14: Correlation profiles of Cka Ras85D and bsk
###################################################
plot(C["Cka",], C["Ras85D",], pch=20, cex=2, xlim=c(-1,1), ylim=c(-1,1),
     cex.axis=2, cex.lab=2,
     xlab="correlation to Cka interaction profile", 
     ylab="correlation to Ras85D interaction profile")


###################################################
### code chunk number 127: Fig. S14: Correlation profiles of Cka Ras85D and bsk
###################################################
lines(c(-1,1),c(0,0),col="darkgray",lwd=2)
lines(c(0,0),c(-1,1),col="darkgray",lwd=2)
I = which((abs(C["Cka",]) > 0.5) | (abs(C["Ras85D",]) > 0.5))
J = I[C["Cka",I]-C["Ras85D",I] >= 0]
text(C["Cka",J],C["Ras85D",J],colnames(C)[J],adj=c(-0.2,1.2))
J = I[C["Cka",I]-C["Ras85D",I] < 0]
text(C["Cka",J],C["Ras85D",J],colnames(C)[J],adj=c(1.2,-0.2))
dev.off()
pdf(width=10,height=10,file="Figure-S14-b-correlationProfile-Cka-bsk.pdf")


###################################################
### code chunk number 128: Fig. S14: Correlation profiles of Cka Ras85D and bsk
###################################################
plot(C["Cka",], C["bsk",], pch=20, cex=2, xlim=c(-1,1), ylim=c(-1,1),
     cex.axis=2, cex.lab=2,
     xlab="correlation to Cka interaction profile", 
     ylab="correlation to bsk interaction profile")


###################################################
### code chunk number 129: Fig. S14: Correlation profiles of Cka Ras85D and bsk
###################################################
lines(c(-1,1),c(0,0),col="darkgray",lwd=2)
lines(c(0,0),c(-1,1),col="darkgray",lwd=2)
I = which((abs(C["Cka",]) > 0.5) | (abs(C["bsk",]) > 0.5))
J = I[C["Cka",I]-C["bsk",I] >= 0]
text(C["Cka",J],C["bsk",J],colnames(C)[J],adj=c(-0.2,1.2))
J = I[C["Cka",I]-C["bsk",I] < 0]
text(C["Cka",J],C["bsk",J],colnames(C)[J],adj=c(1.2,-0.2))
dev.off()


###################################################
### code chunk number 130: Fig. S15: Comparison between Acumen and CellTiterGlo pi scores
###################################################
data("cellTiterGlo", package="RNAinteractMAPK")

M1 <- t(matrix(cellTiterGlo$plate1,nr=24,nc=16))
M2 <- t(matrix(cellTiterGlo$plate2,nr=24,nc=16))
M3 <- t(matrix(cellTiterGlo$plate3,nr=24,nc=16))
MP1 <- medpolish(M1)
MP2 <- medpolish(M2)
MP3 <- medpolish(M3)

Anno <- cellTiterGlo[1:24,2:3]
data <- log2(cbind(MP1$col+MP1$overall, MP2$col+MP2$overall, MP3$col+MP3$overall))


###################################################
### code chunk number 131: Fig. S15: Comparison between Acumen and CellTiterGlo pi scores
###################################################
PIscreen <- Anno[(Anno$dsRNA_1 != "Fluc") & (Anno$dsRNA_2 != "Fluc"),]
PIscreen$pi.screen <- log2(getData(Dmel2PPMAPK, type="pi", format="targetMatrix",
channel="nrCells", screen="mean", do.inv.trafo=TRUE)[as.matrix(PIscreen)])


###################################################
### code chunk number 132: Fig. S15: Comparison between Acumen and CellTiterGlo pi scores
###################################################
result <- data.frame(PIscreen, pi.CTG = 0.0, main1.CTG = 0.0, main2.CTG = 0.0, p.value.CTG = 1.0)

for (i in 1:nrow(PIscreen)) {
  N <- which((Anno$dsRNA_1 == "Fluc") & (Anno$dsRNA_2 == "Fluc"))
  doubleRNAi <- which(((Anno$dsRNA_1 == PIscreen[i,1]) & (Anno$dsRNA_2 == PIscreen[i,2]))
                      | ((Anno$dsRNA_1 == PIscreen[i,2]) & (Anno$dsRNA_2 == PIscreen[i,1])))
  singleRNAi1 <- which(((Anno$dsRNA_1 == PIscreen[i,1]) & (Anno$dsRNA_2 == "Fluc"))
                      | ((Anno$dsRNA_1 == "Fluc") & (Anno$dsRNA_2 == PIscreen[i,1])))
  singleRNAi2 <- which(((Anno$dsRNA_1 == "Fluc") & (Anno$dsRNA_2 == PIscreen[i,2]))
                      | ((Anno$dsRNA_1 == PIscreen[i,2]) & (Anno$dsRNA_2 == "Fluc")))

  neg <- apply(data[N,],2,mean)
  main1 <- data[singleRNAi1,] - neg
  main2 <- data[singleRNAi2,] - neg
  nimodel <- neg + main1 + main2
  piCTG <- data[doubleRNAi,] - nimodel
  pvCTG <- t.test(piCTG)
  result[i,"pi.CTG"] <- mean(piCTG)
  result[i,"main1.CTG"] <- mean(main1)
  result[i,"main2.CTG"] <- mean(main2)
  result[i,"p.value.CTG"] <- t.test(piCTG)$p.value
}


###################################################
### code chunk number 133: Fig. S15: Comparison between Acumen and CellTiterGlo pi scores
###################################################
pdf(file="Figure-S15-correlationAcumenCelTiterGlo.pdf")


###################################################
### code chunk number 134: Fig. S15: Comparison between Acumen and CellTiterGlo pi scores
###################################################
plot(result[,"pi.screen"], result[,"pi.CTG"], xlim=c(-0.7,1.2), ylim=c(-0.7, 1.2), pch=19,
     xlab="pi-score main screen", ylab="pi-score cellTiterGlo",
     main=sprintf("correlation of pi-score (main screen and cellTiterGlo) = %0.2f",
       cor(result[,"pi.screen"], result[,"pi.CTG"])))


###################################################
### code chunk number 135: Fig. S15: Comparison between Acumen and CellTiterGlo pi scores
###################################################
Adj <- matrix(0.0, nr=10, nc=2)
Adj[,1] <- c(1,      1,    0,    1,   0,   1,    0,   0,   0,   0)
Adj[,2] <- c(-0.7, 1.7, -0.7, -0.7, 1.7, 1.7, -0.7, 1.7, 1.7, 1.7)
Adj[,1] <- c(1,      1,    0,    0,   1,   0,    1,   0,   0,   0)
Adj[,2] <- c(-0.7, 1.7, -0.7,  1.7,-0.7, 1.7,  1.7,-0.7, 1.7, 1.7)
lines(c(-10, 10), c(0,0), col="gray")
lines(c(0, 0), c(-10,10), col="gray")
for (i in 1:10) {
  text(result[i, "pi.screen"], result[i, "pi.CTG"],
       sprintf("%s - %s", result$dsRNA_1[i], result$dsRNA_2[i]), adj = Adj[i,])
}
dev.off()



###################################################
### code chunk number 136: Tab. 3: Interaction lists
###################################################
Dmel2PPMAPKT2 <- computePValues(Dmel2PPMAPK, method="HotellingT2", verbose = FALSE)
Dmel2PPMAPKlimma <- computePValues(Dmel2PPMAPK, method="limma",verbose = FALSE)
MAPK.report.gene.lists.paper(Dmel2PPMAPK, Dmel2PPMAPKlimma, Dmel2PPMAPKT2)
head(read.table("Tab3_nrCells.txt", sep="\t", header=TRUE))


###################################################
### code chunk number 137: sessioninfo
###################################################
sessionInfo()


