---
name: hmmcopy
description: The `hmmcopy` suite consists of C++ based command-line utilities designed to process large genomic datasets for copy number analysis.
homepage: http://compbio.bccrc.ca/software/hmmcopy/
---

# hmmcopy

## Overview
The `hmmcopy` suite consists of C++ based command-line utilities designed to process large genomic datasets for copy number analysis. While the statistical modeling occurs within R/Bioconductor, these tools handle the computationally intensive tasks of extracting binned read counts from BAM files and generating the necessary reference files (GC content and mappability) for normalization.

## Core Workflow
The standard workflow involves three primary tools: `readCounter`, `gcCounter`, and `mapCounter`.

### 1. Generating Read Counts
Use `readCounter` to extract binned read counts from indexed BAM files.
```bash
readCounter --window 1000 --chromosome "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,X,Y" input.bam > output.wig
```
- **--window**: Sets the bin size (default is often 1000 or 50000 depending on coverage).
- **--chromosome**: Specify a comma-separated list of chromosomes to process.

### 2. Generating GC Content Reference
Use `gcCounter` on a reference FASTA file to calculate the GC percentage per bin.
```bash
gcCounter --window 1000 reference.fa > gc_content.wig
```

### 3. Generating Mappability Reference
Use `mapCounter` to calculate the average mappability per bin from a BigWig file (typically generated from a self-alignment of the genome).
```bash
mapCounter --window 1000 mappability.bigwig > map_scores.wig
```

## Best Practices
- **Consistency**: Ensure the `--window` size is identical across all three counters (`readCounter`, `gcCounter`, and `mapCounter`) for a single analysis.
- **File Formats**: The output is in WIG (wiggle) format, which is the required input for the `wigsToRdata.R` script or the `HMMcopy` Bioconductor package.
- **Chromosome Naming**: Ensure chromosome names in your BAM file match those in your reference FASTA and mappability files (e.g., "chr1" vs "1").
- **Memory Management**: For large genomes, process chromosomes individually if memory constraints are met, though these C++ tools are generally memory-efficient.

## Reference documentation
- [hmmcopy Overview](./references/anaconda_org_channels_bioconda_packages_hmmcopy_overview.md)