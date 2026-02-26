---
name: catch
description: CATCH designs compact, comprehensive probe sets for the enrichment and discovery of diverse genomic sequences. Use when user asks to design oligonucleotide probes, generate probe sequences in FASTA format, or fetch and process viral sequences via NCBI taxonomy IDs.
homepage: https://github.com/broadinstitute/catch
---


# catch

## Overview
CATCH (Compact Aggregation of Targets for Comprehensive Hybridization) is a computational framework for designing compact, comprehensive probe sets that provide guaranteed coverage of diverse genomic sequences. It is particularly effective for viral discovery and enrichment, where it can process large collections of unaligned sequences to find an optimal set of oligos. Use this skill to generate probe sequences in FASTA format from local files or by automatically fetching data via NCBI taxonomy IDs.

## Command Line Usage

### Core Design Commands
CATCH provides three primary entry points depending on the scale and complexity of the task:

1.  **`design.py`**: Best for single species or small datasets where cautious, high-sensitivity defaults are preferred.
2.  **`design_large.py`**: Optimized for large, diverse inputs (e.g., multiple viral families). It uses pragmatic defaults to reduce runtime and memory usage.
3.  **`pool.py`**: Used for complex designs requiring variable hybridization criteria across different taxa.

### Basic Syntax
```bash
# Design probes from a local FASTA file
design.py input.fasta -o probes.out.fasta

# Design probes by automatically downloading sequences for a specific TaxID
design.py download:11070 -o zika_probes.fasta
```

### Key Parameters
*   **Probe Geometry**:
    *   `-pl, --probe-length`: Length of the probes (default: 100nt).
    *   `-ps, --probe-stride`: The interval at which candidate probes are generated (default: 50nt).
*   **Sensitivity and Compactness**:
    *   `-m, --mismatches`: Number of mismatches to tolerate between a probe and its target. Increasing this value significantly reduces the total number of probes required (default: 0).
    *   `-e, --cover-extension`: Number of nucleotides on each side of a probe that are considered "covered" by hybridization.
*   **Optimization**:
    *   `--max-probes`: Set a hard limit on the number of probes (e.g., to fit a specific array size). CATCH will search for the best coverage within this constraint.

## Expert Tips and Best Practices

*   **Handling Large Diversity**: When working with highly diverse targets (like all known variants of a viral genus), always prefer `design_large.py`. It implements heuristics that prevent the memory exhaustion often encountered with the standard `design.py`.
*   **Automated NCBI Integration**: Use the `download:TAXID` prefix to ensure you are capturing the most up-to-date genetic diversity available in NCBI's databases without manual curation.
*   **Reducing Costs**: If the resulting probe set is too large for your budget, incrementally increase the `-m` (mismatches) parameter. Even a small increase (e.g., from 0 to 2) can lead to a much more compact design with minimal loss in practical capture efficiency.
*   **Background Avoidance**: Use the avoidance features to prevent designing probes that might cross-hybridize with host DNA (e.g., human background in a clinical sample).

## Reference documentation
- [CATCH GitHub Repository](./references/github_com_broadinstitute_catch.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_catch_overview.md)