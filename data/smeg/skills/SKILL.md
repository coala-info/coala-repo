---
name: smeg
description: SMEG is a bioinformatics pipeline that estimates strain-level growth rates in microbial communities by analyzing the frequency of unique single nucleotide polymorphisms. Use when user asks to build a species database from genomes, estimate bacterial replication rates from metagenomic reads, or track growth dynamics of closely related subspecies.
homepage: https://github.com/ohlab/SMEG
---

# smeg

## Overview
SMEG is a bioinformatics pipeline designed to resolve growth rates at the strain level within complex microbial communities. It operates by identifying unique Single Nucleotide Polymorphisms (SNPs) that characterize specific bacterial clusters and then analyzing the frequency of these SNPs across the genome to infer replication rates. 

The tool is particularly useful for:
- Identifying novel or uncharacterized strains in a sample before growth estimation.
- Comparing growth dynamics of closely related subspecies.
- Analyzing metagenomic data where high-resolution strain tracking is required.

## Species Database Construction
Before estimating growth, you must build a database for the species of interest using `build_species`.

### Requirements
- A directory of genomes in `.fna`, `.fa`, or `.fasta` format.
- At least one **complete** reference genome must be present in the input set.

### Common Patterns
Build a standard database with default settings:
```bash
smeg build_species -g /path/to/genomes -o /path/to/output_db
```

Use "auto-mode" to test multiple SNP assignment thresholds (recommended for initial runs):
```bash
smeg build_species -g /path/to/genomes -o /path/to/output_db -a
```

Specify a representative genome and increase threading:
```bash
smeg build_species -g /path/to/genomes -o /path/to/output_db -r complete_genome_id -p 8
```

## Growth Rate Estimation
Use the `growth_est` module to analyze metagenomic reads against your built database.

### De Novo Approach (Default)
Best for samples where the specific strains present are not pre-defined.
```bash
smeg growth_est -r /path/to/reads -x fastq.gz -s /path/to/species_db -o /path/to/results -m 0
```

### Reference-Based Approach
Use when you have specific reference genomes you want to track.
```bash
smeg growth_est -r /path/to/reads -s /path/to/species_db -o /path/to/results -m 1 -g ref_list.txt
```

### Key Parameters for Accuracy
- `-c FLOAT`: Coverage cutoff (default 0.5). Increase this for higher confidence in low-abundance environments.
- `-u INT`: Minimum number of SNPs required to estimate growth (default 100). Lowering this may allow detection of rare strains but reduces statistical power.
- `-d FLOAT`: Cluster detection threshold (0.1 - 1). Adjusts how sensitive the tool is to detecting strain clusters in the sample.

## Expert Tips
- **Genome Selection**: For species with a massive number of available strains (e.g., *E. coli*), only include strains with complete genomes in the `build_species` step to improve database quality and reduce computational overhead.
- **Auto-Mode Selection**: When using `-a`, check the `log.txt` in the output. Look for the highest SNP assignment threshold that still maintains a sufficient number of unique SNPs for most clusters.
- **Contig Reordering**: If you only have draft genomes, SMEG uses Mauve to reorder them against the complete reference. Ensure Mauve is in your PATH.
- **Coverage Requirements**: Always verify the coverage of your strains in the output log before interpreting growth rates; low coverage can lead to erratic growth estimates.



## Subcommands

| Command | Description |
|---------|-------------|
| smeg_build_species | Builds a species database for SMEG. |
| smeg_growth_est | Estimate growth rate of bacterial populations from sequencing reads. |

## Reference documentation
- [SMEG Main Documentation](./references/github_com_ohlab_SMEG_blob_master_README.md)
- [Species Database Module](./references/github_com_ohlab_SMEG_blob_master_build_sp.md)
- [Growth Estimation Logic](./references/github_com_ohlab_SMEG_blob_master_SNP_method.R.md)