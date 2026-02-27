---
name: bioconductor-rsubread
description: Bioconductor-rsubread provides high-performance tools for read alignment, quantification, and mutation discovery in next-generation sequencing data. Use when user asks to build a reference index, align DNA or RNA-seq reads, quantify gene expression with featureCounts, process single-cell RNA-seq data, or call SNPs.
homepage: https://bioconductor.org/packages/release/bioc/html/Rsubread.html
---


# bioconductor-rsubread

name: bioconductor-rsubread
description: High-performance read alignment, quantification, and mutation discovery for NGS data using the Rsubread Bioconductor package. Use this skill when you need to perform genomic or RNA-seq workflows in R, including index building (buildindex), read mapping (align, subjunc), read summarization (featureCounts), and SNP calling (exactSNPs).

# bioconductor-rsubread

## Overview
The `Rsubread` package is a high-performance R interface for the Subread suite. It is designed for processing next-generation sequencing (NGS) data with high efficiency and accuracy using a "seed-and-vote" paradigm. It supports both genomic DNA and RNA-seq data across all major platforms (Linux, macOS, Windows).

## Core Workflow

### 1. Index Building
Before alignment, you must build a hash-table index for your reference genome. This is a one-time operation.

```r
library(Rsubread)
# Build a base-space index
buildindex(basename = "human_index", reference = "hg38.fa")
```
*   **Memory Tip:** A full index for the human genome requires ~15GB RAM. For machines with limited memory, use `gappedIndex = TRUE`.

### 2. Read Alignment
Use `align()` for general mapping (DNA-seq or RNA-seq gene-level expression) and `subjunc()` for RNA-seq junction discovery.

```r
# RNA-seq alignment (local alignment, recommended for DGE)
align(index = "human_index", 
      readfile1 = "reads_R1.fastq.gz", 
      readfile2 = "reads_R2.fastq.gz", # Optional for paired-end
      output_file = "alignment_results.bam",
      nthreads = 8)

# RNA-seq alignment (global alignment, for junction/splicing analysis)
subjunc(index = "human_index", 
        readfile1 = "reads_R1.fastq.gz", 
        output_file = "subjunc_results.bam")
```

### 3. Read Summarization (Quantification)
The `featureCounts()` function assigns mapped reads to genomic features (genes, exons).

```r
# Using in-built NCBI RefSeq annotations (hg38, hg19, mm39, mm10, mm9)
fc <- featureCounts(files = "alignment_results.bam", 
                    annot.inbuilt = "hg38",
                    isPairedEnd = TRUE)

# Using a custom GTF file
fc_custom <- featureCounts(files = "alignment_results.bam",
                           annot.ext = "annotation.gtf",
                           isGTFAnnotationFile = TRUE,
                           GTF.featureType = "exon",
                           GTF.attrType = "gene_id")

# Access counts
head(fc$counts)
```

### 4. Single-Cell RNA-seq (10x Chromium)
Use `cellCounts()` to process raw 10x Genomics data (FASTQ or BCL) into a UMI count matrix.

```r
# sample_sheet should contain BarcodeUMIFile, ReadFile, and SampleName
counts_sc <- cellCounts(index = "human_index", 
                        sample.sheet = my_samples, 
                        annot.inbuilt = "hg38")
```

## Specialized Functions
- **SNP Discovery:** `exactSNPs(bam.files = "file.bam", refObj = "ref.fa")` provides fast, high-accuracy SNP calling.
- **Quality Assessment:** `qualityScores(filename = "reads.fastq")` extracts Phred scores.
- **Mapping Statistics:** `propmapped("file.bam")` calculates the proportion of mapped reads.
- **Duplication Removal:** `removeDupReads(SAMfile = "in.bam", BAMfile = "out.bam")`.

## Best Practices
- **RNA-seq for DGE:** Use `align()` + `featureCounts()`. `align()` is faster and sufficient for gene-level counts.
- **Alternative Splicing:** Use `subjunc()` as it performs full-read alignment across junctions.
- **Multi-mapping:** By default, `featureCounts` ignores multi-mapping reads. To include them, set `countMultiMappingReads = TRUE`.
- **Strand Specificity:** Always check your library prep. Set `strandSpecific` to 0 (unstranded), 1 (stranded), or 2 (reversely stranded) in `featureCounts`.

## Reference documentation
- [Rsubread Vignette](./references/Rsubread.md)
- [Subread Users Guide](./references/SubreadUsersGuide.md)