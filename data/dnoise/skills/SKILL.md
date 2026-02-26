---
name: dnoise
description: DnoisE is a parallelizable denoising tool that merges error sequences into true variants while optionally weighting genetic distances based on codon entropy. Use when user asks to denoise Illumina datasets, perform entropy-corrected denoising for coding sequences, or merge sequences using ratio and distance criteria.
homepage: https://github.com/adriantich/DnoisE
---


# dnoise

## Overview
DnoisE is a parallelizable denoising tool designed as an alternative to the Unoise algorithm. It specializes in processing Illumina datasets by merging "daughter" sequences (errors) into "mother" sequences (true variants). Its primary advantage is the ability to weight genetic distances based on the entropy of codon positions, preventing the over-merging of natural variants that occur frequently at the third codon position.

## Installation and Setup
The most reliable way to deploy dnoise is via Bioconda:

```bash
conda install -c conda-forge -c bioconda dnoise
```

For high-performance environments, use the compiled binary (`DnoisE.bin`) generated during a manual installation to leverage Nuitka-optimized execution.

## Core CLI Usage
The tool is typically invoked using the `dnoise` command.

### Basic Denoising
Run a standard denoising process on a fasta or fastq file:
```bash
dnoise -i input.fas -o output.fas
```

### Entropy-Corrected Denoising
For coding sequences (like the Leray fragment of COI), use entropy correction to avoid losing biological diversity:
```bash
# Calculate entropy values first
dnoise -i input.fas -g

# Run denoising with abundance filtering
dnoise -i input.fas -r [abundance_threshold]
```

### Joining Criteria
DnoisE allows you to choose how sequences are merged. Select the method that best fits your data's diversity profile:
- **r (Ratio):** Original Unoise formulation; joins to the most abundant mother based on skew ratio.
- **d (Distance):** Joins to the mother with the lowest genetic distance.
- **r_d (Ratio-Distance):** Joins to the mother where the skew abundance ratio divided by beta(d) is lowest.

## Expert Tips and Best Practices
- **Parallelization:** DnoisE is designed for multi-core systems. Ensure your environment has sufficient cores allocated to significantly reduce processing time for large Illumina datasets.
- **MOTU Integration:** Use the `-w` flag to perform denoising within Molecular Operational Taxonomic Units (MOTUs) if your workflow involves prior clustering.
- **Input Flexibility:** The tool accepts `.csv`, `.fas`, and `.fastq` formats. It can also return results in `.csv` or `.fas`, making it easy to pipe into downstream ecological analysis scripts in R or Python.
- **Single Sequence Handling:** As of v1.4.2, if an input file contains only one sequence, the tool will bypass the denoising algorithm and provide the output directly to save overhead.
- **Entropy Customization:** If the default entropy calculation does not suit your specific marker, you can provide a custom measure of variability to weight the distances.

## Reference documentation
- [DnoisE GitHub Repository](./references/github_com_adriantich_DnoisE.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_dnoise_overview.md)