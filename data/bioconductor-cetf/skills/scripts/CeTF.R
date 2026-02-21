# Code example from 'CeTF' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, results="hide"----------------------------------------
knitr::opts_chunk$set(tidy = FALSE,
                      cache = FALSE,
                      dev = "png",
                      message = FALSE, error = FALSE, warning = TRUE)

## ----install, eval=FALSE------------------------------------------------------
# BiocManager::install("cbiagii/CeTF")

## ----PCIT, eval=TRUE, warning=FALSE, message=FALSE----------------------------
# Loading packages
library(CeTF)
library(airway)
library(kableExtra)
library(knitr)

# Loading airway data
data("airway")

# Creating a variable with annotation data
anno <- as.data.frame(colData(airway))
anno <- anno[order(anno$dex, decreasing = TRUE), ]
anno <- data.frame(cond = anno$dex, 
                   row.names = rownames(anno))

# Creating a variable with count data
counts <- assay(airway)

# Sorting count data samples by conditions (untrt and trt)
counts <- counts[, rownames(anno)]
colnames(counts) <- paste0(colnames(counts), c(rep("_untrt", 4), rep("_trt", 4)))

# Differential Expression analysis to use only informative genes
DEGenes <- expDiff(exp = counts,
                   anno = anno,
                   conditions = c('untrt', 'trt'),
                   lfc = 4.5,
                   padj = 0.05, 
                   diffMethod = "Reverter")

# Selecting only DE genes from counts data
counts <- counts[rownames(DEGenes$DE_unique), ]

# Converting count data to TPM
tpm <- apply(counts, 2, function(x) {
            (1e+06 * x)/sum(x)
        })

# Count normalization
PCIT_input <- normExp(tpm)

# PCIT input for untrt
PCIT_input_untrt <- PCIT_input[,grep("_untrt", colnames(PCIT_input))]

# PCIT input for trt
PCIT_input_trt <- PCIT_input[,grep("_trt", colnames(PCIT_input))]

# Performing PCIT analysis for untrt condition
PCIT_out_untrt <- PCIT(PCIT_input_untrt, tolType = "mean")

# Performing PCIT analysis for trt condition
PCIT_out_trt <- PCIT(PCIT_input_trt, tolType = "mean")

# Printing first 10 rows for untrt condition
kable(PCIT_out_untrt$tab[1:10, ]) %>% 
  kable_styling(bootstrap_options = "striped", full_width = FALSE)

# Printing first 10 rows for trt condition
kable(PCIT_out_trt$tab[1:10, ]) %>% 
  kable_styling(bootstrap_options = "striped", full_width = FALSE)

# Adjacency matrix: PCIT_out_untrt$adj_raw or PCIT_out_trt$adj_raw
# Adjacency matrix only with the significant values: PCIT_out_untrt$adj_sig or PCIT_out_trt$adj_sig

## ----hist, eval=TRUE, fig.align="center"--------------------------------------
# Example for trt condition
histPlot(PCIT_out_trt$adj_sig)

## ----densitySig, eval=TRUE, fig.align="center"--------------------------------
# Example for trt condition
densityPlot(mat1 = PCIT_out_trt$adj_raw, 
           mat2 = PCIT_out_trt$adj_sig, 
           threshold = 0.5)

## ----RIF, eval=TRUE, warning=FALSE, message=FALSE-----------------------------
# Loading packages
library(CeTF)
library(airway)
library(kableExtra)
library(knitr)

# Loading airway data
data("airway")

# Creating a variable with annotation data
anno <- as.data.frame(colData(airway))
anno <- anno[order(anno$dex, decreasing = TRUE), ]
anno <- data.frame(cond = anno$dex, 
                   row.names = rownames(anno))

# Creating a variable with count data
counts <- assay(airway)

# Sorting count data samples by conditions (untrt and trt)
counts <- counts[, rownames(anno)]
colnames(counts) <- paste0(colnames(counts), c(rep("_untrt", 4), rep("_trt", 4)))

# Differential Expression analysis to use only informative genes
DEGenes <- expDiff(exp = counts,
                   anno = anno,
                   conditions = c('untrt', 'trt'),
                   lfc = 2,
                   padj = 0.05, 
                   diffMethod = "Reverter")

# Selecting only DE genes from counts data
counts <- counts[rownames(DEGenes$DE_unique), ]

# Converting count data to TPM
tpm <- apply(counts, 2, function(x) {
            (1e+06 * x)/sum(x)
        })

# Count normalization
Clean_Dat <- normExp(tpm)

# Loading the Transcript Factors (TFs) character
data("TFs")

# Verifying which TFs are in the subsetted normalized data
TFs <- rownames(Clean_Dat)[rownames(Clean_Dat) %in% TFs]

# Selecting the Target genes
Target <- setdiff(rownames(Clean_Dat), TFs)

# Ordering rows of normalized count data
RIF_input <- Clean_Dat[c(Target, TFs), ]

# Performing RIF analysis
RIF_out <- RIF(input = RIF_input,
               nta = length(Target),
               ntf = length(TFs),
               nSamples1 = 4,
               nSamples2 = 4)

# Printing first 10 rows
kable(RIF_out[1:10, ]) %>% 
  kable_styling(bootstrap_options = "striped", full_width = FALSE)

## ----all, eval=TRUE-----------------------------------------------------------
# Loading packages
library(airway)
library(CeTF)

# Loading airway data
data("airway")

# Creating a variable with annotation data
anno <- as.data.frame(colData(airway))

# Creating a variable with count data
counts <- assay(airway)

# Sorting count data samples by conditions (untrt and trt)
counts <- counts[, order(anno$dex, decreasing = TRUE)]

# Loading the Transcript Factors (TFs) character
data("TFs")

# Performing the complete analysis
out <- runAnalysis(mat = counts, 
                   conditions=c("untrt", "trt"),
                   lfc = 5,
                   padj = 0.05,
                   TFs = TFs,
                   nSamples1 = 4,
                   nSamples2= 4,
                   tolType = "mean",
                   diffMethod = "Reverter", 
                   data.type = "counts")

## ----SmearPlotDE, eval=TRUE, fig.align="center"-------------------------------
# Using the runAnalysis output (CeTF class object)
SmearPlot(object = out, 
          diffMethod = 'Reverter', 
          lfc = 1.5, 
          conditions = c('untrt', 'trt'), 
          type = "DE")

## ----SmearPlotTF, eval=TRUE, fig.align="center"-------------------------------
# Using the runAnalysis output (CeTF class object)
SmearPlot(object = out,
          diffMethod = 'Reverter',
          lfc = 1.5,
          conditions = c('untrt', 'trt'),
          TF = 'ENSG00000185917',
          label = TRUE, 
          type = "TF")

## ----netConditionsPlot, eval=TRUE, fig.align="center"-------------------------
# Using the runAnalysis output (CeTF class object)
netConditionsPlot(out)

## ----getGroupGO, eval=TRUE, fig.align="center"--------------------------------
# Loading Homo sapiens annotation package
library(org.Hs.eg.db)

# Accessing the network for condition 1
genes <- unique(c(as.character(NetworkData(out, "network1")[, "gene1"]), 
                  as.character(NetworkData(out, "network1")[, "gene2"])))

# Performing getGroupGO analysis
cond1 <- getGroupGO(genes = genes, 
                    ont = "BP", 
                    keyType = "ENSEMBL", 
                    annoPkg = org.Hs.eg.db, 
                    level = 3)

## ----getEnrich, eval=FALSE, fig.align="center"--------------------------------
# # Accessing the network for condition 1
# genes <- unique(c(as.character(NetworkData(out, "network1")[, "gene1"]),
#                   as.character(NetworkData(out, "network1")[, "gene2"])))
# 
# # Performing getEnrich analysis
# enrich <- getEnrich(genes = genes, organismDB = org.Hs.eg.db,
#                     keyType = 'ENSEMBL', ont = 'BP', fdrMethod = "BH",
#                     fdrThr = 0.05, minGSSize = 5, maxGSSize = 500)

## ----netGOTFPlot1, eval=TRUE, fig.align="center"------------------------------
library(dplyr)

# Subsetting only the first 12 Ontologies with more counts
t1 <- head(cond1$results, 12)

# Subsetting the network for the conditions to make available only the 12 nodes subsetted
t2 <- subset(cond1$netGO, cond1$netGO$gene1 %in% as.character(t1[, "ID"]))

# generating the GO plot grouping by pathways
pt <- netGOTFPlot(netCond = NetworkData(out, "network1") %>% 
                    mutate(across(everything(), as.character)),
                  resultsGO = t1,
                  netGO = t2,
                  anno = NetworkData(out, "annotation"),
                  groupBy = 'pathways',
                  type = 'GO')
pt$plot
head(pt$tab$`GO:0006807`)

# generating the GO plot grouping by TFs
TFs <- NetworkData(out, "keytfs")$TF[1:4]
pt <- netGOTFPlot(netCond = NetworkData(out, "network1"),
                  resultsGO = t1,
                  netGO = t2,
                  anno = NetworkData(out, "annotation"),
                  groupBy = 'TFs',
                  TFs = TFs, 
                  type = 'GO')
pt$plot
head(pt$tab$ENSG00000011465)

# generating the GO plot grouping by specifics genes
genes <- c('ENSG00000011465', 'ENSG00000026025', 'ENSG00000075624', 'ENSG00000077942')
pt <- netGOTFPlot(netCond = NetworkData(out, "network1"),
                  resultsGO = t1,
                  netGO = t2,
                  anno = NetworkData(out, "annotation"),
                  groupBy = 'genes',
                  genes = genes,
                  type = 'GO')
pt$plot
head(pt$tab$ENSG00000011465)

## ----netGOTFPlot2, eval=TRUE, fig.align="center"------------------------------
pt <- netGOTFPlot(netCond = NetworkData(out, "network1") %>% 
                   mutate(across(everything(), as.character)),
                  netGO = t2,
                  keyTFs = NetworkData(out, "keytfs"), 
                  type = 'Integrated')

pt$plot
head(pt$tab)

## ----diffusion, eval=FALSE, fig.align="center"--------------------------------
# result <- diffusion(object = out,
#                     cond = "network1",
#                     genes = c("ENSG00000185591", "ENSG00000179094"),
#                     cyPath = "C:/Program Files/Cytoscape_v3.7.2/Cytoscape.exe",
#                     name = "top_diffusion",
#                     label = T)

## ----circos, eval=FALSE, fig.align="center"-----------------------------------
# # Loading the CeTF object class demo
# data("CeTFdemo")
# 
# CircosTargets(object = CeTFdemo,
#               file = "/path/to/gtf/file/specie.gtf",
#               nomenclature = "ENSEMBL",
#               selection = "ENSG00000185591",
#               cond = "condition1")

## ----RIFPlot1, eval=TRUE, fig.align="center"----------------------------------
RIFPlot(object = out,
        color  = "darkblue",
        type   = "RIF")

## ----RIFPlot2, eval=TRUE, fig.align="center"----------------------------------
RIFPlot(object = out,
        color  = "darkblue",
        type   = "DE")

## ----enrichment, eval=TRUE, fig.align="center"--------------------------------
# Selecting the genes related to the network for condition 1
genes <- unique(c(as.character(NetworkData(out, "network1")[, "gene1"]), 
                  as.character(NetworkData(out, "network1")[, "gene2"])))

# Performing enrichment analysis
cond1 <- getEnrich(genes = genes, organismDB = org.Hs.eg.db, 
                  keyType = 'ENSEMBL', ont = 'BP', fdrMethod = "BH", 
                  fdrThr = 0.05, minGSSize = 5, maxGSSize = 500)

## ----heatplot, eval=TRUE, fig.align="center"----------------------------------
heatPlot(res = cond1$results,
         diff = getDE(out, "all"))

## ----circle, eval=TRUE, fig.align="center"------------------------------------
enrichPlot(res = cond1$results,
           type = "circle")

## ----barplot, eval=TRUE, fig.align="center"-----------------------------------
enrichPlot(res = cond1$results,
           type = "bar")

## ----dotplot, eval=TRUE, fig.align="center"-----------------------------------
enrichPlot(res = cond1$results,
           type = "dot")

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

