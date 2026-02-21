# Code example from 'signeR-vignette' vignette. See references/ for full tutorial.

## ----results='hide', echo=FALSE, message=FALSE, warning=FALSE-----------------
set.seed(42)
library(knitr)
opts_knit$set(
    self.contained = TRUE,
    upload.fun = image_uri
)
opts_chunk$set(
    dev = 'png',
    dpi = 300,
    out.width = "700px",
    out.height = "700px"
)

## ----eval=FALSE---------------------------------------------------------------
# install.packages("BiocManager")
# BiocManager::install("signeR")

## ----results='hide', message=FALSE--------------------------------------------
library(signeR)

## ----eval=FALSE---------------------------------------------------------------
# library(VariantAnnotation)
# 
# # BSgenome, equivalent to the one used on the variant call
# library(BSgenome.Hsapiens.UCSC.hg19)
# 
# vcfobj <- readVcf("/path/to/a/file.vcf", "hg19")
# mut <- genCountMatrixFromVcf(BSgenome.Hsapiens.UCSC.hg19, vcfobj)

## ----eval=FALSE---------------------------------------------------------------
# mut = matrix(ncol=96,nrow=0)
# for(i in vcf_files) {
#     vo = readVcf(i, "hg19")
#     # sample name (should pick up from the vcf automatically if available)
#     # colnames(vo) = i
#     m0 = genCountMatrixFromVcf(mygenome, vo)
#     mut = rbind(mut, m0)
# }
# dim(mut) # matrix with all samples

## ----eval=FALSE---------------------------------------------------------------
# library(rtracklayer)
# 
# target_regions <- import(con="/path/to/a/target.bed", format="bed")
# opp <- genOpportunityFromGenome(BSgenome.Hsapiens.UCSC.hg19,
#     target_regions, nsamples=nrow(mut))

## ----eval=FALSE---------------------------------------------------------------
# library(Rsamtools)
# 
# # make sure /path/to/genome.fasta.fai exists !
# # you can use "samtools faidx" command to create it
# mygenome <- FaFile("/path/to/genome.fasta")
# 
# mut <- genCountMatrixFromVcf(mygenome, vcfobj)
# opp <- genOpportunityFromGenome(mygenome, target_regions)
# 

## ----eval=FALSE---------------------------------------------------------------
# mut <- genCountMatrixFromMAF(mygenome, "my_file.maf")

## -----------------------------------------------------------------------------
mut <- read.table(system.file("extdata","21_breast_cancers.mutations.txt",
    package="signeR"), header=TRUE, check.names=FALSE)
opp <- read.table(system.file("extdata","21_breast_cancers.opportunity.txt",
    package="signeR"))

## -----------------------------------------------------------------------------
Pmatrix <- as.matrix(read.table(system.file("extdata","Cosmic_signatures_BRC.txt",
    package="signeR"), sep="\t", check.names=FALSE))

## ----eval=FALSE---------------------------------------------------------------
# signatures <- signeR(M=mut, Opport=opp)

## ----eval=FALSE---------------------------------------------------------------
# signatures <- signeR(M=mut, Opport=opp, nlim=c(3,7))

## ----results='hide', message=FALSE--------------------------------------------
signatures <- signeR(M=mut, Opport=opp, nsig=3, main_eval=100, EM_eval=50, EMit_lim=20)

## ----eval=FALSE---------------------------------------------------------------
# signatures.Pstart <- signeR(M=mut, Opport=opp, P=Pmatrix, fixedP=FALSE, main_eval=100, EM_eval=50, EMit_lim=20)

## ----eval=FALSE---------------------------------------------------------------
# BICboxplot(signatures)

## ----echo=FALSE, results='asis'-----------------------------------------------
cat(sprintf("<img src=\"%s\" />\n",image_uri("Model_selection_BICs.png")))

## -----------------------------------------------------------------------------
Pmatrix <- as.matrix(read.table(system.file("extdata","Cosmic_signatures_BRC.txt",
    package="signeR"), sep="\t", check.names=FALSE))

## ----eval=FALSE---------------------------------------------------------------
# exposures.known.sigs <- signeR(M=mut, Opport=opp, P=Pmatrix, fixedP=TRUE, main_eval=100, EM_eval=50, EMit_lim=20)

## ----eval=FALSE---------------------------------------------------------------
# exposures <- Median_exp(exposures.known.sigs$SignExposures)

## -----------------------------------------------------------------------------
Paths(signatures$SignExposures)

## -----------------------------------------------------------------------------
SignPlot(signatures$SignExposures)

## -----------------------------------------------------------------------------
SignHeat(signatures$SignExposures)

## -----------------------------------------------------------------------------
ExposureBoxplot(signatures$SignExposures)

## -----------------------------------------------------------------------------
ExposureBarplot(signatures$SignExposures)

## -----------------------------------------------------------------------------
ExposureBarplot(signatures$SignExposures, relative=TRUE)

## -----------------------------------------------------------------------------
ExposureHeat(signatures$SignExposures)

## -----------------------------------------------------------------------------
# group labels, respective to each row of the mutation count matrix
BRCA_labels <- c("wt","BRCA1+","BRCA2+","BRCA1+","BRCA2+","BRCA1+","BRCA1+",
    "wt","wt","wt","wt","BRCA1+","wt","BRCA2+","BRCA2+","wt","wt","wt",
    "wt","wt","wt")

diff_exposure <- DiffExp(signatures$SignExposures, labels=BRCA_labels)

## -----------------------------------------------------------------------------
# pvalues
diff_exposure$Pvquant

## -----------------------------------------------------------------------------
# most exposed group
diff_exposure$MostExposed

## -----------------------------------------------------------------------------
# note that BRCA_labels [15],[20] and [21] are set to NA
BRCA_labels <- c("wt","BRCA+","BRCA+","BRCA+","BRCA+","BRCA+","BRCA+","wt","wt",
    "wt","wt","BRCA+","wt","BRCA+",NA,"wt","wt","wt","wt",NA,NA)

Class <- ExposureClassify(signatures$SignExposures, labels=BRCA_labels, method="knn")

## -----------------------------------------------------------------------------
# Final assignments
Class$class

# Relative frequencies of assignment to selected groups
Class$freq

# All assigment frequencies
Class$allfreqs

## ----eval=TRUE----------------------------------------------------------------
# feature values, respective to each row of the mutation count matrix. 
# The feature simulated below will be correlated with exposures to signature 2.
myFeature <- (10^6)*Median_exp(signatures$SignExposures)[2,] + rnorm(21,0,1) 

ExpCorr <- ExposureCorrelation(signatures$SignExposures, feature=myFeature)

## ----eval=TRUE----------------------------------------------------------------
ExpLM <- ExposureGLM(signatures$SignExposures, feature=myFeature)

## ----eval=TRUE, message=FALSE-------------------------------------------------
# survival times and censoring, respective to each row of the mutation count matrix. 
#Time is simulated so that it is correlated to exposures to signature 3.
critical_sig<-Median_exp(signatures$SignExposures)[2,]
probs<-(critical_sig-min(critical_sig))/(max(critical_sig)-min(critical_sig))
su<-as.matrix(data.frame(time=sample(80:150,21,replace=T),
                         status=sapply(probs,function(p){sample(c(0,1),1,prob=c(p,1-p))})))

ExpSurv <- ExposureSurvival(Exposures=signatures$SignExposures, 
                            surv=su, method="logrank")

## ----eval=TRUE, message=FALSE-------------------------------------------------
ExpSurv.cox <- ExposureSurvival(Exposures=signatures$SignExposures, 
                                surv=su, method="cox")

## ----eval=TRUE, message=FALSE-------------------------------------------------
BRCA_labels <- c("wt","BRCA+","BRCA+","BRCA+","BRCA+","BRCA+","BRCA+",
    "wt","wt","wt","wt","BRCA+","wt","BRCA+","BRCA+","wt","wt","wt",
    "wt","wt","wt")

ExpSurvMd <- ExposureSurvModel(Exposures=signatures$SignExposures, surv=su, addata=data.frame(as.factor(BRCA_labels)))

## ----eval=TRUE----------------------------------------------------------------
# feature values, respective to each row of the mutation count matrix
HCE <- HClustExp(signatures$SignExposures,method.dist="euclidean", method.hclust="average")

## ----eval=TRUE----------------------------------------------------------------
FCE <- FuzzyClustExp(signatures$SignExposures, Clim=c(3,7))

## -----------------------------------------------------------------------------
citation("signeR")

## -----------------------------------------------------------------------------
sessionInfo()

## -----------------------------------------------------------------------------
print(names(dev.cur()))

