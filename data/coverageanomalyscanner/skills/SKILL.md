---
name: coverageanomalyscanner
description: The coverageanomalyscanner tool identifies and interprets unexpected changes in genomic read coverage to predict structural variants like duplications and deletions. Use when user asks to scan alignment data for coverage anomalies, identify putative structural variants, or visualize coverage metadata.
homepage: https://github.com/rki-mf1/CoverageAnomalyScanner
---


# coverageanomalyscanner

## Overview
The Coverage Anomaly Scanner (CAS) is a specialized tool designed to find and interpret unexpected changes in read coverage within genomic sequence data. It identifies local anomalies and uses "parenthesis rules" to predict structural variant events: an increase followed by a decrease in coverage is interpreted as a duplication, while a decrease followed by an increase is interpreted as a deletion. Use this skill when you need to perform targeted scans of alignment data to identify putative SVs or visualize coverage metadata.

## Command Line Usage

### Basic Scanning
There are two primary ways to specify the genomic window for a scan.

**Option 1: Using a genomic range (Samtools style)**
This is the most convenient method if you know the chromosome name.
```bash
cas --bam input.bam --range chr1:400-900
```

**Option 2: Using explicit coordinates**
This method uses a zero-based chromosome index.
```bash
cas --bam input.bam --chr 0 --start 400 --end 900
```

### Adjusting Sensitivity
By default, CAS uses an internal formula to determine the anomaly detection threshold. You can manually override this to increase or decrease sensitivity.
```bash
cas --bam input.bam --range chr1:400-900 --threshold 0.8
```

## Expert Tips and Best Practices
- **Chromosome Indexing**: When using the `--chr` parameter, the index is 0-based. If you are unsure of the index for a specific chromosome, use `samtools view -H your_file.bam` to check the order of the `@SQ` fields.
- **Output Files**: Every run generates a report of predicted positions to standard output and creates a VCF file named `predictedEvents.vcf` containing paired events (duplications and deletions).
- **Deletion Status**: Note that while duplication detection is stable, deletion prediction (decrease-increase pairs) is currently considered a work in progress (WIP) by the developers.
- **Visualization**: To visualize the metadata used for anomaly detection, the tool must be compiled from source using `make print`. This generates a `coverage.csv` file which can be plotted using the provided R script:
  ```bash
  Rscript util/covplot.R coverage.csv
  ```

## Reference documentation
- [CoverageAnomalyScanner GitHub Repository](./references/github_com_rki-mf1_CoverageAnomalyScanner.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_coverageanomalyscanner_overview.md)