---
name: taseq
description: taseq is a bioinformatics toolkit designed for genotyping targeted amplicon sequencing data through a streamlined four-step workflow. Use when user asks to call haplotypes, generate genotype matrices, filter variants for R/qtl software, or visualize genotypes across chromosomes.
homepage: https://github.com/KChigira/taseq/
metadata:
  docker_image: "quay.io/biocontainers/taseq:1.1.1--pyh7e72e81_0"
---

# taseq

## Overview

taseq is a bioinformatics toolkit designed for the efficient genotyping of targeted amplicon sequencing data. It streamlines the transition from raw sequencing reads to analysis-ready genotype matrices by integrating alignment, variant calling, and filtering into a cohesive four-step command-line workflow. This skill enables the generation of genotype files suitable for R/qtl software and provides tools for visual genotype inspection.

## Installation and Environment

Install taseq via the bioconda channel. It is recommended to use a dedicated environment due to specific dependencies like GATK4 and Samtools.

```bash
conda create -n taseq python=3.12
conda activate taseq
conda install taseq -c bioconda -c conda-forge
```

## Core Workflow

### 1. Haplotype Calling (`taseq_hapcall`)
Processes raw FASTQ files against a reference genome and a target VCF.

*   **Input Requirement**: The input directory (`-I`) must contain only the FASTQ files for the analysis.
*   **Naming Convention**: Files must follow the `[SampleName]_*R1*` and `[SampleName]_*R2*` pattern. The string before the first underscore is parsed as the sample name.
*   **Command**:
    ```bash
    taseq_hapcall -I ./fastq_dir -R ref.fasta -V targets.vcf -n output_dir --cpu 4
    ```

### 2. Genotyping (`taseq_genotype`)
Converts the VCF output from hapcalling into a genotype table.

*   **Parental Specification**: `-p1` and `-p2` must exactly match the column names (sample names) in the VCF used during the hapcall step.
*   **Key Parameters**:
    *   `--mindep`: Minimum read depth (default: 10).
    *   `--hetero_chi`: Chi-square threshold for heterozygote calling (default: 3.84).
*   **Command**:
    ```bash
    taseq_genotype -I output_dir/result_taseq_hapcall.vcf -p1 ParentA -p2 ParentB -n genotype_dir
    ```

### 3. Filtering (`taseq_filter`)
Refines the genotype table based on quality metrics and parental consistency.

*   **R/qtl Export**: This step automatically generates `result_taseq_filter_formated_for_Rqtl.csv`.
*   **Best Practice**: Use `--check_parents` to remove markers where parental genotypes do not match the expected A/B assignment.
*   **Command**:
    ```bash
    taseq_filter -I genotype_dir/result_taseq_genotype.tsv --parent_sample1 ParentA --parent_sample2 ParentB --missing_rate 0.2 -n filter_dir
    ```

### 4. Visualization (`taseq_draw`)
Generates graphical representations of the genotypes across chromosomes.

*   **Requirement**: Requires the FASTA index (`.fai`) of the reference genome to define chromosome lengths.
*   **Command**:
    ```bash
    taseq_draw -I filter_dir/result_taseq_filter.tsv -F ref.fasta.fai -n plots_dir
    ```

## Expert Tips and Best Practices

*   **Adapter Trimming**: By default, `taseq_hapcall` assumes reads are already trimmed (`--adapter NONE`). If using Nextera or TruSeq adapters, specify them explicitly to avoid alignment artifacts.
*   **Memory Management**: Ensure the system has >16GB RAM, as GATK4 and Picard operations within the pipeline are memory-intensive.
*   **Target VCF**: The target VCF (`-V`) should ideally be created using `mkdesigner` or `mkselect` to ensure compatibility with the amplicon targets.
*   **Sample Naming**: Avoid underscores in the actual sample names, as taseq uses the first underscore as a delimiter to identify the sample ID from the FASTQ filename.

## Reference documentation
- [taseq GitHub Repository](./references/github_com_KChigira_taseq.md)
- [taseq Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_taseq_overview.md)