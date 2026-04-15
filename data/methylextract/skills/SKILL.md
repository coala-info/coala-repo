---
name: methylextract
description: MethylExtract analyzes bisulfite sequencing data to generate high-resolution methylation profiles and detect single nucleotide variants. Use when user asks to generate methylation maps for cytosine contexts, call SNVs from bisulfite-treated reads, or filter sequencing data for quality control.
homepage: http://bioinfo2.ugr.es/MethylExtract/
metadata:
  docker_image: "quay.io/biocontainers/methylextract:1.9.1--0"
---

# methylextract

## Overview
MethylExtract is a specialized tool designed for the comprehensive analysis of bisulfite sequencing data. It addresses the unique challenge of distinguishing between genomic C-to-T polymorphisms and C-to-T transitions resulting from bisulfite treatment. This skill facilitates the generation of high-resolution methylation profiles and accurate SNV calls by implementing quality control filters and statistical models tailored for WGBS datasets.

## Usage Patterns

### Basic Execution
The tool is typically invoked via a Perl script. A standard execution requires a reference genome, aligned BAM/SAM files, and a configuration file or command-line parameters.

```bash
# Typical execution pattern
MethylExtract.pl p=<parameter_file>
```

### Key Functional Areas
- **Methylation Mapping**: Generates methylation levels for all cytosine contexts (CpG, CHG, and CHH).
- **SNV Calling**: Detects sequence variations by comparing the bisulfite-treated reads against the reference, filtering out artifacts caused by incomplete conversion.
- **Quality Filtering**: Supports filtering based on base quality, mapping quality, and sequencing depth to ensure high-confidence calls.

### Best Practices
- **Reference Preparation**: Ensure the reference genome is indexed and matches the assembly used during alignment.
- **Duplicate Removal**: Always perform PCR duplicate removal on input BAM files prior to running MethylExtract to avoid biased methylation estimates.
- **Parameter Tuning**: Adjust the minimum coverage threshold and the minimum number of reads supporting a variant based on the specific sequencing depth of your experiment.

## Reference documentation
- [MethylExtract Overview](./references/anaconda_org_channels_bioconda_packages_methylextract_overview.md)