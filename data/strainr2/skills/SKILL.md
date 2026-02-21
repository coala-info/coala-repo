---
name: strainr2
description: StrainR2 is a specialized metagenomic tool designed to deconvolve the relative abundance of specific microbial strains within a known community.
homepage: https://github.com/BisanzLab/StrainR2
---

# strainr2

## Overview
StrainR2 is a specialized metagenomic tool designed to deconvolve the relative abundance of specific microbial strains within a known community. Unlike general-purpose taxonomic profilers, it uses a two-step process—database preparation and read normalization—to overcome biases inherent in unique mapping and genome quality. It is particularly effective for synthetic communities where reference genomes for all expected members are available.

## Installation
The recommended way to install strainr2 is via Bioconda:
```bash
conda create -n strainr2 -c bioconda -c conda-forge strainr2
conda activate strainr2
```

## Workflow and CLI Patterns

### 1. Database Preparation (PreProcessR)
Before analyzing reads, you must create a reference database from your community's genome files (.fasta or .fna). This step only needs to be performed once for a specific community.

```bash
PreProcessR -i /path/to/genomes -o ./MyCommunityDB [OPTIONS]
```

**Key Options:**
- `-e, --excludesize`: Minimum subcontig size (default: 10,000). Contigs smaller than this are ignored.
- `-r, --readsize`: Set this to match your sequencing length (e.g., 150 for 150bp reads).
- `-m, --singleend`: Use this flag if you intend to process single-end reads in the next step.

### 2. Abundance Quantification (StrainR)
Once the database is ready, use the reads from your sample to calculate normalized abundances.

```bash
StrainR -1 forward_reads.fq.gz -2 reverse_reads.fq.gz -r ./MyCommunityDB -o ./results -p SampleName
```

**Key Options:**
- `-c, --weightedpercentile`: Controls sensitivity (default: 60). Increase this value to detect lower abundance strains, though this may increase false positives.
- `-t, --threads`: Specify the number of CPU cores to accelerate mapping.
- `-b1, -b2`: Use these to provide background reads (e.g., host DNA) that should be excluded from the analysis.

## Expert Tips and Best Practices
- **Memory Management**: `PreProcessR` can be memory-intensive for large communities. If the process crashes without an error, increase your system's swap space or available RAM.
- **Subcontig Tuning**: While the tool automatically calculates an optimal subcontig size based on N50, you can override it with `-s`. Smaller subcontigs reduce sensitivity to low-abundance strains, while larger ones may increase false positives due to index hopping or read errors.
- **Output Files**:
    - `.abundance`: The primary result file containing normalized strain abundances.
    - `.rpkm`: Raw RPKM values before StrainR2's specific normalization.
    - `.sam`: The alignment file generated during the process.
- **Input Quality**: Ensure the input directory for `PreProcessR` contains *only* the genome files for the strains you expect to find. Extraneous files can corrupt the database index.

## Reference documentation
- [StrainR2 GitHub README](./references/github_com_BisanzLab_StrainR2.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_strainr2_overview.md)