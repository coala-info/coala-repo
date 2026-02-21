---
name: nasp
description: NASP (Northern Arizona SNP Pipeline) is a comparative genomics toolset designed to identify and report statistically relevant, high-confidence SNPs across a collection of genomes.
homepage: https://github.com/TGenNorth/nasp
---

# nasp

## Overview

NASP (Northern Arizona SNP Pipeline) is a comparative genomics toolset designed to identify and report statistically relevant, high-confidence SNPs across a collection of genomes. It functions as a pipeline that orchestrates external alignment and variant-calling tools to process raw sequencing data or pre-processed alignment files. It is specifically optimized for large-scale genomic analysis where consistency and accuracy in variant calling are paramount for downstream applications like phylogenetics.

## Installation

The recommended way to install NASP is via Conda:

```bash
conda install -c bioconda nasp
```

## Core Workflows

### 1. Interactive Analysis Setup
The most common way to initiate a NASP run is through its interactive command-line interface. This mode guides you through the selection of reference genomes, input files, and specific tools for alignment and SNP calling.

**Procedure:**
1. Create a dedicated folder for your project.
2. Place or symbolically link your input files (FASTA, FASTQ, BAM, or VCF) into this folder.
3. Execute the pipeline:
   ```bash
   nasp.py [output_folder]
   ```
4. Follow the prompts to configure your analysis parameters.

### 2. Configuration-Based Execution
After an interactive run, NASP generates an XML-based configuration file in the output directory. You can use this file to re-run the analysis or to automate similar workflows.

**Command:**
```bash
nasp.py --config [path_to_config.xml]
```

## Input Requirements

NASP is flexible with input formats, allowing you to start from various stages of a genomic workflow:
- **Reference:** A FASTA format genome.
- **Reads:** FASTQ files for mapping.
- **Alignments:** SAM or BAM files.
- **Variants:** VCF files.

## Best Practices

- **Input Organization:** Use symbolic links (`ln -s`) to point to your data files within the NASP working directory. This avoids duplicating large genomic files while keeping the pipeline's input scope clearly defined.
- **External Tools:** NASP relies on external tools (e.g., BWA, Bowtie2, GATK, Samtools). Ensure these are installed and available in your system's `$PATH` before starting the pipeline.
- **Reproducibility:** Always archive the XML configuration file generated in the `output_folder`. This file is the definitive record of the parameters and tool versions used for your specific SNP matrix.
- **Output Review:** NASP produces a variety of output files, including a master SNP matrix. Focus on the "filtered" or "high-confidence" outputs for phylogenetic tree construction to minimize noise from low-coverage or repetitive regions.

## Reference documentation
- [NASP Overview](./references/anaconda_org_channels_bioconda_packages_nasp_overview.md)
- [NASP GitHub Repository](./references/github_com_TGenNorth_NASP.md)