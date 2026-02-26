---
name: how_are_we_stranded_here
description: This tool determines the library strandedness of RNA-Seq data by sampling reads and comparing them against a reference transcriptome. Use when user asks to check sequencing orientation, identify library type, or infer strandedness for downstream analysis.
homepage: https://github.com/betsig/how_are_we_stranded_here
---


# how_are_we_stranded_here

## Overview
This tool solves a common bioinformatics headache: processing RNA-Seq data without knowing the specific library orientation used during sequencing. By sampling a small subset of reads (default 200,000) and pseudoaligning them to a transcriptome using kallisto, it generates a temporary BAM file to run RSeQC's `infer_experiment.py`. The tool then provides a clear interpretation of the results, allowing you to correctly configure downstream tools like featureCounts, HTSeq, or STAR.

## Usage Guidelines

### Basic Command Pattern
To check strandedness, you need a GTF annotation, a transcriptome FASTA (e.g., Ensembl cdna.fasta), and your FASTQ files.

```bash
check_strandedness --gtf <annotation.gtf> --transcripts <transcripts.fasta> --reads_1 <forward.fq.gz> --reads_2 <reverse.fq.gz>
```

### Key Arguments
- `--gtf`: Path to the gene model/annotation file.
- `--transcripts`: Path to the transcriptome sequences or a pre-built kallisto index.
- `--reads_1` / `--reads_2`: Input FASTQ files (supports gzipped files).
- `-n`: Number of reads to sample (default is 200,000; increase if results are ambiguous).

### Interpreting Results
The tool outputs the fraction of reads explained by different orientations. Look for the "likely" interpretation at the end of the output:
- **RF/fr-firststrand**: Common for dUTP, TruSeq Stranded, and Agilent SureSelect.
- **FR/fr-secondstrand**: Common for Directional mRNA-seq or ScriptSeq.
- **Unstranded**: Standard Illumina TruSeq non-stranded.

### Expert Tips
- **Kallisto Versions**: If you encounter errors during pseudoalignment, ensure you are using `kallisto` version 0.44.x. Newer versions sometimes break the `--genomebam` projection used by this tool.
- **Reference Matching**: Ensure the GTF and Transcripts FASTA come from the same genome release (e.g., Ensembl Release 104) to avoid mapping mismatches.
- **Intermediate Files**: The tool creates a directory named after your `reads_1` file to store intermediate BAMs and indices. You can delete this folder after the check is complete to save space.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_signalbash_how_are_we_stranded_here.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_how_are_we_stranded_here_overview.md)