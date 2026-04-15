---
name: bioconductor-grohmm
description: This tool analyzes GRO-seq data using Hidden Markov Models to identify transcribed regions and characterize nascent RNA. Use when user asks to perform de novo transcript calling, generate wiggle files for visualization, evaluate transcript predictions against annotations, or conduct differential expression analysis on nascent RNA-seq data.
homepage: https://bioconductor.org/packages/release/bioc/html/groHMM.html
---

# bioconductor-grohmm

name: bioconductor-grohmm
description: Analysis of GRO-seq (Global Nuclear Run On and Sequencing) data using the groHMM Bioconductor package. Use this skill to perform de novo transcript calling using Hidden Markov Models (HMM), generate wiggle files for visualization, evaluate transcript predictions against annotations, and perform metagene or differential expression analysis on nascent RNA-seq data.

## Overview

The `groHMM` package is designed for the analysis of GRO-seq data, which maps the position and orientation of active RNA polymerases. Its primary feature is a two-state Hidden Markov Model (HMM) that identifies "transcribed" and "non-transcribed" regions across the genome in a strand-specific manner. This allows for the discovery of non-coding RNAs (miRNAs, lincRNAs, eRNAs) and the measurement of instantaneous transcriptional responses.

## Core Workflow

### 1. Data Loading and Preparation
`groHMM` uses `GRanges` objects. Alignments (BAM files) should be loaded using `GenomicAlignments`.

```R
library(groHMM)
library(GenomicAlignments)

# Load BAM files as GRanges
reads <- as(readGAlignments("sample.bam"), "GRanges")

# Set parallel processing
options(mc.cores = getCores(4))
```

### 2. Visualization (Wiggle Files)
Generate strand-specific wiggle or BigWig files for genome browsers.

```R
# Create normalized wiggle files
writeWiggle(reads = reads, file = "plus.wig", strand = "+", reverse = FALSE)
writeWiggle(reads = reads, file = "minus.wig", strand = "-", reverse = TRUE)
```

### 3. De Novo Transcript Calling
The HMM identifies transcribed regions. It is often best to combine replicates or time points to increase sensitivity for low-expression transcripts.

```R
# Combine reads for training
all_reads <- sort(c(reads_rep1, reads_rep2))

# Detect transcripts
# LtProbB: log-transition probability from transcribed to non-transcribed
# UTS: variance of emission probability in non-transcribed state
hmm_result <- detectTranscripts(all_reads, LtProbB = -200, UTS = 5)
transcripts <- hmm_result$transcripts
```

### 4. Evaluation and Tuning
Compare HMM predictions against known annotations (e.g., UCSC knownGene) to calculate error rates (merged or dissociated transcripts).

```R
# Create consensus annotations (collapsing isoforms)
kgConsensus <- makeConsensusAnnotations(knownGenes, keytype = "gene_id")

# Evaluate HMM performance
eval_result <- evaluateHMMInAnnotations(transcripts, kgConsensus)
# Access error rates: eval_result$eval
```

### 5. Refining Transcript Calls
Repair HMM errors by breaking transcripts that merge multiple genes or combining those that dissociate a single gene.

```R
# Break merged transcripts
broken <- breakTranscriptsOnGenes(transcripts, kgConsensus, strand = "+")
# Combine dissociated transcripts
final_tx <- combineTranscripts(broken, kgConsensus)
```

### 6. Downstream Analysis
*   **Differential Expression:** Use `edgeR` or `DESeq2`. For nascent RNA, it is common to count reads in a window (e.g., +1kb to +13kb from TSS) to focus on elongation and avoid promoter-proximal pausing peaks.
*   **Metagene Analysis:** Use `runMetaGene` to visualize average read density around TSSs.

```R
# Metagene around TSS
mg <- runMetaGene(features = genes, reads = reads, size = 100)
# Plotting requires custom logic or the sense/antisense vectors in 'mg'
```

## Tips for Non-Mammalian Genomes
For organisms with high gene density (e.g., *C. elegans*), the default HMM parameters may merge adjacent genes. Increase the `LtProbB` value (e.g., > -50) to make the model more likely to transition to a "non-transcribed" state.

## Reference documentation
- [groHMM Tutorial](./references/groHMM.md)