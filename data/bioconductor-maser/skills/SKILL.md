---
name: bioconductor-maser
description: The maser package provides a workflow for the downstream analysis and functional annotation of rMATS alternative splicing events. Use when user asks to filter rMATS output, visualize splicing events with volcano plots or PCAs, map splicing events to transcript isoforms, or identify protein domains affected by alternative splicing.
homepage: https://bioconductor.org/packages/release/bioc/html/maser.html
---


# bioconductor-maser

## Overview
The `maser` (Mapping Alternative Splicing Events to pProteins) package is designed for the downstream analysis of rMATS output. It provides a structured workflow to transition from raw splice junction counts to functional biological insights by mapping splicing events to both transcript isoforms and protein domains.

## Core Workflow

### 1. Data Import and Object Creation
Initialize a `maser` object by pointing to the directory containing rMATS output files.
```r
library(maser)
path <- "path/to/rMATS_output"
# ftype depends on rMATS version: "ReadsOnTargetAndJunctionCounts" (v4+) or "JunctionCountOnly" (v3.2.5-)
hypoxia <- maser(path, c("Cond1", "Cond2"), ftype = "ReadsOnTargetAndJunctionCounts")
```

### 2. Filtering and Selection
Filter events based on RNA-seq coverage to ensure high-confidence PSI (Percent Spliced In) levels, and select significant events.
```r
# Filter by average reads (e.g., 5 reads)
hypoxia_filt <- filterByCoverage(hypoxia, avg_reads = 5)

# Select significant events (FDR < 0.05 and deltaPSI > 0.1)
hypoxia_top <- topEvents(hypoxia_filt, fdr = 0.05, deltaPSI = 0.1)

# Extract events for a specific gene
mib2_events <- geneEvents(hypoxia_filt, geneS = "MIB2", fdr = 0.05)
```

### 3. Global Visualization
Visualize the distribution and significance of splicing changes across the entire dataset.
```r
# Volcano plot for Exon Skipping (SE)
volcano(hypoxia_filt, fdr = 0.05, deltaPSI = 0.1, type = "SE")

# Dotplot for top events
dotplot(hypoxia_top, type = "SE")

# PCA of replicates
pca(hypoxia_filt, type = "SE")

# Distribution of splicing types (SE, RI, MXE, A3SS, A5SS)
splicingDistribution(hypoxia_top)
```

### 4. Transcript and Protein Mapping
Map splicing events to genomic features using an Ensembl/Gencode GTF (hg38).
```r
library(rtracklayer)
ens_gtf <- import.gff("hg38_annotation.gtf")

# Map transcripts to events
hypoxia_mapped <- mapTranscriptsToEvents(hypoxia_top, ens_gtf)

# Map UniProtKB protein features (e.g., domains, topology)
hypoxia_annot <- mapProteinFeaturesToEvents(hypoxia_mapped, 
                                            tracks = c("Domain_and_Sites", "Topology"), 
                                            by = "category")
```

### 5. Functional Visualization
Generate Gviz-based plots showing the splicing event, compatible transcripts, and overlapping protein features.
```r
# Plot transcripts for a specific event ID
plotTranscripts(hypoxia_mapped, type = "SE", event_id = 33209, gtf = ens_gtf)

# Plot with UniProt features
plotUniprotKBFeatures(hypoxia_annot, type = "SE", event_id = 33209, 
                      features = c("domain", "chain"), gtf = ens_gtf)
```

## Event Type Abbreviations
- **SE**: Skipped Exon (Cassette exon)
- **RI**: Retained Intron
- **MXE**: Mutually Exclusive Exons
- **A3SS**: Alternative 3' Splice Site
- **A5SS**: Alternative 5' Splice Site

## Tips for Success
- **GTF Compatibility**: Ensure the GTF used for mapping matches the genome build used in rMATS (typically hg38).
- **Interactive Exploration**: Use `maser::display(object, "SE")` to open an interactive table of events in the RStudio Viewer or browser.
- **Data Access**: Use helper functions `annotation()`, `counts()`, `PSI()`, and `summary()` to extract data frames from the maser object for custom analysis.

## Reference documentation
- [Introduction](./references/Introduction.md)
- [Mapping protein features to splicing events](./references/Protein_mapping.md)