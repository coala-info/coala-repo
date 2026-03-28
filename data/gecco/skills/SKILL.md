---
name: gecco
description: GECCO is a bioinformatics tool that uses conditional random fields to identify biosynthetic gene clusters in genomic and metagenomic data. Use when user asks to predict biosynthetic gene clusters, annotate protein domains, train custom prediction models, or convert cluster coordinates into formats like AntiSMASH sideloads and GFF3.
homepage: https://gecco.embl.de/
---


# gecco

## Overview

GECCO (Biosynthetic Gene Cluster prediction with Conditional Random Fields) is a high-performance bioinformatics tool designed for the de novo identification of BGCs. Unlike traditional rule-based systems that rely on rigid cluster definitions, GECCO uses a probabilistic CRF model to identify clusters based on protein domain composition and genomic context. It is particularly effective for discovering novel clusters in large-scale metagenomic datasets where speed and sensitivity are paramount.

## Core Workflows

### Standard BGC Prediction
The most common use case is running a full prediction pipeline on a genome or metagenome file.

```bash
# Run prediction on a FASTA file
gecco -v run --genome sequence.fna -o ./output_dir

# Run prediction using a specific HMM database and custom threshold
gecco run --genome sequence.gbk --hmm Pfam35.hmm.gz --threshold 0.8
```

### Annotation and Feature Extraction
If you only need to identify genes and domains without running the BGC prediction model:

```bash
gecco annotate --genome sequences.fna --hmm Pfam35.hmm.gz -o ./annotation_results
```

### Training Custom Models
GECCO allows training on specialized datasets (e.g., specific types of clusters or non-standard organisms).

```bash
gecco train --genes genes.tsv --features features.tsv --clusters clusters.tsv -o ./custom_model --select 0.3
```
*   **Tip**: Use `--select` to perform feature selection based on Fisher p-values, which reduces the domain set to the most informative features.

## Integration and Conversion

GECCO outputs can be converted for use in common visualization and analysis platforms:

*   **AntiSMASH**: Generate a sideload JSON to view GECCO clusters within the AntiSMASH interface.
    ```bash
    gecco run --genome sequence.gbk --antismash-sideload
    ```
*   **GFF3**: Convert cluster coordinates for genome browsers.
    ```bash
    gecco convert clusters -i ./output_dir --format gff
    ```
*   **BiG-SLiCE**: Prepare GECCO clusters for biosynthetic diversity analysis.
    ```bash
    gecco convert gbk -i ./output_dir --format bigslice
    ```

## Expert Tips and Best Practices

1.  **Parallelization**: For massive metagenomic files, split the input FASTA into smaller chunks and run `gecco annotate` in parallel. You can then concatenate the resulting `.genes.tsv` and `.features.tsv` files before running `gecco predict`.
2.  **Verbosity**: Always use `-v` or `-vv` when running long jobs to monitor progress, especially during the HMM annotation phase which is the most computationally expensive step.
3.  **Compressed Inputs**: GECCO natively supports compressed input files (`.gz`, `.bz2`, `.xz`, `.lz4`), saving disk space and I/O time.
4.  **Feature Coloring**: GECCO automatically adds color qualifiers to output GenBank files based on predicted molecular function, which are compatible with viewers like SnapGene, Benchling, and EasyFig.
5.  **Regularization**: When training, if the model is overfitting, adjust the L1 (`--c1`) and L2 (`--c2`) regularization weights. The default is 0.15 for both, but 0.4 for C1 is often preferred for BGC discovery.



## Subcommands

| Command | Description |
|---------|-------------|
| cv | Cross-validation for gecco |
| gecco annotate | Annotate genomic sequences with genes and protein domains. |
| gecco convert | Convert the GenBank records to a different format. |
| gecco predict | Predicts gene clusters and domain annotations. |
| gecco run | Run gecco gene calling and cluster detection |
| gecco_train | Train a CRF model for domain annotation. |

## Reference documentation

- [GECCO Overview](./references/gecco_embl_de_index.md)
- [Training GECCO](./references/gecco_embl_de_training.md)
- [Integrations (AntiSMASH, BiG-SLiCE)](./references/gecco_embl_de_integrations.html.md)
- [API Reference](./references/gecco_embl_de_api_index.html.md)