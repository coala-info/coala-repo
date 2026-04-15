---
name: fastreer
description: fastreeR is a hybrid toolkit for rapid phylogenetic reconstruction and distance matrix calculation from VCF or FASTA files. Use when user asks to calculate distance matrices, generate neighbor-joining trees, or perform streaming bootstrap analysis.
homepage: https://github.com/gkanogiannis/fastreeR
metadata:
  docker_image: "quay.io/biocontainers/fastreer:2.1.3--pyhdfd78af_0"
---

# fastreer

## Overview

fastreeR is a hybrid toolkit that combines a high-performance Java backend with a Python CLI to provide rapid phylogenetic reconstruction. It is optimized for low memory consumption, making it suitable for processing large VCF files that would typically overwhelm standard tools. The tool supports calculating sample-wise cosine distances from VCFs, D2S k-mer based distances from FASTA files, and generating agglomerative neighbor-joining (NJ) trees. It also includes advanced features like streaming bootstrap support and embedding-based distance calculations using genomic language models.

## Installation and Environment

fastreeR requires Java 17+ and Python 3.7+. It is most easily managed via Conda:

```bash
conda install -c bioconda fastreer
```

## Common CLI Patterns

### 1. Distance Matrix Calculation
To compute a distance matrix from a VCF file (supports .vcf, .gz, .bz2, .xz):
```bash
fastreeR VCF2DIST -i input.vcf.gz -o output.dist
```

To compute a k-mer based distance matrix from a FASTA file:
```bash
fastreeR FASTA2DIST -i input.fasta -o output.dist -k 10
```

### 2. Tree Construction
To generate a Newick NJ tree directly from a VCF file:
```bash
fastreeR VCF2TREE -i input.vcf -o output.nwk
```

To generate a tree from an existing distance matrix:
```bash
fastreeR DIST2TREE -i input.dist -o output.nwk
```

### 3. Advanced Workflows
**Streaming Bootstrap**: Generate a tree with encoded bootstrap support values directly from a VCF:
```bash
fastreeR VCF2TREE -i input.vcf -o output.nwk --bootstrap 100
```

**Embedding-Based Distance**: Use pre-computed variant embeddings (e.g., from BioFM or DNA-BERT) to weight distances:
```bash
fastreeR VCF2DIST -i input.vcf -e embeddings.bin -o output.dist
```

## Expert Tips and Best Practices

### Memory Management
While fastreeR is memory-efficient, the JVM may need explicit heap allocation for very large datasets (e.g., 1M+ variants). Use the `--mem` flag to specify RAM in MB:
*   **Rule of Thumb**: Allocate 15-20 bytes per variant per sample for optimal performance.
*   **Example**: For a dataset requiring 4GB of RAM:
    ```bash
    fastreeR VCF2TREE -i input.vcf -o output.nwk --mem 4096
    ```

### Performance Optimization
*   **Multithreading**: fastreeR uses a multithreaded concurrency model. Ensure your environment has multiple cores available to take advantage of the speed.
*   **Piping**: You can pipe compressed input directly into the tool:
    ```bash
    gunzip -c data.vcf.gz | fastreeR VCF2DIST -i - -o output.dist
    ```

### Input Handling
*   The tool handles diploid genotypes (e.g., `0/1`, `1|0`) natively.
*   For FASTA files, the `-k` (k-mer size) parameter significantly impacts the sensitivity of the D2S distance calculation.

## Reference documentation
- [fastreeR GitHub Repository](./references/github_com_gkanogiannis_fastreeR.md)
- [fastreeR Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_fastreer_overview.md)