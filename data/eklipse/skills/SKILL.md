---
name: eklipse
description: eKLIPse is a specialized bioinformatics tool for mitochondrial genomics.
homepage: https://github.com/dooguypapua/eKLIPse
---

# eklipse

## Overview

eKLIPse is a specialized bioinformatics tool for mitochondrial genomics. It identifies structural variations in mtDNA by analyzing soft-clipped reads—sequences where only a portion of the read aligns to the reference. This approach allows for high-sensitivity detection of breakpoints and the quantification of the cumulated percentage of rearrangements at specific gene locations. It supports single and paired-end data from various sources, including Whole Exome Sequencing (WES), Whole Genome Sequencing (WGS), or dedicated mtDNA sequencing.

## Command Line Usage

### Input Preparation
eKLIPse requires a tab-delimited text file as the primary input for alignment files. Each line should contain the file path followed by a unique title.

**Example `input.txt`:**
```text
/path/to/sample1.bam    Sample_A
/path/to/sample2.sam    Sample_B
```

### Basic Execution
Run the analysis by providing the input list and a GenBank (.gb) reference file.

```bash
python eKLIPse.py -in input.txt -ref reference.gbk -out ./results
```

### Common CLI Patterns

**1. Analyzing Short-Read Data (e.g., 100bp Illumina)**
For shorter reads, reduce the soft-clipping and mapping length thresholds to maintain sensitivity.
```bash
python eKLIPse.py -in input.txt -ref ref.gbk -scsize 15 -mapsize 10 -gapopen 5 -gapext 2
```

**2. High Sensitivity for Low Mutant Loads**
To detect rare deletions or multiple deletions, disable downsampling to ensure all mitochondrial reads are processed.
```bash
python eKLIPse.py -in input.txt -ref ref.gbk -downcov 0
```

**3. Detecting Small Rearrangements (Sublimons)**
By default, eKLIPse filters out deletions smaller than 1000bp. Lower this threshold for sublimon detection.
```bash
python eKLIPse.py -in input.txt -ref ref.gbk -mitosize 100
```

## Expert Tips and Best Practices

*   **Alignment Requirements:** Ensure your aligner (e.g., BWA-MEM) is configured to output soft-clipping information in the BAM/SAM files, as eKLIPse relies entirely on these signals.
*   **Reference Selection:** Use the appropriate GenBank file for your species. Common human references like rCRS (NC_012920.1) or CRS (J01415.2) are typically required for clinical or evolutionary studies.
*   **Gap Penalties:** Adjust BLASTn gap parameters based on sequencing technology. For Illumina, which has lower indel error rates, use more stringent penalties (`-gapopen 5 -gapext 2`). For technologies with higher error rates, lower these values.
*   **Filtering:** It is strongly recommended to keep `-bilateral True` (default). This ensures that breakpoints are supported by bidirectional BLAST hits, significantly reducing false positives.
*   **Performance:** Use the `-thread` parameter to specify the number of CPU cores for faster processing of large WGS datasets.

## Reference documentation
- [eKLIPse Overview](./references/anaconda_org_channels_bioconda_packages_eklipse_overview.md)
- [eKLIPse GitHub Repository](./references/github_com_dooguypapua_eKLIPse.md)