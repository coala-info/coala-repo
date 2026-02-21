---
name: bamm
description: BamM is a specialized toolkit designed for the efficient handling of BAM files within metagenomic workflows.
homepage: https://github.com/Ecogenomics/BamM
---

# bamm

## Overview

BamM is a specialized toolkit designed for the efficient handling of BAM files within metagenomic workflows. It provides a C-based backend wrapped in Python to offer rapid parsing and specific utilities for analyzing how reads map to contigs. Key capabilities include calculating coverage metrics (such as trimmed mean), identifying links between contigs, and determining library statistics like insert size and orientation. While the project is currently in maintenance mode (with CoverM suggested as a modern alternative), BamM remains a robust choice for legacy pipelines requiring stable, high-speed BAM processing.

## Installation and Dependencies

BamM is most easily installed via Conda:

```bash
conda install bioconda::bamm
```

**Core Dependencies:**
*   **samtools**: Required for indexing and `bamm make` operations.
*   **bwa**: Required if using the `bamm make` alignment workflow.

## Common CLI Patterns

### Alignment and Indexing
Use the `make` command to handle the alignment process. This wrapper simplifies the transition from raw reads to processed BAM files.

```bash
bamm make -f reads_1.fastq -r reads_2.fastq -d reference.fasta -o output_directory
```

### Filtering and Validation
BamM includes built-in validation to ensure BAM headers are compatible before parsing. The `filter` command is particularly useful because it automatically generates a new index for the resulting file.

```bash
bamm filter -i input.bam -o filtered.bam [options]
```

### Coverage Calculation
BamM is frequently used to generate coverage profiles for metagenomic bins or contigs.
*   **tpmean**: Calculates the trimmed mean coverage, which helps remove outliers from highly conserved regions or mapping artifacts.
*   **Percentage Coverage**: Use specific coverage modes to determine what percentage of a contig is covered by reads.

### Data Extraction
To extract specific read pairs or links that join two different contigs (essential for scaffolding or binning analysis):

```bash
bamm extract -i input.bam -o extracted_reads.bam
```
*Note: Be aware that `bamm extract` may use specific header prefixes that might require stripping for some downstream third-party tools.*

## Expert Tips and Best Practices

*   **Performance**: If your Python scripts using PySam are bottlenecked by BAM parsing speed, consider using the BamM C-library interface for a significant performance boost.
*   **Metagenomic Links**: Use BamM specifically when you need to identify "inter-contig" links (read pairs where each mate maps to a different contig), as this is a primary design goal of the tool.
*   **Handling Low Coverage**: When using `tpmean`, be cautious with very low-coverage samples, as the trimming logic can produce unintuitive results if the number of data points is insufficient.
*   **Transitioning**: For new projects requiring similar functionality with better performance and active support, consider evaluating **CoverM** as a successor.

## Reference documentation
- [github_com_Ecogenomics_BamM.md](./references/github_com_Ecogenomics_BamM.md)
- [anaconda_org_channels_bioconda_packages_bamm_overview.md](./references/anaconda_org_channels_bioconda_packages_bamm_overview.md)
- [github_com_Ecogenomics_BamM_issues.md](./references/github_com_Ecogenomics_BamM_issues.md)