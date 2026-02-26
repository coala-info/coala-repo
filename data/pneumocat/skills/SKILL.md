---
name: pneumocat
description: "PneumoCaT assigns serotypes to *Streptococcus pneumoniae* genomic data using a hierarchical mapping and variant-calling approach. Use when user asks to assign serotypes to pneumococcal genomic data, differentiate between serotypes within a serogroup, or perform capsular typing on Illumina fastq files."
homepage: https://github.com/phe-bioinformatics/pneumocat/archive/v1.1.tar.gz
---


# pneumocat

## Overview
PneumoCaT (Pneumococcal Capsular Typing) is a specialized bioinformatic tool designed to assign serotypes to *S. pneumoniae* genomic data. It operates via a hierarchical logic: first, it performs coverage-based mapping against all known capsular locus sequences; if a unique match is found with >90% coverage, it reports the result. If multiple potential matches exist (common within serogroups), it triggers a second stage using a Capsular Type Variant (CTV) database to differentiate serotypes based on specific SNPs or indels.

## Usage Guidelines

### Basic Command Execution
To run a standard analysis on a pair of Illumina fastq files:
```bash
python PneumoCaT.py -1 <SAMPLE>_1.fastq.gz -2 <SAMPLE>_2.fastq.gz -o <OUTPUT_DIR> --threads 4
```

### Input Requirements
*   **Naming Convention**: Fastq files must end in `1.fastq` and `2.fastq` (or `.gz`). The tool splits the filename at the first `.` to determine the Sample ID.
*   **Read Format**: For the Step 2 variant analysis, the last character before the extension must be the read number (e.g., `sample_1.fastq.gz`).
*   **Quality Metrics**: PneumoCaT requires a mean depth of 20x across the mapped sequence and a minimum depth of 5x. If these are not met, the tool will report "Failed".

### Resource Management
*   **Threads**: Use the `--threads` or `-t` flag to speed up the Bowtie2 mapping process.
*   **Cleanup**: Use the `--cleanup` or `-c` flag to automatically remove intermediate BAM files, which can be large, upon completion.

### Database and Path Configuration
If the CTV database or dependencies are not in your environment's PATH, specify them explicitly:
*   `--variant_database`: Path to the `streptococcus-pneumoniae-ctvdb` folder.
*   `--bowtie`: Path to the `bowtie2` executable.
*   `--samtools`: Path to `samtools` (requires version 1.3+).

## Interpreting Results
*   **Step 1 Result**: Found in `SAMPLEID.results.xml`. If the serotype is determined here, the process stops.
*   **Step 2 Result**: If Step 1 identifies a serogroup (e.g., Group 6), check the final XML output for the variant-based refinement (e.g., 6A vs 6B).
*   **19AF Determination**: In version 1.2.1+, an "19AF" result indicates an isolate that genetically resembles 19A but typically phenotypes as 19F due to the *wzy* gene.

## Troubleshooting
*   **Bowtie2 Failures**: Often caused by fastq filenames not following the strict `*1.fastq` / `*2.fastq` pattern required for Step 2.
*   **Samtools Errors**: Ensure you are using Samtools 1.3 or higher. Older versions (0.1.19) use different command-line arguments for sorting and are incompatible.
*   **Low Concordance**: Always prioritize the XML file in the final output directory over intermediate text logs to ensure you are seeing the refined Step 2 call.

## Reference documentation
- [PneumoCaT GitHub Repository](./references/github_com_ukhsa-collaboration_PneumoCaT.md)
- [Bioconda PneumoCaT Overview](./references/anaconda_org_channels_bioconda_packages_pneumocat_overview.md)