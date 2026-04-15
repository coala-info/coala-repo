---
name: bioconductor-transmogr
description: This tool creates variant-modified reference genomes and transcriptomes by incorporating SNVs, insertions, and deletions into genomic sequences. Use when user asks to incorporate variants into a reference, generate personalized transcriptomes, or shift genomic coordinates based on InDels.
homepage: https://bioconductor.org/packages/release/bioc/html/transmogR.html
---

# bioconductor-transmogr

name: bioconductor-transmogr
description: Create variant-modified reference genomes and transcriptomes using the transmogR R package. Use this skill when you need to incorporate personalized or population-level variants (SNVs, Insertions, Deletions) into genomic sequences, generate custom transcriptomes for pseudo-aligners like salmon, or shift genomic coordinates based on InDels.

# bioconductor-transmogr

## Overview

The `transmogR` package is designed to create personalized reference sequences by incorporating genomic variants into standard reference genomes or transcriptomes. This is particularly useful for improving the accuracy of RNA-seq alignments and transcript abundance estimation. The package handles SNVs, insertions, and deletions, and provides tools to manage coordinate shifts caused by InDels.

## Core Workflow

### 1. Data Preparation
To use `transmogR`, you need three components:
- **Reference Genome**: A `DNAStringSet` or `BSgenome` object.
- **Variants**: A VCF file or a `GRanges` object containing REF and ALT alleles.
- **Transcript Structure**: A `GRanges` or `GRangesList` (usually from a GTF/GFF file) defining exons.

```r
library(transmogR)
library(VariantAnnotation)

# Clean and validate variants
vcf <- VcfFile("path/to/variants.vcf.gz")
var <- cleanVariants(vcf) # Ensures compatibility for transmogrify
```

### 2. Modifying the Transcriptome
The `transmogrify()` function is the primary tool for creating a modified transcriptome. It iterates through transcripts and applies variants.

```r
# Create modified transcript sequences
trans_mod <- transmogrify(
  ref_genome, 
  var, 
  exons, 
  tag = "custom_sample", 
  var_tags = TRUE
)
```

### 3. Modifying the Genome
The `genomogrify()` function applies variants to the entire chromosome/genome sequence.

```r
# Create modified genomic sequences
genome_mod <- genomogrify(ref_genome, var)
```

### 4. High-Performance Workflow (Coordinate Shifting)
For large-scale datasets, it is often faster to shift the genomic coordinates of the features and then extract sequences from the modified genome.

```r
# 1. Shift exon coordinates to account for InDels
new_exons <- shiftByVar(exons, var)

# 2. Extract sequences using GenomicFeatures
library(GenomicFeatures)
new_exons_list <- splitAsList(new_exons, new_exons$transcript_id)
new_trans <- extractTranscriptSeqs(genome_mod, new_exons_list)
```

## Specialized Functions

### Variant Inspection
- `upsetVarByCol()`: Visualize how variants overlap specific features (e.g., exons) summarized by metadata columns like `gene_id`.
- `overlapsByVar()`: Get a tabular breakdown of variant types (SNV, Deletion, Insertion) across genomic regions (promoters, introns, etc.).

### Splice Junctions
- `sjFromExons()`: Extract splice donor and acceptor sites from exon coordinates. Can return results as `GRanges` or `GInteractions`.

### Handling PAR-Y and Masks
- `parY()`: Retrieve Pseudo-Autosomal Regions for hg38, hg19, or CHM13.
- Use these regions as a `mask` in `genomogrify()` to re-assign bases to "N".

## Important Constraints
- **SNVs**: Must be width 1 with a single base replacement.
- **Insertions**: REF must be 1nt; ALT must be > 1nt.
- **Deletions**: REF must be > 1nt; ALT must be 1nt.
- **Memory**: Creating whole-genome modified references is RAM-intensive; HPC environments are recommended for full human genomes.

## Reference documentation

- [Creating a Variant-Modified Reference](./references/creating_a_new_reference.md)