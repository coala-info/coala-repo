---
name: bcftools
description: Index bgzip compressed VCF/BCF files for random access.
homepage: https://github.com/samtools/bcftools
---

# bcftools

## Overview
BCFtools is the industry-standard suite for handling Variant Call Format (VCF) and Binary Variant Call Format (BCF) files. It provides high-performance utilities for the entire variant processing pipeline—from initial calling and normalization to complex filtering and data extraction. It works transparently with both text-based VCFs and binary BCFs, supporting streaming via pipes and indexed random access for large-scale genomic datasets.

## Core CLI Patterns and Best Practices

### Efficient Piping and File Formats
For multi-step workflows, use uncompressed BCF (`-Ou`) for intermediate pipes to maximize speed and minimize CPU overhead from compression/decompression.
*   **Output uncompressed BCF:** `bcftools <command> -Ou -o output.bcf`
*   **Output compressed BCF (default/preferred for storage):** `bcftools <command> -Ob -o output.bcf.gz`
*   **Output compressed VCF:** `bcftools <command> -Oz -o output.vcf.gz`

### Filtering with Expressions
Use `-i` (include) and `-e` (exclude) to filter variants based on INFO or FORMAT tags.
*   **Filter by Quality and Depth:** `bcftools view -i 'QUAL>30 && INFO/DP>10' in.vcf.gz`
*   **Handle Missing Values:** Use regex to target or avoid missing data.
    *   Exclude missing: `-e 'TAG="."'`
    *   Negation of missing: `-i 'TAG!~"\."'`
*   **Sample-specific filters:** Use `SMPL_` or `FMT/` prefixes.
    *   `bcftools view -i 'FMT/GQ>20' in.vcf.gz`

### Normalization and Multiallelic Sites
Always normalize variants before merging or comparing datasets to ensure consistent representation of indels.
*   **Left-align and normalize:** `bcftools norm -f reference.fa in.vcf.gz`
*   **Split multiallelic sites:** `bcftools norm -m -any in.vcf.gz`
*   **Join biallelic sites into multiallelic:** `bcftools norm -m +any in.vcf.gz`

### Data Extraction with Query
The `query` command is the most efficient way to convert VCF data into TSV or custom text formats.
*   **Extract specific fields:** `bcftools query -f '%CHROM\t%POS\t%REF\t%ALT[\t%GT]\n' in.vcf.gz`
*   **Using functions in query:** You can use functions like `SUM`, `MAX`, or `sCOUNT` (sample count).
    *   `bcftools query -f '%CHROM:%POS \t %SUM(FMT/AD)\n' in.vcf.gz`

### Merging and Concatenating
*   **Merge (different samples):** Combines files with different sample sets into a single multisample VCF. Requires indexed files.
    *   `bcftools merge file1.vcf.gz file2.vcf.gz -o merged.vcf.gz`
*   **Concat (same samples):** Joins files containing different genomic regions (e.g., different chromosomes) for the same samples.
    *   `bcftools concat file_chr1.vcf.gz file_chr2.vcf.gz -o all_chrs.vcf.gz`

### Annotation
Add or modify tags using external tab-delimited files.
*   **Basic annotation:** `bcftools annotate -a annotations.tsv.gz -c CHROM,POS,REF,ALT,INFO/TAG in.vcf.gz`
*   **Rename samples:** `bcftools reheader -s samples.txt -o out.vcf.gz in.vcf.gz`

## Expert Tips
*   **Unlimited Depth:** When running `mpileup`, use `-d 0` to set the maximum depth to unlimited, which is critical for high-depth sequencing or amplicon data.
*   **Index First:** Most BCFtools commands that involve random access or merging require the input files to be indexed (`bcftools index file.vcf.gz`).
*   **Plugin Power:** Use the `+` syntax to access plugins for specialized tasks.
    *   `bcftools +fill-tags`: Automatically calculates and adds common INFO tags like AF, AC, and HWE.
    *   `bcftools +split-vep`: Parses complex VEP (Variant Effect Predictor) strings into individual tags.

## Reference documentation
- [BCFtools Overview and Installation](./references/anaconda_org_channels_bioconda_packages_bcftools_overview.md)
- [BCFtools GitHub Repository and Documentation](./references/github_com_samtools_bcftools.md)
- [BCFtools Release Tags and Version History](./references/github_com_samtools_bcftools_tags.md)