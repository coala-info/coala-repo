---
name: shortstack
description: ShortStack is a bioinformatics pipeline for the comprehensive analysis, alignment, and annotation of small RNA-seq data. Use when user asks to identify miRNA genes, perform adapter trimming, align small RNA reads to a reference genome, or discover small RNA clusters.
homepage: https://github.com/MikeAxtell/ShortStack
metadata:
  docker_image: "quay.io/biocontainers/shortstack:4.1.2--hdfd78af_0"
---

# shortstack

## Overview

ShortStack is a specialized bioinformatics pipeline for the comprehensive analysis of small RNA-seq data. It streamlines the transition from raw sequencing reads to annotated genomic loci by performing adapter trimming, genomic alignment, and cluster identification. Its primary strength lies in its ability to distinguish true microRNA (miRNA) genes from other small RNA-producing regions by evaluating both the spatial distribution of reads and the predicted secondary structure of the underlying genomic DNA.

## Installation and Environment

The recommended way to install ShortStack is via Bioconda.

```bash
# Create and activate a dedicated environment
conda create --name ShortStack4 shortstack
conda activate ShortStack4
```

**Note for Apple Silicon (M1/M2/M3) Users:** Some dependencies require the x86_64 architecture. Force the subdir to `osx-64` during environment creation to use Rosetta translation.

## Common CLI Patterns

### Standard Run with Raw Reads
Use this pattern when starting with untrimmed FASTQ files. ShortStack will automatically infer the adapter and perform alignments.
```bash
ShortStack --genomefile genome.fa --readfile reads.fastq.gz --autotrim --threads 8
```

### Processing Pre-aligned BAM Files
If you have already aligned your reads using a specific pipeline, you can skip the alignment step.
```bash
ShortStack --genomefile genome.fa --bamfile aligned.bam --outdir my_results
```

### miRNA Discovery and Annotation
To identify known miRNAs and search for new ones (*de novo*), provide a file of known mature sequences (e.g., from miRBase).
```bash
ShortStack --genomefile genome.fa --readfile reads.fastq --known_miRNAs mature_mirnas.fa --dn_mirna
```

### Trimming Only
If you only want to use ShortStack's robust adapter discovery and trimming logic without running the full annotation pipeline:
```bash
ShortStack --readfile reads.fastq.gz --autotrim_only
```

## Expert Tips and Best Practices

*   **Condensed Reads (v4.1.0+):** Modern versions use a "condensed reads" format to significantly reduce file size and increase processing speed. Ensure your visualization tools (`strucVis` >= 0.9 and `ShortTracks` >= 1.2) are updated to support this format.
*   **Adapter Trimming:** Use `--autotrim` for most libraries. However, if your library contains random nucleotides (Ns) in the 3' adapter or if nucleotide 1 is not the first biological base, you must trim externally (e.g., using `cutadapt`) and provide the trimmed reads without the `--autotrim` flag.
*   **Multi-mapping Reads (`--mmap`):**
    *   `u` (Default): Only uses uniquely mapped reads.
    *   `f`: Uses a fractional weighting scheme for multi-mappers (recommended for comprehensive quantification of repetitive loci).
    *   `r`: Randomly assigns a multi-mapping read to one valid location.
*   **Dicer Sizes:** If working with non-standard small RNA species, adjust `--dicermin` and `--dicermax` (default 21-24nt) to match the expected biology of your organism.
*   **Performance:** ShortStack is multi-threaded. Always specify `--threads` to match your available CPU cores to significantly decrease runtime during the alignment and secondary structure prediction phases.

## Reference documentation
- [ShortStack Main Documentation](./references/github_com_MikeAxtell_ShortStack.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_shortstack_overview.md)