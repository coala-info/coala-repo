---
name: smeg
description: SMEG (Strain-level Metagenomic Estimation of Growth rate) is a specialized bioinformatics tool for measuring the replication rates of specific microbial strains within complex environmental or clinical samples.
homepage: https://github.com/ohlab/SMEG
---

# smeg

## Overview
SMEG (Strain-level Metagenomic Estimation of Growth rate) is a specialized bioinformatics tool for measuring the replication rates of specific microbial strains within complex environmental or clinical samples. Unlike tools that provide bulk species-level growth estimates, SMEG differentiates between closely related strains by identifying cluster-specific unique SNPs. The tool operates in two main phases: first, it constructs a species database from a collection of genomes (requiring at least one complete reference); second, it uses this database to infer growth rates from metagenomic reads.

## Installation and Environment
SMEG requires specific versions of dependencies to ensure compatibility.
- **Conda Installation**: `conda install smeg=1.1.5 prokka=1.11 r-base=3.5.1`
- **System Dependency**: The `rename` utility is often required on Linux systems: `sudo apt-get install -y rename`
- **Singularity**: An image is available for containerized execution: `singularity exec smeg.sif smeg -h`

## Database Construction (build_species)
The `build_species` module prepares the reference data needed for growth estimation.

### Critical Requirements
- **Genome Completeness**: You must provide at least one **COMPLETE** reference genome in the input directory.
- **Draft Genomes**: If using draft genomes, they should be reordered (e.g., using Mauve) against a closely related complete genome to minimize fragmentation issues.
- **File Extensions**: Input genomes must have `.fna`, `.fa`, or `.fasta` extensions.

### Common CLI Patterns
- **Standard Build**:
  `smeg build_species -g /path/to/genomes -o /path/to/output -p 8`
- **Auto-Mode (Recommended)**:
  `smeg build_species -g /path/to/genomes -o /path/to/output -a`
  *Note: The `-a` flag tests multiple SNP assignment thresholds in parallel, allowing you to select the most robust database based on the `log.txt` summary.*
- **Custom SNP Sensitivity**:
  `smeg build_species -g ./genomes -o ./db -s 0.8 -t 100`
  *Sets the SNP assignment threshold to 80% and the iterative clustering threshold to 100 SNPs.*

### Parameter Guide
- `-g`: Directory containing strain genomes.
- `-o`: Output directory for the database.
- `-s`: SNP assignment threshold (0.1 - 1.0). Higher values increase specificity but may reduce the number of usable SNPs.
- `-t`: Minimum number of unique SNPs required before attempting iterative sub-clustering.
- `-r`: Specify a specific representative genome (must be a complete genome).

## Growth Estimation (growth_est)
Once the database is built, use the `growth_est` module to process metagenomic samples.
- **Reference-based**: Uses the pre-built database to map reads and calculate growth.
- **De novo**: Capable of identifying uncharacterized strains in the sample prior to estimation.

## Expert Tips and Best Practices
- **Species with High Strain Counts**: For species like *E. coli* (>700 strains), it is more efficient and accurate to build the database using only strains with complete genomes.
- **Interpreting log.txt**: When using auto-mode, check the `log.txt` file. Databases are stored in folders labeled `T.{threshold}` (iterative clustering ignored) or `F.{threshold}` (iterative clustering active).
- **Phylogenetic Outliers**: SMEG automatically excludes strains with pairwise distances 30 times above the median to prevent taxonomic misclassification or contamination from affecting the growth model.
- **SNP Assignment**: A unique SNP is only identified if it is present in the specified proportion of cluster members (defined by `-s`) and absent in all other clusters.

## Reference documentation
- [SMEG GitHub Repository](./references/github_com_ohlab_SMEG.md)
- [Bioconda SMEG Overview](./references/anaconda_org_channels_bioconda_packages_smeg_overview.md)