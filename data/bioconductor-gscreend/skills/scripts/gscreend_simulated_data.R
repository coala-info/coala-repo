# Code example from 'gscreend_simulated_data' vignette. See references/ for full tutorial.

## ----eval = FALSE-------------------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("gscreend")

## ----message=FALSE------------------------------------------------------------
library(gscreend)
library(SummarizedExperiment)

## -----------------------------------------------------------------------------
raw_counts <- read.table(
    system.file("extdata", "simulated_counts.txt", package = "gscreend"),
    header=TRUE)

## -----------------------------------------------------------------------------
counts_matrix <- cbind(raw_counts$library0, 
                        raw_counts$R0_0, 
                        raw_counts$R1_0)

rowData <- data.frame(sgRNA_id = raw_counts$sgrna_id,
                    gene = raw_counts$Gene)

colData <- data.frame(samplename = c("library", "R1", "R2"),
                    # timepoint naming convention: 
                    # T0 -> reference, 
                    # T1 -> after proliferation
                    timepoint = c("T0", "T1", "T1"))

se <- SummarizedExperiment(assays=list(counts=counts_matrix),
                    rowData=rowData, colData=colData)

## -----------------------------------------------------------------------------
pse <- createPoolScreenExp(se)

## -----------------------------------------------------------------------------
pse_an <- RunGscreend(pse)


## ----fig.width=4, fig.height=4.5----------------------------------------------
plotReplicateCorrelation(pse_an)

## -----------------------------------------------------------------------------
plotModelParameters(pse_an) 

## -----------------------------------------------------------------------------
res <- ResultsTable(pse_an, direction = "negative")
head(res)

## -----------------------------------------------------------------------------
sessionInfo()

