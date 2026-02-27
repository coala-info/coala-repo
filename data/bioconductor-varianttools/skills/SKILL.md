---
name: bioconductor-varianttools
description: This tool detects, filters, and analyzes genetic variants such as SNVs and indels from high-throughput sequencing data within the R environment. Use when user asks to tally variants from BAM files, perform quality assessment on tallies, call single-sample variants, or identify sample-specific somatic mutations.
homepage: https://bioconductor.org/packages/release/bioc/html/VariantTools.html
---


# bioconductor-varianttools

name: bioconductor-varianttools
description: Tools for detecting, filtering, and analyzing genetic variants (SNVs and indels) from high-throughput sequencing data in R. Use this skill when you need to perform variant calling, quality assessment, or compare variants across samples using Bioconductor.

## Overview
The `VariantTools` package provides a set of tools for calling, filtering, and analyzing genetic variants (single nucleotide variants and indels) from high-throughput sequencing data. It relies on the `VRanges` class (an extension of `GRanges`) to store variant information, providing a more flexible alternative to the VCF format for in-memory analysis. The package integrates closely with `gmapR` for alignment and `VariantAnnotation` for VCF export.

## Core Workflow: Calling Single-Sample Variants

The standard workflow for calling variants from a BAM file involves three main steps: tallying, quality assessment, and calling.

### 1. Tallying Variants
The first step is to generate per-nucleotide counts (a "tally") from a BAM file. This is done using `tallyVariants`.

```R
library(VariantTools)

# Define parameters for tallying
# Requires a GmapGenome object (usually created via gmapR)
tally.param <- TallyVariantsParam(gmapR::TP53Genome(), 
                                 high_base_quality = 23L,
                                 indels = TRUE)

# Generate tallies from a BAM file
tallies <- tallyVariants(bam_file_path, tally.param)
```

### 2. Quality Assessment (QA)
Before calling variants, you can annotate the tallies with quality filters (e.g., strand bias, distance from read ends) using `qaVariants`. This adds metadata to the `softFilterMatrix`.

```R
# Apply QA filters (adds metadata, doesn't remove records)
qa.variants <- qaVariants(tallies)

# View summary of filter results
summary(softFilterMatrix(qa.variants))
```

### 3. Calling Variants
The `callVariants` function uses a binomial likelihood ratio test to determine which tallies represent true variants.

```R
# Call variants from the QA-filtered tallies
called.variants <- callVariants(qa.variants)

# Alternatively, call directly from BAM (combines steps)
called.variants <- callVariants(bam_file_path, tally.param)
```

### 4. Post-Filtering
Use `postFilterVariants` to remove variants that are likely artifacts, such as those clustered too closely together.

```R
# Remove clustered variants
final.variants <- postFilterVariants(called.variants)
```

## Comparing Samples (Somatic Mutations)

To find variants specific to a "case" sample (e.g., tumor) relative to a "control" (e.g., normal), use `callSampleSpecificVariants`.

```R
# Call somatic/sample-specific variants
somatic_variants <- callSampleSpecificVariants(case_bam, control_bam, tally.param)

# Or using pre-computed tallies/calls
somatic_variants <- callSampleSpecificVariants(called.variants_case, 
                                               tallies_control, 
                                               control_coverage)
```

## Working with VRanges
The `VRanges` object is the primary data structure in `VariantTools`. It behaves like a `GRanges` object but includes specific columns for `ref`, `alt`, `totalDepth`, `refDepth`, and `altDepth`.

- **Subsetting**: Use standard `GRanges` subsetting or `subsetByOverlaps`.
- **Filtering**: Use `subsetByFilter` with `VariantQAFilters()` or `VariantCallingFilters()`.

## Exporting to VCF
To share results with other tools, convert the `VRanges` object to a `VCF` object and write it to a file.

```R
# Prepare for VCF export
sampleNames(called.variants) <- "SampleID"
mcols(called.variants) <- NULL # Optional: clear metadata for cleaner VCF
vcf_obj <- asVCF(called.variants)

# Write to file
library(VariantAnnotation)
writeVcf(vcf_obj, "output.vcf")
```

## Finding Wildtype Regions
To determine if a region is truly wildtype (vs. simply having insufficient coverage to call a variant), use `callWildtype`.

```R
# Returns TRUE (wildtype), FALSE (variant), or NA (no-call)
is_wildtype <- callWildtype(bam_file, called.variants, VariantCallingFilters(), 
                            pos = target_ranges, power = 0.85)
```

## Reference documentation
- [An Introduction to VariantTools](./references/VariantTools.md)
- [VariantTools Tutorial](./references/tutorial.md)