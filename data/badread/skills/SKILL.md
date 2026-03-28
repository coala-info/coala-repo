---
name: badread
description: Badread simulates realistic, imperfect long reads from a reference genome by imitating sequencing errors, artifacts, and quality fluctuations. Use when user asks to generate synthetic Oxford Nanopore or PacBio reads, simulate sequencing artifacts like chimeras and glitches, or stress-test assembly workflows with low-quality data.
homepage: https://github.com/rrwick/Badread
---

# badread

## Overview

Badread is a specialized tool for generating "imperfect" long reads. Unlike simulators that aim for perfect accuracy, Badread is designed to imitate the messy reality of third-generation sequencing. It allows for fine-grained control over read length distributions, identity percentages, and specific artifacts like "glitches" (sudden drops in quality) or junk reads. This makes it an essential tool for stress-testing the robustness of de novo assembly workflows and alignment tools.

## Basic Usage Patterns

The primary command is `badread simulate`. Output is sent to `stdout` in FASTQ format, which is typically piped to `gzip`.

### Standard Simulation (Oxford Nanopore R10.4.1)
```bash
badread simulate --reference ref.fasta --quantity 50x | gzip > reads.fastq.gz
```

### Simulating Specific Technologies
*   **Oxford Nanopore (Older R9.4.1):**
    ```bash
    badread simulate --reference ref.fasta --quantity 30x \
        --error_model nanopore2020 --qscore_model nanopore2020 --identity 90,98,5
    ```
*   **PacBio HiFi:**
    ```bash
    badread simulate --reference ref.fasta --quantity 50x \
        --error_model pacbio2021 --qscore_model pacbio2021 --identity 99.9,0.1
    ```

## Advanced Parameter Tuning

### Read Identity and Length
*   **Identity (`--identity`):** Takes `mean,max,stdev`. For example, `85,95,5` targets 85% identity but caps it at 95%.
*   **Length (`--length`):** Takes `mean,stdev`. Use `15000,10000` for a standard long-read distribution.

### Introducing Artifacts
To test how a tool handles "bad" data, increase these parameters:
*   **Chimeras (`--chimeras`):** Percentage of reads that are chimeric (joined fragments). Default is 1.0.
*   **Junk/Random (`--junk_reads`, `--random_reads`):** Percentage of reads that are either low-complexity junk or completely random sequences.
*   **Glitches (`--glitches`):** Takes `interval,size,stdev`. Simulates the "stalling" of a pore.

### Custom Adapters
You can simulate specific library prep kits by providing adapter sequences:
```bash
badread simulate --reference ref.fasta --quantity 20x \
    --start_adapter_seq AATGTACTTCGTTCAGTTACGTATTGCT \
    --end_adapter_seq GCAATACGTAACTGAACGAAGT
```

## Expert Tips

1.  **Parallelization:** Badread is single-threaded and can be slow because it performs periodic alignments to ensure identity accuracy. To speed up large simulations, split your `--quantity` into smaller chunks and run multiple instances in parallel, then concatenate the resulting FASTQ files.
2.  **Circular Genomes:** Badread handles circular references automatically. If your FASTA headers contain the word "circular", it will simulate reads that wrap around the start/end of the sequence.
3.  **Small Plasmid Bias:** Use the `--small_plasmid_bias` flag if your reference contains small plasmids and you want to simulate the over-representation often seen in real nanopore preps.
4.  **Deterministic Results:** Use the `--seed` argument to ensure that your simulated dataset is reproducible across different runs.



## Subcommands

| Command | Description |
|---------|-------------|
| badread error_model | Build a Badread error model |
| badread_plot | View read identities over a sliding window |
| badread_qscore_model | Build a Badread qscore model |
| badread_simulate | Generate fake long reads |

## Reference documentation
- [Badread GitHub README](./references/github_com_rrwick_Badread.md)
- [Adapter Sequences Wiki](./references/github_com_rrwick_Badread_wiki_Adapter-sequences.md)
- [Error Models Documentation](./references/github_com_rrwick_Badread_wiki_Error-models.md)
- [Glitches and Artifacts](./references/github_com_rrwick_Badread_wiki_Glitches.md)