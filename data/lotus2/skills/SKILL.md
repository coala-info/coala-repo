---
name: lotus2
description: LotuS2 (Less OTU Scripts) is a high-performance, lightweight pipeline designed for the end-to-end analysis of amplicon data.
homepage: http://lotus2.earlham.ac.uk/
---

# lotus2

## Overview
LotuS2 (Less OTU Scripts) is a high-performance, lightweight pipeline designed for the end-to-end analysis of amplicon data. It streamlines the transition from raw fastq/fasta files to abundance tables and phylogenetic trees. It is particularly useful for users needing a fast alternative to mothur or DADA2 that can run efficiently on limited hardware (like laptops) while maintaining high taxonomic precision.

## Core Usage Patterns

### Basic Pipeline Execution
The primary entry point is the `lotus2` command. A standard run requires input sequences, a mapping file, and an output directory.

```bash
lotus2 -i <input_dir> -m <mapping_file.txt> -o <output_dir> -refDB <database>
```

### Key Parameters
- `-i`: Directory containing raw fastq or fasta files.
- `-m`: Mapping file (tab-delimited) containing sample metadata and barcode information.
- `-o`: Output directory for all processed data and final tables.
- `-refDB`: Taxonomic database to use (e.g., SILVA, Greengenes, UNITE, or PR2).
- `-p`: Sequencing platform (e.g., miSeq, hiSeq, iontorrent).
- `-type`: Type of amplicon (e.g., 16S, 18S, ITS).

### Clustering Options
LotuS2 supports multiple clustering algorithms. Choose based on your research goals:
- **ASVs**: Use `-CL 6` (DADA2) or `-CL 7` (Unoise3) for amplicon sequence variants.
- **OTUs**: Use `-CL 1` (UPARSE) or `-CL 2` (VSEARCH) for traditional 97% identity clustering.

## Expert Tips & Best Practices
- **Demultiplexing**: LotuS2 uses `sdm` internally. If your data is already demultiplexed, ensure your mapping file reflects this to skip the internal demultiplexing step.
- **Resource Management**: For large hiSeq datasets, use the `-t` flag to specify the number of CPU threads to accelerate processing.
- **Phyloseq Integration**: LotuS2 automatically generates `.biom` files and R-compatible objects. Look for the `phyloseq` folder in the output directory for immediate downstream analysis in R.
- **Contamination Removal**: Use the built-in filtering options to remove host DNA (e.g., human or plant plastids) by specifying the target organism in the configuration.

## Reference documentation
- [LotuS2 Home and Workflow Overview](./references/lotus2_earlham_ac_uk_index.md)
- [Bioconda Installation and Versions](./references/anaconda_org_channels_bioconda_packages_lotus2_overview.md)