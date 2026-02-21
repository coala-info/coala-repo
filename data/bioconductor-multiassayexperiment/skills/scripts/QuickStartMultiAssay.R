# Code example from 'QuickStartMultiAssay' vignette. See references/ for full tutorial.

## ----load_packages, include=TRUE, results="hide", message=FALSE, warning=FALSE----
library(MultiAssayExperiment)
library(S4Vectors)

## ----load_miniacc-------------------------------------------------------------
data(miniACC)
miniACC

## ----coldata_access-----------------------------------------------------------
colData(miniACC)[1:4, 1:4]
table(miniACC$race)

## ----experiments_access-------------------------------------------------------
experiments(miniACC)

## ----sample_map_access--------------------------------------------------------
sampleMap(miniACC)

## ----metadata_access----------------------------------------------------------
metadata(miniACC)

## ----subset_by_rownames, results='hide'---------------------------------------
miniACC[c("MAPK14", "IGFBP2"), , ]

## ----subset_by_stage, results='hide'------------------------------------------
stg4 <- miniACC$pathologic_stage == "stage iv"
# remove NA values from vector
miniACC[, stg4 & !is.na(stg4), ]

## ----subset_by_assay_name, results='hide'-------------------------------------
miniACC[, , "RNASeq2GeneNorm"]

## ----double_bracket_subsetting------------------------------------------------
miniACC[[1L]]  #or equivalently, miniACC[["RNASeq2GeneNorm"]]

## ----complete_cases_summary---------------------------------------------------
summary(complete.cases(miniACC))

## ----intersect_columns--------------------------------------------------------
accmatched = intersectColumns(miniACC)

## ----accmatched_colnames------------------------------------------------------
colnames(accmatched)

## ----intersect_rows-----------------------------------------------------------
accmatched2 <- intersectRows(miniACC[, , c("RNASeq2GeneNorm",
                                           "gistict",
                                           "Mutations")])
rownames(accmatched2)

## ----assay_singular-----------------------------------------------------------
class(assay(miniACC))

## ----assays_plural------------------------------------------------------------
assays(miniACC)

## ----longform_example---------------------------------------------------------
longForm(
    miniACC[c("TP53", "CTNNB1"), , ],
    colDataCols = c("vital_status", "days_to_death")
)

## ----wideform_example---------------------------------------------------------
wideFormat(
    miniACC[c("TP53", "CTNNB1"), , ],
    colDataCols = c("vital_status", "days_to_death")
)

## ----mae_constructor----------------------------------------------------------
MultiAssayExperiment(
    experiments=experiments(miniACC),
    colData=colData(miniACC),
    sampleMap=sampleMap(miniACC),
    metadata=metadata(miniACC)
)

## ----concatenate_mae----------------------------------------------------------
miniACC2 <- c(
    miniACC,
    log2rnaseq = log2(assays(miniACC)$RNASeq2GeneNorm),
    mapFrom=1L
)
assays(miniACC2)

## ----upset_samples------------------------------------------------------------
library(UpSetR)
upsetSamples(miniACC)

## ----kaplan_meier_plot_setup,message=FALSE------------------------------------
library(survival)
library(survminer)

coldat <- as.data.frame(colData(miniACC))
coldat$y <- Surv(miniACC$days_to_death, miniACC$vital_status)
colData(miniACC) <- DataFrame(coldat)

## ----remove_missing_survival_data---------------------------------------------
miniACC <- miniACC[, complete.cases(coldat$y), ]
coldat <- as(colData(miniACC), "data.frame")

## ----kaplan_meier_plot--------------------------------------------------------
fit <- survfit(y ~ pathology_N_stage, data = coldat)
ggsurvplot(fit, data = coldat, risk.table = TRUE)

## ----prepare_cox_regression_data----------------------------------------------
wideacc <- wideFormat(
    miniACC["EZH2", , ],
    colDataCols = c("vital_status", "days_to_death", "pathology_N_stage")
)
wideacc$y <- Surv(wideacc$days_to_death, wideacc$vital_status)
head(wideacc)

## ----cox_regression_model-----------------------------------------------------
coxph(
    Surv(days_to_death, vital_status) ~
        gistict_EZH2 + log2(RNASeq2GeneNorm_EZH2) + pathology_N_stage,
    data = wideacc
)

## ----sessioninfo--------------------------------------------------------------
sessionInfo()

