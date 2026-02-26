---
name: metamate
description: metaMATE cleans NGS amplicon data by evaluating abundance thresholds within specific bins to optimize the removal of artifacts like NUMTs. Use when user asks to clean metabarcoding data, evaluate filtering thresholds for ASVs, identify authentic sequences using reference sets, or extract filtered sequences from an abundance analysis.
homepage: https://github.com/tjcreedy/metamate
---


# metamate

## Overview
metaMATE (metabarcoding Multiple Abundance Threshold Evaluator) is a specialized tool designed to clean NGS amplicon data, specifically targeting mitochondrial coding loci. Unlike simple global frequency filters, metaMATE allows for the evaluation of various abundance thresholds within specific "bins"—such as individual libraries, phylogenetic clades, or taxonomic groups. It employs a validation-based approach where input ASVs are checked against reference sequences to identify "authentic" control groups, helping users determine the optimal filtering strategy that balances artifact removal with data retention.

## Installation
Install via bioconda:
```bash
conda install bioconda::metamate
```

## Core Workflow

### 1. The `find` Mode
The primary discovery phase. It assesses a range of frequency filtering specifications and outputs statistics rather than filtered sequences.

**Key Tasks:**
- Identifies authentic sequences using reference sets (via BBmap).
- Flags sequences based on length or translation parameters.
- Bins ASVs by library, clade, or taxon.
- Generates a report on how different thresholds affect the retention of validated sequences.

### 2. Analysis
Review the tabulated results from `find` to identify the threshold set that maximizes the removal of putative NUMTs while minimizing the loss of verified authentic ASVs.

### 3. The `dump` Mode
Once a strategy is chosen, use `dump` to extract the actual filtered ASV sequences from the results cache.

### 4. The `filter-adaptive` Mode
Used for applying filters that can adapt based on sample-specific characteristics rather than a single global threshold.

## Command Line Usage and Best Practices

### Input Requirements
- **ASVs**: Unique sequences (FASTA). Ideally denoised and filtered for length outliers.
- **Reference Sequences**: A set of sequences expected to be present. These are used to "validate" the filtering performance.
- **Library Data**: Information mapping ASVs to discrete sampling units (libraries). This is critical for the tool's power.

### Common CLI Patterns
While specific argument flags depend on the version, the general structure follows:
```bash
# Run discovery
metamate find --asvs sequences.fasta --references refs.fasta --outdir results_dir [additional binning/threshold args]

# Extract filtered data after analysis
metamate dump --cache results_dir/metamate_cache.zip --threshold_set [ID] --output filtered_asvs.fasta
```

### Expert Tips
- **ASV Limits**: If performing clade binning, metaMATE is limited to 65,536 input ASVs due to the complexity of the UPGMA algorithm.
- **Reference Selection**: References do not need to be comprehensive. Even a small set of high-confidence sequences (from BOLD, GenBank, or MIDORI) allows the tool to estimate the impact of filtering.
- **Library Definition**: Ensure your "libraries" represent discrete pools of amplicons (e.g., individual samples or PCR replicates). The tool's strength lies in assessing read counts across these units.
- **Phylogenetic Binning**: Use clade-based binning to catch NUMTs that might be locally abundant in one library but are phylogenetically distinct from authentic sequences.

## Reference documentation
- [metaMATE GitHub Repository](./references/github_com_tjcreedy_metamate.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_metamate_overview.md)