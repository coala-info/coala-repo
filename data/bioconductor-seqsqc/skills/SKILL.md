---
name: bioconductor-seqsqc
description: This tool performs sample-level quality control for next-generation sequencing data to identify problematic samples in VCF files. Use when user asks to identify missing rates, sex mismatches, contamination, cryptic relatedness, or population outliers in genomic datasets.
homepage: https://bioconductor.org/packages/release/bioc/html/SeqSQC.html
---


# bioconductor-seqsqc

name: bioconductor-seqsqc
description: Sample-level quality control (QC) for Next-Generation Sequencing (NGS) data using the SeqSQC Bioconductor package. Use this skill to identify problematic samples in VCF files, including high missing rates, sex mismatches, contamination (inbreeding), cryptic relatedness (IBD), and population outliers.

## Overview

SeqSQC provides an automated pipeline for sample-level quality control of NGS data (WGS or WES). It integrates study samples with a benchmark dataset from the 1000 Genomes Project, making it effective even for small study cohorts. The package identifies five types of problematic samples:
1. **Missing Rate**: Samples with low call rates.
2. **Sex Check**: Discordance between reported and genetic sex (X-chromosome inbreeding).
3. **Inbreeding**: Abnormal inbreeding coefficients (potential contamination).
4. **IBD (Identity-by-Descent)**: Cryptic relatedness or duplicated samples.
5. **Population Outliers**: Samples with genetic ancestry discordant from reported population.

## Data Preparation

### Input Requirements
- **VCF File**: Variant calls for the study cohort.
- **Sample Annotation**: A data frame or text file with columns: `sample`, `population` (e.g., AFR, EUR, EAS, SAS), `gender` (male/female), and `relation`.
- **Capture Region (Optional)**: A BED file for WES data to restrict analysis to targeted regions.

### Loading Data
Use `LoadVfile` to convert VCF data into a `SeqSQC` object, which utilizes the efficient GDS (Genomic Data Structure) format.

```r
library(SeqSQC)

# Define file paths
infile <- "path/to/study.vcf"
sample.annot <- "path/to/annotation.txt"
cr <- "path/to/capture_regions.bed"
outfile <- "output_prefix"

# Create SeqSQC object
seqfile <- LoadVfile(vfile = infile, output = outfile, capture.region = cr, sample.annot = sample.annot)
```

## QC Workflows

### All-in-One Workflow
The `sampleQC` function executes the entire pipeline and generates a report.

```r
# Run full QC pipeline
seqfile <- sampleQC(vfile = seqfile, output = "QC_results", QCreport = TRUE)

# View problematic samples
problemList(seqfile)
```

### Step-by-Step Workflow
Individual QC steps can be run sequentially. Problematic samples identified in one step can be passed to the `remove.samples` argument of the next.

1.  **Missing Rate**:
    ```r
    seqfile <- MissingRate(seqfile)
    plotQC(seqfile, QCstep = "MissingRate")
    ```
2.  **Sex Check**:
    ```r
    seqfile <- SexCheck(seqfile)
    plotQC(seqfile, QCstep = "SexCheck")
    ```
3.  **Inbreeding Check**:
    ```r
    seqfile <- Inbreeding(seqfile)
    plotQC(seqfile, QCstep = "Inbreeding")
    ```
4.  **IBD Check**:
    ```r
    seqfile <- IBD(seqfile)
    plotQC(seqfile, QCstep = "IBD")
    ```
5.  **Population Check**:
    ```r
    seqfile <- PCA(seqfile)
    plotQC(seqfile, QCstep = "PCA", interactive = TRUE)
    ```

## Interpreting Results

- **Missing Rate**: Outliers typically have a missing rate > 0.1.
- **Sex Check**: Predicts sex based on X-inbreeding (F < 0.2 for female, F > 0.8 for male).
- **Inbreeding**: Identifies samples > 5 standard deviations from the mean.
- **IBD**: Uses SVM to predict relationships (Unrelated, Parent-Offspring, Full-Sib, etc.). Kinship coefficients ≥ 0.08 are flagged.
- **PCA**: Uses the top 4 principal components to predict population membership.

## Reporting

Generate a comprehensive HTML report with interactive plots:

```r
RenderReport(seqfile, output = "QC_Report.html", interactive = TRUE)
```

## Reference documentation

- [Sample Quality Check for NGS Data using SeqSQC package](./references/vignette.md)
- [Sample Quality Check for Next-Generation Sequencing Data with SeqSQC](./references/vignette.Rmd)