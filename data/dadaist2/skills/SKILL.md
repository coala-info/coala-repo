---
name: dadaist2
description: dadaist2 is a command-line wrapper for the DADA2 package to generate feature tables and representative sequences from paired-end Illumina reads. Use when user asks to perform amplicon sequence variant (ASV) analysis, taxonomic profiling, or generate ecological analyses from metabarcoding data.
homepage: https://github.com/quadram-institute-bioscience/dadaist2
metadata:
  docker_image: "quay.io/biocontainers/dadaist2:1.3.1--hdfd78af_2"
---

# dadaist2

dadaist2/SKILL.md
```yaml
name: dadaist2
description: |
  A command-line wrapper for the DADA2 package, designed to streamline the process of generating feature tables and representative sequences from paired-end Illumina reads.
  Use this skill when you need to perform amplicon sequence variant (ASV) analysis, taxonomic profiling, or generate ecological analyses from metabarcoding data.
  This skill is particularly useful for researchers working with 16S, 18S, or ITS amplicon sequencing data.
```
## Overview
Dadaist2 is a command-line tool that simplifies the execution of the DADA2 pipeline for processing paired-end sequencing reads. It automates the generation of amplicon sequence variants (ASVs), feature tables, and representative sequences, making it easier to conduct taxonomic profiling and downstream ecological analyses. This skill is ideal for users who need to analyze metabarcoding data from sources like 16S, 18S, or ITS regions.

## Usage Instructions

Dadaist2 is designed to be run from the command line. The primary function is to process a directory of paired-end reads.

### Basic Workflow

The core functionality involves specifying the input directory containing your FASTQ files and an output directory for the results.

```bash
dadaist2 --input_dir /path/to/your/fastq/files --output_dir /path/to/output/directory
```

### Key Options and Parameters

While the basic command is straightforward, dadaist2 offers several options to customize the DADA2 pipeline. Consult the DADA2 documentation for a comprehensive understanding of the underlying parameters, as dadaist2 aims to provide a convenient wrapper.

*   **`--input_dir`**: (Required) Path to the directory containing your paired-end FASTQ files. Files should be named in a way that DADA2 can infer forward and reverse reads (e.g., `sample1_R1.fastq.gz`, `sample1_R2.fastq.gz`).
*   **`--output_dir`**: (Required) Path to the directory where all output files will be saved. This includes the feature table, representative sequences, and any generated plots.
*   **`--sample_sheet`**: Path to a sample sheet (CSV or TSV) that maps sample names to their corresponding forward and reverse read files. This is highly recommended for managing multiple samples.
*   **`--trunc_len_fwd`**: Truncation length for forward reads.
*   **`--trunc_len_rev`**: Truncation length for reverse reads.
*   **`--max_ee_fwd`**: Maximum expected errors for forward reads.
*   **`--max_ee_rev`**: Maximum expected errors for reverse reads.
*   **`--pooling`**: Whether to pool samples for denoising.
*   **`--output_format`**: Specifies the output format for the feature table (e.g., `biom`, `tsv`).

### Advanced Usage and Tips

*   **Sample Sheets**: For projects with many samples, using a sample sheet is crucial for organization and reproducibility. Ensure your sample sheet correctly links sample IDs to their respective R1 and R2 files.
*   **Parameter Tuning**: The default parameters for DADA2 are generally robust, but for optimal results, consider adjusting `trunc_len_fwd`, `trunc_len_rev`, `max_ee_fwd`, and `max_ee_rev` based on your sequencing quality and amplicon length. Refer to DADA2 documentation for guidance on these parameters.
*   **Output Files**: Dadaist2 will generate several key files in the specified output directory:
    *   `feature-table.biom` (or `.tsv`): The ASV feature table.
    *   `dna-sequences.fasta`: Representative sequences for each ASV.
    *   Plots and intermediate files may also be generated depending on the DADA2 pipeline steps executed.

## Reference documentation
- [Dadaist2 Overview](./references/anaconda_org_channels_bioconda_packages_dadaist2_overview.md)
- [Dadaist2 GitHub Repository](./references/github_com_quadram-institute-bioscience_dadaist2.md)