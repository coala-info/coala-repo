---
name: r-genomictools.filehandler
description: This R package provides tools for reading and writing common genomic file formats like FASTA, FASTQ, BED, GFF, GTF, VCF, and PED/MAP as data.table objects. Use when user asks to import genomic data into R, export data frames to standard genomic formats, or convert between different genomic file types.
homepage: https://cran.r-project.org/web/packages/genomictools.filehandler/index.html
---


# r-genomictools.filehandler

name: r-genomictools.filehandler
description: R package for reading and writing common genomic file formats including FASTA, FASTQ, BED, GFF, GTF, VCF, and PED/MAP. Use this skill when you need to import genomic data into R as data.table objects or export R data frames to standard genomic formats.

# r-genomictools.filehandler

## Overview
The `genomictools.filehandler` package provides a collection of I/O tools designed for efficient handling of genomic data. It leverages the speed of `data.table` to process large genomic files and integrates with `snpStats` for genetic data analysis. It is particularly useful for bioinformaticians needing a lightweight, consistent interface for switching between different genomic file types.

## Installation
To install the package from CRAN, use the following command in R:

```R
install.packages("GenomicTools.fileHandler")
```

## Core Functions

### Annotation and Feature Files
The package provides functions to import and export common genomic interval formats. These functions typically return `data.table` objects.

*   **BED Files**:
    *   `importBED(file)`: Reads a BED file.
    *   `exportBED(x, file)`: Writes a data frame or data.table to a BED file.
*   **GFF/GTF Files**:
    *   `importGFF(file)`: Reads GFF formatted files.
    *   `importGTF(file)`: Reads GTF formatted files.
    *   `exportGFF(x, file)` and `exportGTF(x, file)`: Exports data to these formats.

### Sequence Files
*   **FASTA**: `importFASTA(file)` reads FASTA files into a structured format.
*   **FASTQ**: `importFASTQ(file)` handles high-throughput sequencing read files.

### Genetic Variation and Pedigree Files
*   **VCF**: `importVCF(file)` imports Variant Call Format files.
*   **PED/MAP**: 
    *   `importPED(file)`: Imports PLINK format pedigree files.
    *   `importMAP(file)`: Imports PLINK format marker information files.

## Common Workflows

### Converting Genomic Intervals
A common task is reading a GTF file to extract gene coordinates and then saving them as a BED file for use in other tools:

```R
library(GenomicTools.fileHandler)

# Import a GTF file
gtf_data <- importGTF("annotations.gtf")

# Filter or manipulate using data.table syntax
# (e.g., keeping only 'gene' features)
genes_only <- gtf_data[feature == "gene"]

# Export to BED format
exportBED(genes_only, "genes.bed")
```

### Handling VCF Data
When working with VCF files, the package allows for quick import into the R environment for downstream filtering:

```R
# Import VCF
vcf_content <- importVCF("variants.vcf")

# The resulting object allows access to header and body information
# Body is typically a data.table
head(vcf_content$vcf)
```

## Tips for Success
1.  **Data.table Integration**: Since the package depends on `data.table`, you can use fast subsetting and manipulation on the imported objects immediately.
2.  **Memory Management**: For very large VCF or FASTQ files, ensure your R session has sufficient RAM, as these functions load the data into memory.
3.  **Column Consistency**: When exporting to BED or GFF, ensure your data frame columns match the expected standard formats (e.g., chrom, start, end for BED) to maintain file integrity.

## Reference documentation
- [GenomicTools.fileHandler Home Page](./references/home_page.md)