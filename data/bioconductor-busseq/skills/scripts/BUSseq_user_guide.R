# Code example from 'BUSseq_user_guide' vignette. See references/ for full tutorial.

## ----style-knitr, eval=TRUE, echo=FALSE, results="asis"--------------------
BiocStyle::latex()

## ----data_preparation1-----------------------------------------------------
library(BUSseq)
library(SingleCellExperiment)

#Input data is should be a SingleCellExperiment object or a list
CountData <- assay(BUSseqfits_example, "counts")
batch_ind <- unlist(colData(BUSseqfits_example))

# Construct a SingleCellExperiment object with colData as batch indicators 
sce_input <- SingleCellExperiment(assays = list(counts = CountData),
                          colData = DataFrame(Batch_ind = factor(batch_ind)))

# Or, construct a list with each element represents the count data matrix 
# of a batch
num_cell_batch <- table(batch_ind)
list_input <- list(Batch1 = CountData[,1:num_cell_batch[1]], 
              Batch2 = CountData[,1:num_cell_batch[2] + num_cell_batch[1]])

# Cell numbers within each batch
print(num_cell_batch)

#Peek at the read counts
print(CountData[1:5,1:5])

## ----BUSgibbs--------------------------------------------------------------
# Conduct MCMC sampling and posterior inference for BUSseq model
BUSseqfits_res <- BUSseq_MCMC(ObservedData = sce_input, 
                          seed = 1234, n.cores = 2,
                          n.celltypes = 4, n.iterations = 500)

## ----BUSseq_output---------------------------------------------------------
  # The output is a SingleCellExperiment object
  class(BUSseqfits_res)
  
  # Peek at the output
  BUSseqfits_res
  

## ----Output_extract--------------------------------------------------------
    # Extract the imputed read counts
    Imputed_count <- assay(BUSseqfits_res, "imputed_data")

## ----Celltypes-------------------------------------------------------------
  celltyes_est <- celltypes(BUSseqfits_res)

## ----BatchEffects----------------------------------------------------------
  location_batch_effects_est <- location_batch_effects(BUSseqfits_res)
  head(location_batch_effects_est)
  
  overdispersion_est <- overdispersions(BUSseqfits_res)
  head(overdispersion_est)

## ----CellEffects-----------------------------------------------------------
  cell_effects_est <- cell_effect_values(BUSseqfits_res)
  head(cell_effects_est)

## ----CelltypeEffects-------------------------------------------------------
  celltype_mean_expression_est <- celltype_mean_expression(BUSseqfits_example)
  head(celltype_mean_expression_est)
  
  celltype_effects_est <- celltype_effects(BUSseqfits_res)
  head(celltype_effects_est)

## ----IG--------------------------------------------------------------------
  #obtain the intrinsic gene indicators
  intrinsic_gene_indicators <- intrinsic_genes_BUSseq(BUSseqfits_res)
  print(intrinsic_gene_indicators)
  
  #The estimated FDR, the first 240 genes are known as intrinsic 
  #genes in the simulation setting.
  index_intri <- which(unlist(intrinsic_gene_indicators) == "Yes")
  false_discovery_ind <- !(index_intri %in% 1:240)
  fdr_est <- sum(false_discovery_ind)/length(index_intri)
  print(fdr_est)

## ----adjusted--------------------------------------------------------------
  # Obtain the corrected read count data
  BUSseqfits_res <- corrected_read_counts(BUSseqfits_res)
  
  # An new assay "corrected_data" is incorporated
  BUSseqfits_res

## ----visualize1------------------------------------------------------------
  #generate the heatmap of raw read count data
  heatmap_data_BUSseq(BUSseqfits_res, data_type = "Raw", 
                          project_name = "BUSseq_raw_allgenes",
                          image_dir = "./heatmap")
  
  #display only the first 100 genes in the heatmap
  heatmap_data_BUSseq(BUSseqfits_res, data_type = "Raw", 
                          gene_set = 1:100,
                          project_name = "BUSseq_raw_100genes",
                          image_dir = "./heatmap")

## ----visualize2------------------------------------------------------------
  #generate the heatmap of imputed read count data
  heatmap_data_BUSseq(BUSseqfits_res, data_type = "Imputed", 
                          project_name = "BUSseq_imputed_allgenes",
                          image_dir = "./heatmap")
  #generate the heatmap of corrected read count data
  heatmap_data_BUSseq(BUSseqfits_res, data_type = "Corrected",
                          project_name = "BUSseq_corrected_allgenes",
                          image_dir = "./heatmap")

## ----visualize3------------------------------------------------------------
#Only show the identified intrinsic genes
heatmap_data_BUSseq(BUSseqfits_res, data_type = "Corrected",
                gene_set = index_intri,
                project_name = "BUSseq_corrected_intrinsic_genes",
                image_dir = "./heatmap")

## ----RSession--------------------------------------------------------------
  sessionInfo()

