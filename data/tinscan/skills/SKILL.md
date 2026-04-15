---
name: tinscan
description: tinscan scans whole-genome alignments to identify transposable element insertions by comparing a query genome against a target genome. Use when user asks to prepare genomic data for alignment, perform pairwise LASTZ alignments between scaffolds, or scan alignment blocks to detect and annotate insertion signatures in GFF3 format.
homepage: https://github.com/Adamtaranto/TE-insertion-scanner
metadata:
  docker_image: "quay.io/biocontainers/tinscan:0.2.1--pyhdfd78af_0"
---

# tinscan

## Overview

The `tinscan` (TE-Insertion-Scanner) tool is a specialized suite for scanning whole-genome alignments to find signatures of transposable element (TE) insertions. It operates by comparing a "Query" genome (B) against a "Target" genome (A). It identifies instances where two segments are contiguous in the query but separated by a gap (the insertion) in the target. The tool automates the preparation of genomic data, the execution of LASTZ alignments, and the final scanning of alignment blocks to produce GFF3 annotations of candidate insertions.

## Usage Instructions

The `tinscan` workflow consists of three primary stages: preparation, alignment, and detection.

### 1. Prepare Input Genomes
Before alignment, genomes must be split into individual scaffolds. Use `tinscan-prep` to organize these into directories.

```bash
tinscan-prep --adir data/A_target_split --bdir data/B_query_split \
-A data/A_target_genome.fasta -B data/B_query_genome.fasta
```

### 2. Align Genomes
The `tinscan-align` command wraps LASTZ to perform pairwise alignments between all scaffolds in the target and query directories.

```bash
tinscan-align --adir data/A_target_split --bdir data/B_query_split \
--outdir A_Inserts --outfile A_Inserts_vs_B.tab \
--minIdt 60 --minLen 100 --hspthresh 3000
```

**Expert Tip: Chromosome Pairing**
If homologous relationships between scaffolds are known (e.g., Chr1 in A corresponds to Chr1 in B), use the `--pairs` option with a tab-delimited file to significantly reduce computation time by avoiding unnecessary all-vs-all comparisons.

### 3. Find Insertions
The final step scans the generated alignment table for specific insertion signatures and outputs results in GFF3 format.

```bash
tinscan-find --infile A_Inserts/A_Inserts_vs_B.tab \
--outdir A_Inserts --gffOut A_Inserts_vs_B_results.gff3 \
--maxInsert 50000 --minIdent 80 --maxIdentDiff 20
```

## Key Parameters and Best Practices

- **Insertion Size**: Adjust `--maxInsert` (default is often 50kb) based on the biology of the TEs you expect to find.
- **Identity Thresholds**: 
    - Use `--minIdent` in `tinscan-find` to ensure flanking alignments are high quality.
    - Use `--maxIdentDiff` to ensure that the alignments on both sides of the candidate insertion are of similar quality, which helps filter out spurious alignments.
- **TSD Inference**: The tool automatically attempts to infer Target Site Duplications (TSDs) by looking for internal overlaps of flanking alignments in the query genome.
- **Gap Tolerance**: Use `--qGap` to define the maximum allowable distance between two segments in the query genome for them to still be considered "contiguous."



## Subcommands

| Command | Description |
|---------|-------------|
| tinscan-align | Align B genome (query) sequences onto A genome (target) using LASTZ. |
| tinscan-find | Parse whole genome alignments for signatures of transposon insertion. |
| tinscan_tinscan-prep | Split multifasta genome files into directories for A and B genomes. |

## Reference documentation
- [Tinscan README](./references/github_com_Adamtaranto_TE-insertion-scanner_blob_main_README.md)
- [Project Metadata](./references/github_com_Adamtaranto_TE-insertion-scanner_blob_main_pyproject.toml.md)