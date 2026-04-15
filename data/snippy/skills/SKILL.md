---
name: snippy
description: Snippy identifies genetic variants between a haploid reference genome and raw sequencing reads or assembled contigs. Use when user asks to find SNPs and indels, annotate variant effects, or generate a core genome alignment for phylogenomic analysis.
homepage: https://github.com/tseemann/snippy
metadata:
  docker_image: "quay.io/biocontainers/snippy:4.6.0--hdfd78af_6"
---

# snippy

## Overview

Snippy is a high-speed tool designed for finding variants between a haploid reference genome and raw sequencing reads. It automates the complex process of read alignment, variant calling (using Freebayes), and functional annotation into a single command. Beyond individual sample analysis, Snippy includes tools to aggregate results from multiple runs into a core SNP alignment, which is essential for phylogenomic studies. It is optimized for performance and can scale to utilize many CPU cores on a single machine.

## Usage Instructions

### Basic SNP Calling
To run a standard analysis on paired-end reads:
```bash
snippy --cpus 16 --outdir output_folder --ref reference.gbk --R1 reads_R1.fastq.gz --R2 reads_R2.fastq.gz
```

### Core Genome Alignment
After running Snippy on multiple individual samples using the same reference, use `snippy-core` to create a core SNP alignment:
```bash
snippy-core --prefix core_results sample_dir1 sample_dir2 sample_dir3
```
This produces `core.aln` (FASTA alignment) and `core.vcf` (multi-sample VCF).

### Input Requirements
- **Reference**: FASTA or GenBank format.
- **Reads**: FASTQ or FASTA (can be `.gz` compressed). Supports single-end, paired-end, or even assembled contigs (using `--ctgs`).

### Key Parameters
- `--mincov [N]`: Minimum number of reads covering a site (default: 10).
- `--minfrac [X]`: Minimum proportion of reads which must differ from the reference (default: 0.9).
- `--minqual [N]`: Minimum VCF variant call quality (default: 100).
- `--report`: Generates a visual `snps.report.txt` showing the alignment context for each SNP.

## Expert Tips and Best Practices

- **Use GenBank References**: Always prefer a `.gbk` file over a `.fasta` file for the `--ref` parameter. If a GenBank file is provided, Snippy automatically populates functional columns in the output (GENE, PRODUCT, EFFECT) using the genome's internal annotations.
- **Check Dependencies**: Before starting a large batch, run `snippy --check` to ensure all underlying tools (BWA, Samtools, Freebayes, etc.) are correctly installed and accessible in your PATH.
- **Output Interpretation**:
    - `snps.tab/csv`: The most human-readable summary of all variants.
    - `snps.consensus.fa`: A version of the reference genome with all identified variants instantiated.
    - `snps.bam`: The raw alignments; useful for manual inspection in tools like IGV.
- **Handling Contigs**: If you have an assembly instead of raw reads, you can use Snippy to find differences against a reference:
  ```bash
  snippy --outdir diffs --ref ref.fa --ctgs assembly.fa
  ```
- **Memory Management**: Snippy is CPU-efficient but can be RAM-intensive during the variant calling phase. If running on a cluster, ensure you request sufficient memory (typically 4-8GB per core depending on genome size).

## Reference documentation
- [Snippy GitHub Repository](./references/github_com_tseemann_snippy.md)
- [Snippy Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_snippy_overview.md)