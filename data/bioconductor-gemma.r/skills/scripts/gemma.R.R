# Code example from 'gemma.R' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
# Prevent certificate issues for GitHub actions
options(gemma.SSL = FALSE,gemma.memoised = TRUE)
# options(gemma.API = "https://dev.gemma.msl.ubc.ca/rest/v2/")
knitr::opts_chunk$set(
    comment = ""
)

## ----setup, message = FALSE---------------------------------------------------
library(gemma.R)
library(data.table)
library(dplyr)
library(ggplot2)
library(ggrepel)
library(SummarizedExperiment)
library(pheatmap)
library(viridis)
library(listviewer)

## ----include = FALSE----------------------------------------------------------
gemma.R:::setGemmaPath('prod')
forget_gemma_memoised() # to make sure local tests don't succeed because of history

## -----------------------------------------------------------------------------
# accessing all mouse and human datasets
get_datasets(taxa = c('mouse','human')) %>% 
    select(experiment.shortName, experiment.name, 
           experiment.description,taxon.name) %>%
    head %>% gemma_kable

# accessing human datasets with the word "bipolar"
get_datasets(query = 'bipolar',taxa = 'human') %>% 
    select(experiment.shortName, experiment.name, 
           experiment.description,taxon.name) %>%
    head %>% gemma_kable

# access human datasets that were annotated with the ontology term for the
# bipolar disorder
# use search_annotations function to search for available annotation terms
get_datasets(taxa ='human', 
             uris = 'http://purl.obolibrary.org/obo/MONDO_0004985') %>%
    select(experiment.shortName, experiment.name, 
           experiment.description,taxon.name) %>%
    head %>% gemma_kable

## -----------------------------------------------------------------------------
filter_properties()$dataset %>% head %>% gemma_kable()

## -----------------------------------------------------------------------------
# access human datasets that has bipolar disorder as an experimental factor
get_datasets(taxa = 'human',
             filter = "experimentalDesign.experimentalFactors.factorValues.characteristics.valueUri = http://purl.obolibrary.org/obo/MONDO_0004985")  %>%
    select(experiment.shortName, experiment.name, 
           experiment.description,taxon.name) %>%
    head %>% gemma_kable


## -----------------------------------------------------------------------------
# all datasets with more than 4 samples annotated for any disease
get_datasets(filter = 'bioAssayCount > 4 and allCharacteristics.category = disease') %>%
    select(experiment.shortName, experiment.name, 
           experiment.description,taxon.name) %>%
    head %>% gemma_kable

# all datasets with ontology terms for Alzheimer's disease and Parkinson's disease
# this is equivalent to using the uris parameter
get_datasets(filter = 'allCharacteristics.valueUri in (http://purl.obolibrary.org/obo/MONDO_0004975,http://purl.obolibrary.org/obo/MONDO_0005180
)')  %>%
    select(experiment.shortName, experiment.name, 
           experiment.description,taxon.name) %>%
    head %>% gemma_kable

## -----------------------------------------------------------------------------
get_datasets(taxa = 'human') %>% 
    get_all_pages() %>% 
    select(experiment.shortName, experiment.name, 
           experiment.description,taxon.name) %>%
    head %>% gemma_kable

## -----------------------------------------------------------------------------
get_datasets(taxa = 'human', filter = 'bioAssayCount > 4') %>% 
     filter(experiment.batchEffect !=-1) %>% 
    select(experiment.shortName, experiment.name, 
           experiment.description,taxon.name) %>%
    head %>% gemma_kable

## -----------------------------------------------------------------------------
search_annotations('bipolar') %>% 
    head %>% gemma_kable()

## ----dataset------------------------------------------------------------------
get_datasets_by_ids("GSE46416") %>%
    select(experiment.shortName, experiment.name, 
           experiment.description,taxon.name) %>%
    head %>% gemma_kable

## ----load-expression, eval = TRUE---------------------------------------------
dat <- get_dataset_object("GSE46416",
                          type = 'se') # SummarizedExperiment is the default output type

## -----------------------------------------------------------------------------
# Check the levels of the disease factor
dat[[1]]$disease %>% unique()

# Subset patients during manic phase and controls
manic <- dat[[1]][, dat[[1]]$disease == "bipolar disorder with manic phase" | 
        dat[[1]]$disease == "reference subject role"]
manic

## ----boxplot, fig.cap="Sample to sample correlations of bipolar patients during manic phase and controls."----
# Get Expression matrix
manicExpr <- assay(manic, "counts")


manicExpr %>% 
    cor %>% 
    pheatmap(col =viridis(10),border_color = NA,angle_col = 45,fontsize = 7)

## -----------------------------------------------------------------------------
get_dataset_samples('GSE46416') %>% make_design('text') %>% select(-factorValues) %>%  head %>%
    gemma_kable()

## -----------------------------------------------------------------------------
head(get_platform_annotations('GPL96') %>% select(-GOTerms))

## -----------------------------------------------------------------------------
head(get_platform_annotations('Generic_human_ncbiIds') %>% select(-GOTerms))

## -----------------------------------------------------------------------------
# lists genes in gemma matching the symbol or identifier
get_genes('Eno2') %>% gemma_kable()

# ncbi id for human ENO2
probes <- get_gene_probes(2026)

# remove the description for brevity of output
head(probes[,.SD, .SDcols = !colnames(probes) %in% c('mapping.Description','platform.Description')]) %>%
    gemma_kable()


## -----------------------------------------------------------------------------
dif_exp <- get_differential_expression_values('GSE46416')
dif_exp[[1]] %>% head %>% gemma_kable()

## -----------------------------------------------------------------------------
contrasts <- get_dataset_differential_expression_analyses('GSE46416')
contrasts %>% gemma_kable()

## -----------------------------------------------------------------------------
# using result.ID and contrast.ID of the output above, we can access specific
# results. Note that one study may have multiple contrast objects
seq_len(nrow(contrasts)) %>% sapply(function(i){
    result_set = dif_exp[[as.character(contrasts[i,]$result.ID)]]
    p_values = result_set[[glue::glue("contrast_{contrasts[i,]$contrast.ID}_pvalue")]]
    
    # multiple testing correction
    sum(p.adjust(p_values,method = 'BH') < 0.05)
}) -> dif_exp_genes

contrasts <- data.table(result.ID = contrasts$result.ID,
                        contrast.id = contrasts$contrast.ID,
                        baseline.factorValue = contrasts$baseline.factors,
                        experimental.factorValue = contrasts$experimental.factors,
                        n_diff = dif_exp_genes)

contrasts %>% gemma_kable()


contrasts$baseline.factors

contrasts$experimental.factors

## ----diffExpr, fig.cap="Differentially-expressed genes in bipolar patients during manic phase versus controls.", fig.wide=TRUE, warning = FALSE----
de <- get_differential_expression_values("GSE46416",readableContrasts = TRUE)[[1]]
de %>% head %>% gemma_kable

# Classify probes for plotting
de$diffexpr <- "No"
de$diffexpr[de$`contrast_bipolar disorder with manic phase_logFoldChange` > 1.0 & 
        de$`contrast_bipolar disorder with manic phase_pvalue` < 0.05] <- "Up"
de$diffexpr[de$`contrast_bipolar disorder with manic phase_logFoldChange` < -1.0 & 
        de$`contrast_bipolar disorder with manic phase_pvalue` < 0.05] <- "Down"

# Upregulated probes
filter(de, diffexpr == "Up") %>%
    arrange(`contrast_bipolar disorder with manic phase_pvalue`) %>%
    select(Probe, GeneSymbol, `contrast_bipolar disorder with manic phase_pvalue`, 
        `contrast_bipolar disorder with manic phase_logFoldChange`) %>%
    head(10) %>% gemma_kable()

# Downregulated probes
filter(de, diffexpr == "Down") %>%
    arrange(`contrast_bipolar disorder with manic phase_pvalue`) %>%
    select(Probe, GeneSymbol, `contrast_bipolar disorder with manic phase_pvalue`, 
        `contrast_bipolar disorder with manic phase_logFoldChange`) %>%
    head(10) %>% gemma_kable()

# Add gene symbols as labels to DE genes
de$delabel <- ""
de$delabel[de$diffexpr != "No"] <- de$GeneSymbol[de$diffexpr != "No"]

# Volcano plot for bipolar patients vs controls
ggplot(
    data = de,
    aes(
        x = `contrast_bipolar disorder with manic phase_logFoldChange`,
        y = -log10(`contrast_bipolar disorder with manic phase_pvalue`),
        color = diffexpr,
        label = delabel
    )
) +
    geom_point() +
    geom_hline(yintercept = -log10(0.05), col = "gray45", linetype = "dashed") +
    geom_vline(xintercept = c(-1.0, 1.0), col = "gray45", linetype = "dashed") +
    labs(x = "log2(FoldChange)", y = "-log10(p-value)") +
    scale_color_manual(values = c("blue", "black", "red")) +
    geom_text_repel(show.legend = FALSE) +
    theme_minimal()

## -----------------------------------------------------------------------------
get_platforms_by_ids() %>% 
    get_all_pages() %>% head %>% gemma_kable()

## -----------------------------------------------------------------------------
platform_count = attributes(get_platforms_by_ids(limit = 1))$totalElements
print(platform_count)

## -----------------------------------------------------------------------------
lapply(seq(0,platform_count,100), function(offset){
    get_platforms_by_ids(limit = 100, offset = offset) %>%
        select(platform.ID, platform.shortName, taxon.name)
}) %>% do.call(rbind,.) %>% 
    head %>% gemma_kable()

## ----error, error = TRUE------------------------------------------------------
try({
get_dataset_annotations(c("GSE35974", "GSE46416"))
})

## ----loop---------------------------------------------------------------------
lapply(c("GSE35974", "GSE12649"), function(dataset) {
    get_dataset_annotations(dataset) %>% 
        mutate(experiment.shortName = dataset) %>%
        select(experiment.shortName, class.name, term.name)
}) %>% do.call(rbind,.) %>% gemma_kable()

## -----------------------------------------------------------------------------
get_gene_locations("DYRK1A") %>% gemma_kable()

get_gene_locations("DYRK1A", raw = TRUE) %>% jsonedit()

## ----eval=FALSE---------------------------------------------------------------
# # use memoisation by default using the default cache
# gemma_memoised(TRUE)
# 
# # set an altnernate cache path
# gemma_memoised(TRUE,"path/to/cache_directory")
# 
# # cache in memory of the R session
# # this cache will not be preserved between sessions
# gemma_memoised(TRUE,"cache_in_memory")
# 
# 

## ----defaults, eval = FALSE---------------------------------------------------
# options(gemma.memoised = TRUE) # always refer to cache. this is redundant with gemma_memoised function
# options(gemma.overwrite = TRUE) # always overwrite when saving files
# options(gemma.raw = TRUE) # always receive results as-is from Gemma

## ----include = FALSE----------------------------------------------------------
options(gemma.memoised = FALSE)
options(gemma.raw = FALSE)


## -----------------------------------------------------------------------------
sessionInfo()

