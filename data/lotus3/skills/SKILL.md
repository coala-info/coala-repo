---
name: lotus3
description: LotuS3 is a high-performance pipeline for processing raw amplicon sequencing data into taxonomic tables. Use when user asks to analyze amplicon reads, generate OTU or ASV tables, or perform taxonomic annotation of sequencing data.
homepage: https://lotus3.earlham.ac.uk/
metadata:
  docker_image: "quay.io/biocontainers/lotus3:3.03--hdfd78af_1"
---

# lotus3

## Overview
LotuS3 (Less OTU Scripts 3) is a streamlined, highly efficient pipeline designed for the analysis of amplicon sequencing data. It integrates multiple bioinformatics tools into a single workflow, handling everything from raw sequence reads to a final OTU/ASV table with taxonomic annotations. It is optimized for speed and low memory usage, making it suitable for both small-scale studies and large-scale meta-analyses.

## Core Usage Patterns

### Basic Pipeline Execution
The primary entry point for the pipeline is the `lotus2` or `lotus3` command (depending on the specific installation alias). A standard run requires an input directory of fastq files and a mapping file.

```bash
lotus3 -i <input_dir> -m <mapping_file.txt> -o <output_dir> -refDB <database>
```

### Key Parameters
- `-i`: Directory containing raw .fastq or .fastq.gz files.
- `-m`: Mapping file (tab-delimited) linking filenames to sample IDs and metadata.
- `-o`: Output directory for all results.
- `-refDB`: Reference database for taxonomic assignment (e.g., SILVA, Greengenes, UNITE).
- `-p`: Sequencing platform (e.g., `mi` for MiSeq, `hi` for HiSeq, `454`).
- `-t`: Number of threads to use for parallel processing.

### Common Workflow Variations
- **ASV Generation**: To generate Amplicon Sequence Variants (ASVs) instead of traditional OTUs, use the DADA2 or deblur integration.
  ```bash
  lotus3 -i <input> -m <map> -o <out> -clust unoise3
  ```
- **ITS Processing**: When analyzing fungal ITS data, ensure the `-ITS` flag is toggled to handle variable sequence lengths and specialized trimming.
  ```bash
  lotus3 -i <input> -m <map> -o <out> -refDB UNITE -ITS 1
  ```

## Expert Tips
- **Mapping File Validation**: Ensure your mapping file is tab-separated and contains no special characters in sample names. The first column must match the beginning of the fastq filenames.
- **Quality Filtering**: LotuS3 uses a default "autodetect" for quality offsets (Phred 33 vs 64). If you encounter errors during filtering, manually specify the offset using `-qoffset 33`.
- **Memory Management**: For extremely large datasets, use the `-lowMem` flag to reduce the RAM footprint during the clustering phase.
- **Resuming Runs**: If a run is interrupted, LotuS3 can often be resumed by pointing to the same output directory; it will check for existing intermediate files to skip completed steps.

## Reference documentation
- [LotuS3 Overview](./references/anaconda_org_channels_bioconda_packages_lotus3_overview.md)