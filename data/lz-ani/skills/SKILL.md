---
name: lz-ani
description: lz-ani calculates genomic similarity and Average Nucleotide Identity (ANI) using high-performance Lempel-Ziv parsing. Use when user asks to perform pairwise genomic comparisons, calculate ANI between viral or bacterial sequences, or filter similarity results based on coverage and identity thresholds.
homepage: https://github.com/refresh-bio/lz-ani
---


# lz-ani

## Overview
`lz-ani` is a high-performance tool designed for determining genomic similarity through Lempel-Ziv parsing. Unlike traditional tools that rely on computationally expensive local alignments, `lz-ani` uses a simplified indel handling model to achieve massive speedups while maintaining accuracy comparable to sensitive BLASTn searches. It is specifically optimized for viral genomes but can be tuned for larger bacterial or archaeal sequences.

## Core Workflows

### Basic Pairwise Comparison
To compare all sequences within a single multi-FASTA file:
```bash
lz-ani all2all --in-fasta sequences.fna --out results.tsv
```

To compare all FASTA files within a specific directory:
```bash
lz-ani all2all --in-dir ./genome_dir/ --out results.tsv
```

### Output Customization
By default, `lz-ani` produces two files: `[out].tsv` (results) and `[out].ids.tsv` (sequence metadata).

*   **Percentage Scale**: Use `--out-in-percent true` to output ANI values as 0-100 instead of 0-1.
*   **Format Presets**:
    *   `standard`: (Default) Includes IDs, ANI, gANI, tANI, coverage, and length ratio.
    *   `lite`: Minimal output for large datasets (indices and primary metrics).
    *   `complete`: Includes raw match/mismatch counts and alignment numbers.
*   **Custom Columns**: Specify exactly what you need:
    ```bash
    lz-ani all2all --in-fasta input.fna --out-format id1,id2,ani,cov --out results.tsv
    ```

### Filtering Results
To reduce output size and focus on significant hits, use `--out-filter`. This can be used multiple times for different metrics:
```bash
# Only keep pairs with at least 95% ANI and 50% coverage
lz-ani all2all --in-fasta input.fna --out-filter ani 0.95 --out-filter cov 0.5 -o filtered.tsv
```

## Expert Tips

*   **Performance**: The tool auto-detects threads, but you can manually set them with `-t <int>`.
*   **Memory Efficiency**: `lz-ani` is significantly more memory-efficient than BLAST. If working with very large datasets, ensure your input is gzipped, as `lz-ani` supports native `.gz` processing.
*   **Similarity Measures**:
    *   **ANI**: Identity across local alignments.
    *   **gANI (Global)**: Identity relative to the total length of the query/reference.
    *   **tANI (Total)**: Symmetric identity measure considering both directions.
*   **Large Genomes**: While optimized for viruses, for bacteria/archaea, you may need to increase the minimum anchor length (`-a`) or region length (`-g`) to reduce noise in highly repetitive regions.

## Reference documentation
- [LZ-ANI GitHub Repository](./references/github_com_refresh-bio_LZ-ANI.md)
- [Bioconda lz-ani Overview](./references/anaconda_org_channels_bioconda_packages_lz-ani_overview.md)