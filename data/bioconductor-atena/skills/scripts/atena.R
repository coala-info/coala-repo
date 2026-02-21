# Code example from 'atena' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE--------------------------------------------------------
library(knitr)

options(width=80)

knitr::opts_chunk$set(
  collapse=TRUE,
  comment="")

## ----message=FALSE, warning=FALSE---------------------------------------------
library(atena)
library(BiocParallel)

rmskann <- annotaTEs(genome="dm6", parsefun=rmskidentity)
rmskann

## ----message=FALSE, warning=FALSE---------------------------------------------
teann <- annotaTEs(genome="dm6", parsefun=OneCodeToFindThemAll, strict=FALSE,
                   insert=500, BPPARAM=SerialParam(progress=FALSE))
length(teann)
teann[1]

## -----------------------------------------------------------------------------
mcols(teann)

## ----comparsedann, message=FALSE, height=6, width=10, out.width="800px", fig.cap="Composition of parsed TE annotations.", echo=FALSE----
library(RColorBrewer)

pal1 <- brewer.pal(6, "Pastel2")
pal2 <- brewer.pal(length(unique(mcols(teann)$Class)), "Set2")

par(mfrow = c(1,2), mar = c(5,4,3,1))
bp1 <- barplot(table(mcols(teann)$Status), col = pal1, border = "black",
        main = "TEs by status", cex.axis=0.8, xaxt = "n")
grid(nx=NA, ny=NULL)
axis(1, at=bp1, labels = FALSE, las=1, line=0, lwd = 0, lwd.ticks = 1) 
par(xpd=TRUE)
text(x= bp1[, 1] - 0.3, y = 10, labels=names(table(mcols(teann)$Status)), 
     srt=40, offset = 1.7, cex = 0.8, pos = 1)
par(xpd=FALSE)

bp2 <- barplot(table(mcols(teann)$Class), col = pal2, border = "black",
        main = "TEs by class", cex.axis=0.8, xaxt = "n",
        ylim = c(0,max(table(mcols(teann)$Status))))
grid(nx=NA, ny=NULL)
axis(1, at=bp2, labels = FALSE, las=1, line=0, lwd = 0, lwd.ticks = 1) 
par(xpd=TRUE)
text(x= bp2[, 1] - 0.1, y = 10, labels=names(table(mcols(teann)$Class)), 
     srt=35, offset = 1.2, cex = 0.8, pos = 1)
par(xpd=FALSE)

## -----------------------------------------------------------------------------
rmskLINE <- getLINEs(teann, relLength=0.9)
length(rmskLINE)
rmskLINE[1]

## -----------------------------------------------------------------------------
rmskLTR <- getLTRs(teann, relLength=0.8, fullLength=TRUE, partial=TRUE,
                   otherLTR=TRUE)
length(rmskLTR)
rmskLTR[1]

## -----------------------------------------------------------------------------
bamfiles <- list.files(system.file("extdata", package="atena"),
                       pattern="*.bam", full.names=TRUE)
empar <- ERVmapParam(bamfiles, 
                     teFeatures=rmskLTR, 
                     singleEnd=TRUE, 
                     ignoreStrand=TRUE, 
                     suboptimalAlignmentCutoff=NA)
empar

## -----------------------------------------------------------------------------
bamfiles <- list.files(system.file("extdata", package="atena"),
                       pattern="*.bam", full.names=TRUE)
tspar <- TelescopeParam(bfl=bamfiles, 
                        teFeatures=rmskLTR, 
                        singleEnd=TRUE, 
                        ignoreStrand=TRUE)
tspar

## ----message=FALSE------------------------------------------------------------
library(TxDb.Dmelanogaster.UCSC.dm6.ensGene)

txdb <- TxDb.Dmelanogaster.UCSC.dm6.ensGene
gannot <- exonsBy(txdb, by="gene")
length(gannot)

## -----------------------------------------------------------------------------
bamfiles <- list.files(system.file("extdata", package="atena"),
                       pattern="*.bam", full.names=TRUE)
ttpar <- TEtranscriptsParam(bamfiles, 
                            teFeatures=rmskLTR,
                            geneFeatures=gannot,
                            singleEnd=TRUE, 
                            ignoreStrand=TRUE, 
                            aggregateby="repName")
ttpar

## -----------------------------------------------------------------------------
features(ttpar)
mcols(features(ttpar))
table(mcols(features(ttpar))$isTE)

## -----------------------------------------------------------------------------
## Create a toy example of gene annotations
geneannot <- GRanges(seqnames=rep("2L", 8),
                     ranges=IRanges(start=c(1,20,45,80,110,130,150,170),
                                    width=c(10,20,35,10,5,15,10,25)),
                     strand="*", 
                     type=rep("exon",8))
names(geneannot) <- paste0("gene",c(rep(1,3),rep(2,4),rep(3,1)))
geneannot
ttpar2 <- TEtranscriptsParam(bamfiles, 
                             teFeatures=rmskLTR, 
                             geneFeatures=geneannot, 
                             singleEnd=TRUE, 
                             ignoreStrand=TRUE)
mcols(features(ttpar2))
features(ttpar2)[!mcols(features(ttpar2))$isTE]

## ----results='hide'-----------------------------------------------------------
emq <- qtex(empar)

## -----------------------------------------------------------------------------
emq
colSums(assay(emq))

## ----results='hide'-----------------------------------------------------------
tsq <- qtex(tspar)

## -----------------------------------------------------------------------------
tsq
colSums(assay(tsq))

## ----results='hide'-----------------------------------------------------------
ttq <- qtex(ttpar)

## -----------------------------------------------------------------------------
ttq
colSums(assay(ttq))

## -----------------------------------------------------------------------------
head(assay(ttq))

## -----------------------------------------------------------------------------
rowData(ttq)

## -----------------------------------------------------------------------------
table(rowData(ttq)$isTE)

## -----------------------------------------------------------------------------
temask <- rowData(ttq)$isTE
fullLTRs <- rowData(ttq)$Status == "full-lengthLTR"
fullLTRs <- (sapply(fullLTRs, sum, na.rm=TRUE) == 1) &
            (lengths(rowData(ttq)$Status) == 1)
sum(fullLTRs)
rowData(ttq)[fullLTRs, ]

## -----------------------------------------------------------------------------
table(rowData(ttq)$Class[temask])

## ----session_info, cache=FALSE------------------------------------------------
sessionInfo()

