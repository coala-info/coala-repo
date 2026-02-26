---
name: mirge
description: miRge processes small RNA sequencing data to perform quality control, adapter trimming, and alignment against miRNA databases. Use when user asks to annotate miRNAs, identify isomiRs or tRNA fragments, and generate functional expression profiles from raw sequencing reads.
homepage: https://github.com/mhalushka/miRge
---


# mirge

## Overview
The mirge skill enables the processing of small RNA sequencing data through a streamlined pipeline. It handles the transition from raw sequencing reads to functional expression profiles by performing quality control, adapter trimming, and alignment against specialized databases like miRBase or MirGeneDB. This tool is particularly effective for researchers needing to identify non-canonical miRNA variants (isomiRs) or other small non-coding RNAs like tRFs in a single workflow.

## Installation and Setup
The most reliable way to install miRge2.0 is via Bioconda to ensure all dependencies (Bowtie, SAMtools, RNAfold) are correctly managed.

```bash
conda config --add channels defaults
conda config --add channels conda-forge
conda config --add channels bioconda
conda install mirge
```

**Note on Libraries**: miRge requires species-specific libraries (Human, Mouse, Rat, Zebrafish, Nematode, or Fruitfly). These must be downloaded and unzipped into a directory, the absolute path of which is passed to the `-lib` argument.

## Common CLI Patterns

### Basic miRNA Annotation
To perform standard annotation of a FASTQ file using miRBase:
```bash
miRge2.0 annotate -s sample.fastq -d miRBase -pb /usr/local/bin/bowtie -lib /path/to/miRge.Libs -sp human -ad illumina -cpu 4
```

### Comprehensive Analysis (isomiRs, tRFs, and A-to-I)
To enable advanced features like A-to-I analysis and tRNA fragment detection:
```bash
miRge2.0 annotate -s sample.fastq -d miRBase -pb /path/to/bowtie -lib /path/to/miRge.Libs -sp human -ad illumina -ai -trf -gff -di
```

### Working with Multiple Samples
You can provide a text file where each row is a sample name, or list multiple FASTQ files directly:
```bash
miRge2.0 annotate -s sample1.fastq sample2.fastq sample3.fastq -d miRBase -pb /path/to/bowtie -lib /path/to/miRge.Libs -sp mouse -ad ion
```

## Parameter Reference
- `-s`: Input FASTQ files or a text file listing sample names.
- `-d`: Database selection (`miRBase` or `MirGeneDB`).
- `-pb`: Absolute path to the Bowtie binary.
- `-lib`: Absolute path to the miRge libraries directory.
- `-sp`: Species (human, mouse, rat, zebrafish, nematode, fruitfly).
- `-ad`: Adapter type (`illumina`, `ion`, or a custom sequence).
- `-ai`: Enables A-to-I editing analysis.
- `-trf`: Enables tRNA fragment (tRF) detection.
- `-gff`: Generates GFF output files.
- `-ex`: Threshold for canonical reads (default 0.1).

## Expert Tips
- **Absolute Paths**: Always use absolute paths for the `-pb` (bowtie) and `-lib` (libraries) arguments to avoid execution errors.
- **Adapter Trimming**: If your data has already been trimmed, you can omit the `-ad` flag, but ensure the reads are in the expected format for alignment.
- **Version Conflicts**: miRge2.0 is known to be incompatible with `cutadapt` v1.18. If you encounter a `TypeError` regarding arguments, check your cutadapt version using `pip freeze`.
- **Memory Management**: For large datasets, use the `-cpu` flag to parallelize the trimming and alignment phases, but ensure your system has sufficient RAM to load the genome indexes.
- **Novel miRNA Detection**: Note that novel miRNA detection (`predict` mode) is currently optimized and confined primarily to human and mouse species.

## Reference documentation
- [miRge GitHub Repository](./references/github_com_mhalushka_miRge.md)
- [miRge Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mirge_overview.md)