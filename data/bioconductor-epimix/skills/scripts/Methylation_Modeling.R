# Code example from 'Methylation_Modeling' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval = FALSE-------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install(version='devel')
# 
# BiocManager::install("EpiMix")

## ----eval = FALSE-------------------------------------------------------------
# devtools::install_github("gevaertlab/EpiMix.data")
# devtools::install_github("gevaertlab/EpiMix")

## ----message=FALSE, warning=FALSE, include=FALSE------------------------------
library(EpiMix)
library(EpiMix.data)

## ----message=FALSE, warning=FALSE---------------------------------------------
data(MET.data)

## ----echo=FALSE, message=FALSE, warning=FALSE---------------------------------
knitr::kable(MET.data[1:5,1:5])

## ----message=FALSE, warning=FALSE---------------------------------------------
data(mRNA.data)

## ----echo=FALSE, message=FALSE, warning=FALSE---------------------------------
knitr::kable(mRNA.data[1:5,1:5])

## ----message=FALSE, warning=FALSE---------------------------------------------
data(LUAD.sample.annotation)

## ----echo=FALSE, message=FALSE, warning=FALSE---------------------------------
rownums <- nrow(LUAD.sample.annotation)
df1 <- LUAD.sample.annotation[1:4,]
df2 <- LUAD.sample.annotation[(rownums-4):rownums,]
df <- rbind(df1, df2)
knitr::kable(df, row.names = FALSE)

## ----echo=FALSE, message=FALSE, warning=FALSE---------------------------------
library(DT)

## ----echo=TRUE, message=FALSE, warning=FALSE, results='hide'------------------
# Specify the output directory
outputDirectory = tempdir()

# We compare the DNA methylation in cancer (group.1) to the normal (group.2) tissues
EpiMixResults_Regular <- EpiMix(methylation.data = MET.data,
                                 gene.expression.data = mRNA.data,
                                 sample.info = LUAD.sample.annotation,
                                 group.1 = "Cancer",
                                 group.2 = "Normal",
                                 met.platform = "HM450",
                                 OutputRoot =  outputDirectory)

## ----message=FALSE, warning=FALSE---------------------------------------------
datatable(EpiMixResults_Regular$FunctionalPairs[1:5, ],
          options = list(scrollX = TRUE, 
                         autoWidth = TRUE,
                         keys = TRUE, 
                         pageLength = 5, 
                         rownames= FALSE,
                         digits = 3), 
                         rownames = FALSE)


## ----eval = TRUE, message=FALSE, warning=FALSE, results='hide'----------------
# First, we need to set the analytic mode to enhancer
mode <- "Enhancer"

# Since enhancers are cell or tissue-type specific, EpiMix needs 
# to know the reference cell type or tissue to select proper enhancers.
# Available ids for tissue or cell types can be 
# obtained from Figure 2 of the RoadmapEpigenomic
# paper: https://www.nature.com/articles/nature14248. 
# Alternatively, they can also be retrieved from the 
# built-in function `list.epigenomes()`.

roadmap.epigenome.ids = "E096"   

# Specify the output directory
outputDirectory = tempdir()

# Third, run EpiMix
EpiMixResults_Enhancer <- EpiMix(methylation.data = MET.data, 
                                gene.expression.data = mRNA.data,
                                mode = mode,
                                roadmap.epigenome.ids = roadmap.epigenome.ids,
                                sample.info = LUAD.sample.annotation,
                                group.1 = "Cancer",
                                group.2 = "Normal",
                                met.platform = "HM450",
                                OutputRoot =  outputDirectory)

## ----message=FALSE, warning=FALSE---------------------------------------------
datatable(EpiMixResults_Enhancer$FunctionalPairs[1:5, ],
          options = list(scrollX = TRUE, 
                         autoWidth = TRUE,
                         keys = TRUE, 
                         pageLength = 5, 
                         rownames= FALSE,
                         digits = 3), 
                         rownames = FALSE)


## ----eval=TRUE, message=FALSE, warning=FALSE,  results='hide'-----------------
# Note that running the methylation analysis for miRNA genes need gene expression data for miRNAs
data(microRNA.data)

mode <- "miRNA"

# Specify the output directory
outputDirectory = tempdir()

EpiMixResults_miRNA <- EpiMix(methylation.data = MET.data, 
                        gene.expression.data = microRNA.data,
                        mode = mode,
                        sample.info = LUAD.sample.annotation,
                        group.1 = "Cancer",
                        group.2 = "Normal",
                        met.platform = "HM450",
                        OutputRoot = outputDirectory)

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
# View the EpiMix results
datatable(EpiMixResults_miRNA$FunctionalPairs[1:5, ],
          options = list(scrollX = TRUE, 
                         autoWidth = TRUE,
                         keys = TRUE, 
                         pageLength = 5, 
                         rownames= FALSE,
                         digits = 3), 
                         rownames = FALSE)

## ----eval=TRUE, message=FALSE, warning=FALSE, results='hide'------------------
# Note: standard RNA-seq processing method can not detect sufficient amount of lncRNAs. 
# To maximize the capture of lncRNA expression, please use the pipeline propoased 
# in our previous study: PMID: 31808800

data(lncRNA.data)

mode <- "lncRNA"

# Specify the output directory
outputDirectory =  tempdir()

EpiMixResults_lncRNA <- EpiMix(methylation.data = MET.data, 
                        gene.expression.data = lncRNA.data,
                        mode = mode,
                        sample.info = LUAD.sample.annotation,
                        group.1 = "Cancer",
                        group.2 = "Normal",
                        met.platform = "HM450",
                        OutputRoot = outputDirectory)

## ----eval=TRUE, message=FALSE, warning = FALSE--------------------------------
datatable(EpiMixResults_lncRNA$FunctionalPairs[1:5, ],
          options = list(scrollX = TRUE, 
                         autoWidth = TRUE,
                         keys = TRUE,
                         pageLength = 5, 
                         rownames= FALSE,
                         digits = 3), 
                         rownames = FALSE)

## ----eval = FALSE-------------------------------------------------------------
# # Set up the TCGA cancer site. "OV" stands for ovarian cancer.
# CancerSite <- "OV"
# 
# # Specify the analytic mode.
# mode <- "Regular"
# 
# # Set the file path for saving the output.
# outputDirectory <- tempdir()
# 
# # Only required if mode == "Enhancer".
# roadmap.epigenome.ids = "E097"
# 
# # Run EpiMix
# 
# # We highly encourage to use multiple (>=10) CPU cores to
# # speed up the computational process for large datasets
# 
# EpiMixResults <- TCGA_GetData(CancerSite = CancerSite,
#                               mode = mode,
#                               roadmap.epigenome.ids = roadmap.epigenome.ids,
#                               outputDirectory = outputDirectory,
#                               cores = 10)
# 

## ----message=FALSE, results='hide'--------------------------------------------
METdirectories <- TCGA_Download_DNAmethylation(CancerSite = "OV", 
                                               TargetDirectory = outputDirectory)

## ----message=FALSE------------------------------------------------------------
cat("HM27k directory:", METdirectories$METdirectory27k, "\n")
cat("HM450k directory:", METdirectories$METdirectory450k, "\n")

## ----message=FALSE, results='hide'--------------------------------------------
METProcessedData <- TCGA_Preprocess_DNAmethylation(CancerSite = "OV", METdirectories)

## -----------------------------------------------------------------------------
knitr::kable(METProcessedData[1:5,1:5])

## ----eval=TRUE, message = FALSE, results='hide'-------------------------------
# If use the Regular or the Enhancer mode: 
GEdirectories <- TCGA_Download_GeneExpression(CancerSite = "OV", 
                                              TargetDirectory = outputDirectory)
                                              

# If use the miRNA mode, download miRNA expression data:
mode <- "miRNA"
GEdirectories <- TCGA_Download_GeneExpression(CancerSite = "OV", 
                                              TargetDirectory = outputDirectory, 
                                              mode = mode)

# If use the lncRNA mode, download lncRNA expression data:
mode <- "lncRNA"
GEdirectories <- TCGA_Download_GeneExpression(CancerSite = "OV", 
                                              TargetDirectory = outputDirectory, 
                                              mode = mode)

## ----message = FALSE, results='hide'------------------------------------------
GEProcessedData <- TCGA_Preprocess_GeneExpression(CancerSite = "OV", 
                                                  MAdirectories = GEdirectories, 
                                                  mode = mode
                                                  )

## ----message = FALSE, results='hide'------------------------------------------
sample.info = TCGA_GetSampleInfo(METProcessedData = METProcessedData,
                                 CancerSite = "OV", 
                                 TargetDirectory = outputDirectory)

## -----------------------------------------------------------------------------
knitr::kable(sample.info[1:4,])

## ----eval=TRUE, message=FALSE, warning=FALSE, results = 'hide'----------------
data(Sample_EpiMixResults_Regular)

plots <- EpiMix_PlotModel(
                 EpiMixResults = Sample_EpiMixResults_Regular, 
                 Probe = "cg14029001", 
                 methylation.data = MET.data, 
                 gene.expression.data = mRNA.data,
                 GeneName = "CCND3"
                 )

## ----eval=TRUE, fig.show="hold", message=FALSE, warning=FALSE, out.width="33%"----
# Mixture model of the DNA methylation of the CCND3 gene at cg14029001
plots$MixtureModelPlot

# Violin plot of the gene expression levels of the CCND3 gene in different mixtures
plots$ViolinPlot

# Correlation between DNA methylation and gene expression of CCND3
plots$CorrelationPlot

## ----message = FALSE, warning=FALSE, eval=FALSE, fig.show="hold", dev='png', out.width="110%", results = 'hide', fig.cap = "Integrative visualization of the chromatin state, DM values and the transcript structure of the *CCND2* gene. The differential methylation (DM) value represents the mean difference in beta values between the hypermethylated samples versus the normally methylated samples"----
# library(karyoploteR)
# library(TxDb.Hsapiens.UCSC.hg19.knownGene)
# library(org.Hs.eg.db)
# library(regioneR)
# 
# data(Sample_EpiMixResults_Regular)
# 
# gene.name = "CCND2"
# met.platform = "HM450"
# 
# # Since the chromatin states are cell-type specific, we need to specify a reference cell or
# # tissue type for plotting. Available cell or tissue type can be found in
# # Figure 2 of the Roadmap Epigenomics paper (nature, PMID: 25693563):
# # https://www.nature.com/articles/nature14248
# 
# roadmap.epigenome.id = "E096"
# 
# EpiMix_PlotGene(gene.name = gene.name,
#                 EpiMixResults = Sample_EpiMixResults_Regular,
#                 met.platform = met.platform,
#                 roadmap.epigenome.id = roadmap.epigenome.id
#                )
# 

## ----message = FALSE, warning=FALSE, eval=FALSE, fig.show="hold", dev='png', out.width="110%", results = 'hide', fig.cap = "Integrative visualization of the chromatin state and the nearby genes of a differentially methylated CpG site"----
# # The CpG site to plot
# probe.name = "cg00374492"
# 
# # The number of adjacent genes to be plotted
# # Warnings: setting the gene number to a high value (>20 genes) may blow the internal memory
# numFlankingGenes = 10
# 
# # Set up the reference cell/tissue type
# roadmap.epigenome.id = "E096"
# 
# # Generate the plot
# EpiMix_PlotProbe(probe.name,
#                  EpiMixResults = Sample_EpiMixResults_Regular,
#                  met.platform = "HM450",
#                  numFlankingGenes = numFlankingGenes,
#                  roadmap.epigenome.id = roadmap.epigenome.id,
#                  left.gene.margin = 10000,  # left graph margin in nucleotide base pairs
#                  right.gene.margin = 10000  # right graph margin in nucleotide base pairs
#                  )

## ----message=FALSE, warning=FALSE, results="hide"-----------------------------
library(clusterProfiler)
library(org.Hs.eg.db)

# We want to check the functions of both the hypo- and hypermethylated genes. 
methylation.state = "all"

# Use the gene ontology for functional analysis.
enrich.method = "GO"

# Use the "biological process" subterm
selected.pathways = "BP"

# Perform enrichment analysis 
enrich.results <- functionEnrich(EpiMixResults = Sample_EpiMixResults_Regular,
                                  methylation.state = methylation.state,
                                  enrich.method = enrich.method,
                                  ont = selected.pathways,
                                  simplify = TRUE,
                                  save.dir = "" 
                                  )

## ----eval=TRUE, message=FALSE, warning=FALSE, results = "asis"----------------
knitr::kable(head(enrich.results), row.names = FALSE)

## ----eval=TRUE, message=FALSE, warning=FALSE, results = "hide"----------------
enrich.results <- functionEnrich(EpiMixResults = Sample_EpiMixResults_Regular,
                                  methylation.state = "all",
                                  enrich.method = "KEGG",
                                  simplify = TRUE,
                                  save.dir = "")

## ----eval=TRUE, message=FALSE, warning=FALSE, results = "asis"----------------
knitr::kable(head(enrich.results), row.names = FALSE)

## ----eval=TRUE, message=FALSE, warning=FALSE, results = "hide"----------------
library(survival)

# We use a sample result from running the EpiMix's miRNA mode on the 
# lung adenocarcinomas (LUAD) data from TCGA
data("Sample_EpiMixResults_miRNA")

# Set the TCGA cancer site. 
CancerSite = "LUAD"

# Find survival-associated CpGs/genes
survival.CpGs <- GetSurvivalProbe (EpiMixResults = Sample_EpiMixResults_miRNA, TCGA_CancerSite = CancerSite)
                                    

## ----eval=TRUE, message=FALSE, warning=FALSE, results = "asis"----------------
knitr::kable(survival.CpGs, row.names = FALSE)

## ----message = FALSE, warning=FALSE, fig.show="hold", dev='png', fig.cap = "Survival curve for patients showing different methylation states at the CpG cg00909706", results = "hide"----
library(survminer)

# Select the target CpG site whose methylation states will be evaluated
Probe = "cg00909706"

# If using data from TCGA, just input the cancer site 
CancerSite = "LUAD"

EpiMix_PlotSurvival(EpiMixResults = Sample_EpiMixResults_miRNA, 
                                     plot.probe = Probe,
                                     TCGA_CancerSite = CancerSite)

## ----echo=TRUE, message=FALSE, warning=FALSE, results='hide'------------------
library(multiMiR)
library(miRBaseConverter)

miRNA_targets <- find_miRNA_targets(
 EpiMixResults = Sample_EpiMixResults_miRNA,
 geneExprData = mRNA.data
)

## ----message=FALSE, warning=FALSE---------------------------------------------
datatable(miRNA_targets[1:5, ],
          options = list(scrollX = TRUE, 
                         autoWidth = TRUE,
                         keys = TRUE, 
                         pageLength = 5, 
                         rownames= FALSE,
                         digits = 3), 
                         rownames = FALSE)

## -----------------------------------------------------------------------------
sessionInfo()

