---
name: libmems
description: libmems provides the foundational algorithms for comparative genomics, specifically focusing on the identification of conserved segments across multiple DNA sequences.
homepage: http://darlinglab.org/mauve/
---

# libmems

## Overview
libmems provides the foundational algorithms for comparative genomics, specifically focusing on the identification of conserved segments across multiple DNA sequences. It is the core library powering the Mauve alignment system. Use this skill to facilitate efficient string matching, calculate local alignments, and manage genomic coordinate systems during comparative analysis.

## Usage Guidelines

### Installation and Environment
The library is primarily distributed via Bioconda. Ensure the environment is configured to handle large genomic datasets, as memory usage scales with the number of unique MEMs identified.
```bash
conda install -c bioconda libmems
```

### Core Functionality
*   **MEM Identification**: Use libmems to find Maximal Exact Matches, which serve as the seeds for global and local alignments.
*   **Comparative Genomics**: Leverage the library to detect synteny blocks and genomic rearrangements (inversions, translocations) between divergent species.
*   **Library Integration**: When writing C++ applications, link against `libmems` to access optimized suffix tree and suffix array implementations for sequence indexing.

### Best Practices
*   **Sequence Preprocessing**: Ensure input FASTA files are cleaned of non-IUPAC characters to prevent indexing errors.
*   **Memory Management**: For mammalian-sized genomes, monitor RAM usage closely; the underlying suffix structures can be memory-intensive.
*   **Seed Sensitivity**: Adjust match length parameters based on the evolutionary distance of the organisms being compared—shorter seeds for divergent species, longer seeds for closely related strains.

## Reference documentation
- [libmems Overview](./references/anaconda_org_channels_bioconda_packages_libmems_overview.md)