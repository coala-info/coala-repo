---
name: r-seqminer
description: The r-seqminer package efficiently retrieves, annotates, and manipulates genetic variant data from VCF, BCF, and BGEN files. Use when user asks to extract genotypes by genomic range or gene name, perform rare variant analysis, or annotate variants within R workflows.
homepage: https://cloud.r-project.org/web/packages/seqminer/index.html
---

# r-seqminer

name: r-seqminer
description: Efficiently read, annotate, and manipulate genetic variant data from VCF and BCF files. Use this skill when you need to perform rare variant analysis, extract specific genomic regions, or integrate variant information into R workflows for bioinformatics and statistical genetics.

# r-seqminer

## Overview
The `seqminer` package provides highly efficient tools for retrieving and manipulating genetic variants from large-scale datasets (VCF/BCF/BGEN). It is particularly optimized for rare variant analysis, allowing users to extract data by genomic coordinates or gene names, and annotate variants using various databases.

## Installation
To install the package from CRAN:
```R
install.packages("seqminer")
```

## Core Workflows

### Reading VCF/BCF Data
The primary function for data extraction is `readVCFToMatrixByRange`.

```R
library(seqminer)

# Define file path and genomic range
vcfFile <- "path/to/your/file.vcf.gz"
range <- "1:1000000-2000000"

# Extract genotypes as a matrix (Rows: Samples, Cols: Variants)
genotypeMatrix <- readVCFToMatrixByRange(vcfFile, range, annoType = "")
```

### Gene-Based Extraction
If the VCF is indexed and you have a gene definition file (e.g., RefSeq), you can extract by gene name.

```R
geneFile <- "path/to/gene_definition.txt"
genotypes <- readVCFToMatrixByGene(vcfFile, geneFile, "MYC", annoType = "")
```

### Annotation and Filtering
`seqminer` can filter variants based on functional annotations if the VCF contains an `INFO` field with annotation strings.

```R
# Extract only non-synonymous variants
nsGenotypes <- readVCFToMatrixByRange(vcfFile, range, annoType = "Nonsynonymous")
```

### Working with BGEN Files
For UK Biobank style data, use the BGEN specific functions:

```R
bgenFile <- "data.bgen"
bgenIndex <- "data.bgen.bgi"
range <- "1:1000-2000"

# Read BGEN probabilities
data <- readBGENToMatrixByRange(bgenFile, bgenIndex, range)
```

## Key Functions
- `tabix.read.table`: General purpose reader for any tabix-indexed file.
- `rvtests`: Interface for performing rare variant association tests.
- `annotateVCF`: Add functional annotations to an existing VCF file.
- `vcfToVCF`: Convert or subset VCF files efficiently.

## Tips
- **Indexing**: Always ensure your VCF files are compressed with `bgzip` and indexed with `tabix` before using `seqminer`.
- **Memory Efficiency**: `seqminer` is designed to load only the requested regions into memory, making it suitable for very large datasets.
- **Matrix Format**: By default, genotypes are coded as 0, 1, 2 (number of alternate alleles). Missing values are typically handled as `NA` or 0 depending on function parameters.

## Reference documentation
None