---
name: bioconductor-easyrnaseq
description: This tool quantifies RNA-Seq data by summarizing BAM files into gene or exon count tables using genomic annotations. Use when user asks to generate count matrices from BAM files, create synthetic transcripts to handle overlapping features, or automate RNA-Seq quantification workflows.
homepage: https://bioconductor.org/packages/release/bioc/html/easyRNASeq.html
---


# bioconductor-easyrnaseq

name: bioconductor-easyrnaseq
description: Specialized workflow for RNA-Seq quantification using the easyRNASeq Bioconductor package. Use this skill when you need to process BAM files and annotations to generate gene or exon count tables, create synthetic transcripts to avoid multiple counting, or perform biological QA on RNA-Seq data.

# bioconductor-easyrnaseq

## Overview

The `easyRNASeq` package simplifies the process of quantifying RNA-Seq data in R. It provides a streamlined interface to summarize high-throughput sequencing data (BAM files) into count tables based on genomic annotations (GFF, GTF, or biomaRt). Its primary strength lies in the `simpleRNASeq` function, which automates parameter inference and handles the creation of non-redundant "synthetic transcripts" to ensure accurate quantification.

## Core Workflow

### 1. Define Annotation Parameters
Use `AnnotParam` to specify the source of your genomic features.

```r
library(easyRNASeq)

# From a GFF3 or GTF file
annotParam <- AnnotParam(datasource = "path/to/annotation.gff3", type = "gff3")

# From biomaRt
# annotParam <- AnnotParam(datasource = "ensembl", type = "biomaRt")
```

### 2. Create Synthetic Transcripts
To avoid "multiple-counting" where a single read is assigned to multiple overlapping isoforms, collapse transcripts into a single flattened gene structure.

```r
# This creates a non-redundant set of exons for each gene locus
annotParam <- createSyntheticTranscripts(annotParam, verbose = FALSE)
```

### 3. Define BAM Parameters
Specify the nature of your sequencing data using `BamParam`.

```r
# Define if data is paired-end and/or stranded
bamParam <- BamParam(paired = TRUE, stranded = FALSE)

# Get a list of BAM files and their indices
bamFiles <- getBamFileList(filenames = c("sample1.bam", "sample2.bam"), 
                           indexnames = c("sample1.bam.bai", "sample2.bam.bai"))
```

### 4. Configure RNA-Seq Parameters
The `RnaSeqParam` object bundles the annotation and BAM settings with quantification preferences.

```r
rnaSeqParam <- RnaSeqParam(
    annotParam = annotParam,
    bamParam = bamParam,
    countBy = "genes",    # Options: "exon", "transcript", "gene", "feature"
    precision = "read"    # "read" is the recommended default
)
```

### 5. Run Quantification
Execute the `simpleRNASeq` function to produce a `RangedSummarizedExperiment` object containing the counts.

```r
sexp <- simpleRNASeq(bamFiles = bamFiles, param = rnaSeqParam, verbose = TRUE)

# Access the count matrix
counts <- assay(sexp)
```

## Key Functions and Tips

- **`simpleRNASeq`**: The main wrapper. It automatically checks for consistency between your parameters and the actual BAM file headers.
- **`getBamFileList`**: A helper to ensure BAM files and their indices are correctly paired before processing.
- **Handling Multi-mapping**: By default, the package is conservative. It is recommended to use uniquely mapping reads for initial analysis.
- **Strandedness**: If your protocol is strand-specific (e.g., Illumina TruSeq), `easyRNASeq` defaults to `strandProtocol = 'reverse'`.
- **Memory Management**: Use the `yieldSize` argument in `BamParam` (default 1M) to process large BAM files in chunks, which is useful for systems with limited RAM.

## Reference documentation

- [easyRNASeq](./references/easyRNASeq.md)
- [simpleRNASeq](./references/simpleRNASeq.md)