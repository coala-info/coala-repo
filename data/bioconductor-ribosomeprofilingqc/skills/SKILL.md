---
name: bioconductor-ribosomeprofilingqc
description: The ribosomeProfilingQC package provides a comprehensive toolkit for assessing the quality of ribosome-protected fragments and quantifying translational metrics. Use when user asks to estimate P-site positions, visualize metagene distributions, calculate translational efficiency, or determine ribosome release scores.
homepage: https://bioconductor.org/packages/release/bioc/html/ribosomeProfilingQC.html
---


# bioconductor-ribosomeprofilingqc

## Overview
The `ribosomeProfilingQC` package provides a comprehensive toolkit for assessing the quality of ribosome-protected fragments (RPFs). It enables researchers to determine the precise P-site position, visualize metagene distributions, and quantify translational efficiency (TE) and ribosome release scores (RRS). It is designed to work with BAM files mapped to the whole genome and requires a `TxDb` object for transcript annotation.

## Core Workflow

### 1. Data Preparation
Load the necessary genomic and annotation resources.
```R
library(ribosomeProfilingQC)
library(BSgenome.Hsapiens.UCSC.hg38)
library(TxDb.Hsapiens.UCSC.hg38.knownGene)

genome <- Hsapiens
txdb <- TxDb.Hsapiens.UCSC.hg38.knownGene
CDS <- prepareCDS(txdb)

# Load BAM file
bamfilename <- "path/to/RPF.bam"
bamfile <- Rsamtools::BamFile(bamfilename, yieldSize = 10000000)
```

### 2. P-site Estimation and QC
Determine the offset from the 5' or 3' end to the P-site and visualize read distribution.
```R
# Estimate P-site (typically 13 for 5' end)
bestpsite <- estimatePsite(bamfile, CDS, genome)

# Plot reads relative to start/stop codons to verify offset
re <- readsEndPlot(bamfile, CDS, toStartCodon = TRUE)

# Get P-site coordinates for all reads
pc <- getPsiteCoordinates(bamfile, bestpsite = bestpsite)

# Summary of fragment lengths (expect peak around 28-29nt)
readsLen <- summaryReadsLength(pc)
pc.sub <- pc[pc$qwidth %in% c(28, 29)] # Filter for high-quality RPFs
```

### 3. Diagnostic Plots
Assess the biological signal of the Ribo-seq library.
*   **Strand Specificity:** `strandPlot(pc.sub, CDS)` - RPFs should be on the sense strand.
*   **Genomic Distribution:** `readsDistribution(pc.sub, txdb)` - RPFs should be enriched in CDS.
*   **Metagene Analysis:** `metaPlot()` - Compare coverage across 5'UTR, CDS, and 3'UTR.
*   **Reading Frame:** `plotFrameDensity(pc.sub)` - High-quality data shows strong enrichment in Frame 0.

### 4. Quantitative Analysis
Prepare data for differential translation analysis.

**Counting RPFs:**
```R
# Count reads at gene or transcript level
cnts <- countReads(RPF_bams, gtf = "path/to/annotation.gtf", level = "gene", bestpsite = 13)
```

**Translational Efficiency (TE):**
TE is the ratio of RPF abundance to mRNA abundance.
```R
fpkm <- getFPKM(cnts)
TE <- translationalEfficiency(fpkm)

# For better normalization in lowly expressed genes, use TE90 (90nt window)
cvgs <- coverageDepth(RPF_bams, mRNA_bams, txdb)
TE90 <- translationalEfficiency(cvgs, window = 90, normByLibSize = TRUE)
```

**Ribosome Release Score (RRS):**
Measures the drop in RPFs after the stop codon to identify active translation.
```R
RRS <- ribosomeReleaseScore(TE90_cds, TE90_utr3, log2 = TRUE)
```

## Tips and Best Practices
*   **Input Mapping:** Unlike some packages, `ribosomeProfilingQC` expects BAM files mapped to the **genome**, not the transcriptome.
*   **Filtering:** It is highly recommended to filter out reads mapping to rRNA, tRNA, and other non-coding RNAs before analysis to reduce noise.
*   **P-site Anchoring:** While 5' end anchoring is standard for eukaryotes (RNase I), 3' end anchoring (`anchor = "3end"`) is often more accurate for bacterial data or MNase digestion.
*   **ORFscore:** Use `getORFscore(pc.sub)` to quantify the 3-nt periodicity; a high score indicates high-quality RPFs correctly tracking the coding frame.

## Reference documentation
- [ribosomeProfilingQC Guide](./references/ribosomeProfilingQC.md)