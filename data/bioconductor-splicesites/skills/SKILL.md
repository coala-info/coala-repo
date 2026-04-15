---
name: bioconductor-splicesites
description: This tool analyzes RNA-seq align-gaps to quantify, annotate, and score splice site expression and strength. Use when user asks to read BAM files for splice junctions, quantify expression using GPTM or RPMG, annotate junctions with reference genomes, calculate MaxEnt or HBond scores, or perform in silico translation and trypsinization of splice sites.
homepage: https://bioconductor.org/packages/3.8/bioc/html/spliceSites.html
---

# bioconductor-splicesites

name: bioconductor-splicesites
description: Analysis of RNA-seq align-gaps (splice sites) using the Bioconductor package spliceSites. Use this skill to read BAM files, quantify splice site expression (GPTM, RPMG), annotate junctions with reference genomes, calculate MaxEnt and HBond scores, and perform in silico translation/trypsinization of splice junctions.

# bioconductor-splicesites

## Overview
The `spliceSites` package is designed for the analysis of align-gaps (N CIGAR operations) in RNA-seq data, which represent splice junctions. It provides specialized data structures for unilateral (exon-intron boundaries) and bilateral (full gaps) genomic ranges. The package integrates with `rbamtools` for BAM access and `refGenome` for annotation, allowing for the quantification of splice site usage and the evaluation of splice site strength via sequence-based scoring models.

## Core Workflows

### 1. Reading and Quantifying Splice Sites
Splice sites are extracted from BAM files into `gapSites` objects.
- `getGapSites(reader, seqid)`: Read gaps for a specific chromosome from a `bamReader`.
- `alignGapList(reader)`: Read all gaps from a BAM file.
- `readMergedBamGaps(files)`: Merge gaps from multiple BAM files.
- `readTabledBamGaps(files, prof)`: Merge gaps and calculate group-specific statistics based on a profile data frame.

**Quantification Metrics:**
- **GPTM (Gapped Per Ten Million):** (Gap aligns / Total aligns) * 10^7.
- **RPMG (Reads Per Million Gapped):** (Gap aligns / Total gapped aligns) * 10^6.

### 2. Annotation and Strand Inference
Junctions can be annotated using `refGenome` objects (e.g., `ucscGenome` or `ensemblGenome`).
```R
# Load annotation and annotate gapSites
uc <- loadGenome("uc_small.RData")
juc <- getSpliceTable(uc)
annotation(gs) <- annotate(gs, juc)

# Infer strand from annotation
strand(gs) <- getAnnStrand(gs)
```

### 3. Sequence Extraction and Scoring
Extract sequences around junctions to evaluate splice site strength.
- `lJunc(gs, featlen, gaplen)`: Extract ranges around the left boundary.
- `rJunc(gs, featlen, gaplen)`: Extract ranges around the right boundary.
- `dnaRanges(obj, dna_set)`: Add DNA sequences to ranges (returns `cdRanges`).
- `addMaxEnt(gs, dna_set, mes)`: Add Maximum Entropy scores (requires `load.maxEnt()`).
- `addHbond(gs, dna_set)`: Add HBond scores for 5' splice sites.

### 4. Proteomic Analysis (In Silico Translation)
Analyze the coding potential of splice junctions.
- `lCodons` / `rCodons`: Adjust ranges to maintain reading frames.
- `translate(cdObj)`: Translate DNA to amino acids (returns `caRanges`).
- `truncateSeq(caObj)`: Remove sequences containing stop codons before the junction.
- `trypsinCleave(caObj)`: Perform in silico trypsin digestion.

### 5. Alternative Splicing Analysis
Identify alternative 5' or 3' sites (sites sharing one boundary but having different counterparts).
- `alt_left_ranks(gs)`: Identify alternative left boundaries.
- `alt_ranks(gs)`: Combined analysis of alternative splicing.
- `plot_diff_ranks(gs)`: Visualize distances between alternative sites.

### 6. Integration with Differential Expression
Convert splice site counts into standard Bioconductor objects for downstream analysis.
- `readExpSet(bam_files, phenoData)`: Create an `ExpressionSet` of junction counts.
- Use `exprs(es)` as input for `DESeqDataSetFromMatrix` in the `DESeq2` package.

## Reference documentation
- [Using spliceSites package](./references/spliceSites.md)