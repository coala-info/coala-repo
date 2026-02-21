# Code example from 'XBSeq' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'-------------------------------
BiocStyle::markdown()

## ----eval=FALSE----------------------------------------------------------
#  source('http://www.bioconductor.org/biocLite.R')
#  biocLite("XBSeq")

## ----message = FALSE, warning=FALSE--------------------------------------
library("XBSeq")

## ----eval=FALSE----------------------------------------------------------
#  library(devtools)
#  install_github('liuy12/XBSeq')

## ----eval=FALSE----------------------------------------------------------
#  fc_signal <- featureCounts(files = bamLists, annot.ext = gtf_file, isGTFAnnotationFile = TRUE)
#  fc_bg <- featureCounts(files = bamLists, annot.ext = gtf_file_bg, isGTFAnnotationFile = TRUE)

## ----eval=FALSE----------------------------------------------------------
#  features_signal <- import(gtf_file)
#  features_signal <- split(features_signal, mcols(features_signal)$gene_id)
#  so_signal <- summarizeOverlaps(features_signal, bamLists)
#  
#  ## for background noise
#  features_bg <- import(gtf_file_bg)
#  features_bg <- split(features_bg, mcols(features_bg)$gene_id)
#  so_bg <- summarizeOverlaps(features_bg, bamLists)

## ----eval=FALSE----------------------------------------------------------
#  apaStats <- apaUsage(bamTreatment, bamControl, apaAnno)

## ------------------------------------------------------------------------
data(ExampleData)

## ------------------------------------------------------------------------
head(Observed)
head(Background)

## ----tidy=TRUE-----------------------------------------------------------
conditions <- factor(c(rep('C',3), rep('T', 3)))
XB <- XBSeqDataSet(Observed, Background, conditions)

## ----tidy=TRUE,fig.width=5,fig.height=4----------------------------------
XBplot(XB, Samplenum = 1, unit = "LogTPM", Genelength = genelength[,2])

## ---- tidy=TRUE----------------------------------------------------------
XB <- estimateRealCount(XB)
XB <- estimateSizeFactors(XB)
XB <- estimateSCV( XB, method='pooled', sharingMode='maximum', fitType='local' )

## ----fig.width=3,fig.height=3--------------------------------------------
plotSCVEsts(XB)

## ------------------------------------------------------------------------
Teststas <- XBSeqTest( XB, levels(conditions)[1L], levels(conditions)[2L], method ='NP')

## ----fig.width=3,fig.height=3--------------------------------------------
MAplot(Teststas, padj = FALSE, pcuff = 0.01, lfccuff = 1)

## ----eval=FALSE,tidy=TRUE------------------------------------------------
#  # Alternatively, all the codes above can be done with a wrapper function XBSeq
#  Teststats <- XBSeq( Observed, Background, conditions, method='pooled', sharingMode='maximum',
#    fitType='local', pvals_only=FALSE, paraMethod = 'NP' )

## ----eval=FALSE----------------------------------------------------------
#  biocLite("DESeq")

## ----message=FALSE-------------------------------------------------------
library('DESeq')
library('ggplot2')
de <- newCountDataSet(Observed, conditions)
de <- estimateSizeFactors(de)
de <- estimateDispersions(de, method = "pooled", fitType="local")
res <- nbinomTest(de, levels(conditions)[1], levels(conditions)[2])

## ----warning=FALSE,message=FALSE,tidy=TRUE, fig.width=3,fig.height=3-----
DE_index_DESeq <- with(res, which(pval<0.01 & abs(log2FoldChange)>1))
DE_index_XBSeq <- with(Teststas, which(pval<0.01 & abs(log2FoldChange)>1))
DE_index_inters <- intersect(DE_index_DESeq, DE_index_XBSeq)
DE_index_DESeq_uniq <- setdiff(DE_index_DESeq, DE_index_XBSeq)
DE_plot <- MAplot(Teststas, padj = FALSE, pcuff = 0.01, lfccuff = 1, shape=16)
DE_plot + geom_point( data=Teststas[DE_index_inters,], aes(x=baseMean, y=log2FoldChange), color= 'green', shape=16 ) + 
  geom_point( data=Teststas[DE_index_DESeq_uniq,], aes( x=baseMean, y=log2FoldChange ), color= 'blue', shape=16 )

## ------------------------------------------------------------------------
sessionInfo()

