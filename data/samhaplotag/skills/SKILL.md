---
name: samhaplotag
description: samhaplotag is a specialized suite of tools designed to manage barcode metadata within SAM-formatted sequencing data.
homepage: https://github.com/wtsi-hpag/SamHaplotag
---

# samhaplotag

## Overview
samhaplotag is a specialized suite of tools designed to manage barcode metadata within SAM-formatted sequencing data. Its primary function is to convert standard BC (barcode sequence) and QT (quality scores) tags into the RX, QX, and BX tags used by haplotagging workflows. Beyond simple tag conversion, the suite includes utilities to reformat these barcodes for compatibility with 10x Genomics pipelines or generic 16-base barcode processors, facilitating the use of haplotagged libraries in a variety of downstream genomic analysis tools.

## Common CLI Patterns

### Standard Tag Conversion
To convert BC/QT tags to RX/QX/BX tags, pipe the output of `samtools view` directly through `SamHaplotag`. It is essential to include the header (`-h`) for proper SAM processing.

```bash
samtools view -h -F 0xF00 input.cram | SamHaplotag | samtools view -b -o tagged_reads.bam
```

### Converting to 10x Genomics Format
If you need to use haplotagged data with tools expecting 10x Genomics formatted barcodes, use the `10xSpoof` utility. This typically follows a `samtools fastq` command that extracts the BX tag.

```bash
samtools fastq -nT BX tagged_reads.bam | 10xSpoof SamHaplotag_Clear_BC | bgzip > 10x_compatible_reads.fq.gz
```

### Generating Generic 16-Base Barcodes
For tools like `ema` that require generic 16-base barcodes with 7-base joins, use the `16BaseBCGen` utility.

```bash
samtools fastq -nT BX tagged_reads.bam | 16BaseBCGen | bgzip > 16BaseBC_reads.fq.gz
```

## Best Practices and Tips

- **Header Preservation**: Always use the `-h` flag with `samtools view` when piping into `SamHaplotag`. The tool requires the SAM header to function correctly.
- **Filtering**: The documentation recommends using `-F 0xF00` with `samtools` to exclude secondary and supplementary alignments, ensuring only primary alignments are processed for tagging.
- **Piping for Efficiency**: Since these tools are designed to work with standard streams (stdin/stdout), always pipe them between `samtools` commands to avoid creating massive intermediate SAM files on disk.
- **Thread Management**: When working with large CRAM or BAM files, remember to pass thread arguments (e.g., `-@ 16`) to the `samtools` and `bgzip` portions of your pipeline to maintain performance, as `SamHaplotag` itself is often the bottleneck in the stream.
- **Barcode Extraction**: When moving from SAM to FASTQ for spoofing, ensure you use the `-nT BX` flag in `samtools fastq` to include the barcode in the read name, which the spoofing tools rely on.

## Reference documentation
- [samhaplotag - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_samhaplotag_overview.md)
- [wtsi-hpag/SamHaplotag: Process haplotag barcodes in SAM format](./references/github_com_wtsi-hpag_SamHaplotag.md)