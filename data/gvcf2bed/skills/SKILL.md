---
name: gvcf2bed
description: This tool converts gVCF files into BED files representing high-quality genomic intervals by applying specific quality filters to variant and non-variant records. Use when user asks to convert gVCF to BED, filter genomic regions by genotype quality, or define a callable genome from sequencing data.
homepage: https://github.com/sndrtj/gvcf2bed
metadata:
  docker_image: "quay.io/biocontainers/gvcf2bed:0.3.1--py_0"
---

# gvcf2bed

## Overview

The `gvcf2bed` tool is a specialized utility for transforming gVCF files—which provide information for every genomic position—into BED files that represent high-quality intervals. Unlike standard VCFs, gVCFs include large blocks of non-variant (reference) calls. This tool allows researchers to set independent quality filters for variant and non-variant records, ensuring that the resulting BED file accurately reflects the regions of the genome where the sequencing data is reliable.

## Installation

The tool can be installed via Conda or Pip:

```bash
# Via Bioconda
conda install -c bioconda gvcf2bed

# Via PyPI
pip install gvcf2bed
```

## Command Line Usage

### Basic Conversion
To convert a gVCF to a BED file using default quality thresholds (GQ >= 20):

```bash
gvcf2bed -I input.g.vcf -O output.bed
```

### Filtering by Genotype Quality (GQ)
A key feature of `gvcf2bed` is the ability to distinguish between variant and non-variant quality distributions. Non-variant records (hom-ref blocks) often have different GQ score distributions than variant sites.

```bash
# Set variant GQ threshold to 30 and non-variant GQ to 15
gvcf2bed -I input.g.vcf -O output.bed -q 30 -nq 15
```

### Multi-sample gVCFs
If the input file contains multiple samples, specify the target sample by name. If not provided, the tool defaults to the first sample alphabetically.

```bash
gvcf2bed -I multi_sample.g.vcf -O sample_A.bed -s Sample_A
```

### Bedgraph Output
To generate a bedgraph file instead of a standard BED file, use the `-b` flag:

```bash
gvcf2bed -I input.g.vcf -O output.bedgraph -b
```

## Expert Tips and Best Practices

- **Performance**: Ensure `cyvcf2` is installed in your environment. The tool uses `cyvcf2` by default if available, which provides an 8-10x speedup over the older `pyvcf` backend.
- **Defining Callability**: When defining a "callable genome" for a study, use the `-nq` (non-variant quality) parameter to be more or less stringent about the reference blocks. A lower `-nq` might be acceptable for simple coverage checks, while a higher `-nq` is better for sensitive variant discovery.
- **Input Requirements**: The input gVCF must contain a `GQ` field in its `FORMAT` fields. If the `GQ` field is missing or undefined for a record, the tool handles these based on the specific version logic (v0.3.1+ fixes bugs related to undefined GQ).
- **Memory Efficiency**: Because it processes gVCFs (which can be very large), the tool is designed to be relatively efficient, but always ensure you have sufficient disk space for the uncompressed BED output, which can be significantly larger than the input if many small blocks are created.

## Reference documentation
- [gvcf2bed GitHub Repository](./references/github_com_sndrtj_gvcf2bed.md)
- [gvcf2bed Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_gvcf2bed_overview.md)