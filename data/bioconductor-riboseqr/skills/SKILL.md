---
name: bioconductor-riboseqr
description: This tool analyzes ribosome profiling data to infer reading frames and visualize footprint distributions across transcripts. Use when user asks to parse Ribo-seq BAM files, identify predominant reading frames, visualize metagene profiles, or prepare counts for differential translation analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/riboSeqR.html
---

# bioconductor-riboseqr

name: bioconductor-riboseqr
description: Analysis of ribosome profiling (Ribo-seq) data aligned to coding sequences. Use this skill to infer reading frames, identify frameshifts, visualize ribosome footprint distribution (metagene plots), and prepare data for differential translation analysis using the riboSeqR Bioconductor package.

# bioconductor-riboseqr

## Overview

The `riboSeqR` package provides tools for parsing Ribo-seq data (typically from BAM files), identifying the predominant reading frames for different read lengths, and visualizing the distribution of ribosome footprints across transcripts. It is particularly useful for determining the "P-site" offset and filtering reads to those that represent true translation events before performing downstream differential expression analysis.

## Core Workflow

### 1. Data Preparation and CDS Identification
Define coding sequences (CDS) from a FASTA file of transcripts. Note: Use transcript sequences, not genomic sequences.

```r
library(riboSeqR)

# Find potential CDS in a transcript FASTA
chlamyFasta <- system.file("extdata", "rsem_chlamy236_deNovo.transcripts.fa", package = "riboSeqR")
fastaCDS <- findCDS(fastaFile = chlamyFasta, 
                    startCodon = c("ATG"), 
                    stopCodon = c("TAG", "TAA", "TGA"))
```

### 2. Loading Alignment Data
Read Ribo-seq (and optionally RNA-seq) BAM files.

```r
ribofiles <- c("path/to/ribo1.bam", "path/to/ribo2.bam")
riboDat <- readRibodata(ribofiles, replicates = c("WT", "WT"))
```

### 3. Frame Counting and Reading Frame Inference
Assign reads to frames relative to the start codon and determine which read lengths show strong periodicity.

```r
# Count reads in frames
fCs <- frameCounting(riboDat, fastaCDS)

# Infer the predominant reading frame for each read length
fS <- readingFrame(rC = fCs)

# Visualize frame distribution to identify high-quality read lengths
plotFS(fS)
```

### 4. Filtering and Visualization
Filter the data for specific read lengths and frames that match the expected translation signal.

```r
# Filter for 27-mers in frame 1 and 28-mers in frame 0 (example)
ffCs <- filterHits(fCs, lengths = c(27, 28), frames = list(1, 0), 
                   hitMean = 50, unqhitMean = 10, fS = fS)

# Plot metagene profile (average alignment at 5' and 3' ends)
plotCDS(coordinates = ffCs@CDS, riboDat = riboDat, lengths = 27)

# Plot coverage for a specific transcript
plotTranscript("Transcript_ID", coordinates = ffCs@CDS, riboData = riboDat, length = 27)
```

### 5. Preparing for Differential Translation
Extract counts for use in differential translation packages like `baySeq`.

```r
# Extract Ribo-seq counts
riboCounts <- sliceCounts(ffCs, lengths = c(27, 28), frames = list(1, 0))

# Extract RNA-seq counts for normalization/efficiency calculation
rnaCounts <- rnaCounts(riboDat, ffCs@CDS)
```

## Key Functions
- `findCDS`: Identifies ORFs within FASTA sequences.
- `readRibodata`: Loads alignment data from BAM or text files.
- `frameCounting`: Maps reads to frames relative to CDS starts.
- `readingFrame`: Statistical inference of the most likely reading frame per read length.
- `plotFS`: Plots the distribution of frames to help select "in-frame" read lengths.
- `plotCDS`: Generates metagene plots showing ribosome density around start and stop codons.
- `sliceCounts`: Collapses filtered Ribo-seq data into a count matrix for downstream DE analysis.

## Tips
- **Read Lengths**: Different Ribo-seq experiments produce different footprint lengths (usually 26-31nt). Always use `plotFS` to verify which lengths show a strong preference for a single frame.
- **P-site Offset**: `riboSeqR` handles the offset implicitly by identifying the predominant frame for each length rather than requiring a fixed integer shift.
- **Memory**: For large BAM files, ensure the machine has sufficient RAM as `readRibodata` loads alignments into memory.

## Reference documentation
- [riboSeqR](./references/riboSeqR.md)