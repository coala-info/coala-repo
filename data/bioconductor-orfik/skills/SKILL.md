---
name: bioconductor-orfik
description: ORFik is an R package for the comprehensive analysis of transcript and translation features using NGS data such as Ribo-seq and RNA-seq. Use when user asks to manage genomic annotations, perform P-site shifting, calculate translation efficiency, or conduct quality control and differential translation analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/ORFik.html
---


# bioconductor-orfik

name: bioconductor-orfik
description: Analysis of transcript and translation features using NGS data (Ribo-seq, RNA-seq, CAGE, etc.). Use this skill to manage genomic annotations, align sequencing reads using STAR, perform P-site shifting for Ribo-seq, and conduct quality control and differential translation analysis within the ORFik framework.

# bioconductor-orfik

## Overview
ORFik is a comprehensive R package designed for the analysis of protein synthesis and transcript features. It provides a unified API (the "ORFik experiment") to manage multiple NGS libraries alongside their genomic annotations. It is particularly powerful for Ribo-seq analysis, offering specialized tools for P-site shifting, ORF discovery, and translation efficiency calculations.

## Core Workflows

### 1. Project Configuration and Organization
ORFik uses a standardized directory structure to manage raw data, processed files, and annotations.
```r
library(ORFik)

# Set up global paths (run once)
config.save(config_file(), 
            fastq.dir = "~/bio_data/raw", 
            bam.dir = "~/bio_data/processed", 
            reference.dir = "~/bio_data/refs")

# Define a specific experiment configuration
conf <- config.exper(experiment = "MyStudy", assembly = "hg38", type = "Ribo-seq")
```

### 2. Annotation and Genome Management
Use `getGenomeAndAnnotation` to download and prepare references. It automatically creates a `TxDb` and fasta index.
```r
annotation <- getGenomeAndAnnotation(
  organism = "Homo sapiens",
  output.dir = conf["ref"],
  assembly_type = "primary_assembly",
  optimize = TRUE,
  phix = TRUE, rRNA = TRUE # Optional contaminant removal
)

# Load specific regions
txdb <- loadTxdb(annotation["gtf"])
cds <- loadRegion(txdb, "cds")
leaders <- loadRegion(txdb, "leaders")
```

### 3. The ORFik Experiment (ORFikExperiment)
The `ORFikExperiment` object is the central hub for multi-library analysis.
```r
# Create experiment from a folder of BAM files
df <- create.experiment(
  dir = "~/bio_data/processed/MyStudy/aligned/",
  exper = "MyStudy_Ribo",
  txdb = annotation["gtf"],
  fa = annotation["genome"],
  organism = "Homo sapiens"
)

# Load all libraries into the global environment
outputLibs(df, type = "ofst") # 'ofst' is the fastest format
```

### 4. Ribo-seq Specific Processing
For Ribo-seq, you must determine the P-site offset (the distance from the 5' end of the read to the P-site).
```r
# Calculate and apply P-site shifts
shifts <- detectRibosomeShifts(df, readLength = 26:32)
shiftFootprintsByExperiment(df, shifts = shifts)

# Load shifted libraries
outputLibs(df, type = "pshifted")
```

### 5. Quality Control and Quantification
Generate comprehensive reports and count tables.
```r
# Run full QC (generates plots, count tables, and stats)
QCreport(df)

# Get FPKM values for CDS regions
cds_counts <- countTable(df, region = "cds", type = "fpkm")

# Calculate Translation Efficiency (TE)
# Requires both RNA and Ribo experiments
te_table <- translationEfficiency(df_ribo, df_rna)
```

## Tips for Efficiency
- **File Formats**: Always convert BAM files to `.ofst` using `convertLibs(df, type = "ofst")`. This reduces loading time from minutes to seconds.
- **Filtering**: Use `filterTranscripts(txdb, minCDS = 150)` to remove short or non-coding transcripts before analysis to reduce noise.
- **Random Access**: For viewing specific genomic windows without loading full libraries, use `coveragePerTiling` with BigWig files.
- **Pseudo-UTRs**: If your annotation lacks 5' UTRs, use `pseudo_5UTRS_if_needed = 100` in `getGenomeAndAnnotation` to generate 100nt pseudo-leaders.

## Reference documentation
- [Annotation & Alignment](./references/Annotation_Alignment.md)
- [Importing data](./references/Importing_Data.md)
- [Data management](./references/ORFikExperiment.md)
- [ORFik Overview](./references/ORFikOverview.md)
- [Ribo-seq pipeline human](./references/Ribo-seq_pipeline-human.md)
- [Ribo-seq pipeline yeast](./references/Ribo-seq_pipeline-yeast.md)
- [Working with transcripts](./references/Working_with_transcripts.md)