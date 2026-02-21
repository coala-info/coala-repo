---
name: gtfsort
description: `gtfsort` is a high-performance tool written in Rust designed specifically for the lexicographical and coordinate-based sorting of GTF and GFF3 files.
homepage: https://github.com/alejandrogzi/gtfsort
---

# gtfsort

## Overview
`gtfsort` is a high-performance tool written in Rust designed specifically for the lexicographical and coordinate-based sorting of GTF and GFF3 files. Unlike general-purpose sorters, it understands the hierarchical nature of genomic features, ensuring that parent features (like genes) precede their children (transcripts, exons, CDS) in the output. This is critical for tools that process annotations sequentially and for researchers performing manual inspection of gene structures.

## Installation
The tool can be installed via Conda or Cargo:
```bash
# Via Conda
conda install -c bioconda gtfsort

# Via Cargo (Rust)
cargo install gtfsort
```

## Basic Usage
The primary interface is a simple command-line execution requiring an input and output path.

```bash
gtfsort -i input.gtf -o sorted.gtf
```

### Arguments
- `-i, --input <GTF>`: Path to the unsorted GTF/GFF file.
- `-o, --output <OUTPUT>`: Path where the sorted file will be saved.
- `-t, --threads <THREADS>`: Number of threads to use. Defaults to the maximum available CPUs.

## Expert Tips and Best Practices
- **Performance**: `gtfsort` is highly optimized. It can sort a ~2GB GTF file in approximately 3 seconds using less than 1GB of RAM. Use the `-t` flag to limit CPU usage on shared HPC nodes.
- **Feature Hierarchy**: The tool automatically handles the internal ordering of features (gene -> transcript -> exon -> CDS -> start/stop codon -> UTR). This ensures that the output is compatible with tools that expect a specific parent-child order.
- **Format Compatibility**: While named `gtfsort`, the tool supports both GTF (versions 2.5 and 3) and GFF3 formats.
- **Lexicographical Sorting**: Chromosomes are sorted lexicographically. If your downstream tool requires a specific non-lexicographical chromosome order (e.g., 1, 2, ... 10, 11 instead of 1, 10, 11, 2), verify the requirements of that tool before processing.
- **Docker Usage**: For environments without Rust or Conda, use the official container:
  ```bash
  docker run --rm -v "$(pwd):/data" gtfsort -i /data/input.gtf -o /data/sorted.gtf
  ```

## Reference documentation
- [gtfsort GitHub Repository](./references/github_com_alejandrogzi_gtfsort.md)
- [gtfsort Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_gtfsort_overview.md)