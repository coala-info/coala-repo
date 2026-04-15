---
name: bioconductor-vanillaice
description: This tool identifies chromosomal alterations and copy number variants from high-throughput SNP array data using Hidden Markov Models. Use when user asks to detect deletions, duplications, or loss of heterozygosity from B allele frequencies and Log R Ratios.
homepage: https://bioconductor.org/packages/release/bioc/html/VanillaICE.html
---

# bioconductor-vanillaice

name: bioconductor-vanillaice
description: Identify chromosomal alterations and copy number variants (CNVs) from high-throughput SNP array data using Hidden Markov Models (HMM). Use this skill when analyzing B allele frequencies (BAF) and Log R Ratios (LRR) from Illumina or Affymetrix platforms to detect deletions, duplications, and loss of heterozygosity.

## Overview
VanillaICE (Variant Analysis of Illumina and Affymetrix Copy number Estimates) implements a 6-state Hidden Markov Model to infer germline copy number alterations. It is designed to scale to large datasets by using disk-backed storage (via `ArrayViews`) and provides integrated workflows for data preprocessed by the `crlmm` package or raw text exports from software like GenomeStudio.

## Core Workflow

### 1. Data Organization
The package requires marker-level annotation (genomic coordinates) and sample-level summaries (LRR and BAF).

```r
library(VanillaICE)
library(GenomicRanges)

# Create marker annotation
# isSnp is a logical vector indicating polymorphic markers
fgr <- SnpGRanges(GRanges(seqnames=chr, ranges=IRanges(pos, width=1)), isSnp=isSnp)
names(fgr) <- marker_names

# Setup ArrayViews for disk-backed processing
views <- ArrayViews(rowRanges=fgr, sourcePaths=files, parsedPath=tempdir())
```

### 2. Parsing Raw Summaries
If starting from text files (e.g., GenomeStudio Final Reports), use `CopyNumScanParams` to define the file structure.

```r
scan_params <- CopyNumScanParams(
  index_genome = match(names(fgr), dat[["SNP Name"]]),
  cnvar = "Log R Ratio",
  bafvar = "B Allele Freq",
  gtvar = c("Allele1 - AB", "Allele2 - AB")
)

# Parse files to internal .rds format
parseSourceFile(views, scan_params)
```

### 3. Creating a SnpExperiment
Convert the views or existing `crlmm` objects into a `SnpArrayExperiment` for HMM fitting.

```r
# From ArrayViews
snp_exp <- SnpExperiment(views)

# From crlmm CNSet
# library(crlmm)
# snp_exp <- as(cnSet, "SnpArrayExperiment")
```

### 4. Fitting the HMM
The `hmm2` function performs the inference. You can customize emission and transition parameters.

```r
# Define parameters (optional)
param <- EmissionParam(temper = 0.5) # Adjusting sensitivity

# Fit the model
fit <- hmm2(snp_exp, param)
```

### 5. Filtering and Inspection
The HMM results are returned as an `HMMList`. Use `unlist()` to get a `GRanges` object of all segments.

```r
# Define filters
filter_param <- FilterParam(
  min.posterior = 0.99,
  min.markers = 10,
  state = c("1", "2", "5", "6") # Deletions and Duplications
)

# Apply filter
cnvs <- cnvFilter(fit, filter_param)

# Merge adjacent segments of the same state
cnvs_reduced <- reduce(cnvs, min.gapwidth = 500e3)
```

## Visualization
Use `xyplotList` to generate Trellis graphics showing LRR and BAF alongside HMM calls.

```r
trellis_param <- HmmTrellisParam()
figList <- xyplotList(split(cnvs, cnvs$id), snp_exp, trellis_param)
# Display first segment for first sample
print(figList[[1]][[1]])
```

## Tips
- **Parallelization**: `hmm2` supports parallel execution via the `foreach` package. Register a parallel backend (like `doParallel` or `doSNOW`) before running the HMM.
- **Memory Management**: For large cohorts, use the `ArrayViews` infrastructure to avoid loading all LRR/BAF data into RAM simultaneously.
- **Wave Correction**: If genomic waves are present (GC bias), consider using the `ArrayTV` package on the LRR values before HMM fitting.

## Reference documentation
- [VanillaICE](./references/VanillaICE.md)
- [crlmmDownstream](./references/crlmmDownstream.md)