---
name: recalladapters
description: "Identifies and extracts adapter sequences from PacBio sequencing data. Use when dealing with PacBio FASTQ or BAM files and needing to identify or remove adapter sequences for downstream analysis."
homepage: https://github.com/PacificBiosciences/pbbioconda
---


# recalladapters

Identifies and extracts adapter sequences from PacBio sequencing data.
  Use when dealing with PacBio FASTQ or BAM files and needing to identify or remove adapter sequences for downstream analysis.
---
## Overview
The `recalladapters` tool is designed to identify and extract adapter sequences from PacBio sequencing data, specifically FASTQ or BAM files. This is a crucial step in preparing data for various downstream analyses, such as variant calling or transcript assembly, by ensuring that artificial adapter sequences do not interfere with biological signal.

## Usage Instructions

The `recalladapters` tool is typically used via the command line. It requires input FASTQ or BAM files and outputs identified adapter sequences.

### Basic Usage

The most common use case involves providing an input file and specifying an output file for the identified adapters.

```bash
recalladapters --input <input_fastq_or_bam> --output <output_adapters.fasta>
```

### Key Options and Best Practices

*   **`--input`**: Specify the input FASTQ or BAM file. This is a mandatory argument.
    *   **Best Practice**: Ensure your input files are properly formatted and accessible. For BAM files, ensure they are indexed if random access is required by the tool (though `recalladapters` primarily processes reads sequentially).
*   **`--output`**: Specify the output file path where the identified adapter sequences will be saved. The output is typically in FASTA format.
    *   **Expert Tip**: It's good practice to name your output file descriptively, e.g., `sample1_adapters.fasta`.
*   **`--min-adapter-len`**: Minimum length of an adapter to be considered. Defaults to 10.
    *   **When to adjust**: If you suspect very short adapter fragments are present or if you want to filter out very short, potentially spurious adapter calls.
*   **`--max-adapter-len`**: Maximum length of an adapter to be considered. Defaults to 50.
    *   **When to adjust**: If you know your adapters are longer than the default, or if you want to limit the search space for very long, potentially non-specific sequences.
*   **`--min-score`**: Minimum score for an adapter to be reported. Defaults to 0.
    *   **Expert Tip**: Increasing this value can help to filter out less confident adapter calls, especially in noisy data. Experiment with values like 5 or 10 if you encounter too many false positives.
*   **`--min-coverage`**: Minimum coverage of an adapter sequence across reads. Defaults to 1.
    *   **When to adjust**: If you are seeing adapter calls that are present in only a few reads and suspect they are noise, increasing this value can help.
*   **`--threads`**: Number of threads to use for processing.
    *   **Best Practice**: Utilize multiple threads if your system has them available to speed up processing, especially for large input files.

### Example Workflow

1.  **Identify adapters from a FASTQ file:**
    ```bash
    recalladapters --input my_pacbio_reads.fastq --output my_pacbio_adapters.fasta --min-score 8 --threads 4
    ```
2.  **Process a BAM file and save adapters:**
    ```bash
    recalladapters --input aligned_reads.bam --output aligned_reads_adapters.fasta --max-adapter-len 40
    ```

### Common Pitfalls and Solutions

*   **Too many spurious adapter calls**:
    *   **Solution**: Increase `--min-score` and/or `--min-coverage`.
*   **Missing expected adapter sequences**:
    *   **Solution**: Ensure `--min-adapter-len` and `--max-adapter-len` encompass the expected adapter lengths. Check the input data quality.
*   **Slow processing**:
    *   **Solution**: Increase the `--threads` parameter if your system supports it.

## Reference documentation
- [Overview of recalladapters on bioconda](https://anaconda.org/bioconda/recalladapters)
- [GitHub repository for pbbioconda tools](https://github.com/PacificBiosciences/pbbioconda)