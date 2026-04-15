---
name: bamdash
description: BAMdash creates interactive dashboards and visualizations from viral sequencing data by integrating BAM files with genomic feature tracks. Use when user asks to create interactive dashboards, visualize sequencing coverage, overlay genomic features, calculate genome recovery, annotate variants, or export publication-ready images.
homepage: https://github.com/jonas-fuchs/BAMdash
metadata:
  docker_image: "quay.io/biocontainers/bamdash:0.4.5--pyhdfd78af_0"
---

# bamdash

## Overview
BAMdash is a specialized tool for viral genomics that generates interactive dashboards from sequencing data. It aggregates coverage information from BAM files and overlays genomic features from VCF, GenBank, and BED tracks. The tool is particularly useful for researchers needing to explore variant effects, calculate genome recovery, and produce publication-ready static images.

## Core CLI Usage

The basic command requires a BAM file (with its index `.bai`) and the specific reference ID used during mapping.

```bash
bamdash -b sample.bam -r "Reference_ID"
```

### Integrating Multiple Tracks
To create a comprehensive dashboard, provide multiple track files after the `-t` flag. BAMdash supports `.vcf`, `.gb` (GenBank), and `.bed` formats.

```bash
bamdash -b sample.bam -r "Reference_ID" -t variants.vcf features.gb primers.bed
```

### Exporting for Publication
Generate static images (PDF, PNG, JPG, or SVG) by specifying the format and dimensions.

```bash
bamdash -b sample.bam -r "Reference_ID" -e pdf -d 1200 800
```

## Expert Tips and Best Practices

### Automated Variant Annotation
When a GenBank (`.gb`) and VCF (`.vcf`) file are provided together, BAMdash automatically performs advanced biological annotations:
- **Amino Acid Effects**: It identifies SYN, NON-SYN, START_LOST, STOP_GAINED, and FRAMESHIFT mutations.
- **APOBEC Signatures**: It checks if mutations could have been caused by APOBEC deamination.
- **Nomenclature**: Amino acid changes are reported in a simplified format (e.g., `A58Y` for an exchange at position 58).

### Performance Optimization
For large datasets or high-coverage samples, use the binning argument to improve plot responsiveness:
- Use `-bs <int>` to set the bin size. BAMdash will compute the mean coverage over these bins.
- Adjust the quality threshold with `-q` (default is 15) to filter out low-quality reads before calculating coverage.

### Data Extraction
Use the `--dump` flag to export the annotated track data into tabular formats (`.bed`, `.vcf`) or JSON (for GenBank data). This is useful for downstream bioinformatic analysis beyond visualization.

### Statistics Calculation
BAMdash automatically computes:
- **Recovery**: The percentage of the genome covered at or above a specific threshold.
- **Mean Coverage**: Calculated for each track and individual element within the tracks.
- **Coverage Threshold**: Set the minimum coverage for these statistics using the `-c` flag (default is 5).

## Reference documentation
- [BAMdash GitHub Repository](./references/github_com_jonas-fuchs_BAMdash.md)
- [BAMdash Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_bamdash_overview.md)