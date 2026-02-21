# Code example from 'CopyNeutralIMA' vignette. See references/ for full tutorial.

## ----echo = FALSE-------------------------------------------------------------
knitr::opts_chunk$set(collapse=TRUE, comment='#>')

## ----read_tcga, message=F, warning=F------------------------------------------
library(minfi)
library(conumee)
library(minfiData)

data(RGsetEx)
sampleNames(RGsetEx) <- pData(RGsetEx)$Sample_Name
cancer <- pData(RGsetEx)$status == 'cancer'
RGsetEx <- RGsetEx[,cancer]
RGsetEx

## ----normalize_tcga-----------------------------------------------------------
MsetEx <- preprocessIllumina(RGsetEx)
MsetEx

## ----prepare_controls, message=F----------------------------------------------
library(CopyNeutralIMA)
ima <- annotation(MsetEx)[['array']]
RGsetCtrl <- getCopyNeutralRGSet(ima)
# preprocess as with the sample data
MsetCtrl <- preprocessIllumina(RGsetCtrl)
MsetCtrl

## ----conumee------------------------------------------------------------------
# use the information provided by conumee to create annotation files or define
# them according to the package instructions
data(exclude_regions)
data(detail_regions)
anno <- CNV.create_anno(array_type = "450k", exclude_regions = exclude_regions, detail_regions = detail_regions)

# load in the data from the reference and samples to be analyzed
control.data <- CNV.load(MsetCtrl)
ex.data <- CNV.load(MsetEx)

cnv <- CNV.fit(ex.data["GroupB_1"], control.data, anno)
cnv <- CNV.bin(cnv)
cnv <- CNV.detail(cnv)
cnv <- CNV.segment(cnv)
cnv

CNV.genomeplot(cnv)
CNV.genomeplot(cnv, chr = 'chr18')

head(CNV.write(cnv, what = 'segments'))
head(CNV.write(cnv, what='probes'))

## ----session_info, echo = F---------------------------------------------------
sessionInfo()

