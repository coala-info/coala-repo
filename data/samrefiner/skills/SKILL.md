---
name: samrefiner
description: samrefiner extracts and refines variant information from SAM files while filtering chimeric sequences and reporting nucleotide or amino acid changes. Use when user asks to refine post-alignment data, identify variants, handle multi-nucleotide polymorphisms, or deconvolve covariant data in sequencing projects.
homepage: https://github.com/degregory/SAM_Refiner
metadata:
  docker_image: "quay.io/biocontainers/samrefiner:1.4.2.1--pyhdfd78af_0"
---

# samrefiner

## Overview
The `samrefiner` tool is a Python-based utility designed to extract and refine variant information from SAM (Sequence Alignment/Map) files. It excels at filtering out chimeric sequences and providing detailed reports on nucleotide and amino acid changes. Use this skill when you need to perform post-alignment refinement, specifically for identifying variants, handling multi-nucleotide polymorphisms (MNPs), or deconvolving covariant data in viral or microbial sequencing projects.

## Installation
Install via Bioconda for the most stable environment:
```bash
conda install bioconda::samrefiner
```

## Common CLI Patterns

### Basic Variant Calling
To process a SAM file against a FASTA reference:
```bash
SAM_Refiner -r reference.fasta
```

### Using GenBank References
When using a `.gb` file, `samrefiner` can provide protein-level context:
```bash
SAM_Refiner -r reference.gb --AAcentered 1
```

### Whole Genome Sequencing (WGS) Mode
For WGS data, enable the specific processing mode and tile-based abundance calculation:
```bash
SAM_Refiner -r reference.fasta --wgs 1
```

### Performance Optimization
Use multi-processing to speed up the refinement of large SAM files:
```bash
SAM_Refiner -r reference.fasta --mp <number_of_processes>
```

## Expert Tips and Best Practices

- **Reference Selection**: If your reference has CDS entries, use a GenBank (`.gb`) file with `--AAcentered 1` to get amino acid centered outputs for unique sequences and covariants.
- **Filtering Abundance**: Control the sensitivity of your variant calls using the abundance flags:
  - `--min_count`: Minimum raw count for a variant.
  - `--min_samp_abund`: Minimum abundance within a sample.
  - `--min_col_abund`: Minimum abundance across a collection.
- **Handling Indels**: The tool reports amino acids for in-frame indels. Note that mismatch reporting might be inconsistent if mismatches directly flank the indel.
- **Chimeric Removal**: `samrefiner` automatically attempts to remove chimeric sequences during processing, which is critical for accurate covariant deconvolution.
- **Output Customization**: Use `--ntvar 1` if you only require an output of variant calls rather than the full nucleotide call report.
- **Distance Threshold**: The default `--max_dist` is 40. Adjust this if your expected variants or read lengths require a different window for clustering variants.

## Reference documentation
- [SAM_Refiner GitHub Repository](./references/github_com_degregory_SAM_Refiner.md)
- [Bioconda samrefiner Overview](./references/anaconda_org_channels_bioconda_packages_samrefiner_overview.md)