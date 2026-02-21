---
name: flexi-formatter
description: The `flexi-formatter` utility is a specialized bioinformatics tool designed to bridge the gap between `flexiplex` discovery and standard BAM-based single-cell analysis workflows.
homepage: https://github.com/VIB-CCB-BioIT/flexiplex_tag_formatter
---

# flexi-formatter

## Overview
The `flexi-formatter` utility is a specialized bioinformatics tool designed to bridge the gap between `flexiplex` discovery and standard BAM-based single-cell analysis workflows. By default, flexiplex often stores discovered cell barcodes and Unique Molecular Identifiers (UMIs) within the read name (QNAME) string. This skill provides the necessary procedural knowledge to extract those identifiers and re-insert them as formal BAM tags (specifically `CB` for Cell Barcode and `UR` for UMI), ensuring the BAM file is compatible with standard single-cell processing suites.

## Usage Patterns

### Basic Command Structure
The tool is typically invoked via Python or as a standalone CLI after installation via bioconda.

```bash
flexi-formatter -i input.bam -o output_tagged.bam
```

### Key Parameters
- `-i, --input`: Path to the input BAM file containing flexiplex-formatted read names.
- `-o, --output`: Path for the resulting BAM file with populated tags.

## Expert Tips and Best Practices

### 1. Input Validation
Before running the formatter, verify that your upstream `flexiplex` command was configured to append the barcode and UMI to the read name. If the read names do not follow the expected flexiplex naming convention, the tool will fail to extract the tags.

### 2. Resource Management
Since BAM reformatting involves reading and writing large genomic files, ensure you have:
- Sufficient disk space (at least 2x the size of the input BAM).
- `samtools` installed in your environment, as `flexi-formatter` often relies on `pysam` which requires underlying htslib/samtools support.

### 3. Downstream Compatibility
Once the tags are moved to `CB` and `UR`:
- Use `samtools view -h output_tagged.bam | head` to verify the tags appear at the end of the BAM records.
- These tags are now "standard," meaning you can use them for feature counting or deduplication in tools like `Umi-tools` or `featureCounts`.

### 4. Installation via Bioconda
If the tool is not found in the environment, it should be installed using:
```bash
conda install -c bioconda flexi-formatter
```

## Reference documentation
- [flexi-formatter - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_flexi-formatter_overview.md)
- [GitHub - ljwharbers/flexiformatter](./references/github_com_ljwharbers_flexiformatter.md)