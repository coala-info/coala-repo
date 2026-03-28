---
name: taranys
description: Taranys is a computational pipeline for high-resolution bacterial typing using a gene-by-gene approach to identify alleles within MLST schemas. Use when user asks to analyze or clean MLST schemas, select representative reference alleles, perform allele calling on genome assemblies, or generate distance matrices for outbreak tracking.
homepage: https://github.com/BU-ISCIII/taranys
---

# taranys

## Overview

Taranys is a computational pipeline designed for high-resolution bacterial typing. It uses a gene-by-gene approach based on BLASTn to identify alleles within whole-genome or core-genome MLST schemas. By processing complete or draft genomes, it classifies loci into specific categories (e.g., Exact Match, Inferred, or Paralogous) and generates distance matrices essential for tracking outbreaks and understanding strain relationships.

## Core Functionalities

### 1. Schema Analysis and Cleaning
Before running a typing analysis, use `analyze-schema` to ensure the quality of your MLST schema. This identifies duplicate alleles, partial sequences, and non-coding regions (CDS).

**Common Pattern:**
```bash
taranys analyze-schema \
    -i /path/to/schema_dir \
    -o /path/to/output_dir \
    --remove-subsets \
    --remove-duplicated \
    --remove-no-cds \
    --genus "GenusName" \
    --species "SpeciesName" \
    --cpus 8
```

### 2. Reference Allele Selection
To optimize the allele calling process, Taranys selects representative alleles for each locus using the Leiden clustering algorithm. This reduces the search space while maintaining sensitivity.

**Common Pattern:**
```bash
taranys reference-alleles \
    --schema /path/to/schema_dir \
    --output /path/to/ref_output \
    --eval-cluster \
    --cluster-resolution 0.75 \
    --cpus 8 \
    --force
```

### 3. Allele Calling
This is the primary typing module. It identifies which alleles from the schema are present in your sample FASTA files.

**Classification Categories:**
- **Exact Match**: 100% identity and alignment.
- **INF (Inferred)**: New allele found with a known length but different sequence.
- **LNF (Locus Not Found)**: No match found within thresholds.
- **NIPH/NIPHEM**: Non-informative paralogous hits (multiple matches).
- **PLOT**: Match found but truncated by the end of a contig.
- **ASM/ALM**: Alleles with insertions or deletions that change the protein length.

### 4. Distance Matrix Construction
After calling alleles, use the `distance-matrix` functionality to estimate genomic distances between samples, which is the basis for outbreak research and dendrogram visualization.

## Expert Tips and Best Practices

- **Schema Quality**: Always run `analyze-schema` with `--remove-no-cds` if your schema is derived from raw annotations. Non-coding fragments can lead to false positives or "Bad Quality" flags during typing.
- **Mash Parameters**: When running `reference-alleles`, the `-k` (k-mer size) and `-S` (sketch size) parameters significantly impact the initial Mash-based distance estimation. For highly diverse species, consider increasing the sketch size.
- **Handling PLOT Hits**: If you see a high frequency of `PLOT` results in your `summary_result.tsv`, it usually indicates poor assembly quality (highly fragmented contigs) rather than biological variation.
- **Resource Management**: Taranys is multi-threaded. Always specify `--cpus` to match your environment, especially during the BLAST-intensive `allele-calling` phase.



## Subcommands

| Command | Description |
|---------|-------------|
| taranys | taranys version 3.0.1 |
| taranys | taranys version 3.0.1 |
| taranys | taranys version 3.0.1 |

## Reference documentation
- [Introduction](./references/github_com_BU-ISCIII_taranys_wiki_Introduction.md)
- [Usage](./references/github_com_BU-ISCIII_taranys_wiki_Usage.md)
- [Allele Calling Algorithm](./references/github_com_BU-ISCIII_taranys_wiki_Allele-Calling.md)
- [Analyze Schema Details](./references/github_com_BU-ISCIII_taranys_wiki_Analyze-Schema.md)