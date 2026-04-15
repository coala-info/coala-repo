---
name: hicup
description: hicup maps Hi-C sequencing reads to a reference genome and performs quality control. Use when user asks to map Hi-C reads to a reference genome, perform quality control on Hi-C data, or prepare Hi-C data for downstream analysis.
homepage: http://www.bioinformatics.babraham.ac.uk/projects/hicup/
metadata:
  docker_image: "quay.io/biocontainers/hicup:0.9.2--hdfd78af_1"
---

# hicup

yaml
name: hicup
description: |
  A tool for mapping and performing quality control on Hi-C data.
  Use when Claude needs to process Hi-C sequencing data, specifically for:
  - Mapping Hi-C reads to a reference genome.
  - Performing quality control checks on the mapped data.
  - Preparing Hi-C data for downstream analysis.
```

## Overview

The `hicup` tool is designed for the initial processing of Hi-C sequencing data. It takes raw sequencing reads and maps them to a reference genome, performing essential quality control steps along the way. This is a crucial first step before any downstream analysis of Hi-C data, such as identifying chromosomal interactions or generating contact matrices.

## Usage Instructions

`hicup` is a command-line tool. The general workflow involves specifying input files, a reference genome, and output directories.

### Basic Command Structure

```bash
hicup -r <reference_genome.fa> -1 <read1.fastq.gz> -2 <read2.fastq.gz> -o <output_directory>
```

### Key Options and Best Practices

*   **`-r` / `--reference`**: Path to the reference genome FASTA file. Ensure this is the correct and complete genome assembly for your organism.
*   **`-1` / `--reads1`**: Path to the first FASTQ file (R1).
*   **`-2` / `--reads2`**: Path to the second FASTQ file (R2).
*   **`-o` / `--outdir`**: Directory where all output files will be saved. It's good practice to create a dedicated output directory for each analysis run.
*   **`-p` / `--prefix`**: A prefix for all output files. This helps in organizing multiple runs.
*   **`-s` / `--save_intermediate`**: By default, `hicup` removes intermediate files to save space. Use this option if you need to keep them for debugging or further manual inspection.
*   **`-k` / `--keep_logs`**: Keep log files generated during the process. Useful for detailed troubleshooting.
*   **`-q` / `--min_map_quality`**: Minimum mapping quality score to consider a read as uniquely mapped. The default is usually sufficient, but adjust if you encounter issues with low-quality mappings.
*   **`-d` / `--digestion_enzyme`**: Specify the restriction enzyme used for Hi-C library preparation (e.g., `MboI`, `DpnII`). This is important for accurate downstream analysis and can influence mapping strategies. If not specified, `hicup` may attempt to infer it or use a default.
*   **`-l` / `--min_insert_size`**: Minimum expected insert size for valid Hi-C fragments.
*   **`-u` / `--max_insert_size`**: Maximum expected insert size for valid Hi-C fragments.

### Common Workflow Patterns

1.  **Standard Mapping and QC**:
    ```bash
    hicup -r genome.fa -1 reads_R1.fq.gz -2 reads_R2.fq.gz -o hicup_output -p sample1
    ```
    This command will map the paired-end reads to `genome.fa`, save results in `hicup_output` with the prefix `sample1`, and perform standard QC.

2.  **Keeping Intermediate Files for Debugging**:
    ```bash
    hicup -r genome.fa -1 reads_R1.fq.gz -2 reads_R2.fq.gz -o hicup_output -p sample1 --save_intermediate --keep_logs
    ```
    This is useful if you suspect issues with the mapping or QC and want to examine the intermediate BAM files or detailed logs.

3.  **Specifying Digestion Enzyme**:
    ```bash
    hicup -r genome.fa -1 reads_R1.fq.gz -2 reads_R2.fq.gz -o hicup_output -p sample1 -d MboI
    ```
    If your library was prepared using `MboI`, specifying it can improve the accuracy of the analysis.

### Expert Tips

*   **Reference Genome Preparation**: Ensure your reference genome FASTA file is indexed (e.g., using `bwa index` or `samtools faidx`) if `hicup` relies on such indexing for its mapping steps. While `hicup` might handle this internally, having an indexed genome is a good prerequisite.
*   **FASTQ Quality**: Always check the quality of your input FASTQ files using tools like FastQC before running `hicup`. Poor quality reads can significantly impact mapping efficiency and downstream results.
*   **Output Interpretation**: The output directory will contain several files, including mapped reads (BAM/SAM), QC reports, and potentially interaction files. Familiarize yourself with the naming conventions and content of these files.
*   **Resource Management**: Hi-C data processing can be computationally intensive. Ensure you have sufficient RAM and CPU resources available, especially for large datasets.

## Reference documentation

*   [HiCUP Overview](./references/anaconda_org_channels_bioconda_packages_hicup_overview.md)