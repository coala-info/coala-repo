# Code example from 'BloodGen3Module' vignette. See references/ for full tutorial.

## ----echo = FALSE-------------------------------------------------------------
library(knitr)
opts_chunk$set(
    error = FALSE,
    tidy  = FALSE,
    message = FALSE,
    warning = FALSE,
    fig.align = "center"
)

## ----Package installation, echo= TRUE, eval=FALSE-----------------------------
# #Installation from Github:
# devtools::install_github("Drinchai/BloodGen3Module")
# 
# #Installation from Bioconductor:
# if (!requireNamespace("BiocManager", quietly=TRUE))
# install.packages("BiocManager")
# BiocManager::install("BloodGen3Module")
# 

## ----setup, warning=FALSE,message=FALSE, echo= TRUE---------------------------
library(BloodGen3Module)


## ----raw data and annotaion preparation, warning=FALSE,message=FALSE,echo= TRUE----
#Load expression data
#Example expression data for package testting
library(ExperimentHub)
library(SummarizedExperiment)

dat = ExperimentHub()
res = query(dat , "GSE13015")
GSE13015 = res[["EH5429"]]


## ----group comparison analysis using t-test statistical analysis, warning=FALSE, echo= TRUE----
Group_df <- Groupcomparison(GSE13015,
                            sample_info = NULL,
                            FC = 1.5,
                            pval = 0.1 ,
                            FDR = TRUE,
                            Group_column = "Group_test",
                            Test_group = "Sepsis",
                            Ref_group = "Control",
                            SummarizedExperiment = TRUE)

## ----group comparison analysis using limma statistical analysis,warning=FALSE----
Group_limma <- Groupcomparisonlimma(GSE13015,
                                    sample_info = NULL,
                                    FC = 1.5,
                                    pval = 0.1 ,
                                    FDR = TRUE,
                                    Group_column = "Group_test",
                                    Test_group = "Sepsis",
                                    Ref_group = "Control",
                                    SummarizedExperiment = TRUE)

## ----grid visulization after running group comparison analysis----------------
gridplot(Group_df, 
         cutoff = 15, 
         Ref_group = "Control",
         filename= tempfile())

## ----individual single sample analysis, warning=FALSE, echo= TRUE-------------
Individual_df = Individualcomparison(GSE13015,
                                     sample_info = NULL,
                                     FC = 1.5,
                                     DIFF = 10,
                                     Group_column = "Group_test",
                                     Ref_group = "Control",
                                     SummarizedExperiment = TRUE)

## ----fingerprint visualization, warning=FALSE---------------------------------

fingerprintplot(Individual_df,
                sample_info = NULL,
                cutoff = 15,
                rowSplit= TRUE ,
                Group_column= "Group_test",
                show_ref_group = FALSE, 
                Ref_group =  "Control",
                Aggregate = "A28",
                filename = tempfile() ,
                height = NULL,
                width = NULL)


