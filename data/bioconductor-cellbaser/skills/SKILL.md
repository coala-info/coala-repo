---
name: bioconductor-cellbaser
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/cellbaseR.html
---

# bioconductor-cellbaser

## Overview
The `cellbaseR` package provides an R interface to the CellBase RESTful Web service. It allows for high-throughput retrieval of biological information, including genomic features (genes, transcripts, proteins), variations, and clinical annotations, all integrated into a single database.

## Core Workflow

### 1. Initialization
To start, create a `CellBaseR` object which manages the connection settings (default is Human, GRCh37).

```r
library(cellbaseR)
cb <- CellBaseR()
# For specific assembly
# cb <- CellBaseR(assembly = "grch38")
```

### 2. Querying Genomic Features
Most functions follow the pattern `get<Category>(object, ids, resource)`.

*   **Genes**: Retrieve info, transcripts, or constraints.
    ```r
    res <- getGene(object = cb, ids = c("TP73", "TET1"), resource = "info")
    # Access nested transcripts
    transcripts <- res$transcripts[[1]]
    ```
*   **Regions**: Query specific genomic coordinates for conservation or regulatory data.
    ```r
    res <- getRegion(object = cb, ids = "17:1000000-1005000", resource = "conservation")
    ```
*   **Variants**: Get functional annotations for specific variants.
    ```r
    res <- getVariant(object = cb, ids = "1:169549811:A:G", resource = "annotation")
    res_data <- cbData(res)
    ```

### 3. Clinical Data and Filtering
Use `CellBaseParam` to apply filters like gene features, assembly, or limits.

```r
cbparam <- CellBaseParam(feature = "TET1", assembly = "grch38", limit = 50)
res <- getClinical(object = cb, param = cbparam)
```

### 4. Specialized Utilities
*   **VCF Annotation**: Annotate local VCF files using the CellBase server without downloading large datasets.
    ```r
    fl <- system.file("extdata", "hapmap_exome_chr22_200.vcf.gz", package = "cellbaseR")
    res <- AnnotateVcf(object = cb, file = fl, batch_size = 100)
    ```
*   **Gene Models**: Create data frames compatible with the `Gviz` package for visualization.
    ```r
    model <- createGeneModel(object = cb, region = "17:1500000-1550000")
    ```

## Wrapper Functions
For convenience, `cellbaseR` provides direct wrappers for common queries:
- `getGeneInfo(ids)`
- `getTranscriptByGene(ids)`
- `getProteinInfo(ids)`
- `getVariantAnnotation(ids)`
- `getClinicalByGene(ids)`
- `getConservationByRegion(ids)`

## Tips
- **Data Structure**: Results are typically returned as `data.frame` objects. Some columns (like `transcripts` in a gene query) are list-columns containing nested data frames.
- **Batching**: When using `AnnotateVcf`, adjust `batch_size` and `BPPARAM` (for parallel processing) based on your network speed and local resources.

## Reference documentation
- [Simplifying Genomic Annotations in R](./references/cellbaseR.md)
- [cellbaseR Vignette Source](./references/cellbaseR.Rmd)