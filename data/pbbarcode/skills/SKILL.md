---
name: pbbarcode
description: pbbarcode is a specialized toolset for managing barcode information within PacBio sequencing datasets.
homepage: https://github.com/mlbendall/pbbarcode
---

# pbbarcode

## Overview

pbbarcode is a specialized toolset for managing barcode information within PacBio sequencing datasets. It provides a suite of sub-commands to bridge the gap between raw sequencing output and demultiplexed, analysis-ready files. While often integrated into SMRTPipe workflows, the command-line utility offers granular control over how ZMWs are labeled, how alignments are filtered based on barcode scores, and how reads are emitted into FASTA or FASTQ formats.

## Core Command Usage

The primary entry point is `pbbarcode.py`, which utilizes several key sub-commands:

### 1. Labeling ZMWs
Use `labelZmws` to identify barcodes at the ZMW level. This is typically the first step in a demultiplexing workflow.
- **Input**: Requires a barcode FASTA file and PacBio data files (e.g., `bas.h5` or a FOFN).
- **Output**: Produces barcode annotation files that other sub-commands reference.

### 2. Annotating Alignments
Use `labelAlignments` to transfer barcode information to aligned data.
- **Filtering**: This sub-command allows for filtering alignments based on barcode score and quality.
- **Best Practice**: Ensure the input alignment file (SAM/BAM) corresponds to the ZMWs previously labeled.

### 3. Emitting Reads (Demultiplexing)
Use `emitFastqs` to generate the final demultiplexed sequences.
- **CCS vs. Subreads**: By default, if the input FOFN contains CCS (Circular Consensus Sequence) data, `emitFastqs` will prioritize emitting CCS reads.
- **Forcing Subreads**: Use the `--subreads` flag if you specifically need subreads even when CCS data is present in the input files.
- **Unlabeled Reads**: To troubleshoot or analyze reads that failed to meet barcode criteria, use the option to emit unlabeled ZMWs.

### 4. Consensus (Experimental)
Use `consensus` for generating barcode-specific consensus sequences.
- **Dependency**: This requires the `pbdagcon` package to be installed.
- **Context**: Best used for high-fidelity applications where per-barcode consensus is required beyond standard demultiplexing.

## Expert Tips and Best Practices

- **Header Metadata**: pbbarcode automatically appends `RQ` (Read Quality score) and the average barcode score to the header lines of emitted FASTA/Q files. Note that unlabeled ZMWs will lack the average barcode score in their headers.
- **FOFN Handling**: The tool supports File-of-File-Names (FOFN). It can handle both absolute and relative paths within the FOFN, though absolute paths are recommended for stability in complex directory structures.
- **Read Selection Logic**: When working with "Reads of Insert," the tool intelligently selects the appropriate read type based on the input file extension (e.g., `.ccs.h5` vs `.bas.h5`).
- **Performance**: For large datasets, utilize the subsampling facilities if you only need to verify barcode quality or distribution before running a full demultiplexing pass.

## Reference documentation
- [Overview of the pbbarcode package](./references/github_com_mlbendall_pbbarcode.md)
- [Functional specifications and feature history](./references/github_com_mlbendall_pbbarcode_commits_master.md)