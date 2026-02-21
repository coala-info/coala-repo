# Code example from 'BaalChIP' vignette. See references/ for full tutorial.

## ----style, echo=FALSE, results="asis", message=FALSE-------------------------
BiocStyle::markdown()
knitr::opts_chunk$set(tidy = FALSE,
                      warning = FALSE,
                      message = FALSE)

## ----echo=FALSE, results='hide', message=FALSE--------------------------------
library(BaalChIP)

## ----eval=TRUE----------------------------------------------------------------
wd <- system.file("test",package="BaalChIP") #system directory

samplesheet <- file.path(wd, "exampleChIP1.tsv")
hets <- c("MCF7"="MCF7_hetSNP.txt", "GM12891"="GM12891_hetSNP.txt")
res <- BaalChIP(samplesheet=samplesheet, hets=hets)

## ----quick1, eval=FALSE-------------------------------------------------------
# res <- BaalChIP(samplesheet=samplesheet, hets=hets)
# res <- BaalChIP.run(res, cores=4, verbose=TRUE) #cores for parallel computing

## ----quick2, eval=FALSE-------------------------------------------------------
# 
# #create BaalChIP object
# samplesheet <- file.path(wd, "exampleChIP1.tsv")
# hets <- c("MCF7"="MCF7_hetSNP.txt", "GM12891"="GM12891_hetSNP.txt")
# res <- BaalChIP(samplesheet=samplesheet, hets=hets)
# 
# #Now, load some data
# data(blacklist_hg19)
# data(pickrell2011cov1_hg19)
# data(UniqueMappability50bp_hg19)
# 
# #run one at the time (instead of BaalChIP.run)
# res <- alleleCounts(res, min_base_quality=10, min_mapq=15, verbose=FALSE)
# res <- QCfilter(res,
#                 RegionsToFilter=c("blacklist_hg19", "pickrell2011cov1_hg19"),
#                 RegionsToKeep="UniqueMappability50bp_hg19",
#                 verbose=FALSE)
# res <- mergePerGroup(res)
# res <- filter1allele(res)
# res <- getASB(res,
#               Iter=5000,
#               conf_level=0.95,
#               cores=4, RMcorrection = TRUE,
#               RAFcorrection=TRUE)

## -----------------------------------------------------------------------------
gDNA <- list("TaT1"=
               c(file.path(wd, "bamFiles/TaT1_1_gDNA.test.bam"),
                 file.path(wd, "bamFiles/TaT1_2_gDNA.test.bam")),
              "AMOVC"=
               c(file.path(wd, "bamFiles/AMOVC_1_gDNA.test.bam"),
                 file.path(wd, "bamFiles/AMOVC_2_gDNA.test.bam")))

## ----quick3, eval=FALSE-------------------------------------------------------
# wd <- system.file("test",package="BaalChIP") #system directory
# 
# samplesheet <- file.path(wd, "exampleChIP2.tsv")
# hets <- c("TaT1"="TaT1_hetSNP.txt", "AMOVC"="AMOVC_hetSNP.txt")
# res2 <- BaalChIP(samplesheet=samplesheet, hets=hets, CorrectWithgDNA=gDNA)
# res2 <- BaalChIP.run(res2, cores=4, verbose=TRUE) #cores for parallel computing

## -----------------------------------------------------------------------------
samplesheet <- read.delim(file.path(wd,"exampleChIP1.tsv"))
samplesheet

## -----------------------------------------------------------------------------
samplesheet <- read.delim(file.path(wd,"exampleChIP2.tsv"))
samplesheet

## -----------------------------------------------------------------------------
head(read.delim(file.path(system.file("test",package="BaalChIP"),"MCF7_hetSNP.txt")))

## ----eval=TRUE----------------------------------------------------------------
samplesheet <- file.path(wd,"exampleChIP1.tsv")
hets <- c("MCF7"="MCF7_hetSNP.txt", "GM12891"="GM12891_hetSNP.txt")
res <- BaalChIP(samplesheet=samplesheet, hets=hets)
res

## -----------------------------------------------------------------------------
BaalChIP.get(res, what="samples")

## ----eval=TRUE----------------------------------------------------------------
#run alleleCounts
res <- alleleCounts(res, min_base_quality=10, min_mapq=15, verbose=FALSE)

## -----------------------------------------------------------------------------
data(blacklist_hg19)
data(pickrell2011cov1_hg19)
data(UniqueMappability50bp_hg19)

## ----eval=TRUE----------------------------------------------------------------
#run QC filter
res <- QCfilter(res, 
                RegionsToFilter=list("blacklist"=blacklist_hg19, "highcoverage"=pickrell2011cov1_hg19), 
                RegionsToKeep=list("UniqueMappability"=UniqueMappability50bp_hg19), 
                verbose=FALSE)
res <- mergePerGroup(res)
res <- filter1allele(res)

## ----eval=FALSE, message=FALSE, error=FALSE, warning=FALSE--------------------
# res <- filterIntbias(res,
#                      simul_output="directory_name",
#                      tmpfile_prefix="prefix_name",
#                      simulation_script = "local",
#                      alignmentSimulArgs=c("picard-tools-1.119",
#                                           "bowtie-1.1.1",
#                                           "genomes_test/male.hg19",
#                                           "genomes_test/maleByChrom")
#                      verbose=FALSE)

## -----------------------------------------------------------------------------
preComputed_output <- system.file("test/simuloutput",package="BaalChIP")
list.files(preComputed_output)

## ----eval=TRUE, message=FALSE-------------------------------------------------
res <- filterIntbias(res, simul_output=preComputed_output, 
                     tmpfile_prefix="c67c6ec6c433", 
                     skipScriptRun=TRUE,
                     verbose=FALSE)

## -----------------------------------------------------------------------------
res <- mergePerGroup(res)

## -----------------------------------------------------------------------------
res <- filter1allele(res)

## ----eval=FALSE, message=FALSE------------------------------------------------
# res <- getASB(res, Iter=5000, conf_level=0.95, cores = 4,
#               RMcorrection = TRUE,
#               RAFcorrection=TRUE)

## ----eval=TRUE, echo=FALSE, include=FALSE-------------------------------------
data(baalObject)
res <- BaalObject

## -----------------------------------------------------------------------------
res

## -----------------------------------------------------------------------------
result <- BaalChIP.report(res)
head(result[["MCF7"]])

## -----------------------------------------------------------------------------
data(ENCODEexample)
ENCODEexample

## -----------------------------------------------------------------------------
a <- summaryQC(ENCODEexample)

## -----------------------------------------------------------------------------
summaryQC(ENCODEexample)[["filtering_stats"]]

## -----------------------------------------------------------------------------
summaryQC(ENCODEexample)[["average_stats"]]

## ----plotENCODE1--------------------------------------------------------------
plotQC(ENCODEexample, what="barplot_per_group")

## ----plotENCODE2--------------------------------------------------------------
plotQC(ENCODEexample, what="boxplot_per_filter")

## ----plotENCODE3--------------------------------------------------------------
plotQC(ENCODEexample, what="overall_pie")

## ----plotSimul----------------------------------------------------------------
plotSimul(ENCODEexample)

## -----------------------------------------------------------------------------
#ENCODE example
a <- BaalChIP.get(ENCODEexample, "assayedVar")[["MCF7"]]
a[1:5,1:5]

#FAIRE exmaple
a <- BaalChIP.get(FAIREexample, "assayedVar")[["MDA134"]]
a[1:5,]

## -----------------------------------------------------------------------------
summaryASB(ENCODEexample)

## -----------------------------------------------------------------------------
summaryASB(FAIREexample)

## ----adjENCODE, fig.width=12--------------------------------------------------
adjustmentBaalPlot(ENCODEexample)

## ----adjFAIRE1, fig.width=7, fig.height=2.5-----------------------------------
adjustmentBaalPlot(FAIREexample)

## ----adjFAIRE2, fig.width=7, fig.height=2.5-----------------------------------
adjustmentBaalPlot(FAIREexample, col=c("cyan4","chocolate3"))

## -----------------------------------------------------------------------------
biastable <- BaalChIP.get(ENCODEexample, "biasTable")
head(biastable[["K562"]])

## -----------------------------------------------------------------------------
biastable <- BaalChIP.get(FAIREexample, "biasTable")
head(biastable[["T47D"]])

## -----------------------------------------------------------------------------
result <- BaalChIP.report(FAIREexample)[["T47D"]]

#show ASB SNPs
result[result$isASB==TRUE,]

## ----echo=FALSE---------------------------------------------------------------
sessionInfo()

