# Code example from 'MethReg' vignette. See references/ for full tutorial.

## ----settings, include = FALSE--------------------------------------------------------------------
options(width = 100)
knitr::opts_chunk$set(collapse = TRUE, comment = "#>",class.source = "whiteCode")
library(dplyr)

## ----sesame, include = FALSE, eval = TRUE---------------------------------------------------------
library(sesameData)

## ----eval = FALSE---------------------------------------------------------------------------------
# if (!"BiocManager" %in% rownames(installed.packages()))
#      install.packages("BiocManager")
# BiocManager::install("MethReg", dependencies = TRUE)

## ----setup, eval = TRUE---------------------------------------------------------------------------
library(MethReg)

## ----workflow, fig.cap = "Figure 2 Workflow of MethReg. Data - MethReg required inputs are: (1) array-based DNA methylation data (HM450/EPIC) with beta-values, (2) RNA-seq data with normalized counts, (3) estimated TF activities from the RNA-seq data using GSVA or VIPER  software. Creating triplets – there are multiple ways to create a CpG-TF-target gene triplet: (1) CpGs can be mapped to human TFs by using TF motifs from databases such as JASPAR or ReMap and scanning the CpGs region to identify if there is a binding site (2) CpG can be mapped to target genes using a distance-based approach, CpGs will be linked to a gene if it is on promoter region (+-1K bp away from the TSS), for a distal CpG it can be linked to either all genes within a fixed width (i.e. 500k bp), or a fixed number of genes upstream and downstream of the CpG location (3) TF-target genes can be retrieved from external databases (i.e. Cistrome Cancer; Dorothea). Using two different pairs (i.e. CpG-TF, TF-target gene), triplets can then be created. Analysis – each triplet will be evaluated using a robust linear model in which TF activity is estimated from GSVA/Viper software and DNAm.group is a binary variable used to model if the sample CpG belongs to the top 25% methylation levels or the lowest 25% methylation levels. Results – MethReg will output the prioritized triplets and classify both the TF role on the gene expression (repressor or activator) and the DNAm effect on the TF activity (Enhancing or attenuating).", echo = FALSE, fig.width = 13----
png::readPNG("workflow_methReg.png") %>% grid::grid.raster()

## ----warning=FALSE--------------------------------------------------------------------------------
data("dna.met.chr21")

## -------------------------------------------------------------------------------------------------
dna.met.chr21[1:5,1:5]

## -------------------------------------------------------------------------------------------------
dna.met.chr21.se <- make_dnam_se(
  dnam = dna.met.chr21,
  genome = "hg38",
  arrayType = "450k",
  betaToM = FALSE, # transform beta to m-values 
  verbose = FALSE # hide informative messages
)

## -------------------------------------------------------------------------------------------------
dna.met.chr21.se
SummarizedExperiment::rowRanges(dna.met.chr21.se)[1:4,1:4]

## -------------------------------------------------------------------------------------------------
data("gene.exp.chr21.log2")
gene.exp.chr21.log2[1:5,1:5]

## -------------------------------------------------------------------------------------------------
gene.exp.chr21.se <- make_exp_se(
  exp = gene.exp.chr21.log2,
  genome = "hg38",
  verbose = FALSE
)
gene.exp.chr21.se
SummarizedExperiment::rowRanges(gene.exp.chr21.se)[1:5,]

## ----plot, fig.cap = "Different target linking strategies", echo = FALSE--------------------------
png::readPNG("mapping_target_strategies.png") %>% grid::grid.raster()

## ----message = FALSE, results = "hide"------------------------------------------------------------
triplet.promoter <- create_triplet_distance_based(
  region = dna.met.chr21.se,
  target.method = "genes.promoter.overlap",
  genome = "hg38",
  target.promoter.upstream.dist.tss = 2000,
  target.promoter.downstream.dist.tss = 2000,
  motif.search.window.size = 400,
  motif.search.p.cutoff  = 1e-08,
  cores = 1  
)

## ----message = FALSE, results = "hide"------------------------------------------------------------
# Map probes to genes within 500kb window
triplet.distal.window <- create_triplet_distance_based(
  region = dna.met.chr21.se,
    genome = "hg38", 
    target.method = "window",
    target.window.size = 500 * 10^3,
    target.rm.promoter.regions.from.distal.linking = TRUE,
    motif.search.window.size = 500,
    motif.search.p.cutoff  = 1e-08,
    cores = 1
)

## ----message = FALSE, results = "hide"------------------------------------------------------------
# Map probes to 5 genes upstream and 5 downstream
triplet.distal.nearby.genes <- create_triplet_distance_based(
  region = dna.met.chr21.se,
    genome = "hg38", 
    target.method = "nearby.genes",
    target.num.flanking.genes = 5,
    target.window.size = 500 * 10^3,
    target.rm.promoter.regions.from.distal.linking = TRUE,
    motif.search.window.size = 400,
    motif.search.p.cutoff  = 1e-08,
    cores = 1  
)

## ----eval = FALSE---------------------------------------------------------------------------------
# if (!"BiocManager" %in% rownames(installed.packages()))
#      install.packages("BiocManager")
# BiocManager::install("remap-cisreg/ReMapEnrich", dependencies = TRUE)

## ----eval = FALSE---------------------------------------------------------------------------------
# library(ReMapEnrich)
# remapCatalog2018hg38 <- downloadRemapCatalog("/tmp/", assembly = "hg38")
# remapCatalog <- bedToGranges(remapCatalog2018hg38)

## ----eval = FALSE---------------------------------------------------------------------------------
# #-------------------------------------------------------------------------------
# # Triplets promoter using remap
# #-------------------------------------------------------------------------------
# triplet.promoter.remap <- create_triplet_distance_based(
#   region = dna.met.chr21.se,
#   genome = "hg19",
#   target.method =  "genes.promoter.overlap",
#   TF.peaks.gr = remapCatalog,
#   motif.search.window.size = 400,
#   max.distance.region.target = 10^6,
# )

## ----eval = FALSE---------------------------------------------------------------------------------
# if (!"BiocManager" %in% rownames(installed.packages()))
#      install.packages("BiocManager")
# BiocManager::install("dorothea", dependencies = TRUE)

## -------------------------------------------------------------------------------------------------
regulons.dorothea <- dorothea::dorothea_hs
regulons.dorothea %>% head

## -------------------------------------------------------------------------------------------------
rnaseq.tf.es <- get_tf_ES(
  exp = gene.exp.chr21.se %>% SummarizedExperiment::assay(),
  regulons = regulons.dorothea
)

## ----message = FALSE, results = "hide"------------------------------------------------------------
  triplet.regulon <- create_triplet_regulon_based(
    region = dna.met.chr21.se,
    genome = "hg38",  
    motif.search.window.size = 400,
    tf.target = regulons.dorothea,
    max.distance.region.target = 10^6 # 1Mbp
  ) 

## -------------------------------------------------------------------------------------------------
triplet.regulon %>% head

## -------------------------------------------------------------------------------------------------
str(triplet.promoter)
triplet.promoter$distance_region_target_tss %>% range
triplet.promoter %>% head

## ----interaction_model, message = FALSE, results = "hide", eval = TRUE----------------------------
results.interaction.model <- interaction_model(
    triplet = triplet.promoter, 
    dnam = dna.met.chr21.se,
    exp = gene.exp.chr21.se,
    dnam.group.threshold = 0.1,
    sig.threshold = 0.05,
    fdr = T,
    stage.wise.analysis = FALSE,
    filter.correlated.tf.exp.dnam = F,
    filter.triplet.by.sig.term = T
)

## -------------------------------------------------------------------------------------------------
# Results for quartile model
results.interaction.model %>% dplyr::select(
  c(1,4,5,grep("RLM",colnames(results.interaction.model)))
  ) %>% head

## ----stratified_model, message = FALSE, warning = FALSE, results = "hide", eval = TRUE------------
results.stratified.model <- stratified_model(
    triplet = results.interaction.model,
    dnam = dna.met.chr21.se,
    exp = gene.exp.chr21.se,
    dnam.group.threshold = 0.25
)

## -------------------------------------------------------------------------------------------------
results.stratified.model %>% head

## ----plot_interaction_model, eval = TRUE, message = FALSE, results = "hide", warning = FALSE------
plots <- plot_interaction_model(
    triplet.results = results.interaction.model[1,], 
    dnam = dna.met.chr21.se, 
    exp = gene.exp.chr21.se,
    dnam.group.threshold = 0.25
)

## ----fig.height = 8, fig.width = 13, eval = TRUE, fig.cap = "An example output from MethReg."-----
plots

## ----scenarios, fig.cap =  "Scenarios modeled by MethReg. A and B: DNA methylation decreases TF activity. In A TF is a repressor of the target gene, while in B TF is an activator. C and D: DNA methylation increases TF activity. In C TF is a repressor of the target gene, while in D TF is an activator. E and F: DNA methylation inverts the TF role. In E when DNA methylation levels are low the TF works as a repressor, when DNA methylation levels are high the TF acts as an activator. In F when the DNA methylation levels are low the TF works as an activator, when methylation levels are high the TF acts a repressor.", echo = FALSE, fig.width=13----
png::readPNG("scenarios.png")  %>% grid::grid.raster()

## ----residuals, results = "hide", eval = FALSE----------------------------------------------------
# data("gene.exp.chr21.log2")
# data("clinical")
# metadata <- clinical[,c("sample_type","gender")]
# 
# gene.exp.chr21.residuals <- get_residuals(gene.exp.chr21, metadata) %>% as.matrix()

## ----eval = FALSE---------------------------------------------------------------------------------
# gene.exp.chr21.residuals[1:5,1:5]

## ----results = "hide", eval = FALSE---------------------------------------------------------------
# data("dna.met.chr21")
# dna.met.chr21 <- make_se_from_dnam_probes(
#   dnam = dna.met.chr21,
#   genome = "hg38",
#   arrayType = "450k",
#   betaToM = TRUE
# )
# dna.met.chr21.residuals <- get_residuals(dna.met.chr21, metadata) %>% as.matrix()

## ----eval = FALSE---------------------------------------------------------------------------------
# dna.met.chr21.residuals[1:5,1:5]

## ----message = FALSE, results = "hide", eval = FALSE----------------------------------------------
# results <- interaction_model(
#     triplet = triplet,
#     dnam = dna.met.chr21.residuals,
#     exp = gene.exp.chr21.residuals
# )

## -------------------------------------------------------------------------------------------------
regulons.dorothea <- dorothea::dorothea_hs
regulons.dorothea %>% head

## ----message = FALSE, results = "hide"------------------------------------------------------------
rnaseq.tf.es <- get_tf_ES(
  exp = gene.exp.chr21.se %>% SummarizedExperiment::assay(),
  regulons = regulons.dorothea
)

## -------------------------------------------------------------------------------------------------
rnaseq.tf.es[1:4,1:4]

## ----message = FALSE, results = "hide"------------------------------------------------------------
regulons.dorothea <- dorothea::dorothea_hs
regulons.dorothea$tf <- MethReg:::map_symbol_to_ensg(
  gene.symbol = regulons.dorothea$tf,
  genome = "hg38"
)
regulons.dorothea$target <- MethReg:::map_symbol_to_ensg(
  gene.symbol = regulons.dorothea$target,
  genome = "hg38"
)
split_tibble <- function(tibble, col = 'col') tibble %>% split(., .[, col])
regulons.dorothea.list <- regulons.dorothea %>% na.omit() %>% 
  split_tibble('tf') %>% 
  lapply(function(x){x[[3]]})

## ----message = FALSE, results = "hide", eval = FALSE----------------------------------------------
# library(GSVA)
# rnaseq.tf.es.gsva <- gsva(
#   expr = gene.exp.chr21.se %>% SummarizedExperiment::assay(),
#   gset.idx.list = regulons.dorothea.list,
#   method = "gsva",
#   kcdf = "Gaussian",
#   abs.ranking = TRUE,
#   min.sz = 5,
#   max.sz = Inf,
#   parallel.sz = 1L,
#   mx.diff = TRUE,
#   ssgsea.norm = TRUE,
#   verbose = TRUE
# )

## ----size = 'tiny'--------------------------------------------------------------------------------
sessionInfo()

