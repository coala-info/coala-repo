# Code example from 'metanalysis' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
# Prevent certificate issues for GitHub actions
options(gemma.SSL = FALSE,
        datatable.print.trunc.cols = FALSE)

# temporary options
# options(gemma.API = "https://dev.gemma.msl.ubc.ca/rest/v2/")
# options(gemma.memoised = TRUE)

knitr::opts_chunk$set(
    comment = "",
    cache = FALSE
)

## ----setup, message = FALSE---------------------------------------------------
library(gemma.R)
library(dplyr)
library(poolr)
library(ggplot2)
library(stringr)

## ----include = FALSE----------------------------------------------------------
gemma.R:::setGemmaPath('prod')

## -----------------------------------------------------------------------------
annots <- search_annotations("parkinson's")
annots %>% head %>% gemma_kable()

## -----------------------------------------------------------------------------
annot_counts <- annots$value.URI %>% sapply(\(x){
    attributes(get_datasets(uris = x))$totalElements
})

annots$counts = annot_counts

annots %>% filter(counts>0) %>%
    arrange(desc(counts)) %>% gemma_kable()


## -----------------------------------------------------------------------------
filter_properties()$dataset %>% head %>% gemma_kable

## -----------------------------------------------------------------------------
# getting all resulting datasets using limit and offset arguments
results <- get_datasets(filter = "allCharacteristics.valueUri = http://purl.obolibrary.org/obo/MONDO_0005180 and allCharacteristics.valueUri = http://purl.obolibrary.org/obo/UBERON_0000955",
                       taxa ='human') %>% get_all_pages()



results %>% select(experiment.shortName,experiment.name) %>% head

## -----------------------------------------------------------------------------
results <- results %>% filter(experiment.batchEffect == 1)

## -----------------------------------------------------------------------------
experiment_contrasts <- results$experiment.shortName %>% 
    lapply(function(x){
        out = get_dataset_differential_expression_analyses(x)
        }) %>% do.call(rbind,.)


## -----------------------------------------------------------------------------
parkin_contrasts <- experiment_contrasts %>% 
    filter(factor.category == 'disease') %>% 
    filter(sapply(experimental.factors,function(x){
        "http://purl.obolibrary.org/obo/MONDO_0005180" %in% x$value.URI
        }) &
           sapply(baseline.factors,function(x){
               "http://purl.obolibrary.org/obo/OBI_0000220" %in% x$value.URI
               }))


## -----------------------------------------------------------------------------
dup_exp <- parkin_contrasts$experiment.ID %>% 
    table %>% {.[.>1]} %>% names

dup_exp


parkin_contrasts %>% filter(experiment.ID %in%  dup_exp)

## -----------------------------------------------------------------------------
parkin_contrasts %>% filter(experiment.ID %in%  dup_exp) %>% {.$subsetFactor}

## -----------------------------------------------------------------------------
# We are using the first 5 contrasts to keep this analysis short
# sanity_sets = c('GSE8397','GSE7621','GSE20168','GSE20291','GSE20292')
# sanity_ids = results %>% filter(experiment.Accession %in% sanity_sets) %>%  .$experiment.ID

# parkin_contrasts <- parkin_contrasts %>% filter(experiment.ID %in% sanity_ids)
# parkin_contrasts <- parkin_contrasts[1:10,]

## -----------------------------------------------------------------------------
differentials <- parkin_contrasts$result.ID %>% lapply(function(x){
    # take the first and only element of the output. the function returns a list 
    # because single experiments may have multiple resultSets. Here we use the 
    # resultSet argument to directly access the results we need
    get_differential_expression_values(resultSets = x)[[1]]
})

# some datasets might not have all the advertised differential expression results
# calculated due to a variety of factors. here we remove the empty differentials
missing_contrasts <- differentials %>% sapply(nrow) %>% {.==0}
differentials <- differentials[!missing_contrasts]
parkin_contrasts <- parkin_contrasts[!missing_contrasts,]

## -----------------------------------------------------------------------------

condition_diffs <- seq_along(differentials) %>% lapply(function(i){
    # iterate over the differentials
    diff = differentials[[i]]
    # get the contrast information about the differential
    contrast = parkin_contrasts[i,]
    p_vals = diff[[paste0('contrast_',contrast$contrast.ID,"_pvalue")]]
    log2fc = diff[[paste0('contrast_',contrast$contrast.ID,"_log2fc")]]
    genes = diff$GeneSymbol
    
    data.frame(genes,p_vals,log2fc)
})

# we can use result.IDs and contrast.IDs to uniquely name this. 
# we add the experiment.id for readability
names(condition_diffs) = paste0(parkin_contrasts$experiment.ID,'.',
                                parkin_contrasts$result.ID,'.',
                                parkin_contrasts$contrast.ID)

condition_diffs[[1]] %>% head

## -----------------------------------------------------------------------------
all_genes <- condition_diffs %>% lapply(function(x){
    x$genes %>% unique
}) %>% unlist %>% table

# we will remove any gene that doesn't appear in all of the results
# while this criteria is too strict, it does help this example to run 
# considerably faster
all_genes <- all_genes[all_genes==max(all_genes)]
all_genes <- names(all_genes)

# remove any probesets matching multiple genes. gemma separates these by using "|"
all_genes <- all_genes[!grepl("|",all_genes,fixed = TRUE)]

# remove the "". This comes from probesets not aligned to any genes
all_genes <- all_genes[all_genes != ""]
all_genes %>% head

## ----eval = FALSE-------------------------------------------------------------
# fisher_results <- all_genes %>% lapply(function(x){
#     p_vals <- condition_diffs %>% sapply(function(y){
#         # we will resolve multiple probesets by taking the minimum p value for
#         # this example
#         out = y[y$genes == x,]$p_vals
#         if(length(out) == 0 ||all(is.na(out))){
#             return(NA)
#         } else{
#             return(min(out))
#         }
#     })
# 
#     fold_changes <- condition_diffs %>% sapply(function(y){
#         pv = y[y$genes == x,]$p_vals
#         if(length(pv) == 0 ||all(is.na(pv))){
#             return(NA)
#         } else{
#             return(y[y$genes == x,]$log2fc[which.min(pv)])
#         }
#     })
# 
#     median_fc = fold_changes %>% na.omit() %>% median
#     names(median_fc) = 'Median FC'
# 
#     combined = p_vals %>% na.omit() %>% fisher() %>% {.$p}
#     names(combined) = 'Combined'
#     c(p_vals,combined,median_fc)
# }) %>% do.call(rbind,.)
# fisher_results <- as.data.frame(fisher_results)
# rownames(fisher_results) = all_genes
# 
# fisher_results[,'Adjusted'] <- p.adjust(fisher_results[,'Combined'],
#                                         method = 'fdr')
# 
# fisher_results %>%
#     arrange(Adjusted) %>%
#     select(Combined,Adjusted,`Median FC`) %>%
#     head

## ----fisher, include = FALSE--------------------------------------------------
library(parallel)
cores = detectCores()
if (Sys.info()['sysname'] == 'Windows'){
    cores = 1
}

fisher_results <- all_genes %>% mclapply(function(x){
    p_vals <- condition_diffs %>% sapply(function(y){
        # we will resolve multiple probesets by taking the minimum p value for
        # this example
        out = y[y$genes == x,]$p_vals
        if(length(out) == 0 ||all(is.na(out))){
            return(NA)
        } else{
            return(min(out))
        }
    })
    
    fold_changes <- condition_diffs %>% sapply(function(y){
        pv = y[y$genes == x,]$p_vals
        if(length(pv) == 0 ||all(is.na(pv))){
            return(NA)
        } else{
            return(y[y$genes == x,]$log2fc[which.min(pv)])
        }
    })
    
    median_fc = fold_changes %>% na.omit() %>% median
    names(median_fc) = 'Median FC'
    
    combined = p_vals %>% na.omit() %>% fisher() %>% {.$p}
    names(combined) = 'Combined'
    c(p_vals,combined,median_fc)
},mc.cores = ceiling(cores/2)) %>% do.call(rbind,.)
fisher_results <- as.data.frame(fisher_results)
rownames(fisher_results) = all_genes

fisher_results[,'Adjusted'] <- p.adjust(fisher_results[,'Combined'],
                                        method = 'fdr')

fisher_results %>%
    arrange(Adjusted) %>% 
    select(Combined,Adjusted,`Median FC`) %>% 
    head

## -----------------------------------------------------------------------------
sum(fisher_results$Adjusted<0.05) # FDR<0.05
nrow(fisher_results) # number of all genes

## -----------------------------------------------------------------------------
# markers are taken from https://www.eneuro.org/content/4/6/ENEURO.0212-17.2017
dopa_markers <-  c("ADCYAP1", "ATP2B2", "CACNA2D2", 
"CADPS2", "CALB2", "CD200", "CDK5R2", "CELF4", "CHGA", "CHGB", 
"CHRNA6", "CLSTN2", "CNTNAP2", "CPLX1", "CYB561", "DLK1", "DPP6", 
"ELAVL2", "ENO2", "GABRG2", "GRB10", "GRIA3", "KCNAB2", "KLHL1", 
"LIN7B", "MAPK8IP2", "NAPB", "NR4A2", "NRIP3", "HMP19", "NTNG1", 
"PCBP3", "PCSK1", "PRKCG", "RESP18", "RET", "RGS8", "RNF157", 
"SCG2", "SCN1A", "SLC12A5", "SLC4A10", "SLC6A17", "SLC6A3", "SMS", 
"SNCG", "SPINT2", "SPOCK1", "SYP", "SYT4", "TACR3", "TENM1", 
"TH", "USP29")

fisher_results %>% 
    arrange(Combined) %>% 
    rownames %>%
    {.%in% dopa_markers} %>%
    which %>% 
    hist(breaks=20, main = 'Rank distribution of dopaminergic markers')

## -----------------------------------------------------------------------------
# the top gene from our results
gene <- fisher_results %>% arrange(Adjusted) %>% .[1,] %>% rownames

p_values <- fisher_results %>%
    arrange(Adjusted) %>% 
    .[1,] %>% 
    select(-Combined,-`Median FC`,-Adjusted) %>% 
    unlist %>%
    na.omit()

#sum(p_values<0.05)
#length(p_values)

# p values of the result in individual studies
p_values %>% log10() %>% 
    data.frame(`log p value` = .,dataset = 1:length(.),check.names = FALSE) %>% 
    ggplot(aes(y = `log p value`,x = dataset)) +
    geom_point() + 
    geom_hline(yintercept = log10(0.05),color = 'firebrick') + 
    geom_text(y = log10(0.05), x = 0, label = 'p < 0.05',vjust =-1,hjust = -0.1) + 
    theme_bw() + ggtitle(paste("P-values for top gene (", gene, ") in the data sets")) +
    theme(axis.text.x = element_blank())

## -----------------------------------------------------------------------------


# we need the NCBI id of the gene in question, lets get that from the original
# results
NCBIid <- differentials[[1]] %>% filter(GeneSymbol == gene) %>% .$NCBIid %>% unique
#NCBIid


expression_frame <- get_dataset_object(datasets = parkin_contrasts$experiment.ID,
                                       resultSets = parkin_contrasts$result.ID,
                                       contrasts = parkin_contrasts$contrast.ID,
                                       genes = NCBIid,type = 'tidy',consolidate = 'pickvar')

# get the contrast names for significance markers 
signif_contrasts <- which(p_values < 0.05) %>% names

## -----------------------------------------------------------------------------
expression_frame <- expression_frame %>%
    filter(!is.na(expression)) %>% 
    # add a column to represent the contrast 
    dplyr::mutate(contrasts = paste0(experiment.ID,'.',
                                    result.ID,'.',
                                    contrast.ID)) %>%
    # simplify the labels
    dplyr::mutate(disease = ifelse(disease == 'reference subject role','Control','PD'))

# for adding human readable labels on the plot
labeller <- function(x){
    x %>% mutate(contrasts = contrasts %>% 
                     strsplit('.',fixed = TRUE) %>%
                     purrr::map_chr(1) %>%
                     {expression_frame$experiment.shortName[match(.,expression_frame$experiment.ID)]})
}

# pass it all to ggplot
expression_frame %>% 
    ggplot(aes(x = disease,y = expression)) + 
    facet_wrap(~contrasts,scales = 'free',labeller = labeller) + 
    theme_bw() + 
    geom_boxplot(width = 0.5) + 
    geom_point() + ggtitle(paste("Expression of", gene, " per study")) + 
    geom_text(data = data.frame(contrasts = signif_contrasts,
                             expression_frame %>%
                             group_by(contrasts) %>%
                             summarise(expression = max(expression)) %>%
                             .[match(signif_contrasts,.$contrasts),]),
              x = 1.5, label = '*',size=5,vjust= 1)


## -----------------------------------------------------------------------------
sessionInfo()

