[Skip to main content](#main-content)
[ ]

[ ]

`Ctrl`+`K`

[![Logo image](_static/cellsnake-logo-blue-small.png)](index.html)

Getting Started

* [Installation](installation.html)
* [Quick start example](quickstart.html)
* [Example run on Fetal Brain dataset](fetalbrain.html)
* [Example run on Fetal Liver dataset](fetalliver.html)
* [Metagenomics analysis](kraken.html)
* [How to draw marker plots](markers.html)
* [Config Files (Parameter Files)](configs.html)
* [Options and Arguments](options.html)
* Downstream analysis
* [Glossary](glossary.html)

* [.rst](_sources/downstream.rst "Download source file")
* .pdf

# Downstream analysis

# Downstream analysis[#](#downstream-analysis "Permalink to this headline")

Cellsnake provides RDS files for downstream analysis.

The RDS files are saved in the analyses or analyses\_integrated directories.

The RDS files can be loaded into R using the readRDS function.

For example, to load the Seurat object for the analysis with 10% MT threshold and 0.8 resolution, use the following command:

```
library(Seurat)
seurat_object <- readRDS("analyses/processed/percent_mt~10/resolution~0.8/sample_name.rds")
#integrated equivalent of this command is

seurat_object <- readRDS("analyses_integrated/processed/percent_mt~auto/resolution~0.8/integrated.rds")
```

Annotation of cell types for this same dataset can be found in the analyses/singler directory.

```
library(Seurat)
singler_predictions <- readRDS("analyses/singler/percent_mt~10/resolution~0.8/sample_name.rds")
```

Kraken2 predictions (metagenomics results) for this same dataset can be found in the analyses/kraken directory.

```
library(Seurat)
kraken_predictions <- readRDS("analyses/kraken/0_3/percent_mt~10/resolution~0.8/sample_name/microbiome-full-genus-level.rds") #genus level predictions
```

[previous

Options and Arguments](options.html "previous page")
[next

Glossary](glossary.html "next page")

By Sinan U. Umu

© Copyright 2023, Sinan U. Umu.