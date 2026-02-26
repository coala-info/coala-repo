---
name: illumiprocessor
description: illumiprocessor is a high-throughput wrapper for Trimmomatic that automates adapter removal and quality trimming for large batches of Illumina sequencing data. Use when user asks to trim adapter sequences, remove low-quality bases, or preprocess raw fastq files into a standardized directory structure.
homepage: https://github.com/faircloth-lab/illumiprocessor
---


# illumiprocessor

## Overview
illumiprocessor is a high-throughput wrapper for the Trimmomatic package, designed to streamline the preprocessing of Illumina sequencing data. It automates the removal of adapter contamination and low-quality bases across large batches of samples simultaneously. By utilizing a structured configuration file, it maps raw fastq files to specific samples, handles double-indexed reads, and organizes the resulting cleaned data into a standardized directory structure. This tool is ideal for researchers who need a deterministic, parallelized workflow for cleaning genomic or phylogenomic datasets before downstream analysis.

## Installation
The recommended way to install illumiprocessor is via conda:
```bash
conda install -c bioconda illumiprocessor
```
Note: As a wrapper for Trimmomatic, it requires a Java Runtime Environment (JRE) to be installed on the system.

## Configuration File Structure
illumiprocessor requires a configuration file in Microsoft Windows INI format. This file defines the adapters, barcodes, and sample mappings.

### Required Sections
1.  **[adapters]**: Define the i7 and i5 adapter sequences.
    ```ini
    [adapters]
    i7:AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC*ATCTCGTATGCCGTCTTCTGCTTG
    i5:AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGTAGATCTCGGTGGTCGCCGTATCATT
    ```
2.  **[tag sequences]**: List the unique barcode sequences used in the library.
    ```ini
    [tag sequences]
    BFIDT-030:ATGAGGC
    BFIDT-003:AATACTT
    ```
3.  **[tag map]**: Map the fastq file identifier (often the barcode sequence in the filename) to the tag name.
    ```ini
    [tag map]
    Sample1_ATGAGGC:BFIDT-030
    Sample2_AATACTT:BFIDT-003
    ```
4.  **[names]**: Map the internal identifiers to the desired final sample names for output folders.
    ```ini
    [names]
    Sample1_ATGAGGC:Project-Sample-01
    Sample2_AATACTT:Project-Sample-02
    ```

## Command Line Usage
Run the processor by pointing to your input directory, desired output location, and the prepared config file.

```bash
illumiprocessor \
    --input <path-to-raw-fastq-directory> \
    --output <path-to-output-directory> \
    --config <path-to-config-file> \
    --cores <number-of-physical-cores>
```

### Key Arguments
- `--input`: Directory containing your raw `.fastq.gz` files. illumiprocessor assumes you have already merged multiple lanes/files for a single sample into one R1 and one R2 file.
- `--output`: The directory where the tool will create the sample-specific subfolder structure.
- `--cores`: Number of CPU cores to use. Each sample is typically processed on a separate core.
- `--trimmomatic`: (Optional) Path to the Trimmomatic .jar file if it is not in your system path.

## Output Organization
For every sample defined in the `[names]` section, illumiprocessor creates a directory containing:
- `raw-reads/`: Symlinks to the original input files.
- `split-adapter-quality-trimmed/`: The cleaned `.fastq.gz` files (READ1, READ2, and singletons).
- `stats/`: Text files detailing adapter contamination and trimming statistics.
- `adapters.fasta`: The specific adapter sequences used for that sample.

## Expert Tips and Best Practices
- **File Naming**: Ensure your input fastq filenames contain the identifiers used in the `[tag map]` section. The tool uses string matching to associate files with configuration entries.
- **Memory Management**: Since Trimmomatic runs on the JVM, ensure your system has enough RAM to support the number of parallel threads specified by `--cores`.
- **Pre-processing**: Always merge fastq files from multiple lanes for the same sample before running illumiprocessor. It expects a 1:1 or 2:1 (for PE) relationship between files and samples.
- **Adapter Trimming**: If you suspect residual contamination after running, you may follow up with a tool like Scythe, though Trimmomatic's performance is generally sufficient for most Illumina datasets.

## Reference documentation
- [illumiprocessor GitHub Repository](./references/github_com_faircloth-lab_illumiprocessor.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_illumiprocessor_overview.md)