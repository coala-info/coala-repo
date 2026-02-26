---
name: bioconductor-illuminahumanmethylation450kprobe
description: This tool provides probe sequences and genomic reannotation data for the Illumina HumanMethylation450 microarray. Use when user asks to retrieve probe-level metadata, access genomic coordinates, perform sequence analysis, or identify SNPs at CpG sites for 450k methylation data.
homepage: https://bioconductor.org/packages/release/data/annotation/html/IlluminaHumanMethylation450kprobe.html
---


# bioconductor-illuminahumanmethylation450kprobe

name: bioconductor-illuminahumanmethylation450kprobe
description: Access and utilize probe sequences and reannotation data for the Illumina HumanMethylation450 (450k) microarray. Use this skill when you need to retrieve probe-level metadata, genomic coordinates (hg19), probe sequences, or perform custom annotations (like SNP overlapping or TSS distance calculations) for 450k methylation data.

## Overview

The `IlluminaHumanMethylation450kprobe` package is a Bioconductor annotation resource providing detailed information for the 485,577 probes on the Illumina HumanMethylation450 chip. Unlike standard annotation packages that provide high-level mapping, this package contains the actual probe sequences and genomic context, allowing for precise bioinformatics workflows such as sequence analysis, liftOver operations, or identifying potential biases (e.g., SNPs or repeats at the interrogated CpG site).

## Loading and Inspecting Data

The primary data object is a data frame also named `IlluminaHumanMethylation450kprobe`.

```r
library(IlluminaHumanMethylation450kprobe)

# Load the dataset
data(IlluminaHumanMethylation450kprobe)

# Inspect structure
head(IlluminaHumanMethylation450kprobe, 3)
str(IlluminaHumanMethylation450kprobe)
```

### Key Columns
- `Probe_ID`: Illumina probe identifier (cg/ch/rs numbers).
- `chr`, `start`, `end`: Genomic coordinates in hg19/GRCh37.
- `strand`: Genomic strand of the target.
- `site`: The specific coordinate of the interrogated cytosine.
- `probe.sequence`: The allele A sequence designed for the probe.
- `forward.genomic.sequence`: The genomic sequence surrounding the site.
- `CpGs`: Number of CpG sites in the probe sequence.

## Common Workflows

### Converting to GenomicRanges
To perform overlaps or spatial analysis, convert the data frame to a `GRanges` object.

```r
library(GenomicRanges)

# Create GRanges for the interrogated CpG sites
CpGs.450k <- with(IlluminaHumanMethylation450kprobe,
  GRanges(paste0('chr', chr),
          IRanges(start = site, width = 2, names = Probe_ID),
          strand = strand))
```

### Sequence Analysis
Use `Biostrings` to analyze the genomic context provided in the `forward.genomic.sequence` column.

```r
library(Biostrings)

# Convert to DNAStringSet
hm450_seqs <- DNAStringSet(IlluminaHumanMethylation450kprobe$forward.genomic.sequence)

# Calculate dinucleotide frequency (e.g., checking for CpG density)
cg_counts <- dinucleotideFrequency(hm450_seqs)[, "CG"]
```

### Identifying SNPs at CpG Sites
You can intersect the probe locations with SNP databases to identify probes that might be affected by underlying genetic variation.

```r
# Example logic for overlapping with SNPlocs (requires specific SNPlocs package)
# library(SNPlocs.Hsapiens.dbSNP.XXXXXXXX)
# snps <- getSNPlocs("chr1", as.GRanges=TRUE)
# hits <- findOverlaps(CpGs.450k, snps)
```

### Calculating Distance to Transcription Start Sites (TSS)
Combine this package with `GenomicFeatures` to find the nearest genes.

```r
library(GenomicFeatures)
# Load a TxDb object (e.g., hg19 RefSeq)
# txdb <- makeTranscriptDbFromUCSC('refGene', genome='hg19')
# tss <- transcripts(txdb, columns='gene_id')
# nearest_indices <- precede(CpGs.450k, tss)
```

## Tips and Best Practices
- **Genome Build**: Note that the coordinates in this package are based on **hg19/GRCh37**. If working with hg38 data, you must use `rtracklayer::liftOver` on the coordinates.
- **Memory Management**: The data frame is large (~485k rows). When performing chromosome-wide operations, consider using `mclapply` from the `parallel` package to speed up processing.
- **CpH Probes**: For non-CpG probes (CpH), the `CpGs` column will be 0. These probes often require different interpretation in downstream analysis.

## Reference documentation
- [IlluminaHumanMethylation450kprobe](./references/reference_manual.md)