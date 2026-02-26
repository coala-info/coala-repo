---
name: bioconductor-appreci8r
description: This tool filters and classifies SNVs and short indels by integrating results from multiple variant calling tools using the appreci8 algorithm. Use when user asks to combine outputs from multiple variant callers, normalize and annotate variants, or filter and classify SNVs and short indels.
homepage: https://bioconductor.org/packages/release/bioc/html/appreci8R.html
---


# bioconductor-appreci8r

name: bioconductor-appreci8r
description: Expert guidance for the appreci8R Bioconductor package to filter SNVs and short indels. Use this skill when you need to combine outputs from multiple variant calling tools (GATK, VarScan, etc.), normalize variants, annotate them, and apply the 'appreci8' algorithm to classify calls as "probably true", "polymorphism", or "artifact".

# bioconductor-appreci8r

## Overview
The `appreci8R` package implements the "appreci8" algorithm for high-sensitivity and high-PPV variant filtering. It is designed to integrate results from an unlimited number of variant callers (e.g., GATK, VarScan, FreeBayes) and perform a multi-step filtration process. **Note: Currently, only hg19 is supported.**

## Workflow and Key Functions

### 1. Target Filtration (`filterTarget`)
Reads VCF or TXT files and excludes off-target calls based on a BED file or GRanges object.
```r
target <- data.frame(chr = c("2", "17"), start = c(25469500, 7579470), end = c(25469510, 7579475))
# Returns a list of data.frames (one per sample)
on_target <- filterTarget(output_folder = "", caller_name = "GATK", 
                          caller_folder = "path/to/vcf", 
                          caller_file_names_add = ".raw", 
                          caller_file_type = ".vcf", 
                          targetRegions = target)
```

### 2. Normalization (`normalize`)
Standardizes indels, MNVs, and multiple alternate alleles.
```r
# caller_indels_pm: TRUE if deletions use "-" and insertions use "+"
# caller_mnvs: TRUE if MNVs (e.g., CA > GT) should be split
norm_calls <- normalize(output_folder = "", caller_name = "GATK", 
                        target_calls = on_target, 
                        caller_indels_pm = FALSE, caller_mnvs = TRUE)
```

### 3. Annotation (`annotate`)
Annotates variants using `VariantAnnotation` and filters by location and consequence.
```r
annotated <- annotate(output_folder = "", caller_name = "GATK", 
                      normalized_calls = norm_calls,
                      locations = c("coding", "spliceSite"),
                      consequences = c("nonsynonymous", "frameshift", "nonsense"))
```

### 4. Output Combination (`combineOutput`)
Merges results from different callers into a single GRanges object.
```r
# annotated_list is a GRangesList where each element is the output of annotate() for a specific caller
combined <- combineOutput(output_folder = "", 
                          caller_names = c("GATK", "VarScan"), 
                          annotated_calls = annotated_list)
```

### 5. Coverage and Base Quality (`evaluateCovAndBQ`)
Uses BAM files to verify depth (DP), variant allele frequency (VAF), and base quality (BQ).
```r
filtered <- evaluateCovAndBQ(output_folder = "", combined_calls = combined, 
                             bam_folder = "path/to/bams", 
                             dp = 50, nr_alt = 20, vaf = 0.01, bq = 15)
```

### 6. Characteristics Determination (`determineCharacteristics`)
Queries databases (dbSNP, 1000G, ExAC, COSMIC, ClinVar) and predicts impact (SIFT, Provean, or PolyPhen2).
```r
char_calls <- determineCharacteristics(output_folder = "", frequency_calls = filtered,
                                       predict = "Provean", dbSNP = TRUE, cosmicDB = TRUE)
```

### 7. Final Filtration (`finalFiltration`)
The core "appreci8" step. It calculates artifact and polymorphism scores to categorize variants.
```r
final_results <- finalFiltration(output_folder = "results", 
                                 frequency_calls = filtered,
                                 database_calls = char_calls,
                                 combined_calls = combined,
                                 overlapTools = c("VarScan", "GATK"),
                                 vaf = 0.01, artifactThreshold = 0)
```

## GUI Mode
For an interactive experience, use the Shiny interface:
```r
appreci8Rshiny()
```

## Tips for Success
- **Sample Naming**: Ensure BAM file names match the sample names derived from the VCF/TXT files.
- **Checkpoints**: When using the GUI, you can restart from specific steps (checkpoints) if the analysis is interrupted.
- **Hotspots**: Provide a hotspot data.frame to `finalFiltration` to prevent known clinical variants from being filtered as artifacts.
- **Strand Bias**: The package automatically performs Fisher's Exact Test on forward/reverse reads during the final filtration step.

## Reference documentation
- [appreci8R – an R/Bioconductor package for filtering SNVs and short indels](./references/appreci8R.md)