---
name: gafpack
description: gafpack is a high-performance utility designed to quantify how alignments (in GAF format) map onto the nodes of a pangenome variation graph (in GFA format).
homepage: https://github.com/pangenome/gafpack
---

# gafpack

## Overview
gafpack is a high-performance utility designed to quantify how alignments (in GAF format) map onto the nodes of a pangenome variation graph (in GFA format). It translates complex graph-based alignments into readable coverage metrics, which are essential for understanding the depth of evidence for specific genomic variations or haplotypes within a pangenomic reference.

## Installation
The tool is available via Bioconda or can be built from source using Rust's package manager:

```bash
# Via Conda
conda install bioconda::gafpack

# Via Cargo
cargo install --git https://github.com/pangenome/gafpack
```

## Common CLI Patterns

### Basic Coverage Calculation
To generate a tabular coverage map where each node in the graph receives a coverage value based on the provided alignments:
```bash
gafpack --gfa graph.gfa --gaf alignments.gaf > coverage.tsv
```

### Scaling by Node Length
By default, gafpack counts occurrences. Use the length-scaling flag to normalize coverage relative to the length of the graph segments:
```bash
gafpack --gfa graph.gfa --gaf alignments.gaf --len-scale > normalized_coverage.tsv
```

### Handling Large Graphs (Columnar Output)
For graphs with a very high number of nodes, the default horizontal tabular format (one column per node) can become unwieldy. Use the coverage column flag to output a vertical vector:
```bash
gafpack --gfa graph.gfa --gaf alignments.gaf --coverage-column > vector_coverage.tsv
```

### Weighted Coverage
If your workflow requires weighting coverage by query occurrences (useful for multi-mapping or specific evidence weighting), use the weight flag:
```bash
gafpack --gfa graph.gfa --gaf alignments.gaf --weight-queries > weighted_coverage.tsv
```

## Expert Tips and Best Practices
- **Compressed Inputs**: gafpack natively supports compressed GFA files (`.gz` or `.bgz`). You do not need to decompress your pangenome graphs before processing, saving disk space and I/O time.
- **Memory Efficiency**: The tool is written in Rust and designed for efficiency, but ensure your GFA file contains the necessary segment (S) lines, as these are used to define the nodes being tracked for coverage.
- **Haplotype Analysis**: When performing haplotype-based genotyping, use the default output format to easily compare coverage across different samples by concatenating multiple gafpack runs or processing multiple GAF files.
- **Downstream Integration**: The default output is a tab-separated values (TSV) file. If you are using R or Python for downstream analysis, the `--coverage-column` format is often easier to load into data frames (e.g., `pandas.read_csv` or `readr::read_tsv`) when dealing with millions of nodes.

## Reference documentation
- [gafpack GitHub Repository](./references/github_com_pangenome_gafpack.md)
- [gafpack Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_gafpack_overview.md)