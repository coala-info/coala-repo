# Code example from 'PDATK_introduction' vignette. See references/ for full tutorial.

## ----eval=FALSE, echo=TRUE----------------------------------------------------
# if (!require('PDATK')) BiocManager::install('PDATK')

## ----load_package-------------------------------------------------------------
library(PDATK)

## ----SurvivalExperiment_constructor-------------------------------------------
# -- Create some dummy data

# an assay
assay1 <- matrix(rnorm(100), nrow=10, ncol=10,
    dimnames=list(paste0('gene_', seq_len(10)), paste0('sample_', seq_len(10))))

# column and row metadata
rowMData <- DataFrame(gene_name=rownames(assay1),
    id=seq_len(10), row.names=rownames(assay1))
colMData <- DataFrame(sample_name=colnames(assay1),
    overall_survival=sample.int(1000, 10),
    os_status=sample(c(0L, 1L), 10, replace=TRUE),
    row.names=colnames(assay1))


# -- Use it to build a SurvivalExperiment
survExperiment <- SurvivalExperiment(assays=SimpleList(rna=assay1),
    rowData=rowMData, colData=colMData, metadata=list(a='Some metadata'),
    survival_time='overall_survival', event_occurred ='os_status')

## -----------------------------------------------------------------------------
# -- Build A SummarizedExperiment
sumExperiment <- SummarizedExperiment(assays=SimpleList(rna=assay1),
    rowData=rowMData, colData=colMData, metadata=list(a='Some meta data'))

# -- Convert it to a SurvivalExperiment
# Use the sumExp parameter, which must be named
survExperiment <- SurvivalExperiment(sumExp=sumExperiment,
    survival_time='overall_survival', event_occurred='os_status')

## ----CohortList_constructor---------------------------------------------------
cohortList <- CohortList(list(cohort1=survExperiment, cohort2=survExperiment),
    mDataTypes=c('rna_seq', 'rna_micro'))

## ----SurvivalModel_constructor------------------------------------------------
set.seed(1987)
survModel <- SurvivalModel(survExperiment, randomSeed=1987)

