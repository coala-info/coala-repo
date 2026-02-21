# Code example from 'cBioPortalData' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(cache = TRUE)

## ----installation, include=TRUE,results="hide",message=FALSE,warning=FALSE----
library(cBioPortalData)
library(AnVIL)

## ----citation, eval=FALSE-----------------------------------------------------
# citation("MultiAssayExperiment")
# citation("cBioPortalData")

## ----get_studies--------------------------------------------------------------
cbio <- cBioPortal()
studies <- getStudies(cbio, buildReport = TRUE)
head(studies)

## ----cbiodatapack, message=FALSE,warning=FALSE--------------------------------
## Use ask=FALSE for non-interactive use
laml <- cBioDataPack("laml_tcga", ask = FALSE)
laml

## ----cbioportaldata, warning=FALSE--------------------------------------------
acc <- cBioPortalData(
    api = cbio,
    by = "hugoGeneSymbol",
    studyId = "acc_tcga",
    genes = c(
        "TERT", "TERF2", "CDK4", "ZNRF3", "CDKN2A", "RB1", "RPL22",
        "TP53", "CTNNB1", "PRKAR1A", "MEN1"
    ),
    molecularProfileIds = c("acc_tcga_linear_CNA", "acc_tcga_mutations"),
)
acc

## ----metadata_acc-------------------------------------------------------------
metadata(acc)

## ----build_prompt, echo=FALSE-------------------------------------------------
cat(
    "Our testing shows that '%s' is not currently building.\n",
    "  Use 'downloadStudy()' to manually obtain the data.\n",
    "  Proceed anyway? [y/n]: y"
)

## ----remove_cache, eval=FALSE-------------------------------------------------
# removeCache("laml_tcga")

## ----remove_cache_all, eval=FALSE---------------------------------------------
# unlink("~/.cache/cBioPortalData/")

## ----load_surv,message=FALSE,warning=FALSE------------------------------------
library(survival)
library(survminer)

## ----check_data---------------------------------------------------------------
table(colData(laml)$OS_STATUS)
class(colData(laml)$OS_MONTHS)

## ----clean_data---------------------------------------------------------------
collaml <- colData(laml)
collaml[collaml$OS_MONTHS == "[Not Available]", "OS_MONTHS"] <- NA
collaml$OS_MONTHS <- as.numeric(collaml$OS_MONTHS)
colData(laml) <- collaml

## ----survplot-----------------------------------------------------------------
fit <- survfit(
    Surv(OS_MONTHS, as.numeric(substr(OS_STATUS, 1, 1))) ~ SEX,
    data = colData(laml)
)
ggsurvplot(fit, data = colData(laml), risk.table = TRUE)

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

