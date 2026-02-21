# Code example from 'gwasurvivr_Introduction' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, cache=FALSE, eval = TRUE)
library(knitr)

## ----echo=FALSE---------------------------------------------------------------
cols <- c("RSID",
          "CHR",
          "POS",
          "REF",
          "ALT",
          "SAMP_FREQ_ALT",
          "SAMP_MAF",
          "PVALUE",
          "HR",
          "HR_lowerCI",
          "HR_upperCI",
          "COEF",
          "SE.COEF",
          "Z",
          "N",
          "NEVENT")

desc <- c("SNP ID",
          "Chromosome number",
          "Genomic Position (BP)",
          "Reference Allele",
          "Alternate Allele",
          "Alternate Allele frequency in sample being tested",
          "Minor allele frequency in sample being tested",
          "P-value of single SNP or interaction term",
          "Hazard Ratio (HR)",
          "Lower bound 95% CI of HR",
          "Upper bound 95% CI of HR",
          "Estimated coefficient of SNP",
          "Standard error of coefficient estimate",
          "Z-statistic",
          "Number of individuals in sample being tested",
          "Number of events that occurred in sample being tested")

df <- cbind(cols, desc)
colnames(df) <- c("Column", "Description")
kable(df)

## ----echo=FALSE---------------------------------------------------------------
cols <- c("TYPED",
          "AF", 
          "MAF",
          "R2",
          "ER2")
desc <- c("Imputation status: TRUE (SNP IS TYPED)/FALSE (SNP IS IMPUTED)",
          "Minimac3 output Alternate Allele Frequency",
          "Minimac3 output of Minor Allele Frequency",
          "Imputation R2 score (minimac3 $R^2$)",
          "Minimac3 ouput empirical $R^2$")
df <- cbind(cols, desc)
colnames(df) <- c("Column", "Description")

kable(df)

## ----echo=FALSE---------------------------------------------------------------
cols <- c("TYPED",
          "RefPanelAF",
          "INFO")
desc <- c("Imputation status: TRUE (SNP IS TYPED)/FALSE (SNP IS IMPUTED)",
          "HRC Reference Panel Allele Frequency",
          "Imputation INFO score from PBWT")
df <- cbind(cols, desc)
colnames(df) <- c("Column", "Description")
kable(df)

## ----echo=FALSE---------------------------------------------------------------
cols <- c("TYPED",
          "A0",
          "A1", 
          "exp_freq_A1")
desc <- c("`---` is imputed, repeated RSID is typed",
          "Allele coded 0 in IMPUTE2",
          "Allele coded 1 in IMPUTE2",
          "Expected allele frequency of alelle code A1")
df <- cbind(cols, desc)
colnames(df) <- c("Column", "Description")
kable(df)

## ----eval=FALSE---------------------------------------------------------------
# devtools::install_github("suchestoncampbelllab/gwasurvivr")

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("gwasurvivr", version = "devel")

## ----eval=FALSE---------------------------------------------------------------
# install.packages(c("ncdf4", "matrixStats", "parallel", "survival"))

## ----eval=FALSE---------------------------------------------------------------
# BiocManager::install("GWASTools")
# BiocManager::install("VariantAnnotation")
# BiocManager::install("SummarizedExperiment")
# BiocManager::install("SNPRelate")

## -----------------------------------------------------------------------------
library(gwasurvivr)

## ----eval=FALSE---------------------------------------------------------------
# options("gwasurvivr.cores"=4)

## ----eval=FALSE---------------------------------------------------------------
# library(parallel)
# cl <- makeCluster(detectCores())
# 
# impute2CoxSurv(..., clusterObj=cl)
# sangerCoxSurv(..., clusterObj=cl)
# michiganCoxSurv(..., clusterObj=cl)

## ----message=FALSE------------------------------------------------------------
vcf.file <- system.file(package="gwasurvivr",
                        "extdata", 
                        "michigan.chr14.dose.vcf.gz")
pheno.fl <- system.file(package="gwasurvivr",
                        "extdata", 
                        "simulated_pheno.txt")
pheno.file <- read.table(pheno.fl,
                         sep=" ", 
                         header=TRUE,
                         stringsAsFactors = FALSE)
head(pheno.file)

# recode sex column and remove first column 
pheno.file$SexFemale <- ifelse(pheno.file$sex=="female", 1L, 0L)
# select only experimental group sample.ids
sample.ids <- pheno.file[pheno.file$group=="experimental",]$ID_2
head(sample.ids)

## ----eval=FALSE---------------------------------------------------------------
# michiganCoxSurv(vcf.file=vcf.file,
#                 covariate.file=pheno.file,
#                 id.column="ID_2",
#                 sample.ids=sample.ids,
#                 time.to.event="time",
#                 event="event",
#                 covariates=c("age", "SexFemale", "DrugTxYes"),
#                 inter.term=NULL,
#                 print.covs="only",
#                 out.file="michigan_only",
#                 r2.filter=0.3,
#                 maf.filter=0.005,
#                 chunk.size=100,
#                 verbose=TRUE,
#                 clusterObj=NULL)

## ----echo=FALSE---------------------------------------------------------------
michiganCoxSurv(vcf.file=vcf.file,
                covariate.file=pheno.file,
                id.column="ID_2",
                sample.ids=sample.ids,
                time.to.event="time",
                event="event",
                covariates=c("age", "SexFemale", "DrugTxYes"),
                inter.term=NULL,
                print.covs="only",
                out.file=tempfile("michigan_only"),
                r2.filter=0.3,
                maf.filter=0.005,
                chunk.size=100,
                verbose=TRUE,
                clusterObj=NULL)

## ----message=FALSE, eval=FALSE------------------------------------------------
# michigan_only <- read.table("michigan_only.coxph", sep="\t", header=TRUE, stringsAsFactors = FALSE)

## ----message=FALSE, echo=FALSE------------------------------------------------
michigan_only <- read.table(dir(tempdir(), pattern="^michigan_only.*\\.coxph$", full.names = TRUE), sep="\t", header=TRUE, stringsAsFactors = FALSE)

## -----------------------------------------------------------------------------
str(head(michigan_only))

## ----eval=FALSE---------------------------------------------------------------
# michiganCoxSurv(vcf.file=vcf.file,
#                 covariate.file=pheno.file,
#                 id.column="ID_2",
#                 sample.ids=sample.ids,
#                 time.to.event="time",
#                 event="event",
#                 covariates=c("age", "SexFemale", "DrugTxYes"),
#                 inter.term="DrugTxYes",
#                 print.covs="only",
#                 out.file="michigan_intx_only",
#                 r2.filter=0.3,
#                 maf.filter=0.005,
#                 chunk.size=100,
#                 verbose=FALSE,
#                 clusterObj=NULL)

## ----echo=FALSE---------------------------------------------------------------
michiganCoxSurv(vcf.file=vcf.file,
                covariate.file=pheno.file,
                id.column="ID_2",
                sample.ids=sample.ids,
                time.to.event="time",
                event="event",
                covariates=c("age", "SexFemale", "DrugTxYes"),
                inter.term="DrugTxYes",
                print.covs="only",
                out.file=tempfile("michigan_intx_only"),
                r2.filter=0.3,
                maf.filter=0.005,
                chunk.size=100,
                verbose=FALSE,
                clusterObj=NULL)

## ----message=FALSE, eval=FALSE------------------------------------------------
# michigan_intx_only <- read.table("michigan_intx_only.coxph", sep="\t", header=TRUE, stringsAsFactors = FALSE)

## ----message=FALSE, echo=FALSE------------------------------------------------
michigan_intx_only <- read.table(dir(tempdir(), pattern="^michigan_intx_only.*\\.coxph$", full.names = TRUE), sep="\t", header=TRUE, stringsAsFactors = FALSE)

## -----------------------------------------------------------------------------
str(head(michigan_intx_only))

## ----eval=TRUE----------------------------------------------------------------
vcf.file <- system.file(package="gwasurvivr",
                        "extdata", 
                        "sanger.pbwt_reference_impute.vcf.gz")
pheno.fl <- system.file(package="gwasurvivr",
                        "extdata", 
                        "simulated_pheno.txt")
pheno.file <- read.table(pheno.fl,
                         sep=" ",
                         header=TRUE,
                         stringsAsFactors = FALSE)
head(pheno.file)
# recode sex column and remove first column 
pheno.file$SexFemale <- ifelse(pheno.file$sex=="female", 1L, 0L)
# select only experimental group sample.ids
sample.ids <- pheno.file[pheno.file$group=="experimental",]$ID_2
head(sample.ids)

## ----eval=FALSE---------------------------------------------------------------
# sangerCoxSurv(vcf.file=vcf.file,
#               covariate.file=pheno.file,
#               id.column="ID_2",
#               sample.ids=sample.ids,
#               time.to.event="time",
#               event="event",
#               covariates=c("age", "SexFemale", "DrugTxYes"),
#               inter.term=NULL,
#               print.covs="only",
#               out.file="sanger_only",
#               info.filter=0.3,
#               maf.filter=0.005,
#               chunk.size=100,
#               verbose=TRUE,
#               clusterObj=NULL)

## ----echo=FALSE---------------------------------------------------------------
sangerCoxSurv(vcf.file=vcf.file,
              covariate.file=pheno.file,
              id.column="ID_2",
              sample.ids=sample.ids,
              time.to.event="time",
              event="event",
              covariates=c("age", "SexFemale", "DrugTxYes"),
              inter.term=NULL,
              print.covs="only",
              out.file=tempfile("sanger_only"),
              info.filter=0.3,
              maf.filter=0.005,
              chunk.size=100,
              verbose=TRUE,
              clusterObj=NULL)

## ----message=FALSE, echo=FALSE------------------------------------------------
sanger_only <- read.table(dir(tempdir(), pattern="^sanger_only.*\\.coxph$", full.names = TRUE), sep="\t", header=TRUE, stringsAsFactors = FALSE)

## -----------------------------------------------------------------------------
str(head(sanger_only))

## ----eval=FALSE---------------------------------------------------------------
# sangerCoxSurv(vcf.file=vcf.file,
#               covariate.file=pheno.file,
#               id.column="ID_2",
#               sample.ids=sample.ids,
#               time.to.event="time",
#               event="event",
#               covariates=c("age", "SexFemale", "DrugTxYes"),
#               inter.term="DrugTxYes",
#               print.covs="only",
#               out.file="sanger_intx_only",
#               info.filter=0.3,
#               maf.filter=0.005,
#               chunk.size=100,
#               verbose=TRUE,
#               clusterObj=NULL)

## ----echo=FALSE, eval=FALSE---------------------------------------------------
# sangerCoxSurv(vcf.file=vcf.file,
#               covariate.file=pheno.file,
#               id.column="ID_2",
#               sample.ids=sample.ids,
#               time.to.event="time",
#               event="event",
#               covariates=c("age", "SexFemale", "DrugTxYes"),
#               inter.term="DrugTxYes",
#               print.covs="only",
#               out.file=tempfile("sanger_intx_only"),
#               info.filter=0.3,
#               maf.filter=0.005,
#               chunk.size=100,
#               verbose=TRUE,
#               clusterObj=NULL)

## ----message=FALSE------------------------------------------------------------
impute.file <- system.file(package="gwasurvivr",
                            "extdata",
                            "impute_example.impute2.gz")
sample.file <- system.file(package="gwasurvivr",
                           "extdata", 
                           "impute_example.impute2_sample")
covariate.file <- system.file(package="gwasurvivr", 
                              "extdata",
                              "simulated_pheno.txt")
covariate.file <- read.table(covariate.file, 
                             sep=" ",
                             header=TRUE,
                             stringsAsFactors = FALSE)
covariate.file$SexFemale <- ifelse(covariate.file$sex=="female", 1L, 0L)
sample.ids <- covariate.file[covariate.file$group=="experimental",]$ID_2

## ----eval=FALSE---------------------------------------------------------------
# impute2CoxSurv(impute.file=impute.file,
#                sample.file=sample.file,
#                chr=14,
#                covariate.file=covariate.file,
#                id.column="ID_2",
#                sample.ids=sample.ids,
#                time.to.event="time",
#                event="event",
#                covariates=c("age", "SexFemale", "DrugTxYes"),
#                inter.term=NULL,
#                print.covs="only",
#                out.file="impute_example_only",
#                chunk.size=100,
#                maf.filter=0.005,
#                exclude.snps=NULL,
#                flip.dosage=TRUE,
#                verbose=TRUE,
#                clusterObj=NULL)

## ----echo=FALSE---------------------------------------------------------------
impute2CoxSurv(impute.file=impute.file,
               sample.file=sample.file,
               chr=14,
               covariate.file=covariate.file,
               id.column="ID_2",
               sample.ids=sample.ids,
               time.to.event="time",
               event="event",
               covariates=c("age", "SexFemale", "DrugTxYes"),
               inter.term=NULL,
               print.covs="only",
               out.file=tempfile("impute_example_only"),
               chunk.size=100,
               maf.filter=0.005,
               exclude.snps=NULL,
               flip.dosage=TRUE,
               verbose=TRUE,
               clusterObj=NULL)

## ----message=FALSE, eval=FALSE------------------------------------------------
# impute2_res_only <- read.table("impute_example_only.coxph", sep="\t", header=TRUE, stringsAsFactors = FALSE)
# str(head(impute2_res_only))

## ----message=FALSE, echo=FALSE------------------------------------------------
impute2_res_only <- read.table(dir(tempdir(), pattern="^impute_example_only.*\\.coxph$", full.names=TRUE), sep="\t", header=TRUE, stringsAsFactors = FALSE)
str(head(impute2_res_only))

## ----eval=FALSE---------------------------------------------------------------
# impute2CoxSurv(impute.file=impute.file,
#                sample.file=sample.file,
#                chr=14,
#                covariate.file=covariate.file,
#                id.column="ID_2",
#                sample.ids=sample.ids,
#                time.to.event="time",
#                event="event",
#                covariates=c("age", "SexFemale", "DrugTxYes"),
#                inter.term="DrugTxYes",
#                print.covs="only",
#                out.file="impute_example_intx",
#                chunk.size=100,
#                maf.filter=0.005,
#                flip.dosage=TRUE,
#                verbose=FALSE,
#                clusterObj=NULL,
#                keepGDS=FALSE)

## ----echo=FALSE---------------------------------------------------------------
impute2CoxSurv(impute.file=impute.file,
               sample.file=sample.file,
               chr=14,
               covariate.file=covariate.file,
               id.column="ID_2",
               sample.ids=sample.ids,
               time.to.event="time",
               event="event",
               covariates=c("age", "SexFemale", "DrugTxYes"),
               inter.term="DrugTxYes",
               print.covs="only",
               out.file=tempfile("impute_example_intx"),
               chunk.size=100,
               maf.filter=0.005,
               flip.dosage=TRUE,
               verbose=FALSE,
               clusterObj=NULL,
               keepGDS=FALSE)

## ----message=FALSE, eval=FALSE------------------------------------------------
# impute2_res_intx <- read.table("impute_example_intx.coxph", sep="\t", header=TRUE, stringsAsFactors = FALSE)
# str(head(impute2_res_intx))

## ----message=FALSE, echo=FALSE------------------------------------------------
impute2_res_intx <- read.table(dir(tempdir(), pattern="^impute_example_intx.*\\.coxph$", full.names=TRUE), sep="\t", header=TRUE, stringsAsFactors = FALSE)
str(head(impute2_res_intx))

## ----eval=FALSE---------------------------------------------------------------
# ## mysurvivalscript.R
# library(gwasurvivr)
# library(batch)
# 
# parseCommandArgs(evaluate=TRUE) # this is loaded in the batch package
# 
# options("gwasurvivr.cores"=4)
# 
# vcf.file <- system.file(package="gwasurvivr",
#                         "extdata",
#                         vcf.file)
# pheno.fl <- system.file(package="gwasurvivr",
#                         "extdata",
#                         pheno.file)
# pheno.file <- read.table(pheno.fl,
#                          sep=" ",
#                          header=TRUE,
#                          stringsAsFactors = FALSE)
# # recode sex column and remove first column
# pheno.file$SexFemale <- ifelse(pheno.file$sex=="female", 1L, 0L)
# # select only experimental group sample.ids
# sample.ids <- pheno.file[pheno.file$group=="experimental",]$ID_2
# ## -- unlist the covariates
# ## (refer below to the shell script as to why we are doing this)
# covariates <- unlist(sapply(covariates, strsplit, "_", 1, "[["))
# 
# sangerCoxSurv(vcf.file=vcf.file,
#               covariate.file=pheno.file,
#               id.column="ID_2",
#               sample.ids=sample.ids,
#               time.to.event=time,
#               event=event,
#               covariates=covariates,
#               inter.term=NULL,
#               print.covs="only",
#               out.file=out.file,
#               info.filter=0.3,
#               maf.filter=0.005,
#               chunk.size=100,
#               verbose=TRUE,
#               clusterObj=NULL)

## ----eval=FALSE---------------------------------------------------------------
# #!/bin/bash
# DIRECTORY=/path/to/dir/impute_chr
# 
# module load R
# 
# R --script ${DIRECTORY}/survival/code/mysurvivalscript.R -q --args \
#         vcf.file ${DIRECTORY}/sanger.pbwt_reference_impute.vcf.gz \
#         pheno.file ${DIRECTORY}/phenotype_data/simulated_pheno.txt \
#         covariates DrugTxYes_age_SexFemale\
#         time.to.event time \
#         event event \
#         out.file ${DIRECTORY}/survival/results/sanger_example_output

## ----echo=FALSE---------------------------------------------------------------
sessionInfo()

