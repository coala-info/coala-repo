# Code example from 'metaseqr-pdf' vignette. See references/ for full tutorial.

## ----init-init, eval=TRUE, echo=FALSE, message=FALSE, warning=FALSE------
library(metaseqR)

## ----init-metaseqr, eval=FALSE, echo=TRUE, warning=FALSE-----------------
#  library(metaseqR)
#  help(metaseqr) # or
#  help(metaseqr.main)

## ----help-1, eval=FALSE, echo=TRUE---------------------------------------
#  help(hg18.exon.data)
#  help(mm9.gene.data)

## ----data-1, eval=TRUE, echo=TRUE----------------------------------------
data("mm9.gene.data",package="metaseqR")

## ----head-1, eval=TRUE, echo=TRUE----------------------------------------
head(mm9.gene.counts)

## ----random-1, eval=TRUE, echo=TRUE--------------------------------------
sample.list.mm9

## ----random-2, eval=TRUE, echo=TRUE--------------------------------------
libsize.list.mm9

## ----example-1, eval=TRUE, echo=TRUE, tidy=FALSE, message=TRUE, warning=FALSE----
library(metaseqR)
data("mm9.gene.data",package="metaseqR")
result <- metaseqr(
       counts=mm9.gene.counts,
       sample.list=sample.list.mm9,
       contrast=c("e14.5_vs_adult_8_weeks"),
       libsize.list=libsize.list.mm9,
       annotation="download",
       org="mm9",
       count.type="gene",
       normalization="edger",
       statistics="edger",
       pcut=0.05,
       fig.format=c("png","pdf"),
       export.what=c("annotation","p.value","meta.p.value",
          "adj.meta.p.value","fold.change"),
       export.scale=c("natural","log2"),
       export.values="normalized",
       export.stats=c("mean","sd","cv"),
       export.where="~/metaseqr_test",
       restrict.cores=0.8,
       gene.filters=list(
             length=list(
                    length=500
             ),
             avg.reads=list(
                    average.per.bp=100,
                    quantile=0.25
             ),
             expression=list(
                    median=TRUE,
                    mean=FALSE,
                    quantile=NA,
                    known=NA,
                    custom=NA
             ),
             biotype=get.defaults("biotype.filter","mm9")
       ),
       out.list=TRUE
)

## ----head-2, eval=TRUE, echo=TRUE----------------------------------------
head(result[["data"]][["e14.5_vs_adult_8_weeks"]])

## ----example-2, eval=TRUE, echo=TRUE, tidy=FALSE, message=TRUE, warning=FALSE----
library(metaseqR)
data("mm9.gene.data",package="metaseqR")
result <- metaseqr(
       counts=mm9.gene.counts,
       sample.list=sample.list.mm9,
       contrast=c("e14.5_vs_adult_8_weeks"),
       libsize.list=libsize.list.mm9,
       annotation="download",
       org="mm9",
       count.type="gene",
       when.apply.filter="prenorm",
       normalization="edaseq",
       statistics=c("deseq","edger"),
       meta.p="fisher",
       qc.plots=c(
             "mds","biodetection","countsbio","saturation","readnoise","filtered",
             "correl","pairwise","boxplot","gcbias","lengthbias","meandiff",
             "meanvar","rnacomp","deheatmap","volcano","biodist","venn"
       ),
       fig.format=c("png","pdf"),
       preset="medium.normal",
       export.where="~/metaseqr_test2",
       out.list=TRUE
)

## ----example-3, eval=FALSE, echo=TRUE, tidy=FALSE, message=FALSE, warning=FALSE----
#  library(metaseqR)
#  data("mm9.gene.data",package="metaseqR")
#  result <- metaseqr(
#         counts=mm9.gene.counts,
#         sample.list=sample.list.mm9,
#         contrast=c("e14.5_vs_adult_8_weeks"),
#         libsize.list=libsize.list.mm9,
#         annotation="download",
#         org="mm9",
#         count.type="gene",
#         normalization="edaseq",
#         statistics=c("deseq","edger"),
#         meta.p="fisher",
#         fig.format=c("png","pdf"),
#         preset="medium.normal",
#         out.list=TRUE
#  )

## ----example-4, eval=FALSE, echo=TRUE, tidy=FALSE------------------------
#  # A full example pipeline with exon counts
#  data("hg19.exon.data",package="metaseqR")
#  metaseqr(
#         counts=hg19.exon.counts,
#         sample.list=sample.list.hg19,
#         contrast=c("normal_vs_paracancerous","normal_vs_cancerous",
#            "normal_vs_paracancerous_vs_cancerous"),
#         libsize.list=libsize.list.hg19,
#         id.col=4,
#         annotation="download",
#         org="hg19",
#         count.type="exon",
#         normalization="edaseq",
#         statistics="deseq",
#         pcut=0.05,
#         qc.plots=c(
#               "mds","biodetection","countsbio","saturation","rnacomp","pairwise",
#               "boxplot","gcbias","lengthbias","meandiff","meanvar","correl",
#               "deheatmap","volcano","biodist","filtered"
#         ),
#         fig.format=c("png","pdf"),
#         export.what=c("annotation","p.value","adj.p.value","fold.change","stats","counts"),
#         export.scale=c("natural","log2","log10","vst"),
#         export.values=c("raw","normalized"),
#         export.stats=c("mean","median","sd","mad","cv","rcv"),
#         restrict.cores=0.8,
#         gene.filters=list(
#               length=list(
#                      length=500
#               ),
#               avg.reads=list(
#                      average.per.bp=100,
#                      quantile=0.25
#               ),
#               expression=list(
#                      median=TRUE,
#                      mean=FALSE
#               ),
#               biotype=get.defaults("biotype.filter","hg19")
#         )
#  )

## ----example-5, eval=FALSE, echo=TRUE, tidy=FALSE------------------------
#  # A full example pipeline with exon counts
#  data("hg19.exon.data",package="metaseqR")
#  metaseqr(
#         counts=hg19.exon.counts,
#         sample.list=sample.list.hg19,
#         contrast=c("normal_vs_paracancerous","normal_vs_cancerous",
#            "normal_vs_paracancerous_vs_cancerous"),
#         libsize.list=libsize.list.hg19,
#         id.col=4,
#         annotation="download",
#         org="hg19",
#         count.type="exon",
#         normalization="edaseq",
#         statistics="deseq",
#         preset="medium.normal",
#         restrict.cores=0.8
#  )

## ----example-6, eval=TRUE, echo=TRUE, tidy=FALSE-------------------------
data("mm9.gene.data",package="metaseqR")
multic <- check.parallel(0.8)
weights <- estimate.aufc.weights(
    counts=as.matrix(mm9.gene.counts[,9:12]),
    normalization="edaseq",
    statistics=c("edger","limma"),
    nsim=1,N=10,ndeg=c(2,2),top=4,model.org="mm9",
    seed=42,multic=multic,libsize.gt=1e+5
)

## ----head-3, eval=TRUE, echo=TRUE----------------------------------------
weights

## ----help-2, eval=FALSE, echo=TRUE---------------------------------------
#  help(stat.edgeR)

## ----help-3, eval=FALSE, echo=TRUE---------------------------------------
#  help(metaseqr)

## ----session-info, eval=TRUE, echo=FALSE---------------------------------
sessionInfo()

