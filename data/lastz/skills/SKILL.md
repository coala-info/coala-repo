---
name: lastz
description: LASTZ is a powerful pairwise DNA sequence aligner designed as a drop-in, backward-compatible replacement for BLASTZ.
homepage: http://www.bx.psu.edu/~rsharris/lastz/
---

# lastz

## Overview
LASTZ is a powerful pairwise DNA sequence aligner designed as a drop-in, backward-compatible replacement for BLASTZ. It is optimized for large-scale genomic comparisons, capable of handling sequences the size of human chromosomes. The tool operates through a multi-stage pipeline: seeding, gap-free extension (HSPs), chaining, and gapped extension. It is highly configurable, allowing users to balance sensitivity and computational speed based on the evolutionary distance between the sequences being compared.

## Installation
The most efficient way to install LASTZ is via Bioconda:
```bash
conda install bioconda::lastz
```

## Common CLI Patterns

### Basic Alignment
The standard syntax requires a target sequence and a query sequence:
```bash
lastz target.fa query.fa --format=maf > output.maf
```

### High-Speed / Low-Sensitivity Alignment
For comparing very large sequences (e.g., whole chromosomes) where only strong hits are needed, use these flags to significantly reduce runtime and memory:
```bash
lastz target.fa query.fa --notransition --step=20 --nogapped --format=rdotplot
```
*   `--notransition`: Disables transitions in seed patterns, increasing speed.
*   `--step=20`: Samples the target every 20bp instead of every 1bp, reducing memory usage.
*   `--nogapped`: Skips the expensive gapped extension stage.

### Self-Alignment
To find internal repeats or duplications within a single sequence:
```bash
lastz sequence.fa sequence.fa --self --format=lav
```

### Short Read Mapping
When mapping NGS reads to a reference genome of a closely related species:
```bash
lastz reference.fa reads.fq --seed=12to15 --step=1 --format=sam
```

## Expert Tips and Best Practices

### Output Formats
LASTZ supports a wide variety of output formats via the `--format` option:
*   `maf`: Multiple Alignment Format (standard for genomic pipelines).
*   `sam`: Sequence Alignment Map (standard for NGS workflows).
*   `lav`: The default LASTZ/BLASTZ format.
*   `axt`: Used by UCSC Genome Browser pipelines.
*   `general`: Custom column output. You can specify fields like `--format=general:score,name1,strand1,start1,end1,name2,strand2,start2,end2`.

### Memory Management
*   **Target vs. Query**: LASTZ loads the entire target sequence into memory to build a seed position table. If you have limited RAM, use the smaller sequence as the target.
*   **Large Genomes**: For genomes larger than 2 gigabases, ensure you are using the `lastz_32` executable or that the tool was built with large file support.

### Sensitivity Tuning
*   **Seed Patterns**: You can define specific seed patterns (e.g., `111010011001`) to change how the initial matches are found.
*   **Transitions**: By default, LASTZ allows T-C and A-G transitions in seeds. Use `--notransition` for distant species to focus on more conserved regions.
*   **Interpolation**: Use the interpolation stage to "fill in the gaps" between high-scoring alignments by re-running the aligner at higher sensitivity in those specific regions.

### Handling Multiple Sequences
If your target or query files contain multiple sequences (e.g., a multi-FASTA file), LASTZ will process them iteratively. For massive datasets, consider using "Target Capsule Files" (.capsule) to speed up the loading of the target sequence table.

## Reference documentation
- [LASTZ README (v1.04.15)](./references/www_bx_psu_edu__rsharris_lastz_README.lastz-1.04.15.html.md)
- [LASTZ Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_lastz_overview.md)