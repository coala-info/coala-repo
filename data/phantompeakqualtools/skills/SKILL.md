---
name: phantompeakqualtools
description: phantompeakqualtools evaluates the quality of enrichment-based sequencing experiments by calculating strand cross-correlation metrics and identifying fragment lengths. Use when user asks to assess ChIP-seq library quality, calculate NSC and RSC coefficients, or call peaks using the SPP algorithm.
homepage: https://github.com/kundajelab/phantompeakqualtools
metadata:
  docker_image: "quay.io/biocontainers/phantompeakqualtools:1.2.2--0"
---

# phantompeakqualtools

## Overview
phantompeakqualtools is a specialized suite of tools designed to evaluate the quality of enrichment-based sequencing experiments. By analyzing the cross-correlation between reads on the plus and minus strands, the tool identifies the predominant fragment length and assesses the signal-to-noise ratio of the library. It is the standard tool used by the ENCODE consortium for calculating Normalized Strand Cross-correlation (NSC) and Relative Strand Cross-correlation (RSC) coefficients, which are critical for determining if an experiment has successfully captured biological signal.

## Core CLI Usage

The primary interface is the `run_spp.R` script.

### Basic Quality Assessment
To calculate fragment length and quality metrics for a single dataset:
```bash
Rscript run_spp.R -c=<ChIP_file.bam> -savp -out=<results.txt>
```
*   `-c`: Path to your ChIP-seq alignment file (BAM or tagAlign).
*   `-savp`: Saves the cross-correlation plot as a PDF.
*   `-out`: Appends the 11-column quality metrics to a text file.

### Peak Calling
To call peaks using the SPP algorithm, you must provide a control (Input) file:
```bash
Rscript run_spp.R -c=<ChIP.bam> -i=<Input.bam> -fdr=0.01 -savn=<output.narrowPeak>
```
*   `-i`: Path to the control/input alignment file.
*   `-fdr`: False Discovery Rate threshold.
*   `-savn`: Output filename for narrowPeak format (fixed-width peaks).
*   `-savr`: Output filename for regionPeak format (variable-width peaks).

### Performance Optimization
For large datasets, use parallel processing to speed up cross-correlation calculations:
```bash
Rscript run_spp.R -c=<ChIP.bam> -p=<num_threads>
```

## Expert Tips and Best Practices

### File Format Requirements
*   **Extensions**: The tool is strict about file extensions. Ensure files end in `.bam`, `.bam.gz`, `.tagAlign`, or `.tagAlign.gz`.
*   **Samtools**: If using BAM files, `samtools` must be in your system PATH as the script calls it internally.

### Interpreting Quality Metrics
The output file contains 11 columns. Focus on these key values:
*   **estFragLen (Col 3)**: The estimated fragment length. If multiple values are present, they are listed in decreasing order of correlation.
*   **NSC (Col 9)**: Normalized Strand Cross-correlation. Values > 1.1 are generally considered good; values < 1.05 indicate low enrichment.
*   **RSC (Col 10)**: Relative Strand Cross-correlation. Values > 1.0 are preferred. A value < 0.8 often indicates a failed experiment or a "phantom peak" dominated by read length rather than fragment length.
*   **QualityTag (Col 11)**: A quick assessment (2, 1, 0, -1, -2) where higher is better.

### Handling the Phantom Peak
The "phantom peak" occurs at the read length. To avoid misidentifying this as the fragment length, use the `-x` flag to exclude the read length region:
*   Default exclusion: `-x=10:(readlen+10)`
*   If you have specific knowledge of an artifact, adjust the range: `-x=<min>:<max>`

### Chromosome Filtering
To remove artifacts from unplaced scaffolds or mitochondrial DNA that might skew correlation, use the filter flag:
```bash
Rscript run_spp.R -c=<ChIP.bam> -filtchr="chrM|_"
```

## Reference documentation
- [phantompeakqualtools README](./references/github_com_kundajelab_phantompeakqualtools_blob_master_README.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_phantompeakqualtools_overview.md)