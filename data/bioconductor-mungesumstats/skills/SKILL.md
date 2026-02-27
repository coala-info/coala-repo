---
name: bioconductor-mungesumstats
description: bioconductor-mungesumstats standardizes, cleans, and performs quality control on GWAS summary statistics. Use when user asks to reformat GWAS files, perform allele flipping, filter SNPs based on quality metrics, or prepare summary statistics for downstream tools like LDSC and MAGMA.
homepage: https://bioconductor.org/packages/release/bioc/html/MungeSumstats.html
---


# bioconductor-mungesumstats

name: bioconductor-mungesumstats
description: Standardize, clean, and perform quality control on GWAS summary statistics. Use this skill to convert various GWAS formats (including VCF) into standardized tabular formats, perform allele flipping, filter SNPs based on quality metrics (INFO, FRQ, SE), and prepare data for downstream tools like LDSC or MAGMA.

# bioconductor-mungesumstats

## Overview
`MungeSumstats` is a Bioconductor package designed to solve the lack of standardization in GWAS summary statistics. It automates the process of reformatting disparate GWAS files into a consistent structure while performing rigorous Quality Control (QC). It supports human data (GRCh37/GRCh38) and can infer missing information (like RSIDs or coordinates) using reference genomes.

## Core Workflow: Standardizing Sumstats
The primary function is `format_sumstats()`. It handles file reading, header mapping, and QC in one step.

```r
library(MungeSumstats)

# Basic standardization
reformatted_path <- format_sumstats(
  path = "path/to/gwas_file.txt",
  ref_genome = "GRCh37", # Or "GRCh38"
  save_path = "standardized_gwas.tsv.gz"
)

# Return as an R object instead of saving to disk
sumstats_dt <- format_sumstats(
  path = "path/to/gwas_file.vcf",
  ref_genome = "GRCh38",
  return_data = TRUE,
  return_format = "data.table" # Options: "data.table", "GRanges", "VRanges"
)
```

## Key Features and Parameters
- **Genome Build Inference**: If `ref_genome` is NULL, the package attempts to infer the build from the data.
- **Allele Flipping**: Automatically ensures A1 is the reference allele and A2 is the alternative/effect allele by checking against the reference genome (`allele_flip_check = TRUE`).
- **Filtering**:
  - `INFO_filter`: Drop SNPs below an imputation quality score (default 0.9).
  - `FRQ_filter`: Drop SNPs based on frequency.
  - `rmv_chr`: Remove specific chromosomes (default removes X, Y, and MT).
  - `bi_allelic_filter`: Removes non-biallelic SNPs.
- **Imputation**:
  - `compute_z`: Calculate Z-scores from P-values if missing.
  - `compute_n`: Impute sample size if missing.
- **Output Formats**:
  - `save_format = "ldsc"`: Formats specifically for LD Score Regression (swaps A1/A2 convention to match LDSC).
  - `save_format = "opengwas"`: Formats for IEU OpenGWAS VCF standards.

## Working with OpenGWAS
You can search for and import datasets directly from the IEU OpenGWAS project.

```r
# Search for datasets
meta <- find_sumstats(traits = c("alzheimer"), min_sample_size = 5000)

# Import a specific dataset by ID
# Note: Requires an API token (OPENGWAS_JWT) in .Renviron
imported_files <- import_sumstats(ids = "ieu-a-298", ref_genome = "GRCh37")
```

## Utility Functions
- **Liftover**: Convert coordinates between genome builds.
  ```r
  dt_hg38 <- liftover(sumstats_dt = my_dt, ref_genome = "hg19", convert_ref_genome = "hg38")
  ```
- **Header Standardization**: Only fix column names without running the full QC pipeline.
  ```r
  clean_headers <- standardise_header(sumstats_dt = my_dt)
  ```
- **Check Build**: Quickly identify the genome build of a file.
  ```r
  build <- get_genome_builds(sumstats_list = list(gwas1 = "path/to/file.txt"))
  ```

## Tips for Success
1. **Reference Genomes**: Ensure the required Bioconductor reference packages are installed (e.g., `BSgenome.Hsapiens.NCBI.GRCh38` and `SNPlocs.Hsapiens.dbSNP155.GRCh38`).
2. **Memory/Speed**: Use `nThread` to increase speed via `data.table` multi-threading.
3. **Logging**: Set `log_folder_ind = TRUE` to see exactly which SNPs were filtered out and why.
4. **Z-score Direction**: By default, Z-scores are flipped if alleles are flipped. Ensure your input Z-score matches the effect allele (A2) before processing.

## Reference documentation
- [MungeSumstats: Getting started](./references/MungeSumstats.md)
- [Import GWAS summary statistics from Open GWAS](./references/OpenGWAS.md)
- [Docker/Singularity Containers](./references/docker.md)