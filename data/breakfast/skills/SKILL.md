---
name: breakfast
description: `breakfast` is a specialized tool designed for rapid genomic epidemiology.
homepage: https://github.com/rki-mf1/breakfast
---

# breakfast

## Overview

`breakfast` is a specialized tool designed for rapid genomic epidemiology. Unlike traditional clustering tools that process raw FASTA sequences, `breakfast` operates on tabular mutation data (SNPs and indels). By using pre-calculated sequence features, it can identify putative outbreak clusters and infection chains with high efficiency, making it suitable for large-scale genomic surveillance where sequence features have already been extracted by upstream pipelines.

## Installation

Install via Bioconda (recommended) or pip:

```bash
conda install -c bioconda breakfast
# OR
pip install breakfast
```

## Core Usage Patterns

### Basic Clustering
To cluster sequences with a maximum SNP distance of 1 (sequences differing by 0 or 1 SNP will be grouped):

```bash
breakfast --input-file genomic_profiles.tsv --max-dist 1 --outdir results/
```

### Processing Nextclade Outputs
Nextclade TSV files use different column headers and delimiters than the default `covsonar` format. Use these specific flags to map them correctly:

```bash
breakfast \
  --input-file nextclade.tsv \
  --id-col "seqName" \
  --clust-col "substitutions" \
  --sep2 "," \
  --var-type "nextclade_dna" \
  --outdir nextclade-results/
```

### Filtering for Significant Clusters
To ignore small groups or singletons and focus on potential outbreaks, set a minimum cluster size:

```bash
breakfast --input-file profiles.tsv --min-cluster-size 5 --outdir outbreak_clusters/
```

## Expert Tips and Best Practices

### Handling Error-Prone Regions
Sequencing quality often drops at the ends of the genome. Use trimming to ignore these regions during distance calculation:
- Use `--trim-start 264` and `--trim-end 228` (default values for SARS-CoV-2) to mask the 5' and 3' UTRs.
- Adjust these values if working with different reference lengths using `--reference-length`.

### Performance Optimization
- **Parallelization**: Use the `--jobs` flag to specify the number of threads for distance calculations.
- **Caching**: For iterative workflows where you add new sequences to an existing dataset, use `--output-cache` to save results and `--input-cache` in subsequent runs to significantly reduce runtime.

### Mutation Parsing Logic
The `--var-type` flag determines how mutations are interpreted. Choosing the correct type allows the tool to intelligently skip indels:
- `covsonar_dna` / `covsonar_aa`: Standard for covSonar users.
- `nextclade_dna` / `nextclade_aa`: Standard for Nextclade users.
- `raw`: Use this if your input format is custom. Note that `--skip-del`, `--skip-ins`, and trimming are **not** supported in `raw` mode.

### Distance Thresholds
- **--max-dist 0**: Identical sequences only.
- **--max-dist 1**: Highly related sequences (0-1 SNP difference), typical for immediate transmission chain detection.
- **--max-dist 2+**: Broader clusters, useful for identifying wider community transmission or lineage-level groupings.

## Reference documentation
- [breakfast - FAST outBREAK detection and sequence clustering](./references/github_com_rki-mf1_breakfast.md)
- [breakfast - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_breakfast_overview.md)