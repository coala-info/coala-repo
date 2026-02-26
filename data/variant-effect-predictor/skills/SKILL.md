---
name: variant-effect-predictor
description: The Ensembl Variant Effect Predictor determines the functional impact of genetic variation. Use when user asks to predict variant consequences, annotate genetic variants, filter variant consequences, analyze phased haplotypes, or translate variant identifiers.
homepage: https://github.com/Ensembl/ensembl-vep
---


# variant-effect-predictor

## Overview

The Ensembl Variant Effect Predictor (VEP) is the industry-standard tool for determining the functional impact of genetic variation. It maps variants onto genomic features (transcripts, regulatory regions, etc.) to predict consequences such as missense mutations, frameshifts, or splice-site disruptions. Beyond simple consequence prediction, the suite includes specialized tools like `haplo` for phased haplotype analysis and `variant_recoder` for translating between different variant identifiers (e.g., HGVS to genomic coordinates).

## Core CLI Usage Patterns

### Basic Annotation
The most common usage involves taking a VCF input and producing a tab-delimited or VCF output.
```bash
# Standard offline run using a local cache
./vep -i input.vcf -o output.txt --offline --cache

# Output in VCF format with specific annotations
./vep -i input.vcf --vcf --hgvs --symbol --biotype -o annotated.vcf
```

### Filtering Results
Instead of filtering during the VEP run (which can be buggy for insertions/deletions), use the `filter_vep` script on the output.
```bash
# Filter for variants with a specific consequence
./filter_vep -i output.txt -filter "Consequence is missense_variant" -o filtered_output.txt
```

### Haplotype Analysis (Haplosaurus)
Use `haplo` when working with phased genotype data to predict the combined effect of multiple variants on a single transcript.
```bash
./haplo -i phased_input.vcf -o haplotype_output.txt --cache
```

### Variant Recoding
Translate variant descriptions between different formats (e.g., converting HGVS strings to genomic coordinates).
```bash
./variant_recoder -i "HGNC:BRAF:p.Val600Glu" --species human
```

## Expert Tips and Best Practices

- **Performance**: Always prefer `--offline` mode with a pre-downloaded cache. Database connections (`--database`) are significantly slower and can be throttled.
- **Multi-allelic Variants**: VEP does not minimize alleles by default. For the most accurate HGVS and CDS positioning, separate multi-allelic variants into individual lines before processing.
- **Known Bug - HGVS & Stats**: Avoid combining `--hgvs` and `--no_stats` when processing multi-allelic variants, as this can lead to incorrect coordinate reporting or crashes.
- **Parallelization**: Use `--fork [num_threads]` to speed up processing. However, do **not** use `--fork` in conjunction with `--merged` if you require consistent HGNC ID retrieval, as internal caching can cause discrepancies.
- **Memory Management**: For very large VCFs, use the `--buffer_size` flag to control the number of variants read into memory at once (default is 5000).
- **3' Prime Shifting**: Use `--shift_3prime 1` to shift variants to the 3' end of the transcript, which is standard for HGVS nomenclature, but be aware this may not apply to non-coding transcripts in current versions.

## Reference documentation
- [Ensembl VEP Main Documentation](./references/github_com_Ensembl_ensembl-vep.md)
- [Known Bugs and Workarounds](./references/github_com_Ensembl_ensembl-vep.md)
- [Recent Feature Updates (Release 115)](./references/github_com_Ensembl_ensembl-vep_commits_release_115.md)