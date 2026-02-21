# Code example from 'example_using_structToolbox' vignette. See references/ for full tutorial.

## ----echo = FALSE,include=FALSE-----------------------------------------------
suppressPackageStartupMessages(library(structToolbox))
suppressPackageStartupMessages(library(httptest))
suppressPackageStartupMessages(library(metabolomicsWorkbenchR))
httptest::start_vignette('structToolbox_example')

## -----------------------------------------------------------------------------
names(metabolomicsWorkbenchR::context)

## -----------------------------------------------------------------------------
cat('Valid inputs:\n')
context_inputs('study')
cat('\nValid outputs:\n')
context_outputs('study')

## -----------------------------------------------------------------------------
US = do_query(
  context = 'study',
  input_item = 'ignored',
  input_value = 'ignored',
  output_item = 'untarg_studies'
)

head(US[,1:3])

## -----------------------------------------------------------------------------
S = do_query('study','study_id','ST000010','summary')
t(S)

## ----eval=FALSE---------------------------------------------------------------
# DE = do_query(
#   context = 'study',
#   input_item = 'analysis_id',
#   input_value = 'AN000025',
#   output_item = 'untarg_DatasetExperiment'
# )
# DE

## ----eval=TRUE,include=FALSE--------------------------------------------------
DE=metabolomicsWorkbenchR:::AN000025
DE=as.DatasetExperiment(DE)
DE

## ----warning=FALSE------------------------------------------------------------
# model sequence
M = 
    mv_feature_filter(
      threshold = 40,
      method='across',
      factor_name='FCS') +
    mv_sample_filter(mv_threshold =40) +
    vec_norm() +
    knn_impute() +
    log_transform() + 
    mean_centre() + 
    PCA()
# apply model
M = model_apply(M,DE)

# pca scores plot
C = pca_scores_plot(factor_name=c('FCS'))
chart_plot(C,M[length(M)])

## ----echo=FALSE---------------------------------------------------------------
sessionInfo()

## ----include=FALSE------------------------------------------------------------
end_vignette()

