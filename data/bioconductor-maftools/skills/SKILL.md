---
name: bioconductor-maftools
description: Bioconductor-maftools provides comprehensive analysis and visualization of Mutation Annotation Format files from cancer genomics studies. Use when user asks to read, summarize, and visualize somatic variants, perform copy-number analysis, extract mutational signatures, or conduct clinical enrichment and survival analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/maftools.html
---

# bioconductor-maftools

name: bioconductor-maftools
description: Comprehensive analysis and visualization of Mutation Annotation Format (MAF) files from cancer genomics studies. Use this skill to read, summarize, and visualize somatic variants, perform copy-number analysis, extract mutational signatures, and conduct clinical enrichment or survival analysis using the maftools R package.

# bioconductor-maftools

## Overview
The `maftools` package is a versatile Bioconductor tool designed to process Mutation Annotation Format (MAF) files, commonly used in large-scale cancer studies like TCGA. It provides an efficient workflow for summarizing somatic variants and generating publication-quality visualizations (oncoplots, lollipop plots, rainfall plots) without requiring complex data manipulation. Beyond visualization, it supports advanced statistical analyses including mutational signature extraction, detecting mutually exclusive mutations, and identifying cancer driver genes.

## Core Workflow

### 1. Loading Data
The primary entry point is the `read.maf` function, which creates a centralized MAF object.

```r
library(maftools)

# Required: MAF file. Optional: Clinical data and Copy Number data.
laml.maf <- system.file('extdata', 'tcga_laml.maf.gz', package = 'maftools')
laml.clin <- system.file('extdata', 'tcga_laml_annot.tsv', package = 'maftools')

# Load the data
laml <- read.maf(maf = laml.maf, clinicalData = laml.clin)

# Access summaries
getSampleSummary(laml)
getGeneSummary(laml)
getClinicalData(laml)
```

### 2. Essential Visualizations
Once the MAF object is created, use these functions for rapid data exploration:

*   **Summary Plot**: `plotmafSummary(maf = laml)` - Displays variant classifications and mutation load.
*   **Oncoplots (Waterfall)**: `oncoplot(maf = laml, top = 10)` - Visualizes the mutation matrix for top genes.
*   **Lollipop Plots**: `lollipopPlot(maf = laml, gene = 'DNMT3A', AACol = 'Protein_Change')` - Shows mutation distribution along protein domains.
*   **Rainfall Plots**: `rainfallPlot(maf = brca)` - Visualizes hypermutated regions (Kataegis).
*   **VAF Distribution**: `plotVaf(maf = laml, vafCol = 'i_TumorVAF_WU')` - Inspects variant allele frequencies.

### 3. Statistical Analysis
*   **Somatic Interactions**: `somaticInteractions(maf = laml, top = 25)` - Performs Fisher's exact test to find co-occurring or mutually exclusive gene pairs.
*   **Driver Gene Detection**: `oncodrive(maf = laml, AACol = 'Protein_Change')` - Identifies drivers based on positional clustering (OncodriveCLUST).
*   **Survival Analysis**: `mafSurvival(maf = laml, genes = 'DNMT3A', time = 'days_to_last_followup', Status = 'Overall_Survival_Status')`.
*   **Cohort Comparison**: `mafCompare(m1 = primary, m2 = relapse)` - Identifies differentially mutated genes between two groups.

### 4. Mutational Signatures
Extract mutational signatures to understand underlying carcinogenic processes:

```r
# 1. Create trinucleotide matrix (requires BSgenome)
library(BSgenome.Hsapiens.UCSC.hg19)
tnm <- trinucleotideMatrix(maf = laml, ref_genome = "BSgenome.Hsapiens.UCSC.hg19")

# 2. Estimate optimal number of signatures
sign_est <- estimateSignatures(mat = tnm, nTry = 6)
plotCophenetic(sign_est)

# 3. Extract and compare to COSMIC
extracted <- extractSignatures(mat = tnm, n = 3)
comparison <- compareSignatures(nmfRes = extracted, sig_db = "SBS")
plotSignatures(extracted)
```

### 5. Copy Number Analysis
`maftools` can process GISTIC2.0 output or raw segmentation files:
*   **GISTIC**: `readGistic(gisticDir = "path/to/gistic_results")` followed by `gisticOncoPlot()` or `gisticChromPlot()`.
*   **ASCAT/BAM**: Use `gtMarkers()` and `prepAscat()` to prepare files for Allele-specific Copy Number Analysis.
*   **Mosdepth**: Use `plotMosdepth()` to visualize coverage-based CNV from BED files.

## Tips for Success
*   **Field Names**: Ensure your MAF has the mandatory columns: `Hugo_Symbol`, `Chromosome`, `Start_Position`, `End_Position`, `Reference_Allele`, `Tumor_Seq_Allele2`, `Variant_Classification`, `Variant_Type`, and `Tumor_Sample_Barcode`.
*   **Amino Acid Changes**: If `lollipopPlot` fails to find protein changes, check your column names and specify them using the `AACol` argument.
*   **TCGA Data**: Use `tcgaLoad(study = "LAML")` to quickly pull curated TCGA datasets directly into your session.
*   **Subsetting**: Use `subsetMaf(maf = laml, query = "Variant_Classification == 'Splice_Site'")` to create filtered MAF objects for specific analyses.

## Reference documentation
- [Summarize, Analyze, and Visualize MAF Files](./references/maftools.md)
- [Customizing Oncoplots](./references/oncoplots.md)
- [Copy Number Analysis](./references/cnv_analysis.md)
- [Personalized Cancer Report and Hotspots](./references/cancer_hotspots.md)