---
name: mlrho
description: mlrho performs maximum likelihood estimation of evolutionary parameters such as mutation and recombination rates from single diploid individual sequencing data. Use when user asks to estimate population genetic parameters, convert alignment files to profile format, or calculate sequencing error rates from shotgun data.
homepage: http://guanine.evolbio.mpg.de/mlRho/
metadata:
  docker_image: "quay.io/biocontainers/mlrho:2.9--ha9c9cc8_3"
---

# mlrho

## Overview
mlrho is a specialized suite of tools designed to perform maximum likelihood estimation of evolutionary parameters using data from a single diploid individual. Unlike traditional methods that require explicit SNP calling, mlrho utilizes a "profile" format to account for sequencing noise and zygosity patterns directly from assembled reads. This makes it particularly effective for analyzing shotgun sequencing data where coverage might be variable.

## Workflow and CLI Usage

The mlrho pipeline typically follows a two-step process: converting standard alignment formats into profiles, and then running the likelihood estimation.

### 1. Profile Generation
Before running the main analysis, convert your alignment files into the required `.pro` (profile) format using the appropriate auxiliary tool:

- **From SAM files**: `sam2pro -f reference.fasta input.sam > output.pro`
- **From Bowtie files**: `bow2pro input.bowtie > output.pro`
- **From ACE files**: `ace2pro input.ace > output.pro`

### 2. Running mlrho
Once the profile is generated, execute the main estimation tool. The output provides maximum likelihood estimates for $\theta$ (mutation), $\epsilon$ (error), and $\rho$ (recombination).

`mlRho [options] < input.pro > results.txt`

### 3. Profile Management
- **formatPro**: Use this to format or filter existing profile files to ensure they meet the requirements for the likelihood calculation.
- **inspectPro**: Use this to verify the contents and integrity of a profile file before running the computationally intensive estimation.

## Expert Tips and Best Practices
- **Single Individual Constraint**: Ensure the input data originates from a single diploid individual. The underlying model is specifically parameterized for diploid zygosity and will produce incorrect results if pooled samples or multiple individuals are included in a single profile.
- **Error Correction**: The tool is highly valued for its ability to estimate the sequencing error rate ($\epsilon$) simultaneously with biological parameters. This is useful for quality control in non-model organism genomics.
- **Simulation**: Use the included `sequencer` and `ms2dna` tools to generate synthetic datasets. This allows you to validate the sensitivity of the likelihood estimates against known parameters specific to your expected coverage and error profile.
- **Data Volume**: For large genomes, ensure that the profile generation step (`sam2pro`) is piped correctly to avoid creating massive intermediate text files, as profiles can grow significantly in size.

## Reference documentation
- [mlrho - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_mlrho_overview.md)
- [mlRho version 2.9: Software for Estimating the Population Mutation and Recombination Rates](./references/guanine_evolbio_mpg_de_mlRho.md)