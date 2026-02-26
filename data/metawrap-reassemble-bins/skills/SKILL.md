---
name: metawrap-reassemble-bins
description: This tool improves the quality of metagenomic bins by extracting bin-specific reads and reassembling them with a non-metagenomic assembler. Use when user asks to reassemble bins, refine draft genomes, or improve bin completion and purity.
homepage: https://github.com/bxlab/metaWRAP
---


# metawrap-reassemble-bins

## Overview

The `reassemble_bins` module is a specialized tool within the MetaWRAP suite designed to refine draft genomes. Unlike initial metagenomic assembly, which must account for the complexity of an entire community, this module extracts only the reads belonging to a specific bin and reassembles them using a more permissive, non-metagenomic assembler (like SPAdes). This targeted approach allows for better resolution of the genome, leading to longer contigs and higher purity. It is most effective when applied to bins that have already undergone refinement through the MetaWRAP `bin_refinement` module.

## Usage Instructions

### Core Command Pattern
The basic syntax for running the reassembly module is:
```bash
metawrap reassemble_bins -o OUTPUT_DIR -1 READS_1.fastq -2 READS_2.fastq -b BINS_FOLDER
```

### Key Parameters
- `-o`: Output directory for the reassembled bins.
- `-1`, `-2`: Forward and reverse metagenomic reads (FastQ format) used for the original assembly.
- `-b`: Directory containing the input bins (FASTA format) you wish to improve.
- `-t`: Number of threads (recommended: 8+).
- `-m`: Memory in GB (recommended: 64+).
- `-c`: Minimum completion percentage for a bin to be included (default is often 50).
- `-x`: Maximum contamination percentage allowed (default is often 10).

### Advanced Options
- **Nanopore Support**: Recent updates allow for the inclusion of long-read data to assist in the reassembly process.
- **MDMcleaner Integration**: The tool can handle bin formats and contig naming conventions from MDMcleaner.

## Best Practices and Expert Tips

### Input Selection
For the highest quality results, use the output from the MetaWRAP `bin_refinement` module as your input for `-b`. While the tool works on any set of bins, refined bins provide a cleaner starting point for read extraction.

### Resource Allocation
Reassembly is computationally intensive. Because it runs individual assemblies for every bin that meets your completion/contamination thresholds, ensure you have:
- At least 64GB of RAM.
- Sufficient disk space for intermediate read extraction files (which can be large).

### Handling "Stuck" Processes
If the module appears to stop without an error, check the individual bin assembly logs within the output directory. This often happens if a specific bin's read set is too complex for the permissive assembler or if memory limits are exceeded during a specific bin's reassembly.

### Contig Naming
Be aware that reassembly will change contig names. If you have downstream analyses that rely on original contig IDs (like specific gene annotations), you will need to re-run those tools on the new reassembled FASTA files.

## Reference documentation
- [MetaWRAP GitHub Repository](./references/github_com_bxlab_metaWRAP.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_metawrap-reassemble-bins_overview.md)
- [MetaWRAP Bin Directory](./references/github_com_bxlab_metaWRAP_tree_master_bin.md)