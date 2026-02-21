# Code example from 'qsea_tutorial' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# BiocManager::install("qsea")

## ----eval=FALSE---------------------------------------------------------------
# BiocManager::install("BSgenome")
# library("BSgenome")

## ----eval=FALSE---------------------------------------------------------------
# available.genomes()

## ----eval=FALSE---------------------------------------------------------------
# BiocManager::install("BSgenome.Hsapiens.UCSC.hg19")

## ----eval=FALSE---------------------------------------------------------------
# BiocManager::install("GenomicRanges")

## ----eval=FALSE---------------------------------------------------------------
# BiocManager::install("MEDIPSData")

## ----results='asis'-----------------------------------------------------------
data(samplesNSCLC, package="MEDIPSData")
knitr::kable(samples_NSCLC)
path=system.file("extdata", package="MEDIPSData")
samples_NSCLC$file_name=paste0(path,"/",samples_NSCLC$file_name )

## ----lib_qsea, message=FALSE--------------------------------------------------
library(qsea)

## ----lib_BSgenome, message=FALSE----------------------------------------------
library(BSgenome.Hsapiens.UCSC.hg19)

## ----createSet, collapse=TRUE-------------------------------------------------
qseaSet=createQseaSet(sampleTable=samples_NSCLC, 
        BSgenome="BSgenome.Hsapiens.UCSC.hg19", 
        chr.select=paste0("chr", 20:22), 
        window_size=500)
qseaSet

## ----addCoverage, eval=FALSE--------------------------------------------------
# qseaSet=addCoverage(qseaSet, uniquePos=TRUE, paired=TRUE)

## ----addCNV, eval=FALSE-------------------------------------------------------
# qseaSet=addCNV(qseaSet, file_name="file_name",window_size=2e6,
#         paired=TRUE, parallel=FALSE, MeDIP=TRUE)

## ----addLibraryFactors, eval=FALSE--------------------------------------------
# qseaSet=addLibraryFactors(qseaSet)

## ----addPatternDensity, eval=FALSE--------------------------------------------
# qseaSet=addPatternDensity(qseaSet, "CG", name="CpG")

## ----loadDataSet, include=FALSE-----------------------------------------------
#load prepared dataset
data(NSCLC_dataset, package="MEDIPSData")

## ----addOffset, tidy=TRUE, collapse=TRUE--------------------------------------
qseaSet=addOffset(qseaSet, enrichmentPattern="CpG")

## ----addEnrichmentParametersTCGA, collapse=TRUE-------------------------------
data(tcga_luad_lusc_450kmeth, package="MEDIPSData")

wd=findOverlaps(tcga_luad_lusc_450kmeth, getRegions(qseaSet), select="first")
signal=as.matrix(mcols(tcga_luad_lusc_450kmeth)[,rep(1:2,3)])
qseaSet=addEnrichmentParameters(qseaSet, enrichmentPattern="CpG", 
    windowIdx=wd, signal=signal)

## ----addEnrichmentParameters_blind, collapse=TRUE-----------------------------
wd=which(getRegions(qseaSet)$CpG_density>1 &
    getRegions(qseaSet)$CpG_density<15)
signal=(15-getRegions(qseaSet)$CpG_density[wd])*.55/15+.25
qseaSet_blind=addEnrichmentParameters(qseaSet, enrichmentPattern="CpG", 
    windowIdx=wd, signal=signal)

## ----getOffset, collapse=TRUE-------------------------------------------------
getOffset(qseaSet, scale="fraction")

## ----plotEPmatrix, results='hide',collapse=TRUE, fig.width=10,fig.height=7,fig.cap='CpG density dependent Enrichment Profiles'----
plotEPmatrix(qseaSet)

## ----plotCNV, collapse=TRUE,fig.width=10,fig.height=7,fig.cap="Overview representation of Copy Number Variation"----
plotCNV(qseaSet)

## ----collapse=TRUE------------------------------------------------------------
data(annotation, package="MEDIPSData")
CGIprom=intersect(ROIs[["CpG Island"]], ROIs[["TSS"]],ignore.strand=TRUE)
pca_cgi=getPCA(qseaSet, norm_method="beta", ROIs=CGIprom)
col=rep(c("red", "green"), 3)
plotPCA(pca_cgi, bg=col, main="PCA plot based on CpG Island Promoters")

## ----eval=FALSE---------------------------------------------------------------
# design=model.matrix(~group, getSampleTable(qseaSet) )
# qseaGLM=fitNBglm(qseaSet, design, norm_method="beta")
# qseaGLM=addContrast(qseaSet,qseaGLM, coef=2, name="TvN" )

## ----collapse=TRUE------------------------------------------------------------
library(GenomicRanges)
sig=isSignificant(qseaGLM, fdr_th=.01)

result=makeTable(qseaSet, 
    glm=qseaGLM, 
    groupMeans=getSampleGroups(qseaSet), 
    keep=sig, 
    annotation=ROIs, 
    norm_method="beta")
knitr::kable(head(result))

## ----results='asis', collapse=TRUE--------------------------------------------
sigList=list(gain=isSignificant(qseaGLM, fdr_th=.1,direction="gain"),
             loss=isSignificant(qseaGLM, fdr_th=.1,direction="loss"))
roi_stats=regionStats(qseaSet, subsets=sigList, ROIs=ROIs)
knitr::kable(roi_stats)
roi_stats_rel=roi_stats[,-1]/roi_stats[,1]
x=barplot(t(roi_stats_rel)*100,ylab="fraction of ROIs[%]",
    names.arg=rep("", length(ROIs)+1),  beside=TRUE, legend=TRUE, 
    las=2, args.legend=list(x="topleft"), 
    main="Feature enrichment Tumor vs Normal DNA methylation")
text(x=x[2,],y=-.15,labels=rownames(roi_stats_rel), xpd=TRUE, srt=30, cex=1, adj=c(1,0))


## ----collapse=TRUE------------------------------------------------------------
plotCoverage(qseaSet, samples=getSampleNames(qseaSet), 
    chr="chr20", start=38076001, end=38090000, norm_method="beta", 
    col=rep(c("red", "green"), 3), yoffset=1,space=.1, reorder="clust", 
    regions=ROIs["TFBS"],regions_offset=.5, cex=.7 ) 

## ----eval=FALSE---------------------------------------------------------------
# library("BiocParallel")
# register(MulticoreParam(workers=3))
# qseaSet=addCoverage(qseaSet, uniquePos=TRUE, paired=TRUE, parallel=TRUE)
# 

