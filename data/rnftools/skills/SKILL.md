---
name: rnftools
description: rnftools provides a unified environment for managing simulated sequencing data.
homepage: http://karel-brinda.github.io/rnftools
---

# rnftools

## Overview
rnftools provides a unified environment for managing simulated sequencing data. By utilizing the RNF naming convention, it encodes the original genomic coordinates of simulated reads directly into their names. This allows for automated, parameter-free evaluation of how accurately different mappers align reads back to a reference genome. The tool integrates read simulation (via engines like Art, DwgSim, or Mason) and evaluation into a streamlined workflow.

## Core Functionalities

### 1. Read Simulation (rnftools sam2rnf / engine wrappers)
rnftools can wrap various simulators to produce RNF-compliant FASTQ files.
- **Standard Workflow**: Define a simulation configuration (often via a Snakefile) to generate reads from a reference FASTA.
- **Coordinate Encoding**: Ensure reads are generated with RNF names so that downstream evaluation tools can identify the "true" source of the read without needing the original SAM/BAM file.

### 2. Mapper Evaluation (rnftools lavendel)
The `lavendel` module is used to compare mapper output (SAM/BAM) against the ground truth encoded in RNF read names.
- **Input**: A SAM/BAM file produced by a mapper and the original RNF-compliant reads.
- **Output**: Precision-recall curves and reports indicating mapping accuracy.
- **Key Metric**: It calculates the distance between the mapped position and the true position to determine if a read is "correctly" aligned based on a user-defined threshold.

### 3. Format Conversion
- **sam2rnf**: Convert existing SAM files (from simulators that don't support RNF) into RNF-compliant formats.
- **rnf2bam**: Create BAM files where the RNF metadata is preserved or utilized for validation.

## CLI Usage Patterns

### Basic Simulation Setup
While rnftools often uses a Python-based configuration (Snakemake-like), direct CLI utilities are available:
```bash
# Convert a SAM file from a simulator to RNF format
rnftools sam2rnf --input input.sam --output output.rnf.fq
```

### Evaluating a Mapper
To evaluate how well a mapper performed:
```bash
# Generate evaluation plots and statistics
rnftools lavendel --bam aligned_reads.bam --output evaluation_report/
```

## Best Practices
- **Reference Consistency**: Always use the exact same reference FASTA for simulation and for the subsequent mapping index to avoid coordinate shifts.
- **Read ID Integrity**: Do not strip or modify the read names during the mapping process, as rnftools relies on the RNF string in the read header to perform evaluation.
- **Engine Selection**: Choose the simulation engine (Art, Mason, etc.) that best mimics the error profile of the sequencing technology you are benchmarking (e.g., Illumina vs. PacBio).

## Reference documentation
- [rnftools Overview](./references/anaconda_org_channels_bioconda_packages_rnftools_overview.md)
- [RNF Framework Details](./references/brinda_eu_rnftools.md)