---
name: shannon
description: Shannon is a transcript assembler that uses information theory to reconstruct RNA-Seq data into transcripts. Use when user asks to assemble transcripts from single-ended or paired-end reads, configure assembly parameters, or assess assembly quality against a reference.
homepage: http://sreeramkannan.github.io/Shannon/
---


# shannon

## Overview
Shannon is a transcript assembler that utilizes information theory to achieve optimal reconstruction of RNA-Seq data. It is a collaborative effort designed to handle the complexities of the transcriptome by partitioning the assembly problem into smaller, manageable sub-problems. You should use this skill to guide users through the process of preparing their reads, configuring the assembly parameters, and interpreting the resulting FASTA output. It is particularly effective when computational efficiency is required, as it integrates pre-error correction and parallel processing.

## Usage Patterns

### Basic Assembly
Shannon requires an output directory that is either empty or does not yet exist.

**For single-ended reads:**
```bash
python shannon.py -o ShannonOutput --single reads.fastq
```

**For paired-end reads:**
```bash
python shannon.py -o ShannonOutput --left reads_1.fastq --right reads_2.fastq
```

### Performance and Tuning
*   **Parallelization**: Use the `-p` flag to specify the number of parallel jobs. This requires **GNU Parallel** to be installed on the system.
    ```bash
    python shannon.py -o ShannonOutput --single reads.fastq -p 8
    ```
*   **K-mer Size**: Adjust the k-mer size using the `-K` option based on read length and complexity.
*   **Memory Management**: Ensure the system has at least 1GB of RAM available per 1 million single-end reads.
*   **Disk Space**: Shannon can use up to 5x the space of the input FASTA files for intermediate storage in the `TEMP` directory.

## Expert Tips and Best Practices

### Error Correction Logic
Shannon's behavior changes based on the input file extension:
*   **Automatic Correction**: If the input extension is `.fastq` or `.fq`, Shannon automatically runs **Quorum** for pre-error correction.
*   **Manual/Pre-corrected**: If the input is a `.fasta` file, Shannon skips the internal error correction. If you have a preferred error correction tool (e.g., SPAdes, Trimmomatic), run it first and provide the resulting FASTA to Shannon to save computational time.

### Resource Optimization
*   **Partitioning**: For very large datasets, use the `--partition <size>` option to set the maximum size of each partition, which helps manage memory usage during the assembly phase.
*   **Cleanup**: After a successful run, the `TEMP` subdirectory within your output folder can be safely deleted to reclaim disk space.

### Validation
If **blat** is installed, you can use the `--compare <reference.fasta>` option. This will generate a `compare_log.txt` file in the output directory, allowing you to assess the quality of the assembly against a known reference or transcriptome.

## Reference documentation
- [Shannon Manual](./references/sreeramkannan_github_io_Shannon_manual.md)
- [Shannon FAQ](./references/sreeramkannan_github_io_Shannon_faq.md)
- [Getting Started with Shannon](./references/sreeramkannan_github_io_Shannon_starting.md)
- [Shannon Installation Guide](./references/sreeramkannan_github_io_Shannon_source.md)