---
name: svim
description: SVIM (Structural Variant Identification Method) is a specialized tool designed to detect and classify six classes of structural variation using third-generation sequencing reads.
homepage: https://github.com/eldariont/svim
---

# svim

## Overview

SVIM (Structural Variant Identification Method) is a specialized tool designed to detect and classify six classes of structural variation using third-generation sequencing reads. It is particularly effective at distinguishing between similar genomic events, such as tandem and interspersed duplications, by integrating information across the genome. Use this skill to process long-read data to identify large-scale genomic changes (typically >50bp) that short-read technologies often miss.

## Core Workflows

### Analyzing Aligned BAM Files
Use the `alignment` command when you already have sorted and indexed BAM files.

```bash
svim alignment <output_directory> <input.bam> <reference.fasta>
```

**Requirements:**
- The BAM file must be coordinate-sorted (e.g., `samtools sort`).
- A BAM index (`.bai`) is required for the genotyping step.

### Analyzing Raw Reads
Use the `reads` command to perform alignment and SV calling in one step.

```bash
# For PacBio reads (default aligner is ngmlr)
svim reads <output_directory> <input.fq> <reference.fasta>

# For Oxford Nanopore reads
svim reads --nanopore <output_directory> <input.fq> <reference.fasta>

# Using minimap2 instead of ngmlr
svim reads --aligner minimap2 <output_directory> <input.fq> <reference.fasta>
```

## Expert Tips and Best Practices

### Mandatory Post-Processing Filtering
SVIM does not filter its output; it writes every potential call to `variants.vcf`, including low-quality noise supported by only one read.
- **Filter by Score**: Use the `QUAL` column (range 0-100). Higher scores are more trustworthy.
- **Filter by Support**: Check the `INFO:SUPPORT` tag for the number of supporting reads.
- **Recommendation**: Start with a score threshold (e.g., >10 or >15) and adjust based on your specific coverage and false-positive tolerance.

### Handling Different SV Types
- **Translocations**: These are output in breakend (BND) notation.
- **Insertions**: SVIM v2.0+ computes consensus sequences for insertions, providing better accuracy for the `ALT` allele in the VCF.
- **Duplications**: SVIM distinguishes between `DUP:TANDEM` and `DUP:INT` (interspersed). Note that tandem duplications currently do not receive genotypes.

### Performance and Constraints
- **Multi-threading**: SVIM does not natively support multi-threading for the SV calling components (COLLECT, CLUSTER, COMBINE, GENOTYPE).
- **Memory**: For very large datasets, ensure the environment has sufficient RAM for hierarchical clustering.
- **Genotyping**: SVIM assumes a diploid organism for its genotyping logic.

### Common CLI Parameters
- `--min_mapq <int>`: Set a minimum mapping quality (default is 20). Increase this for higher precision in repetitive regions.
- `--all_bnds`: Use this flag to output all SV classes in breakend notation instead of symbolic alleles.
- `--sample <name>`: Specify a sample name to be used in the VCF header.

## Reference documentation
- [SVIM GitHub Repository](./references/github_com_eldariont_svim.md)
- [SVIM Wiki Documentation](./references/github_com_eldariont_svim_wiki.md)