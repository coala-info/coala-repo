---
name: vcflib
description: vcflib is a suite of command-line utilities for high-performance, modular processing and analysis of VCF files. Use when user asks to filter VCF files, remove duplicate variants, normalize indels, realign complex alleles, intersect or compare VCF files, validate VCF files, calculate variant statistics, or identify variants in low-complexity regions.
homepage: https://github.com/vcflib/vcflib
---


# vcflib

## Overview
The `vcflib` suite provides a robust collection of command-line utilities designed for the high-performance processing of Variant Call Format (VCF) files. Unlike monolithic tools, `vcflib` follows the Unix philosophy, offering modular tools that are intended to be chained together via pipes. This allows for memory-efficient, streaming analysis of large genomic datasets. Use this skill to perform tasks ranging from simple filtering and duplicate removal to advanced pangenome-aware variant realignment and complex indel normalization.

## Core CLI Patterns and Best Practices

### Streaming and Piping
Always prefer piping `vcflib` tools to avoid creating massive intermediate files. Most tools read from `stdin` and write to `stdout`.
```bash
vcffilter -f "QUAL > 30" input.vcf | vcfleftalign -r ref.fa | vcfuniq > filtered_normalized.vcf
```

### Normalizing and Realignment
*   **Indel Normalization**: Use `vcfleftalign` to ensure indels are represented at their absolute leftmost position, which is critical for comparing calls from different callers.
*   **Complex Alleles**: For VCFs with overlapping or nested alleles (common in pangenome genotypers), use `vcfwave` to realign sequences using the wavefront algorithm, followed by `vcfcreatemulti` to consolidate records.

### Set Operations with vcfintersect
`vcfintersect` is the primary tool for comparing VCF files.
*   **Intersection**: Find variants present in both files.
    ```bash
    vcfintersect -i file1.vcf file2.vcf
    ```
*   **Union/Difference**: Use `-u` for union or `-v` to find variants in the first file that are NOT in the second.
*   **Bed Intersect**: Use `-b` to filter a VCF against a BED file of genomic regions.

### Filtering and Quality Control
*   **vcffilter**: Use the `-f` flag for INFO field filters and `-g` for genotype-level filters.
    *   Example: `vcffilter -f "DP > 10 & AF > 0.5" data.vcf`
*   **vcfcheck**: Always validate your VCF against the reference genome used for calling to ensure the `REF` column matches the FASTA sequence.
    ```bash
    vcfcheck -f reference.fa input.vcf
    ```

### Statistics and Metrics
*   **Heterozygosity**: Use `vcfhetcount` to get a quick count of alternate alleles in heterozygous genotypes across the entire file.
*   **Sample Metrics**: Use `vcfhethomratio` to generate the heterozygosity/homozygosity ratio for every individual sample in the VCF.
*   **Variant Density**: Use `vcfdistance` to annotate records with the distance to the nearest neighboring variant, useful for identifying clusters.

## Expert Tips
*   **Duplicate Removal**: Use `vcfuniq` on sorted VCF files to remove identical records (same POS, REF, and ALT). If you need to merge genotypes from duplicate records rather than just dropping them, use `vcfcreatemulti`.
*   **Entropy Analysis**: Use `vcfentropy` to identify variants in low-complexity regions. It adds Shannon entropy scores for flanking sequences, which can help filter out potential mapping artifacts.
*   **Memory Efficiency**: Because `vcflib` tools stream, they generally have a low memory footprint. However, tools like `vcfintersect` may require indexed VCFs (using `tabix`) for certain operations to remain efficient.

## Reference documentation
- [vcflib GitHub Overview](./references/github_com_vcflib_vcflib.md)
- [vcflib Bioconda Package](./references/anaconda_org_channels_bioconda_packages_vcflib_overview.md)