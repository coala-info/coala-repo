---
name: genotyphi
description: genotyphi classifies Salmonella Typhi strains into hierarchical lineages and identifies AMR genes and plasmid replicons from sequence data. Use when user asks to classify Salmonella Typhi genotypes, detect AMR mutations in Typhi, or identify plasmid replicons from FASTQ or VCF files.
homepage: https://github.com/katholt/genotyphi
---


# genotyphi

## Overview
The `genotyphi` skill provides a standardized framework for the classification of Salmonella Typhi. It allows researchers to categorize strains into a hierarchical nomenclature (lineages, clades, and subclades) based on unique single nucleotide variant (SNV) markers. Beyond genotyping, the tool integrates AMR gene detection and plasmid replicon identification, specifically tailored for the Typhi global surveillance community.

## Installation and Setup
The tool and its dependencies are primarily managed via Bioconda.

```bash
# Install genotyphi and mykrobe
conda install -c bioconda genotyphi mykrobe
```

Before running predictions, ensure the Typhi-specific panels are up to date:
```bash
mykrobe panels update_metadata
mykrobe panels update_species all
```
Verify the installed version: `mykrobe panels describe`

## Core Workflows

### 1. Genotyping from FASTQ (Typhi Mykrobe)
This is the recommended path for raw sequence data. It provides simultaneous calls for GenoTyphi genotypes, AMR mutations (QRDR, acrB), and plasmid replicons (IncHI1).

**Illumina Paired-end:**
```bash
mykrobe predict --sample <SampleName> \
  --species typhi \
  --format json \
  --out <SampleName>.json \
  --seq <R1.fastq.gz> <R2.fastq.gz>
```

**Oxford Nanopore (ONT):**
Add the `--ont` flag to the command above to optimize for long-read error profiles.

### 2. Tabulating Results
After generating individual JSON files for multiple samples, use the provided Python parser to create a summary table.

```bash
python parse_typhi_mykrobe.py --jsons *.json --prefix typhi_summary
```
*Note: The parser requires a minimum of 85% identity to Typhi MLST loci to report a call.*

### 3. VCF-based Genotyping
For users who have already performed mapping and variant calling:
- Ensure the reference genome used is **Typhi CT18 (AL513382)**.
- The tool uses the SNV markers defined in `GenoTyphi_specification.csv` to assign the most specific genotype possible.

## Expert Tips and Best Practices
- **Reference Consistency:** Always map to CT18. Using other reference genomes will result in incorrect genotype assignments due to coordinate shifts.
- **AMR Interpretation:** The output provides an antibiogram (R/I/S). Note that azithromycin resistance is specifically tracked via `acrB` mutations (R717Q/L).
- **Nomenclature Logic:** Genotypes are hierarchical. For example, `2.2.1` is a subclade of `2.2`. If a specific subclade marker is not found, the tool will default to the parent clade.
- **Version Tracking:** The GenoTyphi scheme is updated periodically. Always check the version of the Mykrobe panel to ensure you are using the latest definitions (e.g., v20240407).

## Reference documentation
- [GenoTyphi GitHub Repository](./references/github_com_typhoidgenomics_genotyphi.md)
- [Bioconda Genotyphi Overview](./references/anaconda_org_channels_bioconda_packages_genotyphi_overview.md)