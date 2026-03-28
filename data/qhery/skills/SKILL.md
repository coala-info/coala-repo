---
name: qhery
description: qhery identifies amino acid changes in SARS-CoV-2 samples and cross-references them against the Stanford Coronavirus Resistance Database to detect drug resistance markers. Use when user asks to perform a resistance analysis, identify available treatments, or extract amino acid mutations from genomic variants.
homepage: http://github.com/mjsull/qhery/
---


# qhery

## Overview
qhery is a specialized genomic tool designed to bridge the gap between raw SARS-CoV-2 sequence data and clinical relevance. It automates the process of identifying amino acid changes from genomic variants and cross-referencing them against the Stanford Coronavirus Resistance Database. This skill enables the rapid assessment of whether a specific viral sample contains known resistance markers or mutations within drug epitopes, while filtering out common lineage-defining mutations to highlight unique or concerning variants.

## Core Workflows

### 1. Resistance Analysis
To perform a full resistance check, use the `run` subcommand. This requires a VCF file called against the Wuhan-Hu-1 reference (MN908947.3).

```bash
qhery run \
  --sample_name <name> \
  --vcf <sample.vcf> \
  --lineage <e.g., BA.5> \
  --rx_list <Drug1> <Drug2> \
  --database_dir <path/to/db> \
  --pipeline_dir <output_dir>
```

*   **Best Practice**: Always include the `--bam` file if available. qhery will use `lofreq` to detect minor alleles (sub-consensus variants) that might be missed in a standard VCF but are critical for early detection of resistance.
*   **Coverage Check**: Providing a BAM file also allows `samtools` to verify if a "missing" resistance mutation is truly absent or simply lacks sufficient sequencing depth (default 20x) to be called.

### 2. Identifying Available Treatments
Before running an analysis, check which drugs are currently supported in the local or downloaded database:

```bash
qhery list_rx --database_dir <path/to/db>
```

### 3. Mutation-Only Extraction
If you only need to annotate the amino acid changes in a sample without performing the resistance database lookup:

```bash
qhery mutations \
  --sample_name <name> \
  --vcf <sample.vcf> \
  --lineage <lineage> \
  --pipeline_dir <output_dir>
```

## Interpreting Results
qhery generates two primary TSV files:
*   **`<sample>.full.tsv`**: A complete list of all detected mutations and all known resistance mutations for the requested drugs.
*   **`<sample>.final.tsv`**: A filtered list containing only:
    1.  Detected mutations in resistance-associated genes that are **not** lineage-defining.
    2.  Known resistance mutations that had insufficient coverage to be called.

### Key Output Columns
| Column | Significance |
| :--- | :--- |
| `in_variant` | If `True`, the mutation is a standard part of that lineage (e.g., Omicron). |
| `resistance_mutation` | If `True`, there is documented evidence of reduced drug susceptibility. |
| `fold_reduction` | The specific magnitude of resistance as reported in the database. |
| `in_epitope` | For Monoclonal Antibodies (MABs), indicates if the mutation is in the binding site. |

## Expert Tips
*   **Reference Genome**: Ensure your VCF/BAM files are mapped to **Wuhan-Hu-1 (MN908947.3)**. Using other references will result in incorrect coordinate mapping and amino acid predictions.
*   **Database Updates**: qhery automatically attempts to download the latest Stanford resistance database if it isn't found in the `--database_dir`. Ensure the environment has internet access or pre-populate this directory.
*   **Visualization**: If `ncbi-blast+` is installed, use the `--fasta` argument during a `run` to generate a BLASTx alignment, which is useful for manual verification of complex insertion/deletion events.



## Subcommands

| Command | Description |
|---------|-------------|
| list_rx | List resistance genes from the Stanford resistance database. |
| qhery run | Run the QHERY pipeline. |
| qhery_mutations | Analyze mutations using the qhery tool. |

## Reference documentation
- [qhery README](./references/github_com_mjsull_qhery_blob_main_README.md)