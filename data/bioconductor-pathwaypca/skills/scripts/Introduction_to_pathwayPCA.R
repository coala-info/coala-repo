# Code example from 'Introduction_to_pathwayPCA' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE,
                      cache = FALSE,
                      comment = "#>")

## ----packLoad, message=FALSE--------------------------------------------------
library(tidyverse)
library(pathwayPCA)

## ----loadAssay----------------------------------------------------------------
gitHubPath_char <- "https://raw.githubusercontent.com/lizhongliu1996/pathwayPCAdata/master/"
ovSurv_df <- readRDS(
  url(paste0(gitHubPath_char, "ovarian_PNNL_survival.RDS"))
)

## ----printAssay, eval=TRUE----------------------------------------------------
ovSurv_df [1:5, 1:5]

## ----rWikiPathways, eval=FALSE------------------------------------------------
# library(rWikiPathways)
# # library(XML) # necessary if you encounter an error with readHTMLTable
# downloadPathwayArchive(
#   organism = "Homo sapiens", format = "gmt"
# )

## ----printWPgmtpath, echo=FALSE-----------------------------------------------
print("wikipathways-20190110-gmt-Homo_sapiens.gmt")

## ----ourWikiPWC---------------------------------------------------------------
dataDir_path <- system.file(
  "extdata", package = "pathwayPCA", mustWork = TRUE
)
wikipathways_PC <- read_gmt(
  paste0(dataDir_path, "/wikipathways_human_symbol.gmt"),
  description = TRUE
)

## ----createOmics, comment=""--------------------------------------------------
ov_OmicsSurv <- CreateOmics(
  # protein expression data
  assayData_df = ovSurv_df[, -(2:3)], 
  # pathway collection
  pathwayCollection_ls = wikipathways_PC,
  # survival phenotypes
  response = ovSurv_df[, 1:3],
  # phenotype is survival data
  respType = "survival",
  # retain pathways with > 5 proteins
  minPathSize = 5  
)

## ----inspectOmicsObj----------------------------------------------------------
ov_OmicsSurv

## ----aespcaCall, comment=""---------------------------------------------------
ovarian_aespcOut <- AESPCA_pVals(
  # The Omics data container
  object = ov_OmicsSurv,
  # One principal component per pathway
  numPCs = 1,
  # Use parallel computing with 2 cores
  parallel = TRUE,
  numCores = 2,
  # # Use serial computing
  # parallel = FALSE,
  # Estimate the p-values parametrically
  numReps = 0,
  # Control FDR via Benjamini-Hochberg
  adjustment = "BH"
)

## ----inspectAESPCAout---------------------------------------------------------
names(ovarian_aespcOut)

## ----headPVals----------------------------------------------------------------
getPathpVals(ovarian_aespcOut, numPaths = 10)

## ----subset_top_genes---------------------------------------------------------
ovOutGather_df <- getPathpVals(ovarian_aespcOut, score = TRUE)

## ----pathway_bar_plots, fig.height = 5, fig.width = 8-------------------------
ggplot(ovOutGather_df) +
  # set overall appearance of the plot
  theme_bw() +
  # Define the dependent and independent variables
  aes(x = reorder(terms, score), y = score) +
  # From the defined variables, create a vertical bar chart
  geom_col(position = "dodge", fill = "#66FFFF", width = 0.7) +
  # Add pathway labels
  geom_text(
    aes(
      x = reorder(terms, score),
      label = reorder(description, score),
      y = 0.1
    ),
    color = "black",
    size = 2, 
    hjust = 0
  ) +
  # Set main and axis titles
  ggtitle("AES-PCA Significant Pathways: Ovarian Cancer") +
  xlab("Pathways") +
  ylab("Negative LN (p-Value)") +
  # Add a line showing the alpha = 0.01 level
  geom_hline(yintercept = -log(0.01), size = 1, color = "blue") +
  # Flip the x and y axes
  coord_flip()

## ----getWP195pcl--------------------------------------------------------------
wp195PCLs_ls <- getPathPCLs(ovarian_aespcOut, "WP195")
wp195PCLs_ls

## ----WP195loads---------------------------------------------------------------
wp195Loadings_df <- 
  wp195PCLs_ls$Loadings %>% 
  filter(PC1 != 0)
wp195Loadings_df

## ----loadDirections-----------------------------------------------------------
wp195Loadings_df <- 
  wp195Loadings_df %>% 
  # Sort Loading from Strongest to Weakest
  arrange(desc(abs(PC1))) %>% 
  # Order the Genes by Loading Strength
  mutate(featureID = factor(featureID, levels = featureID)) %>% 
  # Add Directional Indicator (for Colour)
  mutate(Direction = factor(ifelse(PC1 > 0, "Up", "Down"))) 

## ----graphLoads, fig.height = 3.6, fig.width = 6.5----------------------------
ggplot(data = wp195Loadings_df) +
  # Set overall appearance
  theme_bw() +
  # Define the dependent and independent variables
  aes(x = featureID, y = PC1, fill = Direction) +
  # From the defined variables, create a vertical bar chart
  geom_col(width = 0.5, fill = "#005030", color = "#f47321") +
  # Set main and axis titles
  labs(
    title = "Gene Loadings on IL-1 Signaling Pathway",
    x = "Protein",
    y = "Loadings of PC1"
  ) +
  # Remove the legend
  guides(fill = FALSE)

## ----wp195PCs, fig.height = 3.6, fig.width = 6.5------------------------------
ggplot(data = wp195PCLs_ls$PCs) +
  # Set overall appearance
  theme_classic() + 
  # Define the independent variable
  aes(x = V1) +
  # Add the histogram layer
  geom_histogram(bins = 10, color = "#005030", fill = "#f47321") +
  # Set main and axis titles
  labs(
    title = "Distribution of Sample-specific Estimate of Pathway Activities",
    subtitle = paste0(wp195PCLs_ls$pathway, ": ", wp195PCLs_ls$description),
    x = "PC1 Value for Each Sample",
    y = "Count"
  )

## ----subsetWP195data----------------------------------------------------------
wp195Data_df <- SubsetPathwayData(ov_OmicsSurv, "WP195")
wp195Data_df

## ----gatherWP195--------------------------------------------------------------
wp195gather_df <- wp195Data_df %>% 
  arrange(EventTime) %>% 
  select(-EventTime, -EventObs) %>% 
  gather(protein, value, -sampleID)

## ----heatmapWP195, fig.width=8, fig.asp=0.62----------------------------------
ggplot(wp195gather_df, aes(x = protein, y = sampleID)) +
  geom_tile(aes(fill = value)) +
  scale_fill_gradient2(low = "red", mid = "black", high = "green") +
  labs(x = "Proteins", y = "Subjects", fill = "Protein level") +
  theme(axis.text.x  = element_text(angle = 90)) +
  coord_flip()

## ----dataSubsetMod------------------------------------------------------------
library(survival)
NFKB1_df <- 
  wp195Data_df %>% 
  select(EventTime, EventObs, NFKB1)

wp195_mod <- coxph(
  Surv(EventTime, EventObs) ~ NFKB1,
  data = NFKB1_df
)

summary(wp195_mod)

## ----NFKB1Surv----------------------------------------------------------------
# Add the direction
NFKB1_df <- 
  NFKB1_df %>% 
  # Group subjects by gene expression
  mutate(NFKB1_Expr = ifelse(NFKB1 > median(NFKB1), "High", "Low")) %>% 
  # Re-code time to years
  mutate(EventTime = EventTime / 365.25) %>% 
  # Ignore any events past 10 years
  filter(EventTime <= 10) 

# Fit the survival model
NFKB1_fit <- survfit(
  Surv(EventTime, EventObs) ~ NFKB1_Expr,
  data = NFKB1_df
)

## ----NFKB1SurvPlot, message=FALSE, fig.height = 4, fig.width = 6--------------
library(survminer)

ggsurvplot(
  NFKB1_fit,
  conf.int = FALSE, pval = TRUE,
  xlab = "Time in Years",
  palette = c("#f47321", "#005030"),
  xlim = c(0, 10)
)

## ----CNVsetup-----------------------------------------------------------------
copyNumberClean_df <- readRDS(
  url(paste0(gitHubPath_char, "OV_surv_x_CNV2.RDS"))
)

## ----CNVomics, eval=FALSE-----------------------------------------------------
# ovCNV_Surv <- CreateOmics(
#   assayData_df = copyNumberClean_df[, -(2:3)],
#   pathwayCollection_ls = wikipathways_PC,
#   response = copyNumberClean_df[, 1:3],
#   respType = "survival",
#   minPathSize = 5
# )

## ----CNV_aespca, eval=FALSE---------------------------------------------------
# ovCNV_aespcOut <- AESPCA_pVals(
#   object = ovCNV_Surv,
#   numPCs = 1,
#   parallel = TRUE,
#   numCores = 20,
#   numReps = 0,
#   adjustment = "BH"
# )

## ----CNV_aespca_read, echo=FALSE----------------------------------------------
ovCNV_aespcOut <- readRDS(
  url(paste0(gitHubPath_char, "ovarian_copyNum_aespcOut.RDS"))
)

## ----multiOmicsPvals----------------------------------------------------------
# Copy Number
CNVpvals_df <- 
  getPathpVals(ovCNV_aespcOut, alpha = 0.05) %>% 
  mutate(rawp_CNV = rawp) %>% 
  select(description, rawp_CNV)

# Proteomics
PROTpvals_df <- 
  getPathpVals(ovarian_aespcOut, alpha = 0.05) %>% 
  mutate(rawp_PROT = rawp) %>% 
  select(description, rawp_PROT)


# Intersection
SigBoth_df <- inner_join(PROTpvals_df, CNVpvals_df, by = "description")
# WnT Signaling Pathway is listed as WP363 and WP428

## ----intersectPaths-----------------------------------------------------------
SigBoth_df

## ----wp195--------------------------------------------------------------------
# Copy Number Loadings
CNVwp195_ls <- getPathPCLs(ovCNV_aespcOut, "WP195")
CNV195load_df <- 
  CNVwp195_ls$Loadings %>% 
  filter(abs(PC1) > 0) %>% 
  rename(PC1_CNV = PC1)

# Protein Loadings
PROTwp195_ls <- getPathPCLs(ovarian_aespcOut, "WP195")
PROT195load_df <- 
  PROTwp195_ls$Loadings %>% 
  filter(abs(PC1) > 0) %>% 
  rename(PC1_PROT = PC1)

# Intersection
inner_join(CNV195load_df, PROT195load_df)

## ----mergeGene----------------------------------------------------------------
NFKB1data_df <- inner_join(
  copyNumberClean_df %>% 
    select(Sample, NFKB1) %>% 
    rename(CNV_NFKB1 = NFKB1),
  ovSurv_df %>% 
    select(Sample, NFKB1) %>% 
    rename(PROT_NFKB1 = NFKB1)
)

## ----NFKB1cor, comment=""-----------------------------------------------------
NFKB1_cor <- cor.test(NFKB1data_df$CNV_NFKB1, NFKB1data_df$PROT_NFKB1)
NFKB1_cor

## ----NFKB1plot, fig.height = 4, fig.width = 4---------------------------------
ggplot(data = NFKB1data_df) +
  # Set overall appearance
  theme_bw() +
  # Define the dependent and independent variables
  aes(x = CNV_NFKB1, y = PROT_NFKB1) +
  # Add the scatterplot
  geom_point(size = 2) +
  # Add a trendline
  geom_smooth(method = lm, se = FALSE, size = 1) +
  # Set main and axis titles
  labs(
    title = "NFKB1 Expressions in Multi-Omics Data",
    x = "Copy Number Variation (Centred and Scaled)",
    y = "Protein Expression (Centred and Scaled)"
  ) +
  # Include the correlation on the graph
  annotate(
    geom = "text", x = 0.5, y = -0.6,
    label = paste("rho = ", round(NFKB1_cor$estimate, 3))
  ) +
  annotate(
    geom = "text", x = 0.5, y = -0.7,
    label = "p-val < 10^-5"
  )

## ----kidneyData---------------------------------------------------------------
kidney_df <- readRDS(
  url(paste0(gitHubPath_char, "KIRP_Surv_RNAseq_inner.RDS"))
)

## ----kidneyOmics--------------------------------------------------------------
# Create Omics Container
kidney_Omics <- CreateOmics(
  assayData_df = kidney_df[, -(2:4)],
  pathwayCollection_ls = wikipathways_PC,
  response = kidney_df[, 1:3],
  respType = "surv",
  minPathSize = 5
)

## ----kidneyAESPCA-------------------------------------------------------------
# AESPCA
kidney_aespcOut <- AESPCA_pVals(
  object = kidney_Omics,
  numPCs = 1,
  parallel = TRUE,
  numCores = 2,
  numReps = 0,
  adjustment = "BH"
)

## ----sexInteractFun-----------------------------------------------------------
TestIntxn <- function(pathway, pcaOut, resp_df){
  
  # For the given pathway, extract the PCs and loadings from the pcaOut list
  PCL_ls <- getPathPCLs(pcaOut, pathway)
  # Select and rename the PC
  PC_df <- PCL_ls$PCs %>% select(PC1 = V1)
  # Bind this PC to the phenotype data
  data_df <- bind_cols(resp_df, PC_df)
  
  # Construct a survival model with sex interaction
  sex_mod <- coxph(
    Surv(time, status) ~ PC1 + male + PC1 * male, data = data_df
  )
  # Extract the model fit statistics for the interaction
  modStats_mat <- t(
    coef(summary(sex_mod))["PC1:maleTRUE", ]
  )
 
  # Return a data frame of the pathway and model statistics
  list(
    statistics = data.frame(
      terms = pathway,
      description = PCL_ls$description,
      modStats_mat,
      stringsAsFactors = FALSE
    ),
    model = sex_mod
  )

}

## ----testNewFun---------------------------------------------------------------
TestIntxn("WP195", kidney_aespcOut, kidney_df[, 2:4])$model

## ----applyTestSexFun----------------------------------------------------------
paths_char <- kidney_aespcOut$pVals_df$terms
interactions_ls <- lapply(
    paths_char,
    FUN = TestIntxn,
    pcaOut = kidney_aespcOut,
    resp_df = kidney_df[, 2:4]
)
names(interactions_ls) <- paths_char

interactions_df <- 
  # Take list of interactions
  interactions_ls %>% 
  # select the first element (the data frame of model stats)
  lapply(`[[`, 1) %>% 
  # stack these data frames
  bind_rows() %>% 
  as.tibble() %>% 
  # sort the rows by significance
  arrange(`Pr...z..`)

interactions_df %>% 
  filter(`Pr...z..` < 0.05)

## ----modelRes-----------------------------------------------------------------
summary(interactions_ls[["WP1559"]]$model)

## ----kidneySurvPlotData-------------------------------------------------------
# Bind the Pheno Data to WP1559's First PC
kidneyWP1559_df <- bind_cols(
  kidney_df[, 2:4],
  getPathPCLs(kidney_aespcOut, "WP1559")$PCs %>% select(PC1 = V1)
)

# Add Grouping Feature
kidneySurvWP1559grouped_df <- 
  kidneyWP1559_df %>% 
  # add strength indicator
  mutate(direction = ifelse(PC1 > median(PC1), "High", "Low")) %>% 
  # group by interaction of sex and strength on PC
  mutate(group = paste0(direction, ifelse(male, "_M", "_F"))) %>% 
  # recode time in years
  mutate(time = time / 365.25) %>% 
  # remove summarized columns
  select(-male, -PC1, -direction)

## ----plotKidneyGroupedSurv, message=FALSE, fig.height = 5, fig.width = 7------
# Fit the survival model
fit <- survfit(
  Surv(time, status) ~ group,
  data = kidneySurvWP1559grouped_df
)

ggsurvplot(
  fit, conf.int = FALSE,
  xlab = "Time in Years",
  xlim = c(0, 10),
  ylim = c(0.4, 1)
)

## ----sessionDetails-----------------------------------------------------------
sessionInfo()

