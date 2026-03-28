---
name: bcftools
description: bcftools is a comprehensive suite of utilities for manipulating, filtering, and calling genetic variants in VCF and BCF formats. Use when user asks to call variants, filter records by quality or depth, query specific fields, manage samples, or generate consensus sequences.
homepage: https://github.com/samtools/bcftools
---

# bcftools

## Overview

bcftools is a comprehensive suite of utilities designed for high-performance manipulation of genetic variant files. It handles both text-based VCF and its indexed binary counterpart, BCF. Use this skill to execute common bioinformatics workflows including variant calling (via mpileup), quality control filtering, sample management, and consensus sequence generation.

## Core Command Patterns

### Variant Calling
To call variants from aligned sequence data, pipe the output of `samtools mpileup` into `bcftools call`.
- **Standard Calling**: `samtools mpileup -uf ref.fa aln.bam | bcftools call -mv -Oz -o calls.vcf.gz`
- **Options**: Use `-m` for the multiallelic caller (recommended) and `-v` to output only variant sites.

### Filtering and Statistics
Filtering is performed using expressions with `-i` (include) or `-e` (exclude).
- **Basic Filter**: `bcftools filter -i'%QUAL>20 && DP>10' in.vcf.gz`
- **Complex Expressions**: `bcftools filter -e'RPB<0.1 || %MAX(DV)<=3' in.vcf.gz`
- **Generate Stats**: `bcftools stats file.vcf.gz > file.stats`
- **Visualize Stats**: Use `plot-vcfstats` on the resulting stats file to create graphical reports.

### Querying and Sample Management
- **List Samples**: `bcftools query -l file.vcf.gz`
- **Extract Fields**: `bcftools query -f'%CHROM\t%POS\t%REF\t%ALT[\t%GT]\n' file.vcf.gz`
- **Subset Samples**: `bcftools view -s sample1,sample2 -Oz -o subset.vcf.gz file.vcf.gz`

### Annotating and Reheadering
- **Add Header Lines**: `bcftools annotate -h header_lines.txt in.vcf.gz`
- **Annotate from BED/TAB**: `bcftools annotate -a annots.bed.gz -c CHROM,FROM,TO,TAG -h annots.hdr in.vcf.gz`
- **Rename Samples**: `bcftools reheader -s samples.txt -o out.vcf.gz in.vcf.gz`

### Consensus and Normalization
- **Create Consensus**: `cat ref.fa | bcftools consensus file.vcf.gz > consensus.fa`
- **Normalize Indels**: `bcftools norm -f ref.fa in.vcf.gz` (Left-aligns and normalizes indels).

## Expert Tips

- **Output Compression**: Always use `-Oz` for compressed VCF output and `-Ob` for compressed BCF output to save space and enable indexing.
- **Indexing**: Most random-access operations require an index. Use `bcftools index file.vcf.gz`.
- **Missing Values**: In filtering expressions, refer to missing values using `"."`. For example, `-i'ID!="."'` includes only sites with an ID.
- **Performance**: When processing large datasets, use the `--threads` option to parallelize compression/decompression.
- **Numerical Functions**: Recent versions support functions like `SUM(FORMAT/AD)`, `MAX(INFO/DP)`, and `smpl_COUNT()` within query and filter expressions.



## Subcommands

| Command | Description |
|---------|-------------|
| bcftools annotate | Annotate and edit VCF/BCF files. |
| bcftools call | SNP/indel variant calling from VCF/BCF. To be used in conjunction with  bcftools mpileup. This command replaces the former 'bcftools view' caller. |
| bcftools cnv | Copy number variation caller, requires Illumina's B-allele frequency (BAF) and Log R Ratio intensity (LRR). The HMM considers the following copy number states: CN 2 (normal), 1 (single-copy loss), 0 (complete loss), 3 (single-copy gain) |
| bcftools concat | Concatenate or combine VCF/BCF files. All source files must have the same sample columns appearing in the same order. The input files must be sorted by chr and position. |
| bcftools consensus | Create consensus sequence by applying VCF variants to a reference fasta  file. By default, the program will apply all ALT variants. Using the --samples (and, optionally, --haplotype) option will apply genotype (or haplotype) calls from FORMAT/GT. |
| bcftools convert | Converts VCF/BCF to other formats and back. |
| bcftools csq | Haplotype-aware consequence caller. |
| bcftools filter | Apply fixed-threshold filters. |
| bcftools gtcheck | Check sample identity. With no -g BCF given, multi-sample cross-check is performed. |
| bcftools head | Displays VCF/BCF headers and optionally the first few variant records |
| bcftools index | Index VCF or BCF files for random access. |
| bcftools isec | Create intersections, unions and complements of VCF files. |
| bcftools merge | Merge multiple VCF/BCF files from non-overlapping sample sets to create one multi-sample file. Note that only records from different files can be merged,  never from the same file. |
| bcftools mpileup | Generate VCF or BCF containing genotype likelihoods for one or multiple BAM files |
| bcftools norm | Left-align and normalize indels; check if REF alleles match the reference;  split multiallelic sites into multiple rows; recover multiallelics from  multiple rows. |
| bcftools plugin | Run user defined plugin |
| bcftools polysomy | Detect number of chromosomal copies from Illumina's B-allele frequency (BAF) |
| bcftools query | Extracts fields from VCF/BCF file and prints them in user-defined format |
| bcftools reheader | Modify header of VCF/BCF files, change sample names. |
| bcftools roh | HMM model for detecting runs of autozygosity. |
| bcftools sort | Sort VCF/BCF file. |
| bcftools stats | Parses VCF or BCF and produces stats which can be plotted using plot-vcfstats. When two files are given, the program generates separate stats for intersection and the complements. |
| bcftools view | VCF/BCF conversion, view, subset and filter VCF/BCF files. |

## Reference documentation

- [BCFtools HOWTOs](./references/github_com_samtools_bcftools_wiki_HOWTOs.md)
- [BCFtools Release Tags and Changes](./references/github_com_samtools_bcftools_tags.md)
- [BCFtools Documentation Overview](./references/samtools_github_io_bcftools.md)