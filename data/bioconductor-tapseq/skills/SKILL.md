---
name: bioconductor-tapseq
description: bioconductor-tapseq provides a workflow for designing nested primers and selecting target genes for targeted single-cell RNA sequencing. Use when user asks to design nested primers for gene panels, infer transcript polyadenylation sites from BAM files, or identify cell-type marker genes for targeted scRNA-seq experiments.
homepage: https://bioconductor.org/packages/release/bioc/html/TAPseq.html
---

# bioconductor-tapseq

name: bioconductor-tapseq
description: Targeted Single-Cell RNA Sequencing (TAP-seq) primer design and target gene selection. Use this skill to design nested primers for gene panels, infer polyadenylation (polyA) sites from BAM files, and identify cell-type marker genes for targeted scRNA-seq experiments.

# bioconductor-tapseq

## Overview

The `TAPseq` package provides a complete workflow for designing primers for targeted single-cell RNA sequencing. It allows users to identify optimal target genes, infer transcript 3' ends from pilot data, and design nested primer sets (outer and inner) that are compatible with multiplex PCR and minimize off-target binding.

## Core Workflows

### 1. Target Gene Selection
Identify marker genes from existing scRNA-seq data (e.g., Seurat objects) to create a targeted panel.

```R
library(TAPseq)
library(Seurat)

# Select ~100 target genes using Lasso regularization
target_genes <- selectTargetGenes(seurat_obj, targets = 100)

# Visualize how well target genes distinguish cell types
plotTargetGenes(seurat_obj, target_genes = target_genes)
```

### 2. Transcript Sequence Preparation
Before designing primers, infer the actual 3' ends of transcripts using pilot data (BAM files) to ensure primers target the correct regions.

```R
# 1. Infer polyA sites from BAM data
polyA_sites <- inferPolyASites(target_genes_granges, bam = "pilot_data.bam")

# 2. Truncate transcript models at inferred polyA sites
truncated_txs <- truncateTxsPolyA(target_genes_granges, polyA_sites = polyA_sites)

# 3. Extract sequences using a BSgenome object
library(BSgenome.Hsapiens.UCSC.hg38)
txs_seqs <- getTxsSeq(truncated_txs, genome = Hsapiens)
```

### 3. Nested Primer Design
Design outer and inner primers. This process requires local installations of **Primer3** and **BLASTn**.

```R
# Create input objects for Primer3 (outer primers: 350-500 bp product)
outer_io <- TAPseqInput(txs_seqs, target_annot = truncated_txs, 
                        product_size_range = c(350, 500))

# Design primers
outer_io <- designPrimers(outer_io)

# Estimate off-targets using a BLAST database
outer_io <- blastPrimers(outer_io, blastdb = "path/to/blastdb")

# Pick the best primer per gene based on lowest off-targets
best_outer <- pickPrimers(outer_io, n = 1, by = "off_targets")

# Repeat for inner primers with a smaller product size (150-300 bp)
inner_io <- TAPseqInput(txs_seqs, target_annot = truncated_txs, 
                        product_size_range = c(150, 300))
# ... follow design, blast, and pick steps ...
```

### 4. Multiplexing and Export
Check if primers in a panel are compatible for multiplexing and export the results.

```R
# Check for primer-dimer potential
outer_comp <- checkPrimers(best_outer)

# Export to data.frame
outer_df <- primerDataFrame(best_outer)

# Create BED tracks for genome browser visualization
createPrimerTrack(best_outer, color = "steelblue3")
```

## Key Tips
- **Software Paths**: If `primer3` or `blastn` are not in your system PATH, specify them in functions: `designPrimers(io, primer3 = "/path/to/primer3_core")`.
- **PolyA Inference**: Always manually inspect inferred polyA sites in a genome browser (IGV) by exporting to BED format before proceeding to primer design.
- **BLAST Database**: For best results, create a BLAST database containing both the genome and the transcriptome using `createBLASTDb()`.

## Reference documentation

- [TAP-seq primer design workflow](./references/tapseq_primer_design.md)
- [Select target genes for TAP-seq](./references/tapseq_target_genes.md)