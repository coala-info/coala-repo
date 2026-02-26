---
name: squigulator
description: "squigulator simulates nanopore raw signal data from reference sequences or basecalled reads. Use when user asks to simulate nanopore reads, generate synthetic BLOW5 signal data, or create mock datasets for testing nanopore bioinformatics tools."
homepage: https://github.com/hasindu2008/squigulator
---


# squigulator

## Overview

squigulator is a high-performance tool designed to simulate nanopore raw signal data using traditional pore models and Gaussian noise. It transforms reference sequences (FASTA) or basecalled reads (FASTQ) into synthetic signal data, primarily in the BLOW5 format. While the simulation is simplified for speed, it allows for rapid generation of large datasets—such as 30X human genome coverage in approximately one hour—making it an essential utility for developers and bioinformaticians working on the Nanopore ecosystem.

## Common CLI Patterns

### Genomic DNA Simulation
By default, squigulator simulates DNA PromethION reads (R9.4.1). Use the `-x` flag to specify different flowcell and chemistry profiles.

*   **Standard Simulation**: Generate a specific number of reads from a reference genome.
    ```bash
    squigulator reference.fa -x dna-r9-prom -n 150000 -o reads.blow5
    ```
*   **Coverage-based Simulation**: Generate reads to reach a specific fold coverage (e.g., 30X).
    ```bash
    squigulator reference.fa -x dna-r10-prom -f 30 -o reads.blow5
    ```
*   **Ultra-long Reads**: Adjust the mean read length using a gamma distribution.
    ```bash
    squigulator reference.fa -r 50000 -n 10000 -o long_reads.blow5
    ```

### Direct RNA Simulation
When simulating RNA, the input must be a transcriptome FASTA. squigulator simulates the entire transcript length.

*   **Standard RNA**:
    ```bash
    squigulator transcriptome.fa -x rna-r9-prom -n 5000 -o rna_reads.blow5
    ```
*   **Complete RNA Model**: Use `--prefix` to include the adapter and polyA tail in the simulated signal.
    ```bash
    squigulator transcriptome.fa -x rna004-prom --prefix -n 4000 -o rna_with_tails.blow5
    ```

### Signal Manipulation
*   **Ideal Signals**: Generate perfect signals without Gaussian noise for baseline testing.
    ```bash
    squigulator reference.fa --ideal -n 1000 -o perfect.blow5
    ```
*   **Signal from Basecalls**: Re-simulate signals for existing basecalled reads (FASTQ input).
    ```bash
    squigulator basecalled.fq -x dna-r9-prom --full-contigs -o resimulated.blow5
    ```

## Expert Tips

*   **Simulating Variants**: squigulator does not introduce mutations natively. To simulate reads with variants, first apply a VCF to your reference using `bcftools consensus`, then use the resulting FASTA as input.
*   **Downstream Basecalling**: The output BLOW5 files can be basecalled directly using `buttery-eel` or the ONT `dorado` basecaller. If FAST5 files are required, use `slow5tools` to convert the BLOW5 output.
*   **Truth Mapping**: Generated read IDs encode the true mapping positions (e.g., `S1_33!chr1!225258409!225267761!-`). These are 0-based BED-like coordinates compatible with `paftools.js mapeval`.
*   **Performance Tuning**: Use the `-t` option to specify the number of CPU threads. The tool is highly efficient, typically requiring only ~3 GB of RAM for human genome simulations.

## Reference documentation
- [squigulator GitHub Repository](./references/github_com_hasindu2008_squigulator.md)
- [squigulator Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_squigulator_overview.md)