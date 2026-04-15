---
name: bioconductor-rcas
description: The RNA Centric Annotation System (RCAS) provides functional analysis and annotation of transcriptome-wide regions of interest such as CLIP-seq peaks or RNA modifications. Use when user asks to perform overlap analysis with genomic features, discover motifs, conduct functional enrichment, or generate meta-analysis reports across multiple samples.
homepage: https://bioconductor.org/packages/release/bioc/html/RCAS.html
---

# bioconductor-rcas

name: bioconductor-rcas
description: RNA Centric Annotation System (RCAS) for functional analysis and annotation of transcriptome-wide regions of interest (e.g., CLIP-seq peaks, RNA modifications). Use this skill to perform overlap analysis with genomic features, motif discovery, functional enrichment, and meta-analysis across multiple samples.

# bioconductor-rcas

## Overview
RCAS is an R/Bioconductor package designed for the functional analysis of RNA-binding sites or any genomic coordinates at the transcriptome level. It integrates transcript-feature distribution (exons, introns, UTRs), motif discovery, and functional enrichment (GO/KEGG) into automated reports. It supports both single-sample analysis and multi-sample meta-analysis using an SQLite-based workflow.

## Core Workflows

### Single Sample Analysis
The primary entry point for a single sample is `runReport()`, which generates a comprehensive HTML document.

```r
library(RCAS)

# Import data
queryRegions <- importBed(filePath = "peaks.bed", sampleN = 10000)
gff <- importGtf(filePath = "annotation.gtf")

# Generate full report
runReport(queryFilePath = "peaks.bed", 
          gffFilePath = "annotation.gtf", 
          genomeVersion = "hg19",
          outFile = "RCAS_report.html")
```

### Manual Analysis Steps
If you need to perform specific analyses without the full report:

1.  **Feature Overlaps**:
    ```r
    # Extract features from GTF
    txdbFeatures <- getTxdbFeaturesFromGRanges(gff)
    
    # Summarize distribution
    summary <- summarizeQueryRegions(queryRegions = queryRegions, txdbFeatures = txdbFeatures)
    
    # Get gene-centric table
    geneTable <- getTargetedGenesTable(queryRegions = queryRegions, txdbFeatures = txdbFeatures)
    ```

2.  **Coverage Profiling**:
    ```r
    # Profile across feature boundaries (e.g., TSS/TES)
    cvg <- getFeatureBoundaryCoverage(queryRegions = queryRegions, 
                                      featureCoords = txdbFeatures$transcripts, 
                                      boundaryType = 'fiveprime')
    ```

3.  **Motif Discovery**:
    ```r
    motifResults <- runMotifDiscovery(queryRegions = queryRegions, 
                                      genomeVersion = 'hg19', 
                                      motifWidth = 6)
    ```

4.  **Functional Enrichment**:
    ```r
    enrichedFuncs <- findEnrichedFunctions(targetGenes = unique(geneTable$gene_id), 
                                           species = 'hsapiens')
    ```

### Multi-Sample Meta-Analysis
For comparing multiple replicates or conditions, RCAS uses an SQLite database to store preprocessed data.

1.  **Create/Update Database**:
    Create a `projData` data frame with `sampleName` and `bedFilePath`.
    ```r
    createDB(dbPath = "project.sqlite", 
             projDataFile = "samples.tsv", 
             gtfFilePath = "annotation.gtf", 
             genomeVersion = "hg19")
    ```

2.  **Run Meta-Analysis Report**:
    Requires a `sampleTable` mapping `sampleName` to `sampleGroup`.
    ```r
    runReportMetaAnalysis(dbPath = "project.sqlite", 
                          sampleTablePath = "comparison_groups.tsv", 
                          outFile = "meta_analysis.html")
    ```

## Tips and Best Practices
- **Downsampling**: Use the `sampleN` parameter (e.g., 10,000) in `importBed` or `runReport` to speed up analysis for very large peak sets.
- **Genome Versions**: Ensure `genomeVersion` matches a valid `BSgenome` identifier (e.g., "hg19", "mm10").
- **Database Management**: Use `summarizeDatabaseContent(dbPath)` to check what samples are already processed. Use `deleteSampleDataFromDB()` to remove specific samples before re-running.
- **Feature Extraction**: `getTxdbFeaturesFromGRanges` is a wrapper that handles the conversion of GTF data into categorized GRanges (UTRs, Introns, etc.) which are required for most summary functions.

## Reference documentation
- [How to do meta-analysis of CLIP-seq peaks from multiple samples with RCAS](./references/RCAS.metaAnalysis.vignette.md)
- [The RNA Centric Analysis System Report](./references/RCAS.vignette.md)