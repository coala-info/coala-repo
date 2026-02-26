---
name: minia
description: "Minia is a de Bruijn graph-based short-read assembler. Use when user asks to assemble genomes or metagenomes from short sequencing reads."
homepage: https://github.com/GATB/minia
---


# minia

yaml
name: minia
description: |
  Minia is a de Bruijn graph-based short-read assembler.
  Use this skill when you need to assemble genomes or metagenomes from short sequencing reads.
  It is particularly useful for assembling large genomes (like human genomes) on desktop computers within a reasonable timeframe.
  This skill is suitable for tasks involving de novo genome assembly from FASTQ files.
```
## Overview
Minia is a powerful tool for assembling genomes and metagenomes using short sequencing reads. It leverages a de Bruijn graph approach to construct contigs, making it efficient enough to assemble large genomes on standard desktop hardware. Use Minia when your primary goal is de novo genome assembly from FASTQ formatted sequencing data.

## Usage Instructions

Minia is a command-line tool. The basic usage involves specifying input files, output directory, and key assembly parameters.

### Core Command Structure

```bash
minia -in <input_fastq_files> -out <output_directory> [options]
```

### Key Parameters

*   **`-in <input_fastq_files>`**: Specifies the input FASTQ file(s). Multiple files can be provided, separated by commas.
    *   Example: `-in reads1.fastq,reads2.fastq`
*   **`-out <output_directory>`**: The directory where Minia will write its output files, including contigs.
    *   Example: `-out assembly_results`
*   **`-k <kmer_size>`**: The size of the k-mers to use for the de Bruijn graph. This is a critical parameter that influences assembly contiguity and accuracy. The optimal k-mer size often depends on the sequencing technology and genome characteristics.
    *   Default: Varies by Minia version, but often around 31 or 51.
    *   Example: `-k 51`
*   **`-h <memory_limit>`**: Maximum memory to use (in MB).
    *   Example: `-h 8000` (for 8GB)
*   **`-t <threads>`**: Number of threads to use.
    *   Example: `-t 4`
*   **`-v`**: Verbose output.

### Common Assembly Scenarios and Tips

1.  **Basic Assembly**:
    For a straightforward assembly with default settings, you might run:
    ```bash
    minia -in my_reads.fastq -out my_assembly -k 51 -t 8
    ```

2.  **Handling Paired-End Reads**:
    Provide both forward and reverse reads using the `-in` flag. Ensure they are correctly paired.
    ```bash
    minia -in reads_R1.fastq,reads_R2.fastq -out paired_assembly -k 51 -t 8
    ```

3.  **Adjusting K-mer Size**:
    Experiment with different k-mer sizes to find the best assembly for your data. Smaller k-mers might be better for highly repetitive genomes, while larger k-mers can improve contiguity for less repetitive regions.
    ```bash
    minia -in my_reads.fastq -out kmer_test_assembly -k 31 -t 8
    minia -in my_reads.fastq -out kmer_test_assembly -k 71 -t 8
    ```

4.  **Memory Management**:
    If you encounter memory errors, reduce the k-mer size or the number of threads, or increase the `-h` parameter if you have more RAM available.
    ```bash
    minia -in my_reads.fastq -out low_memory_assembly -k 31 -h 4000 -t 4
    ```

5.  **Output Files**:
    The primary output file of interest is typically `contigs.fa` (or similar) within the specified output directory, which contains the assembled contigs. Other files may include statistics and intermediate graph data.

### Expert Tips

*   **Read Quality**: Ensure your input FASTQ files are of good quality. Trimming low-quality bases or adapters before assembly can significantly improve results.
*   **K-mer Selection**: The choice of k-mer size is crucial. There isn't a universal best k-mer; it's data-dependent. Consider using tools or heuristics to estimate an appropriate k-mer size for your specific dataset.
*   **Computational Resources**: Genome assembly is computationally intensive. Allocate sufficient CPU threads (`-t`) and memory (`-h`) for faster and more complete assemblies.
*   **Multiple K-mers (Advanced)**: While Minia primarily uses a single k-mer size, some advanced pipelines or related tools might explore multi-k strategies. For direct Minia usage, focus on optimizing a single k-mer.
*   **Error Handling**: Check the output directory for any error messages or warnings. The `README.md` in the output directory might contain useful information.

## Reference documentation
- [Minia User Manual](./references/github_com_GATB_minia.md)