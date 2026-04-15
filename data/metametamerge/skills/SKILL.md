---
name: metametamerge
description: MetaMetaMerge integrates and normalizes taxonomic profiling and binning outputs from multiple metagenomic classifiers into a consensus result. Use when user asks to merge disparate metagenomic classification results, calculate consensus abundances across different tools, or resolve taxonomic conflicts between profiling and binning data.
homepage: https://github.com/pirovc/metametamerge/
metadata:
  docker_image: "quay.io/biocontainers/metametamerge:1.1--py35_1"
---

# metametamerge

## Overview
MetaMetaMerge is a specialized tool for integrating disparate outputs from various metagenomic taxonomic classifiers. It handles both profiling (abundance-based) and binning (read-based) data, normalizing them against a common taxonomic framework. By using database profiles that describe the "search space" of each individual tool, it can accurately calculate consensus abundances and resolve taxonomic conflicts.

## Input Preparation
MetaMetaMerge requires specific input formats and auxiliary files to function correctly.

### 1. Input Files (-i)
Supports two primary formats:
- **BioBoxes**: Standardized CAMI format.
- **TSV**: 
  - **Profiling**: `rank`, `taxon name/taxid`, `abundance` (e.g., `species 195 0.0582`).
  - **Binning**: `readid`, `taxon name/taxid`, `sequence_length` (e.g., `R140 354 201`).

### 2. Database Profiles (-d)
You must provide a database profile for every input tool. These profiles represent the taxa known to the tool's specific database.
- Generate these using the `acc2tab.bash` and `tab2count.bash` scripts from the MetaMeta repository.
- The order of files in `-d` must exactly match the order of input files in `-i`.

### 3. NCBI Taxonomy Files
You must provide the following files from the NCBI Taxonomy database:
- `names.dmp` (-n)
- `nodes.dmp` (-e)
- `merged.dmp` (-m)

## Common CLI Patterns

### Merging Multiple Profilers
To merge results from three different profiling tools (e.g., ToolA, ToolB, ToolC):
```bash
MetaMetaMerge.py \
  -i toolA.tsv toolB.tsv toolC.tsv \
  -d db_profileA.out db_profileB.out db_profileC.out \
  -t 'ToolA,ToolB,ToolC' \
  -c 'p,p,p' \
  -n names.dmp -e nodes.dmp -m merged.dmp \
  -o merged_profile.tsv -p tsv
```

### Combining Binning and Profiling
If merging a binning tool with a profiling tool:
```bash
MetaMetaMerge.py \
  -i binning_results.tsv profiling_results.tsv \
  -d db_binning.out db_profiling.out \
  -t 'BinTool,ProfTool' \
  -c 'b,p' \
  -n names.dmp -e nodes.dmp -m merged.dmp \
  -o combined_output.out
```

## Expert Tips and Parameters

### Adjusting Sensitivity and Precision
Use the `-f` (mode) parameter to control the merging logic:
- `linear`: The default balanced approach.
- `precise` / `very-precise`: Prioritizes agreement between tools; reduces false positives.
- `sensitive` / `very-sensitive`: Includes more low-abundance or single-tool identifications.
- `no-cutoff`: Disables internal filtering.

### Filtering Results
- **Abundance Cutoff (-r)**: 
  - Values between 0 and 1 (e.g., `0.001`) set a minimum relative abundance threshold.
  - Values $\ge$ 1 (e.g., `50`) limit the output to the top N identifications per rank.
- **Rank Selection (-s)**: By default, the tool merges at the `species` level. You can specify a comma-separated list (e.g., `genus,species`) or use `all` to merge every taxonomic level independently.

### Detailed Diagnostics
Use the `--detailed` flag to generate an additional output file. This file includes normalized abundances for each individual tool, where:
- `0`: Taxon was not identified but was present in the tool's database.
- `-1`: Taxon was not present in the tool's database (the tool was "blind" to this organism).

## Reference documentation
- [MetaMetaMerge GitHub Repository](./references/github_com_pirovc_metametamerge.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_metametamerge_overview.md)