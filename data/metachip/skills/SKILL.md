---
name: metachip
description: MetaCHIP is a bioinformatics pipeline for identifying community-level horizontal gene transfer events using a combination of heuristic searches and phylogenetic reconciliation. Use when user asks to identify horizontal gene transfer between prokaryotic genomes, map gene flow across taxonomic ranks, or analyze HGT between custom-defined groups.
homepage: https://github.com/songweizhi/MetaCHIP
metadata:
  docker_image: "quay.io/biocontainers/metachip:1.10.13--pyh7cba7a3_0"
---

# metachip

## Overview

MetaCHIP is a specialized bioinformatics pipeline for community-level horizontal gene transfer (HGT) identification. It distinguishes itself by combining heuristic "best-match" searches with rigorous phylogenetic reconciliation (using Ranger-DTL) to minimize false positives. You should use this tool when you have a collection of prokaryotic genomes and want to map the direction and frequency of gene flow between different taxonomic groups (from phylum down to species) or user-defined clusters.

## Usage Guidelines

### Pre-requisites and Input Requirements
- **Prokaryotes Only**: Do not include eukaryotic genomes in the input folder.
- **Genome Quality**: Input genomes must have at least 40% completeness for reliable results.
- **Taxonomy**: GTDB-Tk is the recommended tool for generating the taxonomic classification file. MetaCHIP requires the 'user_genome' and 'classification' columns.
- **File Names**: Ensure genome file extensions (e.g., .fa, .fasta) are **not** included in the taxonomy or grouping text files.

### Core Workflow
The pipeline is executed in two primary stages: the Phylogenetic Identification (PI) module and the Best-match/Phylogenetic (BP) module.

#### 1. PI Module (Initial Processing)
This module performs gene prediction, homology searching, and initial phylogenetic analysis.
```bash
MetaCHIP PI -p [prefix] -r [ranks] -t [threads] -i [input_folder] -x [extension] -taxon [taxonomy_file]
```
- `-r`: Taxonomic ranks to analyze. Use combinations of `d` (domain), `p` (phylum), `c` (class), `o` (order), `f` (family), `g` (genus), and `s` (species). Example: `-r pcofg`.
- `-x`: The extension of your genome files (e.g., `fasta` or `fna`).

#### 2. BP Module (HGT Identification)
This module identifies HGT events and generates visualizations.
```bash
MetaCHIP BP -p [prefix] -r [ranks] -t [threads]
```
- **Note**: The prefix (`-p`) and ranks (`-r`) must match those used in the PI step.
- **Visualization**: To generate plots of the flanking regions of identified HGTs, add the `-pfr` flag.

### Custom Grouping
If you want to detect HGT between specific groups not defined by standard taxonomy (e.g., different environments or experimental clusters), use the `-g` flag instead of `-taxon`.
```bash
MetaCHIP PI -p ProjectName -g customized_grouping.txt -t 8 -i ./bins -x fasta
MetaCHIP BP -p ProjectName -g customized_grouping.txt -t 8
```

### Supplementary Modules
- `rename_seqs`: Useful for cleaning up sequence headers before starting the pipeline.
- `filter_HGT`: Allows for post-processing and refining the HGT result list.
- `update_hmms`: Updates the internal HMM profiles (Pfam/TIGRFAMS).

## Best Practices and Tips
- **Output Management**: Use the `-o` flag (available in v1.10.6+) to specify a dedicated output directory and keep your workspace organized.
- **Multiprocessing**: Always utilize the `-t` flag to specify available CPU threads, as the phylogenetic reconciliation step is computationally intensive.
- **Interpreting Results**: 
    - The `[prefix]_[ranks]_detected_HGTs.txt` file is the primary output.
    - The `Occurrence` column in multi-level detections uses a bitstring (e.g., "011") to indicate at which taxonomic levels the HGT was confirmed.
    - Pay attention to the `Direction` column, which indicates the donor-to-recipient flow based on Ranger-DTL.

## Reference documentation
- [MetaCHIP GitHub Repository](./references/github_com_songweizhi_MetaCHIP.md)
- [MetaCHIP Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_metachip_overview.md)