---
name: bioconductor-rcistarget
description: RcisTarget identifies transcription factor binding motifs over-represented in a gene list or set of genomic regions. Use when user asks to perform motif enrichment analysis, annotate motifs to transcription factors, or identify specific genes and regions regulated by a transcription factor.
homepage: https://bioconductor.org/packages/release/bioc/html/RcisTarget.html
---


# bioconductor-rcistarget

name: bioconductor-rcistarget
description: Identify transcription factor (TF) binding motifs over-represented on a gene list or genomic regions using RcisTarget. Use this skill when you need to perform motif enrichment analysis, annotate motifs to TFs, or identify specific genes/regions regulated by a TF.

# bioconductor-rcistarget

## Overview
RcisTarget is an R package designed to identify transcription factor (TF) binding motifs enriched in a gene list or a set of genomic regions. It utilizes pre-computed rankings of genes (or regions) based on motif scores across various species (Human, Mouse, Fly). The workflow typically involves calculating the Area Under the Curve (AUC) for motif recovery, determining a Normalized Enrichment Score (NES) to identify significant motifs, and finally identifying the specific "enriched genes" that drive the motif's significance.

## Core Workflow

### 1. Setup and Data Loading
RcisTarget requires specific database files (.feather) containing motif rankings and motif-to-TF annotations.

```r
library(RcisTarget)

# Load gene sets (as a named list)
geneList <- c("ADM", "ADORA2B", "AHNAK2", "AK4")
geneLists <- list(hypoxia = geneList)

# Load Motif-TF annotations (provided in package for standard collections)
data(motifAnnotations_hgnc) 

# Import pre-computed rankings (requires local .feather file)
# Databases available at: https://resources.aertslab.org/cistarget/
motifRankings <- importRankings("hg38_10kbp_up_10kbp_down_full_tx_v10_clust.genes_vs_motifs.rankings.feather")
```

### 2. Running the Analysis (One-Step)
The `cisTarget()` function wraps the entire workflow: enrichment calculation, TF annotation, and significant gene identification.

```r
motifEnrichmentTable <- cisTarget(geneLists, 
                                  motifRankings,
                                  motifAnnot = motifAnnotations)
```

### 3. Step-by-Step Execution (Advanced)
For more control or to optimize performance on large datasets, run the steps individually:

```r
# Step 1: Calculate AUC
motifs_AUC <- calcAUC(geneLists, motifRankings, nCores = 1)

# Step 2: Select significant motifs (NES > 3) and add TF annotations
motifEnrichmentTable <- addMotifAnnotation(motifs_AUC, 
                                           nesThreshold = 3,
                                           motifAnnot = motifAnnotations)

# Step 3: Identify specific genes contributing to the enrichment
motifEnrichmentTable_wGenes <- addSignificantGenes(motifEnrichmentTable,
                                                   rankings = motifRankings, 
                                                   geneSets = geneLists,
                                                   method = "aprox") # "icistarget" is slower but more accurate
```

## Specialized Analyses

### Genomic Regions Analysis
To analyze genomic regions (e.g., ChIP-seq peaks) instead of gene symbols:
1. Import regions as a `GRanges` object.
2. Convert regions to database-specific IDs using `convertToTargetRegions()`.
3. Adjust `aucMaxRank` based on the organism (Human/Mouse: 0.005, Fly: 0.01).

```r
# Convert query regions to DB IDs using a region location mapping
regionSets_db <- lapply(regionSets, function(x) {
  convertToTargetRegions(queryRegions = x, targetRegions = dbRegionsLoc)
})

# Run analysis with adjusted rank
motifEnrichmentTable <- cisTarget(regionSets_db, 
                                  motifRankings, 
                                  aucMaxRank = 0.005 * getNumColsInDB(motifRankings))
```

### Analysis with Background
If you have a specific background set of genes (e.g., all genes expressed in an experiment):
1. Import rankings only for the background genes.
2. Re-rank the motifs within that subset using `reRank()`.
3. Run `cisTarget()` using the re-ranked database.

```r
rankingsDb <- importRankings(dbPath, columns = backgroundGenes)
bgRanking <- reRank(rankingsDb)
motifEnrichmentTable <- cisTarget(geneSets, bgRanking, 
                                  geneErnMethod = "icistarget")
```

## Tips and Interpretation
- **NES Threshold**: A NES > 3.0 is the standard cutoff for significance.
- **TF Confidence**: The output table distinguishes between `TF_highConf` (direct evidence) and `TF_lowConf` (inferred via orthology or motif similarity).
- **Visualization**: Use `showLogo(motifEnrichmentTable)` to view the sequence logos of the enriched motifs.
- **Parallelization**: Many functions support `nCores` to speed up calculations on multi-core systems.

## Reference documentation
- [RcisTarget: Transcription factor binding motif enrichment](./references/RcisTarget_MainTutorial.md)
- [Motif enrichment in genomic regions](./references/Tutorial_AnalysisOfGenomicRegions.md)
- [Motif enrichment with background](./references/Tutorial_AnalysisWithBackground.md)