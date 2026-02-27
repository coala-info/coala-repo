---
name: bioconductor-methylseekr
description: This tool segments high-coverage whole-genome bisulfite-sequencing data to identify regulatory regions and large-scale methylation domains. Use when user asks to identify unmethylated regions, low-methylated regions, or partially methylated domains.
homepage: https://bioconductor.org/packages/release/bioc/html/MethylSeekR.html
---


# bioconductor-methylseekr

name: bioconductor-methylseekr
description: Analysis of whole-genome bisulfite-sequencing (Bis-seq) data to identify regulatory regions, specifically Unmethylated Regions (UMRs), Low-Methylated Regions (LMRs), and Partially Methylated Domains (PMDs). Use this skill when analyzing DNA methylation data to find distal regulatory elements or large-scale domain structures.

# bioconductor-methylseekr

## Overview

MethylSeekR is an R package designed for the segmentation of high-coverage (min 10X) Bis-seq data. It identifies regulatory regions by distinguishing between UMRs (typically promoters/CpG islands) and LMRs (typically distal enhancers). It also includes a Hidden Markov Model (HMM) to identify and mask PMDs, which are large regions of disordered methylation that can interfere with regulatory region detection.

## Typical Workflow

### 1. Data Preparation and Import
Data must be in a tab-delimited format with four columns: `chromosome`, `position`, `T` (total reads), and `M` (methylated reads).

```R
library(MethylSeekR)
library(BSgenome.Hsapiens.UCSC.hg38)

# Get chromosome lengths
sLengths <- seqlengths(Hsapiens)

# Load methylation data
meth.gr <- readMethylome(FileName="data.tab", seqLengths=sLengths)

# Optional: Filter SNPs if the sample genome differs from the reference
snps.gr <- readSNPTable(FileName="snps.tab", seqLengths=sLengths)
meth.gr <- removeSNPs(meth.gr, snps.gr)
```

### 2. PMD Segmentation
Identify large-scale partially methylated domains. This step is necessary if the alpha distribution is bimodal.

```R
# Check alpha distribution to decide if PMD segmentation is needed
plotAlphaDistributionOneChr(m=meth.gr, chr.sel="chr22", num.cores=1)

# If bimodal, segment PMDs
PMDsegments.gr <- segmentPMDs(m=meth.gr, chr.sel="chr22", 
                              seqLengths=sLengths, num.cores=1)

# Save PMD results
savePMDSegments(PMDs=PMDsegments.gr, TableFilename="PMDs.tab")
```

### 3. UMR and LMR Identification
Identify regulatory regions using a False Discovery Rate (FDR) approach to determine optimal cut-offs.

```R
# 1. Get CpG Island annotation (to mask during FDR calculation)
library(rtracklayer)
session <- browserSession()
genome(session) <- "hg38"
query <- ucscTableQuery(session, table = "cpgIslandExt")
CpGislands.gr <- track(query)
CpGislands.gr <- resize(CpGislands.gr, 5000, fix="center")

# 2. Calculate FDRs to pick parameters (m = methylation cut-off, n = min CpGs)
stats <- calculateFDRs(m=meth.gr, CGIs=CpGislands.gr, PMDs=PMDsegments.gr)

# 3. Segment UMRs and LMRs (using m=0.5 and n determined from FDR < 5%)
UMRLMRsegments.gr <- segmentUMRsLMRs(m=meth.gr, meth.cutoff=0.5, nCpG.cutoff=4, 
                                     PMDs=PMDsegments.gr, myGenomeSeq=Hsapiens, 
                                     seqLengths=sLengths)

# 4. Save results
saveUMRLMRSegments(segs=UMRLMRsegments.gr, TableFilename="UMRsLMRs.tab")
```

## Key Functions and Parameters

- `readMethylome()`: Imports methylation data into a GRanges object.
- `segmentPMDs()`: Uses an HMM to partition the genome into PMD and notPMD regions.
- `calculateFDRs()`: Helps determine the `meth.cutoff` (m) and `nCpG.cutoff` (n) by comparing real data to randomized data.
- `segmentUMRsLMRs()`: The final segmentation step. It classifies regions with < 30 CpGs as LMRs and >= 30 CpGs as UMRs.
- `plotFinalSegmentation()`: Visualizes the raw and smoothed methylation levels alongside the identified segments.

## Tips for Success

- **Coverage**: Ensure your data has at least 10X genome-wide coverage. MethylSeekR is not recommended for low-coverage datasets.
- **Parallelization**: Most functions support `num.cores`. Use multiple cores on Unix/Mac systems to significantly speed up `segmentPMDs` and `calculateFDRs`.
- **Visual Inspection**: Always use `plotAlphaDistributionOneChr` and `plotPMDSegmentation` to verify that the HMM has correctly identified the modes of methylation.
- **Reproducibility**: Set a seed (`set.seed()`) before running the analysis, as FDR calculations involve random permutations.

## Reference documentation
- [MethylSeekR](./references/MethylSeekR.md)