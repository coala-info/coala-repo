---
name: pygvcf2coverage
description: pygvcf2coverage transforms gVCF files into streamlined coverage reports by collapsing genomic records into contiguous intervals. Use when user asks to extract coverage from a gVCF file, convert gVCF to TSV, or maintain ploidy information across genomic blocks.
homepage: https://github.com/varda/varda2_preprocessing
metadata:
  docker_image: "quay.io/biocontainers/pygvcf2coverage:0.2--py_0"
---

# pygvcf2coverage

## Overview
The `pygvcf2coverage` tool is a specialized utility for transforming gVCF (genomic VCF) files into a streamlined coverage report. Unlike standard VCF files that primarily list variants, gVCFs contain information about every genomic position. This tool parses those records and collapses them into contiguous intervals. It is particularly useful when you need to maintain ploidy information across genomic blocks, a feature that is often lost when using general-purpose tools like `bedtools merge`.

## Command Line Usage

The tool typically operates via standard input and output streams.

### Basic Extraction
To extract coverage from a gVCF file:
```bash
pygvcf2coverage < input.gVCF > coverage.tsv
```

### High-Performance Extraction
If the C-based implementation (`gvcf2coverage`) is installed, use it for significantly faster processing (approximately 12x faster than the Python version):
```bash
gvcf2coverage < input.gVCF > coverage.tsv
```

### Output Format
The tool produces a tab-separated values (TSV) file with the following columns:
1. `<CHROM>`: Chromosome or Reference Sequence ID
2. `<START>`: Start position (0-based)
3. `<END>`: End position
4. `<PLOIDY>`: The ploidy level for that interval

Example output:
```text
NC_000001.10    10033    10038    2
NC_000001.10    10038    10043    2
```

## Expert Tips and Best Practices

### Interval Merging
By default, the tool merges adjacent entries with a distance of 0. It is recommended to use the tool's internal merging logic rather than piping to `bedtools merge`. This is because `pygvcf2coverage` is ploidy-aware; it will correctly handle intervals that have different ploidy values, whereas standard BED tools might merge them incorrectly or require complex grouping.

### Reference ID Normalization
If your gVCF uses non-standard chromosome names (e.g., `1` or `chr1` instead of RefSeq accessions like `NC_000001.10`), you should pipe the output to `cthreepo` to ensure compatibility with the Varda2 database:
```bash
pygvcf2coverage < input.gVCF | cthreepo --mapfile h37 --infile - --id_from uc --id_to rs --outfile output.tsv
```

### Workflow Integration
In a standard Varda2 preprocessing pipeline, coverage extraction is performed in parallel with variant extraction. While `pygvcf2coverage` handles the coverage blocks, variants should be processed separately using `vcf2variants`.

## Reference documentation
- [Varda2 Preprocessing Overview](./references/github_com_varda_varda2_preprocessing.md)
- [pygvcf2coverage Bioconda Summary](./references/anaconda_org_channels_bioconda_packages_pygvcf2coverage_overview.md)