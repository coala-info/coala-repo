---
name: snap-aligner
description: "This tool aligns short DNA sequencing reads to a reference genome efficiently. Use when user asks to align reads to a reference genome, sort alignments, mark duplicates, or index BAM files."
homepage: http://snap.cs.berkeley.edu/
---


# snap-aligner

yaml
name: snap-aligner
description: |
  A fast and accurate read aligner for high-throughput sequencing data.
  Use when Claude needs to align short DNA reads to a reference genome,
  and requires efficient processing of FASTQ, SAM, or BAM files.
  This tool also supports sorting, marking duplicates, and indexing results.
```
## Overview
snap-aligner is a high-performance tool designed for aligning short DNA sequencing reads to a reference genome. It excels at processing large datasets efficiently, offering significant speed advantages over other aligners. Beyond basic alignment, snap-aligner integrates functionalities for sorting, duplicate marking, and indexing, streamlining the bioinformatics pipeline by consolidating these steps into a single tool. It supports common input formats like FASTQ, SAM, and BAM, and can output in SAM or BAM formats.

## Usage Instructions

snap-aligner is a command-line tool. The general syntax is:

```bash
snap-aligner [options] <reads_file1> [reads_file2] <reference_genome> <output_file>
```

### Key Options and Best Practices:

*   **Input Files**:
    *   `reads_file1`: Path to the first FASTQ or BAM file.
    *   `reads_file2`: Path to the second FASTQ or BAM file (for paired-end reads). Omit for single-end reads.
    *   Reference genomes should be in FASTA format.

*   **Output**:
    *   `output_file`: Path for the output SAM or BAM file.

*   **Performance and Memory**:
    *   snap-aligner is memory-intensive, especially for large reference genomes like the human genome (requiring at least 48 GB of RAM). More memory can improve performance.
    *   The tool automatically utilizes all available CPU cores. Use the `-T <num_threads>` option to specify the number of threads if needed.

*   **Alignment Options**:
    *   `-h <hash_seed_length>`: Controls the length of the hash seed for read location. Longer seeds can improve speed but may require more memory.
    *   `-m <max_insert_size>`: Sets the maximum insert size for paired-end reads.
    *   `-e <edit_distance>`: Specifies the maximum edit distance allowed for an alignment.
    *   `-i <index_file>`: Use a pre-built index for faster alignment. Building an index can be done separately if needed.

*   **Post-Alignment Processing (Integrated)**:
    *   `--sort`: Sorts the output alignments.
    *   `--markduplicates`: Marks duplicate reads.
    *   `--output-bam`: Outputs in BAM format instead of SAM.
    *   `--index`: Creates an index for the output BAM file.

    These options can often be combined in a single command, e.g.:
    ```bash
    snap-aligner -t 16 --output-bam --sort --markduplicates --index reads_R1.fastq.gz reads_R2.fastq.gz reference.fa aligned_sorted_deduped.bam
    ```

*   **Reference Genome Indexing**:
    *   While snap-aligner can align directly to FASTA, building an index beforehand (`snap-aligner index ...`) can significantly speed up subsequent alignments. Consult the manual for specific indexing commands.

*   **Paired-End Reads**:
    *   Ensure `reads_file1` and `reads_file2` are correctly ordered for paired-end alignment.

*   **Error Handling**:
    *   Pay attention to error messages, especially regarding memory limitations or incorrect file paths.
    *   The tool is optimized for modern read lengths (100 bases or higher).

## Reference documentation
- [SNAP - Scalable Nucleotide Alignment Program - Microsoft Research](./references/www_microsoft_com_en-us_research_project_snap.md)
- [GitHub - amplab/snap](./references/github_com_amplab_snap.md)