# Code example from 'Supplement5-Analyse_Results' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(collapse = TRUE,
                      cache = FALSE,
                      comment = "#>")

## ----packageLoad, message=FALSE-----------------------------------------------
library(tidyverse)
library(pathwayPCA)

## ----load_data----------------------------------------------------------------
# Load Data: see Chapter 2
data("colonSurv_df")
data("colon_pathwayCollection")

# Create -Omics Container: see Chapter 3
colon_OmicsSurv <- CreateOmics(
  assayData_df = colonSurv_df[, -(2:3)],
  pathwayCollection_ls = colon_pathwayCollection,
  response = colonSurv_df[, 1:3],
  respType = "surv"
)

## ----show_AESPCA--------------------------------------------------------------
# AESPCA Analysis: see Chapter 4
colonSurv_aespcOut <- AESPCA_pVals(
  object = colon_OmicsSurv,
  numReps = 0,
  numPCs = 2,
  parallel = TRUE,
  numCores = 2,
  adjustpValues = TRUE,
  adjustment = c("BH", "Bonf")
)

## ----viewPathwayRanks---------------------------------------------------------
getPathpVals(colonSurv_aespcOut)

## ----match_abbrev_to_name-----------------------------------------------------
pVals_df <- 
  getPathpVals(colonSurv_aespcOut) %>% 
  mutate(
    terms = ifelse(
      str_length(terms) > 35,
      paste0(str_sub(terms, 1, 33), "..."),
      terms
    )
  )

pVals_df

## ----subset_top_genes---------------------------------------------------------
colonOutGather_df <-
  # Take in the results data frame,
  pVals_df %>%
  # "tidy" the data,
  gather(variable, value, -terms) %>%
  # add the score variable, and
  mutate(score = -log(value)) %>%
  # store the adjustment methods as a factor
  mutate(variable = factor(variable)) %>% 
  mutate(
    variable = recode_factor(
      variable,
      rawp = "None",
      FDR_BH = "Hochberg",
      FWER_Bonferroni = "Bonferroni"
    )
  )

## ----BH_pvals-----------------------------------------------------------------
BHpVals_df <- 
  colonOutGather_df %>% 
  filter(variable == "Hochberg") %>% 
  select(-variable)

## ----bar_plots, fig.height = 6, fig.width = 10.7, out.width = "100%", out.height = "60%"----
ggplot(BHpVals_df) +
  # set overall appearance of the plot
  theme_bw() +
  # Define the dependent and independent variables
  aes(x = reorder(terms, score), y = score) +
  # From the defined variables, create a vertical bar chart
  geom_col(position = "dodge", fill = "#F47321") +
  # Set main and axis titles
  ggtitle("AES-PCA Significant Pathways: Colon Cancer") +
  xlab("Pathways") +
  ylab("Negative Log BH-FDR") +
  # Add a line showing the alpha = 0.01 level
  geom_hline(yintercept = -log(0.01), size = 2, color = "#005030") +
  # Flip the x and y axes
  coord_flip()

## ----surv_aes_pval_plot, fig.height = 6, fig.width = 10.7, out.width = "100%", out.height = "60%"----
ggplot(colonOutGather_df) +
  # set overall appearance of the plot
  theme_bw() +
  # Define the dependent and independent variables
  aes(x = reorder(terms, score), y = score) +
  # From the defined variables, create a vertical bar chart
  geom_col(position = "dodge", aes(fill = variable)) +
  # Set the legend, main titles, and axis titles
  scale_fill_discrete(guide = FALSE) +
  ggtitle("AES-PCA Significant Colon Pathways by FWER Adjustment") +
  xlab("Pathways") +
  ylab("Negative Log p-Value") +
  # Add a line showing the alpha = 0.01 level
  geom_hline(yintercept = -log(0.01), size = 1) +
  # Flip the x and y axes
  coord_flip() + 
  # Create a subplot for each p-value adjustment method
  facet_grid(. ~ variable)

## ----significant_pathway_keys-------------------------------------------------
pVals_df %>% 
  filter(FDR_BH < 0.01) %>% 
  select(terms)

## ----path491_PCL--------------------------------------------------------------
pathway491_ls <- getPathPCLs(colonSurv_aespcOut, "PID_EPHB_FWD_PATHWAY")
pathway491_ls

## ----pathway177_PCL-----------------------------------------------------------
pathway177_ls <- getPathPCLs(colonSurv_aespcOut, "KEGG_ASTHMA")

## ----TidyLoading_fun----------------------------------------------------------
TidyLoading <- function(pathwayPCL, numPCs = 1){
  # browser()
  
  # Remove rows with 0 loading from the first numPCs columns
  loadings_df <- pathwayPCL$Loadings
  totLoad_num  <- rowSums(abs(
    loadings_df[, 2:(numPCs + 1), drop = FALSE]
  ))
  keepRows_idx <- totLoad_num > 0
  loadings_df <- loadings_df[keepRows_idx, , drop = FALSE]
  
  # Sort the value on first feature
  load_df <- loadings_df %>% 
    arrange(desc(PC1))
  
  # Wrangle the sorted loadings:
  gg_df <- load_df %>%
    # make the featureID column a factor, and rename the ID column,
    mutate(ID = factor(featureID, levels = featureID)) %>% 
    select(-featureID) %>% 
    # "tidy" the data, and
    gather(Feature, Value, -ID) %>% 
    # add the up / down indicator.
    mutate(Direction = ifelse(Value > 0, "Up", "Down"))
  
  # Add the pathway name and description
  attr(gg_df, "PathName") <- pathwayPCL$term
  attr(gg_df, "Description") <- pathwayPCL$description
  
  gg_df
  
}

## ----TidyLoadings-------------------------------------------------------------
tidyLoad491_df <- TidyLoading(pathwayPCL = pathway491_ls)
tidyLoad491_df

## ----TidyLoadings110, echo=FALSE----------------------------------------------
tidyLoad177_df <- TidyLoading(pathwayPCL = pathway177_ls)

## ----PathwayBarChart_fun------------------------------------------------------
PathwayBarChart <- function(ggData_df, y_lab,
                            colours = c(Up = "#009292", Down = "#920000"),
                            label_size = 5,
                            sigFigs = 0,
                            ...){
  
  # Base plot layer
  p1 <- ggplot(ggData_df, aes(x = ID, y = Value, color = Direction))
  
  # Add geometric layer and split by Feature
  p1 <- p1 +
    geom_col(aes(fill = Direction), width = 0.5) +
    facet_wrap(~Feature, nrow = length(unique(ggData_df$Feature)))
  
  # Add Gene Labels
  p1 <- p1 +
    geom_text(
      aes(y = 0, label = ID),
      vjust = "middle",
      hjust = ifelse(ggData_df$Direction == "Up", "top", "bottom"),
      size = label_size, angle = 90, color = "black"
    )
  
  # Add Value Labels
  p1 <- p1 +
    geom_text(
      aes(label = ifelse(ggData_df$Value == 0, "", round(Value, sigFigs))),
      vjust = ifelse(ggData_df$Direction == "Up", "top", "bottom"),
      hjust = "middle",
      size = label_size, color = "black"
    )
  
  # Set the Theme
  p1 <- p1 +
    scale_y_continuous(expand = c(0.15, 0.15)) +
    theme_classic() +
    theme(
      axis.title.x = element_blank(),
      axis.text.x  = element_blank(),
      axis.ticks.x = element_blank(),
      strip.text   = element_text(size = 14),
      legend.position = "none"
    )
  
  # Titles, Subtitles, and Labels
  pathName <- attr(ggData_df, "PathName")
  pathDesc <- attr(ggData_df, "Description")
  if(is.na(pathDesc)){
    p1 <- p1 + ggtitle(pathName) + ylab(y_lab)
  } else {
    p1 <- p1 + labs(title = pathName, subtitle = pathDesc, y = y_lab)
  }
  
  # Return
  p1
  
}

## ----pathway491_loadings_bar_chart, fig.height = 6, fig.width = 10.7, out.width = "100%", out.height = "60%"----

PathwayBarChart(
  ggData_df = tidyLoad491_df,
  y_lab = "PC Loadings",
  sigFigs = 2
)

## -----------------------------------------------------------------------------
# pathway177_loadings_bar_chart, fig.height = 6, fig.width = 10.7, out.width = "100%", out.height = "60%"
PathwayBarChart(
  ggData_df = tidyLoad177_df,
  y_lab = "PC Loadings",
  sigFigs = 2
)

## ----TidyCorrelation_fun------------------------------------------------------
TidyCorrelation <- function(Omics, pathwayPCL, numPCs = 1){
  
  loadings_df <- pathwayPCL$Loadings
  totLoad_num  <- rowSums(abs(
    loadings_df[, 2:(numPCs + 1), drop = FALSE]
  ))
  keepRows_idx <- totLoad_num > 0
  loadings_df <- loadings_df[keepRows_idx, , drop = FALSE]
  
  geneNames <- loadings_df$featureID
  geneCorr_mat <- t(
    cor(
      pathwayPCL$PCs[, -1],
      getAssay(Omics)[geneNames],
      method = "spearman"
    )
  )
  colnames(geneCorr_mat) <- paste0("PC", 1:ncol(geneCorr_mat))

  pathwayPCL$Loadings <- data.frame(
    featureID = rownames(geneCorr_mat),
    geneCorr_mat,
    stringsAsFactors = FALSE,
    row.names = NULL
  )
  
  TidyLoading(pathwayPCL, numPCs = numPCs)
  
}

## ----TidyCorrelation----------------------------------------------------------
tidyCorr491_df <- TidyCorrelation(
  Omics = colon_OmicsSurv,
  pathwayPCL = pathway491_ls
)
tidyCorr491_df

## ----TidyCorrelation2, echo=FALSE---------------------------------------------
tidyCorr177_df <- TidyCorrelation(
  Omics = colon_OmicsSurv,
  pathwayPCL = pathway177_ls
)

## ----pathway491_correlations_bar_chart, fig.height = 6, fig.width = 10.7, out.width = "100%", out.height = "60%"----

PathwayBarChart(
  ggData_df = tidyCorr491_df,
  y_lab = "Assay-PC Correlations",
  sigFigs = 1
)

## ----pathway177_correlations_bar_chart, fig.height = 6, fig.width = 10.7, out.width = "100%", out.height = "60%"----
PathwayBarChart(
  ggData_df = tidyCorr177_df,
  y_lab = "Assay-PC Correlations",
  sigFigs = 1
)

## ----circle plot of IL-1 pathway copyNum and proteomics pc1 score-------------
# Load data (already ordered by copyNumber PC1 score)
circlePlotData <- readRDS("circlePlotData.RDS")

# Set color scales
library(grDevices)
bluescale <- colorRampPalette(c("blue", "white"))(45)
redscale  <- colorRampPalette(c("white", "red"))(38)
Totalpalette <- c(bluescale,redscale)

# Apply colours
copyCol <-  Totalpalette[circlePlotData$copyNumOrder]
proteoCol <- Totalpalette[circlePlotData$proteinOrder]

## -----------------------------------------------------------------------------
library(circlize)

# Set parameters
nPathway <- 83
factors  <- 1:nPathway

# Plot Setup
circos.clear()
circos.par(
  "gap.degree" = 0,
  "cell.padding" = c(0, 0, 0, 0),
  start.degree = 360/40,
  track.margin = c(0, 0),
  "clock.wise" = FALSE
)
circos.initialize(factors = factors, xlim = c(0, 3))

# ProteoOmics
circos.trackPlotRegion(
  ylim = c(0, 3),
  factors = factors,
  bg.col = proteoCol,
  track.height = 0.3
)

# Copy Number
circos.trackPlotRegion(
  ylim = c(0, 3),
  factors = factors,
  bg.col = copyCol,
  track.height = 0.3
)

# Add labels
suppressMessages(
  circos.trackText(
    x = rep(-3, nPathway),
    y = rep(-3.8, nPathway),
    labels = "PID_IL1",
    factors = factors,
    col = "#2d2d2d",
    font = 2,
    adj = par("adj"),
    cex = 1.5,
    facing = "downward",
    niceFacing = TRUE
  )
)

## ----sessionDetails-----------------------------------------------------------
sessionInfo()

