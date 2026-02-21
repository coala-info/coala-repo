---
name: elprep
description: elPrep is a high-performance tool designed for the rapid processing of sequence alignment files (.sam, .bam, and .vcf.gz).
homepage: https://github.com/ExaScience/elprep
---

# elprep

## Overview

elPrep is a high-performance tool designed for the rapid processing of sequence alignment files (.sam, .bam, and .vcf.gz). Unlike traditional tools that require multiple passes over data, elPrep uses a single-pass, in-memory architecture to execute complex pipelines (sorting, marking duplicates, BQSR, and variant calling) simultaneously. This approach significantly reduces runtime and disk I/O, making it ideal for high-end servers and cloud environments.

## Core CLI Patterns

### Single-Pass Filter Mode (sfm)
The `sfm` command is the primary entry point for combining multiple processing steps into a single execution.

```bash
# Example: Sorting and Marking Duplicates in one pass
elprep sfm input.bam output.bam \
    --mark-duplicates \
    --sorting-order coordinate
```

### Full Variant Calling Pipeline
To run a GATK-best-practices-equivalent pipeline (Sorting, MarkDuplicates, BQSR, and HaplotypeCaller):

```bash
elprep sfm input.bam output.vcf.gz \
    --mark-duplicates \
    --sorting-order coordinate \
    --bqsr output.recal \
    --known-sites known_sites.elsites \
    --reference reference.elfasta \
    --haplotypecaller output.vcf.gz
```

### Format Conversions
elPrep uses optimized internal formats (`.elsites` and `.elfasta`) to speed up BQSR and variant calling.

*   **VCF to elsites**: `elprep vcf-to-elsites input.vcf output.elsites`
*   **FASTA to elfasta**: `elprep fasta-to-elfasta input.fasta output.elfasta`

## Best Practices and Expert Tips

*   **Memory Management**: elPrep is an in-memory tool. For Whole Genome Sequencing (WGS) data, ensure the server has sufficient RAM (typically 160GB+ for 30x-50x WGS). If memory is limited, use the `split`/`merge` tools to process data by chromosome.
*   **Avoid Intermediate Files**: One of elPrep's main advantages is reducing disk I/O. Avoid piping between elPrep and other tools if the operation can be handled within a single `sfm` command.
*   **Optical Duplicates**: When marking duplicates, use `--optical-duplicate-pixel-distance 2500` (for patterned flow cells like NovaSeq) to improve accuracy.
*   **System Requirements**: elPrep is optimized for high-end servers. It is not recommended for use on laptops or low-end desktops due to its high RAM and multi-threading requirements.
*   **CRAM Support**: elPrep does not natively support .cram. Convert .cram to .bam using `samtools` before processing with elPrep.

## Reference documentation

- [elPrep GitHub Repository](./references/github_com_ExaScience_elprep.md)
- [elPrep Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_elprep_overview.md)