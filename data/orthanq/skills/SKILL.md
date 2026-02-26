---
name: orthanq
description: Orthanq is a Bayesian framework for the quantification of haplotypes from NGS data, specifically for HLA typing and viral lineage estimation. Use when user asks to perform high-resolution HLA typing, estimate viral lineage proportions, or quantify haplotypes using a probabilistic model.
homepage: https://github.com/orthanq/orthanq
---


# orthanq

## Overview

Orthanq is a specialized Bayesian framework designed for the quantification of haplotypes from NGS data. It is primarily used for high-resolution HLA typing and viral lineage estimation. Unlike deterministic callers, Orthanq utilizes a probabilistic model that incorporates evidence from Varlociraptor to account for uncertainty, making it highly effective for samples with low coverage, sequencing errors, or complex mixtures of closely related alleles.

## Installation and Setup

Orthanq is available via Bioconda. It is recommended to use `mamba` for faster dependency resolution.

```bash
mamba install orthanq
```

For development or manual builds, Orthanq uses the `pixi` package manager:

```bash
pixi install
pixi run cargo build
```

## Core Workflows

### HLA Quantification
Orthanq predicts HLA types by analyzing evidence across multiple loci. It supports standard HLA genes as well as DQA1 and DRB1.

**Best Practices:**
- **Sample Naming**: Always use the `--sample-name` parameter to ensure outputs are correctly labeled in multi-sample studies.
- **Resolution**: Use the 4-field resolution feature for maximum clinical and research detail.
- **Filtering**: Use significance level parameters to skip rows that do not meet your confidence threshold, which simplifies the resulting output.

### Virus Variant Quantification
Used for estimating the proportions of different viral lineages (e.g., SARS-CoV-2) within a single sample.

**Expert Tips:**
- **Event Selection**: Use the `--events` flag to select specific events for quantification rather than relying on the default "present" status.
- **Performance**: For large datasets, Orthanq supports a distance-based approach (Jaccard distance) to optimize the quantification process.

## CLI Usage Patterns

### Common Parameters
- `--sample-name <name>`: Sets the sample identifier for the run.
- `--output <dir>`: Directs results to a specific directory. Newer versions prefer directory output over single CSV files to manage intermediate and visualization data.
- `--significance-level <float>`: Filters haplotypes based on posterior probability.
- `--events <list>`: Specifies which events to consider during the Bayesian inference.

### Output Management
Orthanq generates several output types:
1.  **Quantification Tables**: CSV or directory-based results showing haplotype fractions.
2.  **Visualizations**: Integration with `datavzrd` allows for the generation of arrow plots and haplotype bar plots.
3.  **Intermediate Files**: By default, newer versions (v1.21.0+) suppress intermediate files to save disk space unless specifically requested.

## Reference documentation
- [Anaconda Bioconda Orthanq Overview](./references/anaconda_org_channels_bioconda_packages_orthanq_overview.md)
- [Orthanq GitHub Repository](./references/github_com_orthanq_orthanq.md)
- [Orthanq Release Tags and Features](./references/github_com_orthanq_orthanq_tags.md)