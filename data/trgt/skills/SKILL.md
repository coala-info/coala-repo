---
name: trgt
description: TRGT (Tandem Repeat Genotyping Tool) is a specialized suite designed to characterize tandem repeats using the high accuracy of PacBio HiFi reads.
homepage: https://github.com/PacificBiosciences/trgt
---

# trgt

## Overview

TRGT (Tandem Repeat Genotyping Tool) is a specialized suite designed to characterize tandem repeats using the high accuracy of PacBio HiFi reads. Unlike traditional tools that only estimate repeat length, TRGT profiles the internal sequence composition, identifies mosaicism, and detects CpG methylation within repeat units. Use this skill to navigate the command-line interface for single-sample genotyping, multi-sample merging, and preparing data for visualization.

## Core Workflows and CLI Patterns

### 1. Genotyping Tandem Repeats
The primary command for analyzing a sample. It requires a reference genome, aligned HiFi reads, and a repeat definition catalog.

```bash
trgt genotype \
  --genome reference.fa \
  --reads sample_hifi.bam \
  --repeats human_STRs.bed \
  --output-prefix sample_name
```

**Key Outputs:**
- `sample_name.vcf.gz`: Contains genotypes, motif composition, and methylation stats.
- `sample_name.spanning.bam`: A specialized BAM file containing reads that overlap the target repeats, used for visualization.

### 2. Repeat Catalogs
TRGT is catalog-driven. You must provide a definition file (BED format) specifying the regions and motifs to analyze.
- **STRchive**: Recommended for known pathogenic repeats.
- **Adotto**: Recommended for genome-wide repeat analysis.
- **Custom**: Ensure your BED file includes the `MOTIFS` and `STRUC` info required by TRGT.

### 3. Joint Analysis (Multi-sample)
To compare repeats across a cohort, use the `merge` subcommand to combine individual VCFs.

```bash
trgt merge \
  --genome reference.fa \
  --vcf sample1.vcf.gz \
  --vcf sample2.vcf.gz \
  --output-vcf cohort_merged.vcf.gz
```

For very large cohorts, consider using the **TDB** (formerly TRGTdb) tool to convert VCFs into a queryable database format, which is more efficient than multi-sample VCFs.

### 4. Visualization
TRGT generates a "spanning BAM" that is optimized for viewing repeat structures.
- Use the `spanning.bam` in IGV or specialized plotters.
- The `deepdive` subcommand can be used to extract detailed read-level information for specific loci of interest.

## Expert Tips and Best Practices

- **Methylation**: TRGT automatically utilizes the `Mm` and `Ml` tags in PacBio HiFi BAMs to estimate CpG methylation. Ensure your input BAMs contain these kinetics tags for epigenetic profiling.
- **Mosaicism**: Check the VCF fields for evidence of multiple alleles beyond the expected ploidy, which may indicate somatic mosaicism.
- **Performance**: For genome-wide catalogs, ensure your reference genome is indexed (`.fai`) and your input BAM is indexed (`.bai`).
- **Validation**: Use the `trgt validate` (or check the catalog documentation) to ensure custom repeat definitions are formatted correctly before running large genotyping jobs.

## Reference documentation
- [trgt Overview](./references/github_com_PacificBiosciences_trgt.md)
- [Installation and Versions](./references/anaconda_org_channels_bioconda_packages_trgt_overview.md)