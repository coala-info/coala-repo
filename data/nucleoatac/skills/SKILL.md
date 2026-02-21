---
name: nucleoatac
description: NucleoATAC is a specialized computational framework for high-resolution mapping of nucleosomes using ATAC-Seq data.
homepage: http://nucleoatac.readthedocs.io/en/latest/
---

# nucleoatac

## Overview
NucleoATAC is a specialized computational framework for high-resolution mapping of nucleosomes using ATAC-Seq data. While standard ATAC-Seq analysis focuses on open chromatin peaks, NucleoATAC leverages the fragment size distribution and Tn5 transposase insertion patterns to infer the precise locations and occupancy levels of nucleosomes. This skill provides the necessary command-line patterns and requirements to execute the nucleosome calling workflow.

## Requirements and Preparation
Before running NucleoATAC, ensure the following input files are prepared:
- **BAM File**: Paired-end reads, sorted and indexed. It is highly recommended to filter for high-quality alignments and remove duplicates.
- **FASTA File**: The reference genome used for alignment, indexed with `samtools faidx`.
- **BED File**: A file containing regions for analysis. These should typically be broad open chromatin regions (e.g., peaks identified by MACS2).

**Note on Environment**: NucleoATAC requires **Python 2.7**. It is best managed via a Conda environment or a dedicated virtual environment to avoid dependency conflicts.

## Core Usage Patterns

### Running the Nucleosome Caller
The primary command for identifying nucleosome positions and occupancy is `nucleoatac run`.

```bash
nucleoatac run --bed <regions.bed> --bam <aligned.bam> --fasta <genome.fa> --out <output_prefix> --cores <number_of_cores>
```

### Key Parameters
- `--bed`: Target regions (e.g., ATAC-seq peaks) where nucleosome calling will be performed.
- `--bam`: The sorted and indexed BAM file containing paired-end ATAC-seq fragments.
- `--fasta`: The indexed reference genome.
- `--out`: The prefix for all generated output files.
- `--cores`: Number of CPU cores to use for parallel processing.

### Utility Functions
NucleoATAC includes a secondary set of utilities under the `pyatac` command for general ATAC-Seq data manipulation and fragment analysis. Use `pyatac --help` to explore available sub-commands for data processing.

## Best Practices
- **Region Selection**: Do not run NucleoATAC on the entire genome. Limit the BED file to open chromatin regions to significantly reduce computation time and improve the signal-to-noise ratio.
- **Fragment Sizes**: Ensure your ATAC-Seq library has the characteristic nucleosomal periodicity (mono-, di-, tri-nucleosome fragments) for the best results.
- **Parallelization**: Use the `--cores` flag to speed up the analysis, as the nucleosome occupancy model is computationally intensive.

## Reference documentation
- [NucleoATAC Documentation](./references/nucleoatac_readthedocs_io_en_latest.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_nucleoatac_overview.md)