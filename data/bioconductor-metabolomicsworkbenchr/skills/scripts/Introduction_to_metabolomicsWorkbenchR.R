# Code example from 'Introduction_to_metabolomicsWorkbenchR' vignette. See references/ for full tutorial.

## ----echo = FALSE,include=FALSE-----------------------------------------------
suppressPackageStartupMessages(library(grid))
suppressPackageStartupMessages(library(httptest))
suppressPackageStartupMessages(library(metabolomicsWorkbenchR))
httptest::start_vignette('introduction')

## -----------------------------------------------------------------------------
# search for all studies with "Diabetes" in the title and return a summary
df = do_query(
    context = 'study',
    input_item = 'study_title',
    input_value = 'Diabetes',
    output_item = 'summary'
)
df[1:3,c(1,4)]

## -----------------------------------------------------------------------------
df = do_query(
    context = 'compound',
    input_item = 'regno',
    input_value = '11',
    output_item = 'compound_exact'
)

df[,1:3]

## ----eval=FALSE---------------------------------------------------------------
# img = do_query(
#         context = 'compound',
#         input_item = 'regno',
#         input_value = '11',
#         output_item = 'png'
#       )
# 
# grid.raster(img)
# 

## -----------------------------------------------------------------------------
# valid contexts
names(context) # context, input_item or output_item

## -----------------------------------------------------------------------------
# valid inputs for "study" context
context_inputs('study')

## -----------------------------------------------------------------------------
df = do_query(
  context = 'study',
  input_item = 'ignored',
  input_value = 'ignored',
  output_item = 'untarg_studies'
)

df[1:3,1:3]

## -----------------------------------------------------------------------------
df = do_query(
  context = 'compound',
  input_item = 'regno',
  input_value = '11',
  output_item = 'compound_exact'
)

df[,1:3]

## -----------------------------------------------------------------------------
df = do_query(
  context = 'gene',
  input_item = 'gene_name',
  input_value = 'acetyl-CoA',
  output_item = 'gene_partial'
)

df[1:3,1:3]

## -----------------------------------------------------------------------------
SE = do_query(
    context = 'study',
    input_item = 'study_id',
    input_value = 'ST000001',
    output_item = 'SummarizedExperiment' # or 'DatasetExperiment'
)

SE


## -----------------------------------------------------------------------------
MAE = do_query(
    context = 'study',
    input_item = 'study_id',
    input_value = 'ST000009',
    output_item = 'MultiAssayExperiment' 
)

MAE

## ----eval=FALSE---------------------------------------------------------------
# SE = do_query(
#     context = 'study',
#     input_item = 'analysis_id',
#     input_value = 'AN000025',
#     output_item = 'untarg_SummarizedExperiment' # or 'untarg_DatasetExperiment'
# )
# 
# SE

## ----eval=TRUE,include=FALSE,echo=TRUE----------------------------------------
SE = metabolomicsWorkbenchR:::AN000025

## -----------------------------------------------------------------------------
# list all context names
names(metabolomicsWorkbenchR::context)

## -----------------------------------------------------------------------------
# list valid inputs/outputs for the "study" context
metabolomicsWorkbenchR::context$study

## -----------------------------------------------------------------------------
# input item "study_id" info
input_item$study_id

## -----------------------------------------------------------------------------
# output item 'summary' info
output_item$summary

## ----echo=FALSE---------------------------------------------------------------
sessionInfo()

## ----include=FALSE------------------------------------------------------------
end_vignette()

