---
name: chunked-scatter
description: The `chunked-scatter` suite provides three distinct utilities to divide genomic contigs and regions into overlapping or balanced chunks.
homepage: https://github.com/biowdl/chunked-scatter
---

# chunked-scatter

## Overview
The `chunked-scatter` suite provides three distinct utilities to divide genomic contigs and regions into overlapping or balanced chunks. It automates the process of splitting large chromosomes while grouping smaller ones to prevent the creation of an excessive number of output files. This skill enables efficient preparation of genomic data for distributed computing by generating BED files that represent specific subsets of the genome.

## Core Commands and Usage

### 1. chunked-scatter
Use this for standard partitioning where you want specific control over chunk size and overlap.
- **Basic Pattern**: `chunked-scatter -p output_prefix -c 1000000 -o 150 input.bed`
- **Key Options**:
  - `-c, --chunk-size`: Target size for each chunk (default: 1e6).
  - `-o, --overlap`: Number of bases to overlap between adjacent chunks (default: 150).
  - `-m, --minimum-bp-per-file`: Minimum bases required before starting a new output file (default: 45e6).
  - `-S, --split-contigs`: Allow a single contig to be split across multiple files.

### 2. scatter-regions
Optimized for GATK-style scattering where the goal is to create files with a specific total genomic size.
- **Basic Pattern**: `scatter-regions -p scatter_ -s 1000000000 input.dict`
- **Key Options**:
  - `-s, --scatter-size`: The maximum total size of regions per output file.
  - `-S, --split-contigs`: Essential if individual contigs exceed the scatter size.

### 3. safe-scatter
Use this for the most even distribution of sizes across a fixed number of output files.
- **Basic Pattern**: `safe-scatter -c 50 -m 10000 input.fai`
- **Key Options**:
  - `-c, --scatter-count`: The exact number of output files to generate.
  - `-m, --min-scatter-size`: Ensures no chunk is smaller than this value (unless the input itself is smaller).
  - `--mix-small-regions`: Distributes small unplaced contigs among larger ones to prevent processing bottlenecks.

## Expert Tips and Best Practices

- **Input Detection**: The tool automatically detects format by extension. Ensure your files end in `.bed`, `.dict`, `.fai`, `.vcf`, `.vcf.gz`, or `.bcf`.
- **Scripting Integration**: Always use the `-P` or `--print-paths` flag when calling these tools within a shell script. This prints the resulting file paths to STDOUT, allowing you to capture them into an array or list for downstream loops.
- **Handling Small Contigs**: If your reference genome contains many small scaffolds (like the human "unplaced" contigs), use `safe-scatter --mix-small-regions`. This prevents a single worker from being assigned thousands of tiny regions, which often causes overhead issues in cluster environments.
- **GATK Compatibility**: When scattering for GATK, `scatter-regions` is the preferred tool as it mimics the logic required for interval-based parallelization.
- **Memory Efficiency**: For very large VCF files, ensure they are indexed (`.tbi` or `.csi`) to allow the tool to parse headers and regions efficiently without loading the entire file into memory.

## Reference documentation
- [chunked-scatter GitHub Repository](./references/github_com_biowdl_chunked-scatter.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_chunked-scatter_overview.md)