# Code example from 'data_import' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  message = FALSE,
  digits = 3,
  collapse = TRUE,
  comment = "#>"
)
options(digits = 3)

## -----------------------------------------------------------------------------
suppressPackageStartupMessages(library(mia))
suppressPackageStartupMessages(library(phyloseq))

## -----------------------------------------------------------------------------
# Example of a rich dense biom file
rich_dense_biom  <-
  system.file("extdata", "rich_dense_otu_table.biom",  package = "phyloseq")

# Import biom as a phyloseq-class object
phy <- phyloseq::import_biom(
  rich_dense_biom,  
  parseFunction = parse_taxonomy_greengenes
)

phy

# Print sample_data
phyloseq::sample_data(phy)

# Print tax_table
phyloseq::tax_table(phy)

# Recipe init
rec <- dar::recipe(phy, var_info = "BODY_SITE", tax_info = "Genus")

rec

## -----------------------------------------------------------------------------
# Example of a rich dense biom file
rich_dense_biom  <-
  system.file("extdata", "rich_dense_otu_table.biom",  package = "phyloseq")

# Import biom as a phyloseq-class object
tse <- mia::importBIOM(rich_dense_biom)

tse

# Print sample_data
colData(tse)

# Print tax_table
rowData(tse)

# Change the column names of the tax_table
colnames(rowData(tse)) <- 
  c("Kingdom", "Phylum", "Class", "Order", "Family", "Genus", "Species")

rowData(tse)

# Recipe init
rec <- dar::recipe(tse, var_info = "BODY_SITE", tax_info = "Genus")

rec

## -----------------------------------------------------------------------------
# Import QIIME data
phy_qiime <- phyloseq::import_qiime(
  otufilename = system.file("extdata", "GP_otu_table_rand_short.txt.gz", package = "phyloseq"),
  mapfilename = system.file("extdata", "master_map.txt", package = "phyloseq"),
  treefilename = system.file("extdata", "GP_tree_rand_short.newick.gz", package = "phyloseq")
)

phy_qiime

# Recipe init
rec <- dar::recipe(phy_qiime, var_info = "SampleType", tax_info = "Genus")

rec

## -----------------------------------------------------------------------------
# Import QIIME data to tse
tse_qiime <- mia::importQIIME2(
  featureTableFile = system.file("extdata", "table.qza", package = "mia"),
  taxonomyTableFile = system.file("extdata", "taxonomy.qza", package = "mia"),
  sampleMetaFile = system.file("extdata", "sample-metadata.tsv", package = "mia"),
  refSeqFile = system.file("extdata", "refseq.qza", package = "mia"),
  phyTreeFile = system.file("extdata", "tree.qza", package = "mia")
)

tse_qiime

# Recipe init
rec <- dar::recipe(tse_qiime, var_info = "body.site", tax_info = "genus")

rec

## -----------------------------------------------------------------------------
# Import Mothur data
phy_mothur <- phyloseq::import_mothur(
  mothur_list_file = system.file("extdata", "esophagus.fn.list.gz", package = "phyloseq"),
  mothur_group_file = system.file("extdata", "esophagus.good.groups.gz", package = "phyloseq"),
  mothur_tree_file = system.file("extdata", "esophagus.tree.gz", package = "phyloseq")
)

phy_mothur

# Recipe init
rec <- dar::recipe(phy_mothur)

rec

## -----------------------------------------------------------------------------
# Import Mothur data to TreeSummarizedExperiment
tse_mothur <- mia::importMothur(
  sharedFile = system.file("extdata", "mothur_example.shared", package = "mia"),
  taxonomyFile = system.file("extdata", "mothur_example.cons.taxonomy", package = "mia"),
  designFile = system.file("extdata", "mothur_example.design", package = "mia")
) |> methods::as("TreeSummarizedExperiment")

tse_mothur

# Recipe init
rec <- dar::recipe(tse_mothur, var_info = "drug", tax_info = "Genus")

rec

## -----------------------------------------------------------------------------
# Importing data from Metaphlan
tse_metaphlan <- mia::importMetaPhlAn(
  file = system.file("extdata", "merged_abundance_table.txt", package = "mia")
)

# Recipe init
tse_metaphlan <- TreeSummarizedExperiment::TreeSummarizedExperiment(
  assays = list(counts = SummarizedExperiment::assay(tse_metaphlan)),
  rowData = SummarizedExperiment::rowData(tse_metaphlan),
  colData = SummarizedExperiment::colData(tse_metaphlan) |> 
    as.data.frame() |> 
    dplyr::mutate(condition = rep(c("A", "B"), times = 3))
)

rec <- dar::recipe(tse_metaphlan, var_info = "condition", tax_info = "Genus")

rec

## -----------------------------------------------------------------------------
devtools::session_info()

