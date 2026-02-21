---
name: thapbi-pict
description: The THAPBI Phytophthora ITS1 Classifier Tool (PICT) is a specialized bioinformatics pipeline designed for the identification of plant pathogens from environmental samples.
homepage: https://github.com/peterjc/thapbi-pict
---

# thapbi-pict

## Overview
The THAPBI Phytophthora ITS1 Classifier Tool (PICT) is a specialized bioinformatics pipeline designed for the identification of plant pathogens from environmental samples. While originally optimized for the Phytophthora genus using the ITS1 marker, the tool is flexible enough to handle various eukaryotic markers (ITS2, 12S, 16S, COI) across diverse taxa including fungi, fish, and bats. It operates by merging overlapping paired-end Illumina reads and tracking unique sequences via MD5-checksummed ASVs, ensuring high reproducibility and precision in diagnostic profiling.

## Core CLI Usage
The primary entry point for the tool is the `thapbi_pict` command.

### Basic Commands
- **Check Version**: `thapbi_pict -v`
- **General Help**: `thapbi_pict -h`
- **Subcommand Help**: `thapbi_pict [subcommand] -h` (e.g., `thapbi_pict sample-tally -h`)

### Common Workflow Patterns
1. **Database Management**:
   Use the `database` subcommand to maintain local taxonomic records. The tool relies on a curated database of full-length markers to perform classifications.
   - Update taxonomy using NCBI data: `thapbi_pict taxonomy -t taxdmp.zip`

2. **Sample Tallying**:
   The `sample-tally` command is used to process raw FASTQ files into a table of ASV counts.
   - **Tip**: Use the `-x` flag to strip common FASTQ suffixes from sample names in the metadata to keep reports clean.
   - **Performance**: For large datasets, ensure you are using the `vsearch` backend for chimera detection and clustering.

3. **Classification and Assessment**:
   - **Classify**: Run the classifier against your processed tallies to assign species identities.
   - **Assess**: Use the `assess` command to compare tool outputs against "mock communities" or known samples to calculate sensitivity and specificity.

4. **Visualization**:
   - **Edit-Graph**: Generate sequence similarity networks. This is useful for visualizing how closely related ASVs are and identifying potential hybrid species or sequencing artifacts.

## Expert Tips and Best Practices
- **Read Merging**: THAPBI PICT requires overlapping paired-end reads. If your library preparation results in non-overlapping reads (e.g., the insert size is significantly larger than 2x read length), this tool will not be able to process them.
- **MD5 Identifiers**: The tool uses MD5 checksums for ASVs. This allows for easy comparison across different studies and runs without needing to re-align sequences, as the same sequence will always yield the same MD5 ID.
- **Custom Markers**: To use the tool for non-Phytophthora organisms, you must provide a custom database and specify the appropriate primer sequences. The tool is "marker agnostic" as long as the amplicon is short enough to be covered by overlapping reads.
- **Handling Chimeras**: When running `sample-tally`, the tool can interface with `vsearch`. Be aware that different versions of `vsearch` may produce slightly different chimera counts; consistency in software versions is critical for longitudinal studies.

## Reference documentation
- [THAPBI PICT GitHub Repository](./references/github_com_peterjc_thapbi-pict.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_thapbi-pict_overview.md)