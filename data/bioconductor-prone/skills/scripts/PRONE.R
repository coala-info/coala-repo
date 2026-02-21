# Code example from 'PRONE' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>", message = TRUE, warning = FALSE,
  fig.width=8,
  fig.height =6
)

## ----loading, eval = FALSE----------------------------------------------------
# # Official BioC installation instructions
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("PRONE")

## ----message = FALSE----------------------------------------------------------
# Load and attach PRONE
library(PRONE)

## ----echo=FALSE, fig.cap="Six-step workflow of PRONE.", out.width="700px"-----
knitr::include_graphics("../man/figures/Workflow_PRONE.png")

## ----load_real_tmt------------------------------------------------------------
data_path <- readPRONE_example("tuberculosis_protein_intensities.csv")
md_path <- readPRONE_example("tuberculosis_metadata.csv")

data <- read.csv(data_path)
md <- read.csv(md_path)

md$Column <- stringr::str_replace_all(md$Column, " ", ".")

ref_samples <- md[md$Group == "ref",]$Column

se <- load_data(data, md, protein_column = "Protein.IDs", 
                gene_column = "Gene.names", ref_samples = ref_samples, 
                batch_column = "Pool", condition_column = "Group", 
                label_column = "Label")


## ----load_real_lfq------------------------------------------------------------
data_path <- readPRONE_example("mouse_liver_cytochrome_P450_protein_intensities.csv")
md_path <- readPRONE_example("mouse_liver_cytochrome_P450_metadata.csv")

data <- read.csv(data_path, check.names = FALSE)
md <- read.csv(md_path)

se <- load_data(data, md, protein_column = "Accession", 
                gene_column = "Gene names", ref_samples = NULL, 
                batch_column = NULL, condition_column = "Condition", 
                label_column = NULL)

## -----------------------------------------------------------------------------
se

## -----------------------------------------------------------------------------
assays(se)

## -----------------------------------------------------------------------------
se <- normalize_se(se, c("Median", "LoessF"))

## -----------------------------------------------------------------------------
assays(se)

## ----eval = FALSE-------------------------------------------------------------
# if(!dir.exists("output/")) dir.create("output/")
# 
# export_data(se, out_dir = "output/", ain = c("log2", "Median", "LoessF"))

## -----------------------------------------------------------------------------
utils::sessionInfo()

