---
name: bioconductor-nucler
description: This tool analyzes nucleosome positioning data from NGS and tiling microarray experiments using Fast Fourier Transform for noise removal. Use when user asks to import BAM files, process genomic reads, perform signal smoothing via FFT, and call or score nucleosome peaks.
homepage: https://bioconductor.org/packages/release/bioc/html/nucleR.html
---

# bioconductor-nucler

name: bioconductor-nucler
description: Analysis of nucleosome positioning experiments from NGS (ChIP-seq) and Tiling Microarrays (ChIP-on-Chip). Use this skill to import BAM files, process genomic reads, perform signal smoothing via Fast Fourier Transform (FFT), and call/score nucleosome peaks.

# bioconductor-nucler

## Overview
The `nucleR` package provides high-level processing for genomic datasets focused on nucleosome positioning. It handles both Next Generation Sequencing (NGS) and Tiling Microarray data. Its core strength is a noise-removal method based on Fast Fourier Transform (FFT) which allows for efficient peak detection and scoring of well-positioned versus fuzzy nucleosomes without the complexity of Hidden Markov Models.

## Typical Workflow

### 1. Data Import and Pre-processing
For NGS data, use `readBAM` to import alignments. For Tiling Arrays, use `processTilingArray`.

```r
library(nucleR)

# NGS: Import BAM (paired or single)
reads <- readBAM("path/to/file.bam", type="paired")

# Process reads: filter by length and/or trim to dyad
# For mononucleosomes, fragmentLen=200 is common; trim=40 sharpens the dyad
proc_reads <- processReads(reads, type="paired", fragmentLen=200, trim=40)

# Convert to normalized coverage (Reads Per Million)
cover <- coverage.rpm(proc_reads)
```

### 2. Noise Removal (FFT Filtering)
`nucleR` uses FFT to remove high-frequency noise. Use `pcKeepComp` to specify the percentage of components to keep (typically 0.01-0.02).

```r
# Convert Rle coverage to vector for FFT
raw_signal <- as.vector(cover[[1]])

# Filter signal: 2% components for NGS, 1% for Tiling Arrays
fft_signal <- filterFFT(raw_signal, pcKeepComp=0.02)

# Optional: Automatically detect pcKeepComp
# pc <- pcKeepCompDetect(raw_signal, cor=0.99)
```

### 3. Nucleosome Calling and Scoring
Detect peaks in the filtered signal. Scoring accounts for height (coverage) and sharpness (fuzziness).

```r
# Detect peaks with a threshold (e.g., 25% of max height)
# Set width=147 to get GRanges of nucleosome-sized regions
peaks <- peakDetection(fft_signal, threshold="25%", score=TRUE, width=147)

# Resulting scores:
# score: Combined score
# score_h: Height score (reads coverage)
# score_w: Sharpness score (fuzziness)
```

### 4. Visualization and Export
```r
# Plot peaks over the signal
plotPeaks(peaks, fft_signal, threshold="25%")

# Export for genome browsers
export.wig(cover, "coverage.wig")
export.bed(peaks, "nucleosomes.bed")
```

## Key Functions
- `readBAM`: Direct import of BAM files into GRanges.
- `processReads`: Filters reads by length and allows trimming to the dyad center.
- `coverage.rpm`: Calculates coverage normalized to reads per million.
- `filterFFT`: Removes noise using Fast Fourier Transform.
- `peakDetection`: Identifies peaks; can return simple indices or scored GRanges.
- `peakScoring`: Calculates height and sharpness scores for identified peaks.
- `controlCorrection`: Corrects nucleosomal profiles using a mock (naked DNA) control.
- `syntheticNucMap`: Generates synthetic maps for benchmarking.

## Tips
- **Fuzziness**: A high `score_w` indicates a well-positioned nucleosome. Overlapping peaks in wide regions often indicate fuzzy or de-localized nucleosomes.
- **Tiling Arrays**: These usually require more smoothing (`pcKeepComp` around 0.01) compared to NGS.
- **Memory**: For large genomes, process data chromosome by chromosome to manage memory efficiently.

## Reference documentation
- [nucleR](./references/nucleR.md)