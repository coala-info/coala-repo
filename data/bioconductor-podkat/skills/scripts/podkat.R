# Code example from 'podkat' vignette. See references/ for full tutorial.

## ----LoadPackageToDetermineVersion,echo=FALSE,message=FALSE,results='hide'----
options(width=65)
set.seed(0)
library(podkat)
podkatVersion <- packageDescription("podkat")$Version
podkatDateRaw <- packageDescription("podkat")$Date
podkatDateYear <- as.numeric(substr(podkatDateRaw, 1, 4))
podkatDateMonth <- as.numeric(substr(podkatDateRaw, 6, 7))
podkatDateDay <- as.numeric(substr(podkatDateRaw, 9, 10))
podkatDate <- paste(month.name[podkatDateMonth], " ",
                     podkatDateDay, ", ",
                     podkatDateYear, sep="")

## ----InstallPODKAT,eval=FALSE----------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("podkat")

## ----LoadPODKAT,eval=FALSE-------------------------------------
# library(podkat)

## ----SimpleExFileNames-----------------------------------------
phenoFileLin <- system.file("examples/example1lin.csv", package="podkat")
phenoFileLog <- system.file("examples/example1log.csv", package="podkat")
vcfFile <- system.file("examples/example1.vcf.gz", package="podkat")

## ----SimpleExNullModelLin--------------------------------------
pheno.c <- read.table(phenoFileLin, header=TRUE, sep=",")
model.c <- nullModel(y ~ ., pheno.c)
model.c

## ----SimpleExLoadHgA-------------------------------------------
data(hgA)
hgA
windows <- partitionRegions(hgA)
windows

## ----SimpleExLoadVCF-------------------------------------------
geno <- readGenotypeMatrix(vcfFile)
geno

## ----SimpleExAssocTestLin--------------------------------------
res.c <- assocTest(geno, model.c, windows)
print(res.c)

## ----SimpleExPAdjLin-------------------------------------------
res.c <- p.adjust(res.c)
print(res.c)

## ----SimpleExManhLin,fig.width=9,fig.height=4.5,out.width='\\textwidth'----
plot(res.c, which="p.value.adj")

## ----SimpleExNullModelLog--------------------------------------
pheno.b <- read.table(phenoFileLog, header=TRUE, sep=",")
model.b <- nullModel(y ~ ., pheno.b)
model.b

## ----SimpleExAssocTestLog--------------------------------------
res.b <- assocTest(vcfFile, model.b, windows)
print(res.b)

## ----SimpleExPAdjLog-------------------------------------------
res.b <- p.adjust(res.b)
print(res.b)

## ----SimpleExManhLog,fig.width=9,fig.height=4.5,out.width='\\textwidth'----
plot(res.b, which="p.value.adj")

## ----ShowPhenoExample1-----------------------------------------
colnames(pheno.c)
summary(pheno.c)

## ----ShowPhenoExample2-----------------------------------------
colnames(pheno.b)
summary(pheno.b)
table(pheno.b$y)

## ----TrainModel1-----------------------------------------------
model.c <- nullModel(y ~ ., pheno.c)
model.c
model.b <- nullModel(y ~ ., pheno.b)
model.b

## ----TrainModel2-----------------------------------------------
nullModel(y ~ 1, pheno.c)

## ----TrainModel3-----------------------------------------------
nullModel(y ~ 0, pheno.b, type="bernoulli")

## ----TrainModel4-----------------------------------------------
covX <- as.matrix(pheno.c[, 1:2])
traitY <- pheno.c$y
nullModel(covX, traitY)
nullModel(y=traitY)

covX <- as.matrix(pheno.b[, 1:2])
traitY <- pheno.b$y
nullModel(covX, traitY)
nullModel(y=traitY)
nullModel(y=traitY, type="bernoulli")

## ----TrainModel5-----------------------------------------------
attach(pheno.c)
nullModel(y ~ X.1 + X.2)

## ----SilentlyDetach,echo=FALSE,results='hide'------------------
detach(pheno.c)

## ----TrainModel6-----------------------------------------------
nullModel(y ~ ., pheno.b, n.resampling=1000, adj="none")
nullModel(y ~ ., pheno.b, n.resampling.adj=2000)

## ----hg38UnmaskedCall------------------------------------------
data(hg38Unmasked)
hg38Unmasked
names(hg38Unmasked)
hg38Unmasked$chr1
seqinfo(hg38Unmasked)

## ----ReUnitePseudoautosomal------------------------------------
hg38basic <- hg38Unmasked[paste0("chr", 1:22)]
hg38basic$chrX <- reduce(unlist(hg38Unmasked[c("chrX", "X.PAR1",
                                               "X.PAR2", "X.XTR")]))
hg38basic$chrY <- reduce(unlist(hg38Unmasked[c("chrY", "Y.PAR1",
                                               "Y.PAR2", "Y.XTR")]))
hg38basic
names(hg38basic)

## ----AllInOneGRanges-------------------------------------------
hg38all <- reduce(unlist(hg38Unmasked))
hg38all

## ----partToy---------------------------------------------------
gr <- GRanges(seqnames="chr1", ranges=IRanges(start=1, end=140000))
partitionRegions(gr, width=10000, overlap=0.5)
partitionRegions(gr, width=15000, overlap=0.8)
partitionRegions(gr, width=10000, overlap=0)

## ----hg38partAll-----------------------------------------------
partitionRegions(hg38Unmasked, width=20000)

## ----hg38partAll21-22------------------------------------------
partitionRegions(hg38Unmasked[c("chr21", "chr22")], width=20000)

## ----trExHg38,message=FALSE------------------------------------
library(TxDb.Hsapiens.UCSC.hg38.knownGene)
hg38tr <- transcripts(TxDb.Hsapiens.UCSC.hg38.knownGene, columns="tx_name")
hg38tr

## ----splitHg38transcripts--------------------------------------
strand(hg38tr) <- "*"
split(hg38tr, hg38Unmasked[c("chrX", "X.PAR1", "X.PAR2", "X.XTR")])

## ----hg38trPart------------------------------------------------
partitionRegions(reduce(hg38tr))

## ----HBAGenesManual--------------------------------------------
hbaGenes <- GRanges(seqnames="chr16",
                    ranges=IRanges(start=c(176680, 172847),
                                   end=c(177521, 173710)))
names(hbaGenes) <- c("HBA1", "HBA2")
hbaGenes

## ----HBAGenesManualTxDb----------------------------------------
hbaGenes <- hg38tr[which(mcols(hg38tr)$tx_name %in%
                         c("ENST00000320868.9", "ENST00000251595.11"))]
names(hbaGenes) <- c("HBA1", "HBA2")
hbaGenes

## ----SimpleEx2LoadVCF------------------------------------------
geno <- readGenotypeMatrix(vcfFile)
geno

## ----vInfo-----------------------------------------------------
variantInfo(geno)

## ----MAFs------------------------------------------------------
summary(MAF(geno))

## ----vInfoSummary----------------------------------------------
summary(variantInfo(geno), details=TRUE)

## ----assocTestWholeGenotype------------------------------------
assocTest(geno, model.c)
assocTest(geno, model.b)

## ----SimpleExAssocTestLin2-------------------------------------
res.c <- assocTest(geno, model.c, windows)
print(res.c)

## ----SimpleExAssocTestLin3-------------------------------------
res.c <- assocTest(vcfFile, model.c, windows)
print(res.c)

## ----SimpleExAssocTestLog2-------------------------------------
res.b <- assocTest(geno, model.b, windows)
print(res.b)

## ----SimpleExAssocTestLog3-------------------------------------
res.b.noAdj <- assocTest(geno, model.b, windows, adj="none")
print(res.b.noAdj)

## ----p.adjustExample-------------------------------------------
print(p.adjust(res.c))

## ----p.adjustExampleBH-----------------------------------------
res.c.adj <- p.adjust(res.c, method="BH")
print(res.c.adj)
res.b.adj <- p.adjust(res.b, method="BH")
print(res.b.adj)

## ----ManhPlot1,fig.width=9,fig.height=4.5,out.width='\\textwidth'----
plot(res.c.adj)

## ----ManhPlot2,fig.width=9,fig.height=4.5,out.width='\\textwidth'----
plot(res.c.adj, which="p.value.adj")

## ----ManhPlot3,fig.width=9,fig.height=4.5,out.width='\\textwidth'----
plot(res.c.adj, which="p.value.adj", col=gray(0.5, alpha=0.25))

## ----QQplot1,fig.width=6,fig.height=6,out.width='0.6\\textwidth'----
qqplot(res.c)

## ----QQplot2,fig.width=6,fig.height=6,out.width='0.6\\textwidth'----
qqplot(res.b, res.b.noAdj)

## ----QQplot3,fig.width=6,fig.height=6,out.width='0.6\\textwidth'----
qqplot(res.b.noAdj)

## ----Filter1---------------------------------------------------
res.c.f <- filterResult(res.c, cutoff=1.e-6)
print(res.c.f, cutoff=1.e-6)
res.c.adj.f <- filterResult(res.c.adj, filterBy="p.value.adj")
print(res.c.adj.f)

## ----Weights1--------------------------------------------------
w.res.c.adj <- weights(res.c.adj.f, geno, model.c)
w.res.c.adj

## ----WeightHist,fig.width=8,fig.height=6,out.width='0.7\\textwidth'----
hist(mcols(w.res.c.adj[[1]])$weight.contribution, col="lightblue",
     border="lightblue", xlab="weight.contribution", main="")

## ----WeightHistPlot1,fig.width=8,fig.height=6,out.width='0.7\\textwidth'----
plot(w.res.c.adj[[1]], "weight.contribution")

## ----WeightHistPlot2,fig.width=8,fig.height=6,out.width='0.7\\textwidth'----
plot(w.res.c.adj[[1]], "weight.raw", alongGenome=TRUE, type="b")

## ----FilterWeights---------------------------------------------
filterResult(w.res.c.adj, cutoff=0.07)

## ----DisplayGenotype,fig.width=8,fig.height=8,out.width='0.7\\textwidth'----
res.c.adj.sorted <- sort(res.c.adj, sortBy="p.value.adj")
Zi <- readGenotypeMatrix(vcfFile, regions=res.c.adj.sorted[1])
plot(Zi, labRow=NA)

## ----DisplayGenotype2,fig.width=8,fig.height=8,out.width='0.7\\textwidth'----
plot(Zi, y=pheno.c$y, labRow=NA)

## ----DisplayGenotype4,fig.width=8,fig.height=8,out.width='0.7\\textwidth'----
plot(Zi, y=residuals(model.c), labRow=NA)

## ----DisplayGenotype5,fig.width=8,fig.height=8,out.width='0.7\\textwidth'----
res.b.adj.sorted <- sort(res.b.adj, sortBy="p.value.adj")
Zi <- readGenotypeMatrix(vcfFile, regions=res.b.adj.sorted[1])
plot(Zi, y=factor(pheno.b$y), labRow=NA)

## ----VariantInfo-----------------------------------------------
vInfo <- readVariantInfo(vcfFile, omitZeroMAF=FALSE, refAlt=TRUE)
vInfo
summary(vInfo)

## ----GenotypeMatrixConstructorExample--------------------------
A <- matrix(rbinom(10000, size=1, prob=0.05), 200, 50)
pos <- sort(sample(1:200000, 50))
Z <- genotypeMatrix(A, pos=pos, seqnames="chr1")
Z
variantInfo(Z)

## ----UnmaskedRegionsMM10,message=FALSE-------------------------
library(BSgenome.Mmusculus.UCSC.mm10.masked)
regions <- unmaskedRegions(BSgenome.Mmusculus.UCSC.mm10.masked,
                           chrs=paste0("chr", 1:19))
names(regions)
regions$chr1

## ----UnmaskedRegionsSexHg38,message=FALSE----------------------
library(BSgenome.Hsapiens.UCSC.hg38.masked)
library(GWASTools)

pseudoautosomal.hg38 ## from GWASTools package
psaut <- pseudoautosomal.hg38
psaut$chrom <- paste0("chr", psaut$chrom)
psaut

regions <- unmaskedRegions(BSgenome.Hsapiens.UCSC.hg38.masked,
                           chrs=c("chrX", "chrY"), pseudoautosomal=psaut)
names(regions)
regions$chrX
regions$X.PAR1

