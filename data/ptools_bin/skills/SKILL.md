---
name: ptools_bin
description: ptools_bin is a suite of command-line utilities for converting specialized ENCODE genomic data formats and processing transcriptomic mappings. Use when user asks to convert PBAM to BAM, generate FASTQ files from alignments, or process transcriptome-mapped reads.
homepage: https://github.com/ENCODE-DCC/ptools_bin
---


# ptools_bin

## Overview
ptools_bin is a suite of command-line utilities developed by the ENCODE-DCC for specialized genomic data processing. It is primarily used to bridge the gap between internal ENCODE processing formats (like PBAM) and standard bioinformatics formats. The toolset provides essential scripts for file conversion, sequence extraction, and transcriptomic mapping workflows, ensuring that metadata tags (like MC:Z) are properly handled and sanitized for downstream analysis.

## Installation and Dependencies
- **Requirement**: `samtools` must be installed and available in your system PATH.
- **Conda**: `conda install bioconda::ptools_bin`
- **Pip**: `pip install ptools_bin`

## Core CLI Utilities
The package installs several executable scripts. While specific arguments depend on the version, the primary tools include:

- `pbam2bam`: Converts PBAM (Position-sorted BAM or internal ENCODE variant) files into standard BAM format.
- `makefastq`: Extracts sequence data from alignment files to generate FASTQ files.
- `makediff`: Used for generating difference files or comparing genomic datasets.
- `pbam_mapped_transcriptome`: Processes alignments specifically mapped to transcriptomic coordinates.

## Expert Tips and Best Practices
- **Spike-in Handling**: Recent versions (0.0.7+) include logic to automatically skip or handle reads associated with "Spikein" chromosome names. If your workflow involves spike-in controls, ensure you are using the latest version to avoid processing errors.
- **Tag Sanitization**: The tool automatically sanitizes the `MC:Z` tag during processing, which is critical for compatibility with certain versions of Picard or GATK that are sensitive to malformed mate-CIGAR tags.
- **Transcriptome Mapping Errors**: If you encounter an "Index not found error" when running `pbam_mapped_transcriptome`, verify that your input BAM/PBAM file is properly indexed and that the transcriptome reference index is accessible in the working directory.
- **Pipe Compatibility**: The scripts are designed to work within shell pipes; however, ensure that stdin is properly formatted as the tool iterates over input streams.

## Reference documentation
- [ptools_bin Overview](./references/anaconda_org_channels_bioconda_packages_ptools_bin_overview.md)
- [GitHub Repository README](./references/github_com_ENCODE-DCC_ptools_bin.md)
- [Issue #11: Index not found error](./references/github_com_ENCODE-DCC_ptools_bin_issues.md)
- [Commit History: Script list and logic updates](./references/github_com_ENCODE-DCC_ptools_bin_commits_dev.md)