# Code example from 'metadata' vignette. See references/ for full tutorial.

## ----setup, message = FALSE---------------------------------------------------
library(gemma.R)
library(dplyr)
library(pheatmap)
library(purrr)

## ----include = FALSE----------------------------------------------------------
options('gemma.memoised' = TRUE)

## ----include=FALSE,eval=FALSE-------------------------------------------------
# # finding a good example
# all_valid <-
#     get_result_sets(filter = "analysis.subsetFactorValue.characteristics.size > 0") %>%
#     get_all_pages()
# 
# # remove bugged ones, should be temporary until #50 is fixed
# contrasts_with_subsets <- all_valid[!all_valid$experimental.factors %>% sapply(is.null),]
# 
# 
# # find datasets where the experimental factor is marked by multiple statements
# contrasts_with_subsets <- contrasts_with_subsets[contrasts_with_subsets$experimental.factors %>% sapply(nrow) %>% {.>1},]
# 
# # find datasets where experimental factor is marked by multiple statements belonging to the same factor
# 
# contrasts_with_subsets$experimental.factors %>% sapply(function(x){
#     any(duplicated(x$ID))
#     }) %>% {contrasts_with_subsets[.,]} -> contrasts_with_subsets
# 
# # interaction
# contrasts_with_subsets = contrasts_with_subsets[grepl("_",contrasts_with_subsets$contrast.ID),]

## -----------------------------------------------------------------------------
get_dataset_annotations('GSE48962') %>%
    gemma_kable

## -----------------------------------------------------------------------------
samples <- get_dataset_samples('GSE48962')
samples$sample.factorValues[[
    which(samples$sample.name == "TSM490")
    ]] %>% 
    gemma_kable()

## ----include = FALSE----------------------------------------------------------

doubled_id <- samples$sample.factorValues[[
    which(samples$sample.name == "TSM490")
]] %>% filter(value == "R6/2") %>% # R6/2 is the mouse strain that contains the human HTT gene
    {.$ID} %>% unique


## -----------------------------------------------------------------------------
id <- samples$sample.factorValues[[
    which(samples$sample.name == "TSM490")
]] %>% filter(value == "R6/2") %>% {.$ID} %>% unique


# count how many patients has this phenotype
samples$sample.factorValues %>% sapply(\(x){
    id %in% x$ID
}) %>% sum


## -----------------------------------------------------------------------------
id <- samples$sample.factorValues[[
    which(samples$sample.name == "TSM490")
    ]] %>% 
    filter(value == "R6/2") %>% {.$factor.ID} %>% unique

samples$sample.factorValues %>% lapply(\(x){
    x %>% filter(factor.ID == id) %>% {.$summary}
}) %>% unlist %>% unique

## -----------------------------------------------------------------------------
design <- make_design(samples)
design[,-1] %>% head %>%  # first column is just a copy of the original factor values
    gemma_kable()

## -----------------------------------------------------------------------------
design %>%
    group_by(`organism part`,`developmental stage`,strain) %>% 
    summarize(n= n()) %>% 
    arrange(desc(n)) %>% 
    gemma_kable()


## -----------------------------------------------------------------------------
# removing columns containing factor values and URIs for brevity
remove_columns <- c('baseline.factors','experimental.factors','subsetFactor','factor.category.URI')

dea <- get_dataset_differential_expression_analyses("GSE48962")

dea[,.SD,.SDcols = !remove_columns] %>% 
    gemma_kable()

## -----------------------------------------------------------------------------
contrast <- dea %>% 
    filter(
        factor.category == "strain" & 
            subsetFactor %>% map_chr('value') %>% {.=='cerebral cortex'} # we will talk about subsets in a moment
        )

## -----------------------------------------------------------------------------
# removing URIs for brevity
uri_columns = c('category.URI',
                'object.URI',
                'value.URI',
                'predicate.URI',
                'factor.category.URI')

contrast$baseline.factors[[1]][,.SD,.SDcols = !uri_columns] %>% 
     gemma_kable()

contrast$experimental.factors[[1]][,.SD,.SDcols = !uri_columns] %>% 
     gemma_kable()

## -----------------------------------------------------------------------------
contrast <- dea %>% 
    filter(
        factor.category == "developmental stage,strain" & 
            subsetFactor %>% map_chr('value') %>% {.=='cerebral cortex'} # we're almost there!
        )

## -----------------------------------------------------------------------------
contrast$baseline.factors[[1]][,.SD,.SDcols = !uri_columns] %>% 
     gemma_kable()

contrast$experimental.factors[[1]][,.SD,.SDcols = !uri_columns] %>% 
     gemma_kable()

## -----------------------------------------------------------------------------
contrast$subsetFactor[[1]][,.SD,.SDcols = !uri_columns] %>%
     gemma_kable()

## -----------------------------------------------------------------------------
obj <-  get_dataset_object("GSE48962",resultSets = contrast$result.ID,contrasts = contrast$contrast.ID,type = 'list')
obj[[1]]$design[,-1] %>% 
    head %>% gemma_kable()

## -----------------------------------------------------------------------------
dif_vals <- get_differential_expression_values('GSE48962')
dif_vals[[as.character(contrast$result.ID)]] %>% head %>%  
     gemma_kable()

## -----------------------------------------------------------------------------
# getting the top 10 genes
top_genes <- dif_vals[[as.character(contrast$result.ID)]] %>% 
    arrange(across(paste0('contrast_',contrast$contrast.ID,'_pvalue'))) %>% 
    filter(GeneSymbol!='' | grepl("|",GeneSymbol,fixed = TRUE)) %>% # remove blank genes or probes with multiple genes
    {.[1:10,]}
top_genes %>% select(Probe,NCBIid,GeneSymbol) %>% 
     gemma_kable()

## -----------------------------------------------------------------------------
exp_subset<- obj[[1]]$exp %>% 
    filter(Probe %in% top_genes$Probe)
genes <- top_genes$GeneSymbol

# ordering design file
design <- obj[[1]]$design %>% arrange(strain,`developmental stage`)

# shorten the resistance label a bit
design$strain[grepl('R6/2',design$strain)] = "Huntington Model"

exp_subset[,.SD,.SDcols = rownames(design)] %>% t  %>% scale %>% t %>%
    pheatmap(cluster_rows = FALSE,cluster_cols = FALSE,labels_row = genes,
             annotation_col =design %>% select(strain,`developmental stage`))


## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

