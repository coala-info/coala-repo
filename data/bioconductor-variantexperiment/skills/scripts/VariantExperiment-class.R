# Code example from 'VariantExperiment-class' vignette. See references/ for full tutorial.

## ----options, eval=TRUE, echo=FALSE-------------------------------------------
options(showHeadLines=3)
options(showTailLines=3)

## ----getPackage, eval=FALSE---------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("VariantExperiment")

## ----eval = FALSE-------------------------------------------------------------
# BiocManager::install("Bioconductor/VariantExperiment")

## ----Load, message=FALSE------------------------------------------------------
library(VariantExperiment)

## ----GDSArray-----------------------------------------------------------------
library(GDSArray)
file <- GDSArray::gdsExampleFileName("seqgds")
gdsnodes(file)
GDSArray(file, "genotype/data")
GDSArray(file, "sample.id")

## ----makeVariantExperimentFromGDS---------------------------------------------
ve <- makeVariantExperimentFromGDS(file)
ve

## ----showAvailable------------------------------------------------------------
args(makeVariantExperimentFromGDS)
showAvailable(file)

## ----makeVariantExperimentFromGDS2--------------------------------------------
assays(ve)
assay(ve, 1)
GDSArray(file, "genotype/data")  ## original GDSArray from GDS file before permutation

## ----rrrd---------------------------------------------------------------------
rowRanges(ve)
rowData(ve)

## ----colData------------------------------------------------------------------
colData(ve)

## ----gdsfile------------------------------------------------------------------
gdsfile(ve)

## ----metaData-----------------------------------------------------------------
metadata(ve)

## ----makeVariantExperimentFromVCF---------------------------------------------
vcf <- SeqArray::seqExampleFileName("vcf")
ve <- makeVariantExperimentFromVCF(vcf, out.dir = tempfile())
ve

## ----retrieve GDS-------------------------------------------------------------
gdsfile(ve)

## ----makeVariantExperimentFromVCF2--------------------------------------------
assay(ve, 1)

## ----makeVariantExperimentFromVCF3--------------------------------------------
rowData(ve)

## ----sampleInfo---------------------------------------------------------------
sampleInfo <- system.file("extdata", "Example_sampleInfo.txt",
                          package="VariantExperiment")
vevcf <- makeVariantExperimentFromVCF(vcf, sample.info = sampleInfo)
colData(vevcf)

## ----makeVariantExperimentFromVCFArgs-----------------------------------------
vevcf1 <- makeVariantExperimentFromVCF(vcf, info.import=c("OR", "GP"))
rowData(vevcf1)

## ----makeVariantExperimentFromVCFArgs_startCount------------------------------
vevcf2 <- makeVariantExperimentFromVCF(vcf, start=101, count=1000)
vevcf2

## ----makeVariantExperimentFromGDS_seq-----------------------------------------
gds <- SeqArray::seqExampleFileName("gds")
ve <- makeVariantExperimentFromGDS(gds)
ve

## ----showAvailable1-----------------------------------------------------------
showAvailable(gds)

## ----makeVariantExperimentFromGDSArgs-----------------------------------------
ve3 <- makeVariantExperimentFromGDS(gds,
                                    rowDataColumns = c("allele", "annotation/id"),
                                    infoColumns = c("AC", "AN", "DP"),
                                    rowDataOnDisk = TRUE,
                                    colDataOnDisk = FALSE)
rowData(ve3)  ## DelayedDataFrame object 
colData(ve3)  ## DataFrame object

## -----------------------------------------------------------------------------
veseq <- makeVariantExperimentFromGDS(file,
                                      rowDataColumns = c("allele"),
                                      infoColumns = character(0))
rowData(veseq)

## ----makeVariantExperimentFromGDS_snp-----------------------------------------
snpfile <- SNPRelate::snpgdsExampleFileName()
vesnp <- makeVariantExperimentFromGDS(snpfile,
                                      rowDataColumns = c("snp.allele"))
rowData(vesnp)

## ----2d-----------------------------------------------------------------------
ve[1:10, 1:5]

## ----colDataExtraction--------------------------------------------------------
colData(ve)
ve[, as.logical(ve$family == "1328")]

## ----rowDataExtraction--------------------------------------------------------
rowData(ve)
ve[as.logical(rowData(ve)$REF == "T"),]

## ----overlap------------------------------------------------------------------
ve1 <- subsetByOverlaps(ve, GRanges("22:1-48958933"))
ve1

## ----saveVE-------------------------------------------------------------------
a <- tempfile()
ve2 <- saveVariantExperiment(ve1, dir=a, replace=TRUE, chunk_size = 30)

## ----loadVE-------------------------------------------------------------------
ve3 <- loadVariantExperiment(dir=a)
gdsfile(ve3)
all.equal(ve2, ve3)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

