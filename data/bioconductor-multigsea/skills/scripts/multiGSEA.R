# Code example from 'multiGSEA' vignette. See references/ for full tutorial.

## ----bioconductor, eval=FALSE-------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#   install.packages("BiocManager")
# }
# 
# # The following initializes usage of Bioc devel
# BiocManager::install(version = "devel")
# 
# BiocManager::install("multiGSEA")

## ----devtools, eval=FALSE-----------------------------------------------------
# install.packages("devtools")
# devtools::install_github("https://github.com/yigbt/multiGSEA")

## ----load_multiGSEA, eval=FALSE-----------------------------------------------
# library(multiGSEA)

## ----load_mapping_library, results='hide', warning=FALSE, message=FALSE-------
library("org.Hs.eg.db")

## ----organismsTable, results='asis', echo=FALSE-------------------------------
caption <- "Supported organisms, their abbreviations being used in `multiGSEA`,
            and mapping database that are needed for feature conversion.
            Supported abbreviations can be seen with `getOrganisms()`"
df <- data.frame(
  Organisms = c(
    "Human", "Mouse", "Rat", "Dog", "Cow", "Pig",
    "Chicken", "Zebrafish", "Frog", "Fruit Fly",
    "C.elegans"
  ),
  Abbreviations = c(
    "hsapiens", "mmusculus", "rnorvegicus",
    "cfamiliaris", "btaurus", "sscrofa",
    "ggallus", "drerio", "xlaevis",
    "dmelanogaster", "celegans"
  ),
  Mapping = c(
    "org.Hs.eg.db", "org.Mm.eg.db", "org.Rn.eg.db",
    "org.Cf.eg.db", "org.Bt.eg.db", "org.Ss.eg.db",
    "org.Gg.eg.db", "org.Xl.eg.db", "org.Dr.eg.db",
    "org.Dm.eg.db", "org.Ce.eg.db"
  )
)

knitr::kable(df, caption = caption)

## ----load_multiGSEA_package, results='hide', message=FALSE, warning=FALSE-----
library(multiGSEA)
library(magrittr)

## ----load_omics_data----------------------------------------------------------
# load transcriptomic features
data(transcriptome)

# load proteomic features
data(proteome)

# load metabolomic features
data(metabolome)

## ----omicsTable, results='asis', echo=FALSE-----------------------------------
caption <- "Structure of the necessary omics data. For each layer
            (here: transcriptome), feature IDs, log2FCs, and p-values
            are needed."

knitr::kable(
  transcriptome %>%
    dplyr::arrange(Symbol) %>%
    dplyr::slice(1:6),
  caption = caption
)

## ----rank_features, results='hide'--------------------------------------------
# create data structure
omics_data <- initOmicsDataStructure(layer = c(
  "transcriptome",
  "proteome",
  "metabolome"
))

## add transcriptome layer
omics_data$transcriptome <- rankFeatures(
  transcriptome$logFC,
  transcriptome$pValue
)
names(omics_data$transcriptome) <- transcriptome$Symbol

## add proteome layer
omics_data$proteome <- rankFeatures(proteome$logFC, proteome$pValue)
names(omics_data$proteome) <- proteome$Symbol

## add metabolome layer
## HMDB features have to be updated to the new HMDB format
omics_data$metabolome <- rankFeatures(metabolome$logFC, metabolome$pValue)
names(omics_data$metabolome) <- metabolome$HMDB
names(omics_data$metabolome) <- gsub(
  "HMDB", "HMDB00",
  names(omics_data$metabolome)
)

## ----omics_short--------------------------------------------------------------
omics_short <- lapply(names(omics_data), function(name) {
  head(omics_data[[name]])
})
names(omics_short) <- names(omics_data)
omics_short

## ----calculate_enrichment, results='hide', message=FALSE, warning=FALSE-------
databases <- c("kegg", "reactome")
layers <- names(omics_data)

pathways <- getMultiOmicsFeatures(
  dbs = databases, layer = layers,
  returnTranscriptome = "SYMBOL",
  returnProteome = "SYMBOL",
  returnMetabolome = "HMDB",
  useLocal = FALSE
)

## ----pathways_short-----------------------------------------------------------
pathways_short <- lapply(names(pathways), function(name) {
  head(pathways[[name]], 2)
})
names(pathways_short) <- names(pathways)
pathways_short

## ----run_enrichment, results='hide', message=FALSE, warning=FALSE-------------
# use the multiGSEA function to calculate the enrichment scores
# for all omics layer at once.
enrichment_scores <- multiGSEA(pathways, omics_data)

## ----combine_pvalues----------------------------------------------------------
df <- extractPvalues(
  enrichmentScores = enrichment_scores,
  pathwayNames = names(pathways[[1]])
)

df$combined_pval <- combinePvalues(df)
df$combined_padj <- p.adjust(df$combined_pval, method = "BH")

df <- cbind(data.frame(pathway = names(pathways[[1]])), df)

## ----resultTable, results='asis', echo=FALSE----------------------------------
caption <- "Table summarizing the top 15 pathways where we can calculate an
            enrichment for all three layers . Pathways from KEGG, Reactome,
            and BioCarta are listed based on their aggregated adjusted p-value.
            Corrected p-values are displayed for each omics layer separately and
            aggregated by means of the Stouffer's Z-method."

knitr::kable(
  df %>%
    dplyr::arrange(combined_padj) %>%
    dplyr::filter(!is.na(metabolome_padj)) %>%
    dplyr::select(c(pathway, transcriptome_padj, proteome_padj, metabolome_padj, combined_pval)) %>%
    dplyr::slice(1:15),
  caption = caption
)

## ----msigdbr, eval=FALSE------------------------------------------------------
# library(msigdbr)
# library(dplyr)
# 
# hallmark <- msigdbr(species = "Rattus norvegicus", category = "H") %>%
#   dplyr::select(gs_name, ensembl_gene) %>%
#   dplyr::filter(!is.na(ensembl_gene)) %>%
#   unstack(ensembl_gene ~ gs_name)
# 
# pathways <- list("transcriptome" = hallmark)

## ----session, echo=FALSE------------------------------------------------------
sessionInfo()

