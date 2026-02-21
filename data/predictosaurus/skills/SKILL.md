---
name: predictosaurus
description: Predictosaurus is a command-line utility designed for haplotype-based genomic variant effect prediction that incorporates uncertainty.
homepage: https://github.com/fxwiegand/predictosaurus
---

# predictosaurus

## Overview
Predictosaurus is a command-line utility designed for haplotype-based genomic variant effect prediction that incorporates uncertainty. Unlike traditional tools that treat variants in isolation, Predictosaurus constructs variant graphs to represent complex haplotypes. This allows researchers to quantify the likelihood of specific protein-level changes (peptides) based on the underlying probability of genomic observations. It is particularly effective for analyzing subgraphs of individual features and calculating scores for all possible haplotypes of a transcript.

## Command-line Usage

### 1. Building the Variant Graph
The first step in any workflow is to construct a variant graph from VCF files. This graph is stored in a DuckDB database for efficient querying.

```bash
predictosaurus build \
    --calls path/to/calls.vcf \
    --observations sample1=path/to/obs1.vcf sample2=path/to/obs2.vcf \
    --min-prob-present 0.8 \
    --min-vaf 0.05 \
    --output graphs.duckdb
```

*   **Expert Tip**: Use `--min-prob-present` to filter out low-confidence variants early. The default is 0.8; lowering this increases graph complexity but captures more potential haplotypes.

### 2. Processing Features and Scoring
Once the graph is built, use a GFF file and a reference genome to calculate scores for haplotypes.

```bash
predictosaurus process \
    --features features.gff \
    --reference reference.fasta \
    --graph graphs.duckdb \
    --haplotype-metric geometric-mean \
    --output scores.duckdb
```

*   **Metric Selection**: Choose `--haplotype-metric` based on your statistical model:
    *   `geometric-mean` (Default): Balanced approach for haplotype quantification.
    *   `product`: Strict probability multiplication.
    *   `minimum`: Focuses on the "weakest link" in the haplotype chain.

### 3. Extracting Peptide Sequences
Extract peptide sequences for specific samples and events, useful for neoantigen identification.

```bash
predictosaurus peptides \
    --features features.gff \
    --reference reference.fasta \
    --graph graphs.duckdb \
    --sample sample1 \
    --interval 8-11 \
    --events event1 event2 \
    --min-event-prob 0.8 \
    --output peptides.fasta
```

*   **Peptide Length**: The `--interval` flag (default 8-11) is optimized for MHC Class I binding predictions.
*   **Probability Thresholds**: Use `--min-event-prob` and `--max-background-event-prob` to filter peptides based on the cumulative probability of the variants that cause them.

### 4. Exporting Results
Convert the internal DuckDB scores into a human-readable TSV format for downstream analysis.

```bash
predictosaurus plot --input scores.duckdb --output scores.tsv
```

## Performance and Global Options
*   **Multi-threading**: Use `--threads` (or `-t`) to specify the number of cores. If set to 0, it defaults to all available logical cores.
*   **Logging**: Use `--verbose` (or `-v`) to get detailed execution logs, which is critical for debugging complex graph builds.

## Reference documentation
- [Predictosaurus GitHub README](./references/github_com_fxwiegand_predictosaurus.md)
- [Predictosaurus Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_predictosaurus_overview.md)