---
name: sequenza-utils
description: This skill provides the procedural knowledge to use the `sequenza-utils` Python suite.
homepage: http://sequenza-utils.readthedocs.org
---

# sequenza-utils

## Overview
This skill provides the procedural knowledge to use the `sequenza-utils` Python suite. It serves as the bridge between raw Next-Generation Sequencing (NGS) data and the Sequenza R package. You will use this to generate GC-content reference files, process BAM or pileup files into the specialized `.seqz` format, and perform binning to reduce data size for efficient downstream analysis.

## Common Workflows and CLI Patterns

### 1. Generating a GC-content Reference
Before processing samples, you must create a GC-content window file for the specific reference genome used in alignment.
```bash
sequenza-utils gc_wiggle -w 50 -f reference.fasta -o hg38.gc50.wig.gz
```
*Tip: Match the window size (`-w`) to your intended analysis resolution (usually 50bp).*

### 2. Processing BAM Files to Seqz
The most common entry point is converting a Normal-Tumor BAM pair into a compressed seqz file. This requires `samtools` to be available in the environment.
```bash
sequenza-utils bam2seqz -n normal.bam -t tumor.bam --fasta reference.fasta \
    -gc hg38.gc50.wig.gz -o out.seqz.gz
```

### 3. Processing VCF Files
If you already have a VCF containing germline heterozygous SNPs, use the `vcf2seqz` command.
```bash
sequenza-utils vcf2seqz -v input.vcf.gz -n normal.bam -t tumor.bam \
    -gc hg38.gc50.wig.gz -f reference.fasta -o out.seqz.gz
```

### 4. Binning for Performance
Raw `.seqz` files are often too large for R to process efficiently. Binning reduces the file size by shrinking the genomic resolution.
```bash
sequenza-utils seqz_binning -s out.seqz.gz -w 50 -o out_bin50.seqz.gz
```
*Expert Tip: Always perform binning if your raw seqz file exceeds 1GB to prevent memory exhaustion in the R environment.*

## Best Practices
- **Compression**: Always use the `.gz` extension for output files; `sequenza-utils` handles gzip compression natively and the R package expects it.
- **Chromosome Naming**: Ensure the chromosome naming convention (e.g., "chr1" vs "1") is consistent across the FASTA, GC-wiggle, and BAM files.
- **Resource Management**: For whole-genome sequencing (WGS), `bam2seqz` is CPU intensive. If possible, process by chromosome and use `merge_seqz` to combine them.

## Reference documentation
- [Sequenza-utils ReadTheDocs](./references/sequenza-utils_readthedocs_io_en_latest.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_sequenza-utils_overview.md)