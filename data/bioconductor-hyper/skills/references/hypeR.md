# hypeR

Anthony Federico1,2 and Stefano Monti1,2

1Boston University School of Medicine, Boston, MA
2Bioinformatics Program, Boston University, Boston, MA

#### December 8, 2025

#### Package

hypeR 2.8.2

# Contents

* [1 Introduction](#introduction)
* [2 Documentation](#documentation)
* [3 Requirements](#requirements)
* [4 Installation](#installation)
* [5 Usage](#usage)
  + [5.1 Signature](#signature)
  + [5.2 Geneset](#geneset)
  + [5.3 Downloading Genesets](#downloading-genesets)
  + [5.4 Enrichment](#enrichment)
  + [5.5 Reproducibility](#reproducibility)
  + [5.6 Downstream Methods](#downstream-methods)

# 1 Introduction

Geneset enrichment is an important step in biological data analysis workflows, particularly in bioinformatics and computational biology. At a basic level, one is performing a hypergeometric or Kol-mogorov–Smirnov test to determine if a group of genes is over-represented or enriched, respectively, in pre-defined sets of genes, which suggests some biological relevance. The R package hypeR brings a fresh take to geneset enrichment, focusing on the analysis, visualization, and reporting of enriched genesets. While similar tools exists - such as Enrichr (Kuleshov et al., 2016), fgsea (Sergushichev, 2016), and clusterProfiler (Wang et al., 2012), among others - hypeR excels in the downstream analysis of gene-set enrichment workflows – in addition to sometimes overlooked upstream analysis methods such as allowing for a flexible back-ground population size or reducing genesets to a background distribution of genes. Finding relevant biological meaning from a large number of often obscurely labeled genesets may be challenging for researchers. hypeR overcomes this barrier by incorporating hierarchical ontologies - also referred to as relational genesets - into its workflows, allowing researchers to visualize and summarize their data at varying levels of biological resolution. All analysis methods are compatible with hypeR’s markdown features, enabling concise and reproducible reports easily shareable with collaborators. Additionally, users can import custom genesets that are easily defined, extending the analysis of genes to other areas of interest such as proteins, microbes, metabolites, etc. The hypeR package goes beyond performing basic enrichment, by providing a suite of methods designed to make routine geneset enrichment seamless for scientists working in R.

# 2 Documentation

Please visit <https://montilab.github.io/hypeR-docs/> for documentation, examples, and demos for all features and usage or read our recent paper [hypeR: An R Package for Geneset Enrichment Workflows](https://doi.org/10.1093/bioinformatics/btz700) published in *Bioinformatics*.

# 3 Requirements

We recommend the latest version of R (>= 4.0.0) but **hypeR** currently requires R (>= 3.6.0) to be installed directly from Github or Bioconductor. To install with R (>= 3.5.0) see below. Use with R (< 3.5.0) is not recommended.

# 4 Installation

Install the development version of the package from Github.

```
devtools::install_github("montilab/hypeR")
```

Or install the development version of the package from Bioconductor.

```
BiocManager::install("montilab/hypeR", version="devel")
```

Or install with Conda.

```
conda create --name hyper
source activate hyper
conda install -c r r-devtools
R
library(devtools)
devtools::install_github("montilab/hypeR")
```

Or install with previous versions of R.

```
git clone https://github.com/montilab/hypeR
nano hypeR/DESCRIPTION
# Change Line 8
# Depends: R (>= 3.6.0) -> Depends: R (>= 3.5.0)
R
install.packages("path/to/hypeR", repos=NULL, type="source")
```

# 5 Usage

## 5.1 Signature

**hypeR** employs multiple types of enrichment analyses (e.g. hypergeometric, kstest, gsea). Depending on the type, different kinds of signatures are expected. There are three types of signatures `hypeR()` expects.

```
# Simply a character vector of symbols (hypergeometric)
signature <- c("GENE1", "GENE2", "GENE3")

# A ranked character vector of symbols (kstest)
ranked.signature <- c("GENE2", "GENE1", "GENE3")

# A ranked named numerical vector of symbols with ranking weights (gsea)
weighted.signature <- c("GENE2"=1.22, "GENE1"=0.94, "GENE3"=0.77)
```

## 5.2 Geneset

A geneset is simply a list of vectors, therefore, one can use any custom geneset in their analyses, as long as it’s appropriately defined.

```
genesets <- list("GSET1" = c("GENE1", "GENE2", "GENE3"),
                 "GSET2" = c("GENE4", "GENE5", "GENE6"),
                 "GSET3" = c("GENE7", "GENE8", "GENE9"))
```

## 5.3 Downloading Genesets

```
BIOCARTA <- msigdb_gsets(species="Homo sapiens", collection="C2", subcollection="CP:BIOCARTA")
KEGG     <- msigdb_gsets(species="Homo sapiens", collection="C2", subcollection="CP:KEGG_LEGACY")
REACTOME <- msigdb_gsets(species="Homo sapiens", collection="C2", subcollection="CP:REACTOME")
```

## 5.4 Enrichment

All workflows begin with performing hyper enrichment with `hyper()`. Often we are just interested in a single signature, as described above. In this case, `hyper()` will return a `hyp` object. This object contains relevant information to the enrichment results and is recognized by downstream methods.

```
hyp_obj <- hypeR(signature, genesets)
```

## 5.5 Reproducibility

All data related to enrichment arguments, parameters, and results and stored into a single `hyp` object. Saving your `hyp` objects will enable reproducible enrichment workflows.

```
hyp_obj$info
```

```
$hypeR
[1] "v2.8.2"

$`Signature Head`
[1] "GENE1,GENE2,GENE3"

$`Signature Size`
[1] "3"

$`Signature Type`
[1] "symbols"

$Genesets
[1] "Custom "

$Background
[1] "23467"

$`P-Value`
[1] "1"

$FDR
[1] "1"

$Test
[1] "hypergeometric"

$Power
[1] "1"

$Absolute
[1] "FALSE"
```

## 5.6 Downstream Methods

```
# Show interactive table
hyp_show(hyp_obj)

# Plot dots plot
hyp_dots(hyp_obj)

# Plot enrichment map
hyp_emap(hyp_obj)

# Plot hiearchy map (relational genesets)
hyp_hmap(hyp_obj)

# Map enrichment to an igraph object (relational genesets)
hyp_to_graph(hyp_obj)

# Save to excel
hyp_to_excel(hyp_obj, file_path="hypeR.xlsx")

# Save to table
hyp_to_table(hyp_obj, file_path="hypeR.txt")

# Generate markdown report
hyp_to_rmd(hyp_obj,
           file_path="hypeR.rmd",
           title="Hyper Enrichment (hypeR)",
           subtitle="YAP, TNF, and TAZ Knockout Experiments",
           author="Anthony Federico, Stefano Monti")
```