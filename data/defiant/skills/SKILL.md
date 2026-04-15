---
name: defiant
description: Defiant identifies differentially methylated regions (DMRs) from large-scale methylation datasets with minimal computational overhead. Use when user asks to identify DMRs, annotate regions with genomic features, or visualize methylation differences using heatmaps.
homepage: https://github.com/hhg7/defiant
metadata:
  docker_image: "quay.io/biocontainers/defiant:1.1.4--h7b50bb2_6"
---

# defiant

## Overview
Defiant (Differential methylation: Easy, Fast, Identification and ANnoTation) is a high-performance tool designed to identify differentially methylated regions (DMRs) with minimal computational overhead. It is particularly useful for researchers who need to process large-scale methylation datasets on standard hardware. The tool handles multiple experimental groups and replicates, supports a wide variety of input formats, and can perform functional annotation and visualization.

## Installation
The most reliable way to install defiant is via Bioconda:
```bash
conda install bioconda::defiant
```

## Command Line Usage

### Basic Syntax
The core syntax uses spaces to separate experimental groups and commas to separate replicates within those groups.
```bash
defiant [OPTIONS] -i group1_rep1,group1_rep2 group2_rep1,group2_rep2
```

### Common CLI Patterns

**1. Standard DMR Discovery with BED Output**
To find DMRs between two groups and output the results in BED format:
```bash
defiant -b -i control1,control2 treatment1,treatment2
```

**2. Analysis with Genomic Annotation**
Provide a GTF or refFlat file to annotate DMRs with nearby genes:
```bash
defiant -a mm10.gtf -i c1,c2 t1,t2
```

**3. Parallel Parameter Testing**
Defiant allows testing multiple thresholds (e.g., coverage) in a single parallelized run:
```bash
defiant -cpu 4 -c 10,20,30 -i c1,c2 t1,t2
```

**4. Visualizing Results**
Generate heatmaps and EPS figures for each DMR (requires R and gplots):
```bash
defiant -heatmap -f -i c1,c2 t1,t2
```

## Expert Tips and Best Practices

### Input Format Support
Defiant automatically recognizes 12 different input formats. Key supported types include:
- **Bismark**: Coverage and cytosine reports.
- **CGmap**: Output from BS-Seeker2.
- **BSmooth**: Standard output formats.
- **methylKit**: RRBS and standard formats.

### Parameter Tuning
- **Coverage (`-c`)**: The default is often low; increasing this (e.g., `-c 10`) reduces noise in low-depth regions.
- **Gap Size (`-G`)**: Defines the maximum distance between nucleotides to be considered part of the same DMR. Default is usually sufficient, but increase for sparse data.
- **Differential Count (`-d`)**: Sets the minimum number of differentially methylated nucleotides required to call a DMR.

### Statistical Considerations
- **Multiple Testing (`-fdr`)**: While Defiant supports several methods (Holm, BH, Bonferroni, etc.), the author recommends caution. For genome-scale CpG measurements, strict FDR often results in q-values of 1.0 across the board.
- **Performance**: Avoid the `Hommel` correction method for large datasets as it is significantly slower than other options.

### Troubleshooting
- **Chromosome Names**: In versions 1.1.9 and later, the "chr" prefix is no longer required.
- **Memory Usage**: If RAM is a bottleneck, avoid the `-fdr` and `-E` (print statistics for every CpN) options, as they significantly increase memory consumption.
- **Error Handling**: All error messages are directed to `STDERR`. If the program exits unexpectedly, check the end of the error log for methylated C counts exceeding total coverage, which triggers a safety exit.

## Reference documentation
- [Defiant GitHub Repository](./references/github_com_hhg7_defiant.md)
- [Bioconda Defiant Overview](./references/anaconda_org_channels_bioconda_packages_defiant_overview.md)