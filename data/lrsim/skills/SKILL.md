---
name: lrsim
description: lrsim simulates 10X Genomics Linked Read sequencing data from a reference genome or specific haplotypes. Use when user asks to simulate whole genome sequencing data, model 10X Genomics barcoding protocols, or generate synthetic linked reads for benchmarking genomic algorithms.
homepage: https://github.com/aquaskyline/LRSIM
metadata:
  docker_image: "quay.io/biocontainers/lrsim:1.0--pl5321hbcd995c_0"
---

# lrsim

## Overview
The `lrsim` skill enables the simulation of whole genome sequencing data using 10X Genomics Linked Read technology. It models the 10X protocol by capturing key steps including fragment partitioning and barcoding. This tool is essential for benchmarking algorithms like LongRanger, SuperNova, and HapCUT2. It allows users to define complex genomic variations (SNPs, Indels, Duplications, Inversions, and Translocations) and control sequencing parameters such as molecule length, partition count, and read pair volume.

## CLI Usage and Best Practices

The primary entry point is the Perl script `simulateLinkedReads.pl`.

### Basic Command Structure
```bash
./simulateLinkedReads.pl -r <reference.fasta> -p <output_prefix> [options]
```

### Common Parameter Patterns
*   **Simulating from Haplotypes**: To use specific variants, provide two haploid FASTA files (e.g., generated via `vcf2diploid`):
    ```bash
    ./simulateLinkedReads.pl -g hap1.fa,hap2.fa -p simulated_wgs
    ```
*   **Adjusting Coverage**: Use `-x` to set the total number of read pairs (in millions). For example, for ~30x coverage on a human genome:
    ```bash
    ./simulateLinkedReads.pl -r hg38.fa -p hg38_sim -x 600
    ```
*   **Custom Fragment Sizes**: Instead of a mean length (`-f`), provide a distribution file:
    ```bash
    ./simulateLinkedReads.pl -r ref.fa -p out -c test/fragmentSizesList
    ```

### Expert Tips and Constraints
*   **Barcode Limit**: Do not set the average number of molecules per partition (`-m`) higher than 4700, as this exceeds the available barcode pool and will cause the program to fail.
*   **Small Genomes**: The default barcoding parameters are optimized for human-sized genomes. For genomes smaller than 100Mbp, default parameters may not perform realistically.
*   **Resource Management**: 
    *   **Memory**: Simulating a human genome typically requires ~48GB of RAM.
    *   **Parallelization**: Use `-z` to set the number of threads for DWGSIM. Each thread requires approximately 4GB of memory for human genome simulations.
*   **Resuming Workflows**: If you need to tweak library parameters (like fragment size or molecule count) without re-simulating variants, use the `-u 4` option with the same output prefix to skip to the read simulation step:
    ```bash
    ./simulateLinkedReads.pl -r ref.fa -p existing_prefix -u 4 -f 50 -m 15
    ```
*   **Variant Ratios**: Note that the ratio of homozygous to heterozygous simulated variants is hardcoded at 1:2.
*   **Parameter Validation**: If using non-human genomes or unconventional parameters, use `-o` to disable the built-in valid range checks.

## Troubleshooting
*   **Missing Inline::C**: If you encounter a "Missing Inline::C library" error, you can manually point to the included libraries by uncommenting the `use lib` lines in the `simulateLinkedReads.pl` script or by ensuring the `lib` directory is in your `PERL5LIB` path.
*   **Reference Formatting**: Ensure your reference FASTA has standard line breaks; some components (like SURVIVOR) may stall if the FASTA file lacks proper newlines.

## Reference documentation
- [LRSIM GitHub Repository](./references/github_com_aquaskyline_LRSIM.md)
- [LRSIM Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_lrsim_overview.md)