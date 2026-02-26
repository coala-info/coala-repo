---
name: pathphynder
description: pathPhynder places low-coverage or ancient DNA samples into high-coverage reference phylogenies by evaluating informative markers. Use when user asks to assign ancient samples to branches of a tree, perform phylogenetic placement for haploid data, or mitigate deamination effects in aDNA analysis.
homepage: https://github.com/ruidlpm/pathPhynder
---


# pathphynder

## Overview

pathPhynder is a specialized toolset designed to address the unique challenges of ancient DNA (aDNA) analysis, specifically deamination and low sequencing coverage. It enables the placement of ancient samples into high-coverage reference phylogenies by identifying informative markers and evaluating the likelihood of placement across different branches. This workflow is particularly useful for haploid data, such as Y-chromosome or mitochondrial DNA analysis, where ancient samples often lack the coverage required for traditional de novo tree building.

## Installation and Setup

The most reliable way to install pathPhynder and its dependencies (including `phynder` and `samtools`) is via Conda:

```bash
conda config --add channels bioconda
conda config --add channels conda-forge
conda config --set channel_priority flexible
conda create -n pathPhynder -c bioconda pathphynder samtools=1.20
conda activate pathPhynder
```

## Core Workflow

The pathPhynder process consists of three main phases: branch assignment, data preparation, and sample placement.

### 1. Assign SNPs to Branches
Before running pathPhynder, you must use `phynder` to identify which SNPs in your reference VCF map to specific branches of your Newick tree.

```bash
phynder -B -o branches.snp tree.nwk tree.vcf.gz
```

### 2. Prepare Reference Data
Prepare the necessary bed files and tables for phylogenetic placement.

```bash
pathPhynder -s prepare -i tree.nwk -p <output_prefix> -f branches.snp
```

### 3. Run Placement (The "All" Step)
You can process a single BAM file or a list of BAM files. This step performs pileup, filtering, path evaluation, and tree integration.

**Single Sample:**
```bash
pathPhynder -s all -i tree.nwk -p <data_prefix> -b <sample.bam>
```

**Multiple Samples:**
```bash
pathPhynder -s all -i tree.nwk -p <data_prefix> -l <bam_list.txt>
```

## Expert Tips and CLI Patterns

### Handling aDNA Damage
Ancient DNA often suffers from transitions (C->T and G->A) due to deamination. To minimize the impact of this damage, use the `transversions` filtering mode. This restricts analysis to transversions, which are not affected by deamination.

```bash
pathPhynder -s all -i tree.nwk -p <prefix> -b <sample.bam> -m transversions
```

### Adjusting Tolerance
If an ancient sample has many unexpected alleles (potentially due to contamination or extreme damage), the algorithm might stop traversing a path too early. Increase the `-t` (maximumTolerance) parameter to allow the algorithm to explore further.

```bash
pathPhynder -s all -i tree.nwk -p <prefix> -b <sample.bam> -t 5
```

### Quality Filtering
To ensure high-confidence placements, adjust the base quality threshold (`-q`) and the mismatch threshold (`-c`).

*   **Higher Stringency:** Increase `-q` (default 20) to ignore lower-quality sequencing bases.
*   **Mismatch Control:** Use `-c` to set a threshold for mismatches allowed in the pileup.

### Running Individual Steps
If the "all" step fails or you need to re-run only the placement logic without re-doing the pileups, use the individual step flags:
1.  `pileup_and_filter`: Generates filtered SNP calls.
2.  `chooseBestPath`: Performs the actual phylogenetic placement logic.
3.  `addAncToTree`: Generates a new Newick tree containing the ancient samples.

## Reference documentation
- [pathPhynder GitHub Repository](./references/github_com_ruidlpm_pathPhynder.md)
- [pathPhynder Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pathphynder_overview.md)