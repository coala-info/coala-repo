---
name: r-virfinder
description: VirFinder identifies viral sequences from assembled metagenomic data using k-mer signatures and logistic regression models. Use when user asks to predict viral contigs in FASTA files, estimate false discovery rates for viral predictions, or train custom viral detection models.
homepage: https://cran.r-project.org/web/packages/virfinder/index.html
---

# r-virfinder

name: r-virfinder
description: Identifying viral sequences from assembled metagenomic data using k-mer signatures. Use this skill when you need to predict viral contigs in FASTA files, estimate false discovery rates (q-values) for viral predictions, or train custom viral detection models using specific host/virus databases.

# r-virfinder

## Overview
VirFinder is an R package for identifying viral sequences from metagenomic data using sequence signatures (k-tuple word frequencies). It is particularly effective for short (~1kb) and novel viral sequences. It uses a logistic regression model trained on k-mer frequencies to distinguish between viral and host (prokaryotic) sequences.

## Installation
To install the dependencies and the package:
```R
install.packages("glmnet", dependencies=TRUE)
install.packages("Rcpp", dependencies=TRUE)

# Install qvalue from Bioconductor
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("qvalue")

# Install VirFinder from GitHub or local source
# install.packages("VirFinder_1.1.tar.gz", repos = NULL, type="source")
```

## Core Workflow

### Predicting Viral Sequences
The primary function `VF.pred()` takes a FASTA file and returns a data frame with sequence names, lengths, scores, and p-values. Higher scores and lower p-values indicate a higher likelihood of being viral.

```R
library(VirFinder)

# 1. Run prediction
predResult <- VF.pred("path/to/contigs.fa")

# 2. Estimate q-values (False Discovery Rate)
predResult$qvalue <- VF.qvalue(predResult$pvalue)

# 3. Filter or sort results
# Sort by p-value
predResult <- predResult[order(predResult$pvalue), ]

# Filter for high-confidence viral contigs (e.g., p < 0.05)
viralContigs <- predResult[predResult$pvalue < 0.05, ]
```

### Training Custom Models
Users can train models on specific datasets (e.g., to include eukaryotic viruses or specific host niches).

```R
# 1. Define training files
trainHost <- "path/to/host_sequences.fa"
trainVirus <- "path/to/virus_sequences.fa"
modDir <- "path/to/output_dir"
modName <- "customModel"

# 2. Train the model (w = k-mer length, e.g., 4 to 8)
# Note: Increasing k-mer length increases accuracy but requires more data/time
customMod <- VF.train.user(trainHost, trainVirus, modDir, modName, w=4, equalSize=TRUE)

# 3. Predict using the custom model
predResultUser <- VF.pred.user("path/to/input.fa", customMod)
```

### Using Pre-trained Eukaryotic Virus Models
If using the specialized `VF.modEPV_k8.rda` model (for prokaryotic + eukaryotic viruses):

```R
load("VF.modEPV_k8.rda")
predResult <- VF.pred.user("input.fasta", modEPV)
```

## Usage Tips
- **Sequence Length**: VirFinder works on contigs as short as 500bp, but accuracy improves significantly with longer sequences (1kb - 3kb+).
- **Eukaryotic Contamination**: If your sample contains eukaryotic host DNA (e.g., human), filter those out before running VirFinder, as it may misidentify eukaryotic fragments as viral.
- **q-value Errors**: If `VF.qvalue` returns an error regarding `pi0 <= 0`, it usually means the p-value distribution is skewed, often because there are too few host (background) contigs in the dataset.
- **Parallelization**: For large datasets, consider using parallel wrappers to run `VF.pred` across multiple cores.

## Reference documentation
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)
- [licence.md](./references/licence.md)