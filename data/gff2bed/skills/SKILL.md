---
name: gff2bed
description: The gff2bed utility converts genomic annotations from GFF3 format into BED format while automatically handling coordinate system shifts. Use when user asks to convert GFF3 files to BED, transform genomic intervals for track visualization, or process malformed GFF3 data into BED format.
homepage: https://gitlab.com/salk-tm/gff2bed
metadata:
  docker_image: "quay.io/biocontainers/gff2bed:1.0.3--pyhdfd78af_0"
---

# gff2bed

## Overview
The `gff2bed` utility is a specialized tool designed to convert genomic annotations from the GFF3 (General Feature Format version 3) format into the BED (Browser Extensible Data) format. This conversion is essential for bioinformatic workflows that require BED-formatted input for interval arithmetic, overlap analysis, or track visualization. This specific implementation (from the salk-tm repository) includes features for handling malformed or non-standard GFF3 files.

## Usage Instructions

### Basic Conversion
The tool typically accepts a GFF3 file as input and outputs the BED-formatted data to standard output.

```bash
gff2bed input.gff3 > output.bed
```

### Handling Malformed Input
If you encounter errors due to non-standard GFF3 formatting or unexpected attributes, use the "graceful" mode to prevent the conversion from failing on individual record errors.

```bash
gff2bed --graceful input.gff3 > output.bed
```

### Installation
The tool is available via the Bioconda channel. Ensure your conda environment is configured with the necessary channels (conda-forge, bioconda).

```bash
conda install bioconda::gff2bed
```

## Best Practices
- **Input Validation**: Ensure your input file strictly follows GFF3 specifications (9 tab-separated columns) before conversion to ensure the most accurate BED output.
- **Stream Processing**: Since the tool outputs to stdout, it can be easily integrated into shell pipes for multi-step genomic processing.
- **Coordinate Systems**: Remember that GFF3 is 1-based (closed interval), while BED is 0-based (half-open interval). `gff2bed` automatically handles this coordinate shift during conversion.

## Reference documentation
- [README.md](./references/gitlab_com_salk-tm_gff2bed_-_blob_main_README.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_gff2bed_overview.md)