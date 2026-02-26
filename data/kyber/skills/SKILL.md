---
name: kyber
description: Kyber creates standardized heatmap images visualizing the correlation between read length and sequencing accuracy for genomic data. Use when user asks to generate quality control heatmaps, compare sequencing runs, or visualize read length versus accuracy from BAM or CRAM files.
homepage: https://github.com/wdecoster/kyber
---


# kyber

## Overview
Kyber is a high-performance tool designed to create standardized 600x600 pixel heatmap images visualizing the correlation between read length and sequencing accuracy. By using fixed axes—log-transformed read length on the X-axis (up to 1M) and gap-compressed identity or Phred-scaled accuracy on the Y-axis—it allows for direct, consistent comparisons across different sequencing runs or technologies. It is particularly effective for long-read data analysis where quality control across varying lengths is critical.

## Command Line Usage

### Basic Execution
Generate a default heatmap (green on black background) from a BAM or CRAM file:
```bash
kyber input.bam
```

### Accuracy Scaling
By default, the Y-axis shows gap-compressed reference identity (70% to 100%). To use Phred-scaled accuracy (Q0 to Q40) instead:
```bash
kyber --phred input.bam
```

### Visual Customization
Kyber supports specific color schemes and background options to improve visibility or match publication requirements:
*   **Colors**: `red`, `green`, `blue`, `purple`, `yellow`
*   **Backgrounds**: `black`, `white`

Example for a publication-ready white background:
```bash
kyber -c blue -b white -o publication_heatmap.png input.bam
```

### Performance and Normalization
For datasets with extremely high depth or uneven distribution, use normalization to prevent high-count bins from obscuring the rest of the data:
```bash
kyber --normalize input.bam
```

To speed up processing of large files, increase the decompression threads:
```bash
kyber --threads 8 input.cram
```

## Expert Tips and Best Practices

### Handling Massive Datasets
While Kyber is fast (processing 150GB in ~11 minutes), processing multi-terabyte datasets can still be time-consuming. Use `samtools` to downsample the input via a pipe to generate a representative heatmap quickly:
```bash
samtools view -h -s 0.05 alignment.cram | kyber -o downsampled_accuracy.png -
```
*Note: The `-` character tells kyber to read from stdin.*

### Comparative Analysis
Because Kyber uses fixed axes, you can generate heatmaps for two different runs and compare them side-by-side without worrying about scale shifts. This is the most effective way to identify "cliff-offs" in accuracy at specific read lengths between different flow cells or library prep methods.

### Unmapped BAMs (uBAM)
Kyber supports unmapped BAM files (`--ubam`). This is useful for checking raw data quality before alignment, provided the accuracy metrics are present in the tags.

## Reference documentation
- [Kyber GitHub Repository](./references/github_com_wdecoster_kyber.md)
- [Bioconda Kyber Overview](./references/anaconda_org_channels_bioconda_packages_kyber_overview.md)