---
name: peakzilla
description: Peakzilla is a self-learning peak caller designed to identify high-resolution transcription factor binding sites from ChIP-seq data. Use when user asks to call peaks, identify point-source enrichment, or estimate peak size parameters from BED or BEDPE files.
homepage: https://github.com/steinmann/peakzilla
---


# peakzilla

## Overview
Peakzilla is a self-learning peak caller optimized for identifying precise transcription factor binding sites. It excels at detecting point-source enrichment with high resolution by automatically estimating necessary parameters from the input data. While highly effective for transcription factors, it is specifically not intended for broad enrichment regions such as histone modifications.

## CLI Usage and Patterns

### Basic Execution
The standard workflow requires a ChIP sample and a control (input) sample in BED format.
```bash
python peakzilla.py chip.bed control.bed > peaks.tsv
```

### Paired-End Data
If working with paired-end sequencing, ensure the input is in BEDPE format and use the `-p` flag.
```bash
python peakzilla.py -p chip.bedpe control.bedpe > peaks.tsv
```

### Filtering and Stringency
While Peakzilla is self-learning, you can manually adjust thresholds for specific experimental needs:
- **Increase Confidence**: Use `-s` to set a higher score cutoff (default is 1).
- **Fold Enrichment**: Use `-c` to set a minimum fold enrichment (default is 2).
- **Model Estimation**: Use `-m` to change the number of highly enriched regions used to estimate peak size (default is 200).

### Output Management
- **Negative Peaks**: To identify enriched regions in the control sample (useful for FDR validation or noise analysis), use the `-n` flag.
- **Logging**: Redirect logs to a specific file using `-l path/to/log.txt`.

## Expert Tips and Best Practices

### Pre-processing Requirements
Peakzilla requires BED formatted alignments. Common bioinformatics pipelines should follow this sequence:
1. Map reads (e.g., Bowtie).
2. Convert SAM/BAM to BED using `bedtools` (`bamToBed`).
3. Run Peakzilla on the resulting BED files.

### Performance Optimization
For significantly faster processing (up to 2x performance increase), run the script using **PyPy** instead of standard CPython.

### Tool Selection
- **Use Peakzilla for**: Transcription factors, ChIP-exo, and high-resolution point-source peaks.
- **Do NOT use Peakzilla for**: Histone marks (H3K36me3, H3K27me3, etc.) or broad domains. Use MACS for these applications.

### Interpreting Results
The output is a tab-delimited table. Key columns to monitor for downstream analysis:
- **Summit**: The exact coordinate of predicted binding.
- **Score**: The statistical strength of the peak.
- **DistributionScore**: Indicates how well the read distribution matches the expected peak model.

## Reference documentation
- [Peakzilla README](./references/github_com_steinmann_peakzilla.md)
- [Peakzilla Wiki](./references/github_com_steinmann_peakzilla_wiki.md)