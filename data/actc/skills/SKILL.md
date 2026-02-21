---
name: actc
description: Align clr to ccs reads.
homepage: https://github.com/PacificBiosciences/actc
---

# actc

## Overview

`actc` is a specialized alignment utility for Pacific Biosciences data. It maps individual subreads (Continuous Long Reads) to the consensus reads (CCS) generated from the same Zero-Mode Waveguides (ZMWs). This tool is essential for workflows that require subread-level information relative to the high-accuracy consensus, providing both BAM and FASTA outputs.

## Prerequisites

Before running `actc`, ensure the following conditions are met:
- **Indexing**: The subreads BAM file must be indexed. Use `pbindex` (from the `pbbam` package) to generate a `.subreads.bam.pbi` file.
- **Sorting**: The subreads BAM file must be sorted by ZMW (the default for standard PacBio subreads.bam).
- **ZMW Matching**: The CCS file must contain a subset of the ZMWs present in the subread input file.

## Basic Usage

Run the alignment with the following command structure:

```bash
actc movie.subreads.bam movie.ccs.bam aligned.bam --log-level INFO
```

### Key Arguments
- `movie.subreads.bam`: Input subreads (CLR) file.
- `movie.ccs.bam`: Input CCS (consensus) file.
- `aligned.bam`: Output alignment file.
- `-j <int>`: Number of threads to use for (de)compression and alignment.

## Advanced CLI Patterns

### Parallelization via Chunking
To parallelize processing across multiple nodes or cores, use the `--chunk` flag. This requires the CCS BAM file to have a `.pbi` index.

Example of a 10-way parallel split:
```bash
# Run these concurrently
actc movie.subreads.bam movie.ccs.bam aligned.1.bam --chunk 1/10 -j 4
actc movie.subreads.bam movie.ccs.bam aligned.2.bam --chunk 2/10 -j 4
# ... up to 10/10
```

### Trimming and Filtering
Use these flags to improve alignment quality or filter out low-quality consensus targets:
- `--trim-flanks-bp <int>`: Clip N bases from each flank of the CCS read.
- `--min-ccs-length <int>`: Ignore CCS reads that are shorter than N bp after trimming.

## Expert Tips

- **Output Files**: `actc` produces two files: the primary `aligned.bam` and an auxiliary `aligned.fasta` containing the references used in the alignment.
- **Memory Management**: For low-complexity molecules, ensure you are using version 0.2.0 or later, which includes optimizations to reduce the memory footprint.
- **Revio Support**: Version 0.4.0 and later natively support Revio system data.
- **Unsorted CCS**: While subreads must be sorted by ZMW, version 0.5.0 and later allow the use of unsorted uBAM CCS input.

## Reference documentation
- [actc GitHub Repository](./references/github_com_PacificBiosciences_actc.md)
- [actc Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_actc_overview.md)