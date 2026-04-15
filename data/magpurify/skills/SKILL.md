---
name: magpurify
description: MAGpurify is a modular pipeline designed to improve the quality of metagenomic bins by identifying and removing contaminating contigs. Use when user asks to clean metagenomic bins, identify taxonomic discordance, detect sequence composition outliers, or filter contigs based on inconsistent coverage profiles.
homepage: https://github.com/snayfach/MAGpurify
metadata:
  docker_image: "quay.io/biocontainers/magpurify:2.1.2--pyhdfd78af_2"
---

# magpurify

## Overview

MAGpurify is a modular pipeline designed to improve the quality of metagenomic bins. It defines contamination as contigs belonging to a species other than the primary organism represented in the MAG. The tool is built on a "high specificity" philosophy, meaning it aims to minimize the accidental removal of correct contigs while identifying clear outliers. It employs a multi-pronged approach—checking for taxonomic discordance, sequence composition outliers (GC and tetranucleotide frequency), and inconsistent coverage profiles across samples.

## Installation and Database Setup

Before running the modules, ensure the environment is configured:

1.  **Database**: Download and unpack the MAGpurify reference database (v1.0).
2.  **Environment Variable**: Set the path to the database to avoid using the `--db` flag in every command:
    `export MAGPURIFYDB=/path/to/MAGpurify-db-v1.0`

## Core Workflow

The standard workflow involves running individual detection modules followed by a final cleaning step.

### 1. Run Detection Modules
Execute the desired modules against your input MAG. Each module populates the specified output directory with flagged contig information.

```bash
# Taxonomic discordance modules (Requires Database)
magpurify phylo-markers input.fna output_dir/
magpurify clade-markers input.fna output_dir/
magpurify known-contam input.fna output_dir/

# Sequence composition modules (No external data required)
magpurify tetra-freq input.fna output_dir/
magpurify gc-content input.fna output_dir/

# Coverage-based detection (Requires sorted BAM files)
magpurify coverage input.fna output_dir/ sample1.bam sample2.bam
```

### 2. Conspecific Alignment (Advanced)
To find contigs that fail to align to closely related genomes, you must first build a Mash sketch of reference genomes:

```bash
# Create the reference sketch
mash sketch -l ref_genomes.list -o ref_genomes_sketch

# Run the module
magpurify conspecific input.fna output_dir/ ref_genomes_sketch.msh
```

### 3. Clean the Bin
After running the detection modules, use `clean-bin` to generate the final purified FASTA file. This module aggregates all flags found in the output directory.

```bash
magpurify clean-bin input.fna output_dir/ cleaned_mag.fna
```

## Expert Tips and Best Practices

*   **Sequential Execution**: Modules are independent and can be run in any order or in parallel, provided they share the same output directory for the final `clean-bin` step.
*   **Specificity vs. Sensitivity**: The default parameters are tuned for high specificity. If you suspect significant remaining contamination, consider lowering the thresholds for `gc-content` or `tetra-freq` modules.
*   **Coverage Module Selection**: When providing multiple BAM files to the `coverage` module, MAGpurify automatically selects the sample with the highest average contig coverage for outlier detection.
*   **Resource Management**: For large MAGs or many bins, ensure `prodigal`, `hmmer`, and `blast` are in your PATH, as these are the primary computational bottlenecks for the marker-based modules.



## Subcommands

| Command | Description |
|---------|-------------|
| magpurify clade-markers | Find taxonomic discordant contigs using a database of clade-specific marker genes. |
| magpurify clean-bin | Remove putative contaminant contigs from bin. |
| magpurify conspecific | Find contigs that fail to align to closely related genomes. |
| magpurify gc-content | Find contigs with outlier GC content. |
| magpurify known-contam | Find contigs that match a database of known contaminants. |
| magpurify phylo-markers | Find taxonomic discordant contigs using a database of phylogenetic marker genes. |
| magpurify tetra-freq | Find contigs with outlier tetranucleotide frequency. |
| magpurify_coverage | Find contigs with outlier coverage profile. |

## Reference documentation
- [MAGpurify GitHub Repository](./references/github_com_snayfach_MAGpurify_blob_master_README.md)
- [MAGpurify Overview](./references/anaconda_org_channels_bioconda_packages_magpurify_overview.md)