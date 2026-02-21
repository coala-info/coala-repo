# Code example from 'PubScore_vignette' vignette. See references/ for full tutorial.

## ----setup, include = TRUE----------------------------------------------------
library(knitr)
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----Initialization-----------------------------------------------------------
library(PubScore)
# list of genes :
selected_genes <- c('CD79A', 'CD14', 'NKG7', 'CST3', 'AIF1')

# These genes were selected from a panel containing the following genes
total_genes <- c('CD79A', 'CD14', 'NKG7', 'CST3', 'AIF1', 'FOXA1', 'PPT2', 'ZFP36L1','AFF4', 'ANTXR2', "HDAC8", "VKORC1" )

terms_of_interest <- c("B cells", "macrophages", "NK cells")

## ----Creating PubScore Object-------------------------------------------------
pub <- pubscore(terms_of_interest = terms_of_interest, genes = selected_genes )
print(getScore(pub))

## ----Testing the Pubscore Object----------------------------------------------
pub <- test_score(pub, total_genes =  total_genes)


## ----Heatmap Visualization----------------------------------------------------
p <- heatmapViz(pub)
library(plotly)
ggplotly(p)

## ----Netowrk Visualization----------------------------------------------------
p <- networkViz(pub)
plot(p)

## ----messages = FALSE---------------------------------------------------------
library("FCBF")
library('SingleCellExperiment')
# load expression data
data(scDengue)

## ----Running FCBF-------------------------------------------------------------
infection <- SummarizedExperiment::colData(scDengue)
target <- infection$infection

exprs <- as.data.frame(SummarizedExperiment::assay(scDengue,'logcounts'))
discrete_expression <- as.data.frame(FCBF::discretize_exprs(exprs))

fcbf_features <- fcbf(discrete_expression, target, thresh = 0.05, verbose = FALSE)
total_features <- rownames(exprs)
head(fcbf_features)

## ----Running biomaRt----------------------------------------------------------
library(biomaRt)

ensembl = useMart("ensembl",dataset="hsapiens_gene_ensembl")
reference = biomaRt::getBM(attributes = c('ensembl_gene_id', 'hgnc_symbol'), 
              mart = ensembl)

total_genes <- reference[reference$ensembl_gene_id %in% total_features,]$hgnc_symbol

fcbf_genes<- reference[reference$ensembl_gene_id %in% rownames(fcbf_features),]$hgnc_symbol

## -----------------------------------------------------------------------------
total_genes <- total_genes[total_genes != ""]
fcbf_genes <- fcbf_genes[fcbf_genes != ""]

## -----------------------------------------------------------------------------
terms_of_interest <- c('Dengue')

pub <- pubscore(terms_of_interest = terms_of_interest, genes = fcbf_genes )
print(getScore(pub))

p_map <- heatmapViz(pub)
library(plotly)
ggplotly(p_map)

p_net <- networkViz(pub)
plot(p_net)

## -----------------------------------------------------------------------------

#' pub <- test_score(pub, total_genes = total_genes)
#' all_counts <- get_all_counts(pub)
#' save(all_counts, file= '../data/all_counts.RData')
data("all_counts")
set_all_counts(pub) <- all_counts

## -----------------------------------------------------------------------------

# A table with all possible combinations is generated
simulation_of_literature_null <- get_all_counts(pub)

# Then, a number of genes equal to your original list is picked
# and, from this list, we get a score.
# This process is repeated 10 thousand times.

      message('Running 10000 simulations')
      distribution_of_scores <- c()
      for (i in seq_len(10000)){
        
        genes_to_sample_now <- sample(total_genes, 62)
        
        simu_now <- simulation_of_literature_null[simulation_of_literature_null$Genes %in% genes_to_sample_now,]$count
        
        #the list score is made by the sum of all scores divided by the number of combinations (62 genes x 1 term)
        list_score <- sum(simu_now) / (62 * 1)
        distribution_of_scores <- c(distribution_of_scores,list_score )
        
      }
      
    distribution_of_scores<- data.frame(d = distribution_of_scores)
    
    # The score to compare is the one of the original list  
    score <- getScore(pub)
      
    # Then you ask: how many of the null simulations had a score
    # as high as the one of the original list?
    # This is the simulated p-value!

    pvalue <-sum(distribution_of_scores[,1] >= score)/length(distribution_of_scores[,1])
    
    
    print('The p-value by simulation is:')
    print(pvalue) 
      

## -----------------------------------------------------------------------------
all_counts <- get_all_counts(pub)
head(all_counts$Genes[order(all_counts$count, decreasing = TRUE)], 10)

## -----------------------------------------------------------------------------

pub <- test_score(pub, remove_ambiguous = TRUE, nsim = 10000)

## -----------------------------------------------------------------------------
retested_literature_object <- test_score(pub, remove_ambiguous = TRUE,
                                                      ambiguous_terms = 
                                                      c("PC", "JUN", "IMPACT"), nsim = 10000)


