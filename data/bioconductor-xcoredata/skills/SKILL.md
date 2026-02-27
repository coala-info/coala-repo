---
name: bioconductor-xcoredata
description: This package provides curated FANTOM5 promoter annotations and ReMap2020 transcription factor binding signatures for the xcore framework. Use when user asks to load promoter definitions, access molecular signatures for gene expression modeling, or retrieve transcription factor binding data for activity analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/xcoredata.html
---


# bioconductor-xcoredata

name: bioconductor-xcoredata
description: Access and explore molecular signatures and promoter data for the xcore package. Use this skill to load FANTOM5 promoter annotations and ReMap2020 transcription factor binding signatures for gene expression modeling and transcription factor activity analysis.

## Overview
The `xcoredata` package is an experiment data package that provides essential genomic resources for the `xcore` framework. It primarily contains curated FANTOM5 promoter definitions and molecular signatures derived from ReMap2020 ChIP-seq data. These resources are used to bridge the gap between gene expression data and transcription factor activity.

## Loading Data
To use the data, load the library and call the specific accessor functions. The data is retrieved from a cache (ExperimentHub).

```R
library(xcoredata)

# Load FANTOM5 promoters (GRanges)
promoters <- promoters_f5()

# Load a "core" subset of FANTOM5 promoters
promoters_core <- promoters_f5_core()

# Load ReMap2020 molecular signatures (Sparse Matrix)
# Rows correspond to promoters, columns to TF experiments
signatures <- remap_promoters_f5()
```

## Key Data Objects
- **FANTOM5 Promoters**: Accessible via `promoters_f5()`. This returns a `GRanges` object containing genomic coordinates, gene symbols, and Entrez IDs. It is based on the hg38 genome assembly.
- **Core Promoters**: Accessible via `promoters_f5_core()`. A filtered subset of the FANTOM5 promoters typically used for more streamlined analyses.
- **ReMap2020 Signatures**: Accessible via `remap_promoters_f5()`. This returns a large sparse matrix (`dgCMatrix`) where 1 indicates a transcription factor binding peak overlaps with a specific promoter.

## Typical Workflow
1. **Initialize**: Load the package and the promoter set you intend to use for your expression analysis.
2. **Match Expression Data**: Ensure your expression matrix rows (genes/promoters) match the names or indices of the `GRanges` object returned by `promoters_f5()`.
3. **Load Signatures**: Load the signature matrix. The row names of the signature matrix are designed to match the names of the FANTOM5 promoter objects.
4. **Downstream Analysis**: Pass these objects to `xcore` functions to perform linear ridge regression or other modeling tasks to estimate transcription factor activities.

## Tips
- The first time you call these functions, they will download data from Bioconductor's ExperimentHub. Subsequent calls will load from your local cache.
- The signature matrix is very large; always handle it as a sparse matrix to save memory.
- Use `mcols(promoters_f5())` to access metadata like `SYMBOL` or `ENTREZID` for mapping your own data.

## Reference documentation
- [Exploring the data in xcoredata](./references/xcoredata.md)