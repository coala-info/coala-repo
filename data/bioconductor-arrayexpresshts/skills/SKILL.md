---
name: bioconductor-arrayexpresshts
description: This tool provides an integrated RNA-Seq pipeline for processing raw sequence files into expression measurements and quality reports. Use when user asks to process public ArrayExpress datasets, analyze custom local RNA-seq data, perform read alignment, or estimate gene expression levels.
homepage: https://bioconductor.org/packages/3.8/bioc/html/ArrayExpressHTS.html
---


# bioconductor-arrayexpresshts

name: bioconductor-arrayexpresshts
description: RNA-Seq pipeline for transcription profiling. Use this skill to process raw sequence files into Bioconductor ExpressionSet objects, perform alignment, quality assessment, and expression estimation for both public ArrayExpress datasets and custom local RNA-seq data.

# bioconductor-arrayexpresshts

## Overview

The `ArrayExpressHTS` package provides an integrated pipeline for processing RNA-seq data. It automates the transition from raw FASTQ files to expression measurements (RPKM/FPKM) and quality control reports. It supports both public datasets (via ArrayExpress accession numbers) and custom user-provided datasets.

## Core Workflows

### 1. Processing Public ArrayExpress Datasets
To process a dataset already hosted on ArrayExpress, you only need the accession number.

```r
library(ArrayExpressHTS)

# Run the pipeline for a specific accession
# usercloud = FALSE is used for local execution
aehts <- ArrayExpressHTS("E-GEOD-16190", usercloud = FALSE)

# The result is an ExpressionSet object
# It is also saved as 'eset_notstd_rpkm.RData' in the experiment folder
```

### 2. Processing Custom Local Datasets
For custom data, you must organize files into a specific directory structure and provide metadata (IDF and SDRF files).

**Directory Structure:**
- `experiment_name/`
  - `data/`
    - `*.fastq` (or `*_1.fastq` and `*_2.fastq` for paired-end)
    - `experiment.idf.txt`
    - `experiment.sdrf.txt`

**Execution:**
```r
# Run the pipeline on the local folder
aehts <- ArrayExpressHTS(accession = "my_experiment", 
                         organism = "Homo_sapiens", 
                         dir = getwd(), 
                         usercloud = FALSE)
```

### 3. Preparing References and Annotations
If the required organism reference is not available, use the built-in preparation functions to fetch data from Ensembl.

```r
# Prepare genome and transcriptome references
referencefolder <- "./reference"
dir.create(referencefolder)

prepareReference("Homo_sapiens", type = "genome", location = referencefolder)
prepareReference("Homo_sapiens", type = "transcriptome", location = referencefolder)

# Prepare annotation
prepareAnnotation("Homo_sapiens", "current", location = referencefolder)
```

## Configuration Options

You can customize the pipeline behavior using the `options` parameter (a list):

| Option | Values | Description |
| :--- | :--- | :--- |
| `aligner` | 'tophat', 'bowtie', 'bwa' | The alignment tool to use. |
| `count_method` | 'cufflinks', 'mmseq', 'count' | Method for expression estimation. |
| `standardise` | TRUE, FALSE | TRUE returns FPKM; FALSE returns raw counts. |
| `reference` | 'genome', 'transcriptome' | Target for alignment. |
| `normalisation` | 'none', 'tmm' | Normalization method (TMM uses edgeR). |
| `stranded` | TRUE, FALSE | Set TRUE for strand-specific protocols. |

**Example with custom options:**
```r
custom_opts <- list(
    insize = 200,
    count_method = "mmseq",
    aligner = "tophat",
    standardise = TRUE
)

aehts <- ArrayExpressHTS("E-GEOD-16190", options = custom_opts, usercloud = FALSE)
```

## Handling Results

The pipeline produces an `ExpressionSet` object.

```r
# Access expression values
expression_matrix <- exprs(aehts)
head(expression_matrix)

# Access sample metadata
sample_metadata <- pData(aehts)

# Access feature metadata
feature_metadata <- fData(aehts)
```

## Tips and Best Practices
- **Local vs. Cloud:** By default, the package tries to use the EBI R Cloud. For local use, always set `usercloud = FALSE`.
- **External Tools:** Ensure `samtools`, `bowtie`/`tophat`, and `cufflinks` are installed and in your system PATH, or set them via `setPipelineOptions`.
- **Memory:** RNA-seq alignment is resource-intensive. Ensure your local machine has sufficient RAM (typically 8GB-16GB+ depending on genome size).
- **Reports:** The pipeline generates HTML quality reports in the experiment subfolders (e.g., `experiment/report` or `experiment/tophat_out/report`).

## Reference documentation
- [An Introduction to ArrayExpressHTS : RNA-Seq Pipeline](./references/ArrayExpressHTS.md)