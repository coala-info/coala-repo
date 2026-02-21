---
name: isotools
description: `isotools` is a specialized Python library designed to handle the unique challenges of long-read transcriptomics.
homepage: https://github.com/MatthiasLienhard/isotools
---

# isotools

## Overview

`isotools` is a specialized Python library designed to handle the unique challenges of long-read transcriptomics. It allows researchers to import aligned full-length transcripts (BAM files), compare them against reference annotations (GFF3/GTF), and classify novel transcripts using a biologically motivated scheme. The tool is particularly effective for defining alternative splicing events based on segment graphs and performing differential splicing analysis across different experimental groups.

## Core Workflow Patterns

### 1. Initializing the Transcriptome Object
Always start by loading a reference annotation. This serves as the backbone for all subsequent transcript classifications.

```python
from isotools import Transcriptome
import logging

# Set up logging to monitor import progress
logging.basicConfig(format='%(levelname)s:%(message)s', level=logging.INFO)

# Load reference (supports gzipped GFF3/GTF)
isoseq = Transcriptome.from_reference('path/to/reference.gff.gz')
```

### 2. Importing Sample Data
Add samples from BAM files. It is best practice to define groups and platforms during import to facilitate downstream differential analysis.

```python
# Add samples individually or in a loop
isoseq.add_sample_from_bam(
    'sample_1.bam', 
    sample_name='CTL_1', 
    group='Control', 
    platform='SequelII'
)
```

### 3. Quality Control and Persistence
Computing QC metrics requires the reference fasta file. To avoid re-processing large BAM files, save the processed `Transcriptome` object as a pickle file.

```python
# Add QC metrics (requires genome fasta)
isoseq.add_qc_metrics('genome_reference.fa')

# Save for fast future access
isoseq.save('my_dataset.pkl')

# To reload later:
# isoseq = Transcriptome.load('my_dataset.pkl')
```

## Expert Tips and Best Practices

- **Memory Management**: For very large datasets, process samples individually and save the `Transcriptome` object. The `.pkl` format is significantly faster than re-parsing BAM files.
- **Reference Consistency**: Ensure the chromosome names in your GFF3/GTF reference exactly match those in your BAM headers and genome FASTA file.
- **Classification Scheme**: `isotools` uses a specific classification for novel transcripts (e.g., "novel isoform", "antisense", "intergenic"). Use these categories to filter for high-confidence novel splicing events before performing differential testing.
- **Alternative Splicing**: Use the segment graph-based approach for defining splicing events. This is more robust for long reads than traditional exon-skipping definitions used in short-read tools.
- **Visualization**: Utilize the built-in plotting functions for sashimi plots and transcript structure comparisons to validate novel isoforms visually.

## Reference documentation
- [IsoTools GitHub Repository](./references/github_com_MatthiasLienhard_isotools.md)
- [IsoTools Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_isotools_overview.md)