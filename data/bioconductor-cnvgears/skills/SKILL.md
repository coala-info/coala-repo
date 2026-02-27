---
name: bioconductor-cnvgears
description: CNVgears provides a framework for integrating, filtering, and analyzing copy number variation results from multiple calling algorithms, with a focus on family-based cohorts. Use when user asks to load PED files, filter CNV calls, detect de novo or inherited patterns, merge inter-method results, or compute consensus CNV regions.
homepage: https://bioconductor.org/packages/3.13/bioc/html/CNVgears.html
---


# bioconductor-cnvgears

name: bioconductor-cnvgears
description: Analysis of Copy Number Variation (CNV) calling and segmentation results, particularly for human family-based cohorts. Use this skill to load PED files and marker data, pre-process and filter CNV calls from multiple algorithms (e.g., PennCNV, QuantiSNP), detect inheritance patterns (de novo vs. inherited), merge inter-method results, and compute CNV regions (CNVRs).

# bioconductor-cnvgears

## Overview
CNVgears provides an extensible framework for integrating and analyzing CNV calling results from various pipelines (SNP arrays or NGS). It is optimized for family-based studies (trios/quads) but supports general cohort analysis. The package leverages `data.table` for high-performance processing of large genomic datasets and provides tools for filtering, inheritance detection, and inter-method consensus merging.

## Typical Workflow

### 1. Data Loading
Load cohort metadata (PED format) and marker locations (SNP positions or NGS intervals).

```r
library(CNVgears)

# Load cohort metadata
cohort <- read_metadt(DT_path = "path/to/cohort.ped",
                      sample_ID_col = "Individual ID", 
                      fam_ID_col = "Family ID",
                      sex_col = "Gender", role_col = "Role")

# Load marker locations (e.g., SNP PFB file)
SNP_markers <- read_finalreport_snps("path/to/SNP.pfb",
                                     mark_ID_col = "Name", 
                                     chr_col = "Chr", 
                                     pos_col = "Position")
```

### 2. Importing CNV Results
Import results from different callers. Use `read_results` for standard formats or `cnmops_to_CNVresults` for `cn.mops` output.

```r
penn <- read_results(DT_path = "penn_cnvs.txt", 
                     res_type = "file", DT_type = "TSV/CSV",
                     chr_col = "chr", start_col = "posStart", 
                     end_col = "posEnd", CN_col = "CN", 
                     samp_ID_col = "Sample_ID", 
                     sample_list = cohort, 
                     markers = SNP_markers, 
                     method_ID = "P")
```

### 3. Exploration and Filtering
Generate summary statistics to identify over-segmented samples and apply filters based on length or number of markers (NP).

```r
# Summary stats
stats <- summary(object = penn, sample_list = cohort, markers = SNP_markers)

# Filter: min length 10kb, min 10 markers
penn_filt <- cleaning_filter(results = penn, min_len = 10000, min_NP = 10)

# Optional: Filter by blacklists (telomeres/centromeres)
hg19telom <- telom_centrom(hg19_start_end_centromeres, centrom = FALSE)
# Use data.table syntax to filter results against these regions
```

### 4. Inheritance Detection
Identify *de novo* candidates by comparing offspring calls against parental raw data (Log2R/CopyRatio). Requires raw data processed into RDS format via `read_finalreport_raw`.

```r
# Detect inheritance (requires raw_path to RDS files)
penn_inh <- cnvs_inheritance(results = penn_filt, 
                             sample_list = cohort, 
                             markers = SNP_markers, 
                             raw_path = "path/to/RDS_dir")

# Extract de novo events
de_novo <- penn_inh[inheritance == "denovo", ]
```

### 5. Inter-Method Merging and CNVRs
Combine results from multiple callers to find consensus calls and define CNV Regions (CNVRs).

```r
# Merge results from multiple methods (e.g., Penn, Quanti, IPattern)
merged_res <- inter_res_merge(res_list = list(penn_filt, quanti_filt, ipn_filt),
                              sample_list = cohort, 
                              chr_arms = hg19_chr_arms)

# Compute CNV Regions (CNVRs)
cnvrs <- cnvrs_create(cnvs = merged_res, chr_arms = hg19_chr_arms)
```

## Key Functions and Tips
- **Parallelization**: Set threads using `data.table::setDTthreads(n)`. Optimal performance is usually between 4 and 8 threads.
- **Annotation**: Use `genic_load(DT_in, mart)` to annotate CNVs with genes (requires `biomaRt`). Use `genomic_locus()` for cytogenetic bands.
- **Visualization**: Use `lrr_trio_plot()` to visually inspect *de novo* candidates alongside parental Log2R signals.
- **Data Export**: Since objects are `data.table` based, use `fwrite(df, "file.tsv", sep="\t")` for export. Use `CNVresults_to_GRanges()` to interface with other Bioconductor packages.

## Reference documentation
- [CNVgears package](./references/CNVgears.md)
- [CNVgears Vignette](./references/CNVgears.Rmd)