---
name: seqbuster
description: SeqBuster is a specialized bioinformatic suite designed for the high-throughput analysis of small RNA (sRNA) datasets.
homepage: https://github.com/lpantano/seqbuster
---

# seqbuster

## Overview

SeqBuster is a specialized bioinformatic suite designed for the high-throughput analysis of small RNA (sRNA) datasets. Its primary utility lies in the precise annotation of microRNAs (miRNAs) and their variants, known as isomiRs. The core of the current toolkit is `miraligner`, a Java-based tool that aligns sRNA reads to miRBase to characterize sequences based on their variations at the 5' and 3' ends, as well as internal nucleotide substitutions. Use this skill to guide users through the command-line workflow of transforming raw sequencing reads into detailed miRNA expression profiles.

## Command-Line Usage and Best Practices

### Installation
The most reliable way to deploy SeqBuster is via Bioconda.
```bash
conda install -c bioconda seqbuster
```

### Core Workflow: miraligner
The `miraligner` tool is the primary executable for miRNA/isomiR annotation. It requires a pre-formatted database (usually from miRBase) and input sequences in fastq or collapsed fasta format.

**Basic Command Pattern:**
```bash
miraligner -i <input.fastq> -db <database_dir> -o <output_prefix>
```

**Key Parameters and Expert Tips:**
- **Input Format**: While it supports fastq, using collapsed fasta files (where identical reads are merged and counts are stored in the header) significantly reduces processing time.
- **Length Filtering**: By default, `miraligner` often ignores reads shorter than 18 nucleotides. If working with highly degraded samples or specific sRNA classes, ensure your input reads meet this threshold after trimming.
- **Frequency Parameter (`-freq`)**: Use this flag to include the frequency of each isomiR in the output, which is essential for downstream differential expression analysis.
- **Species Specificity**: Ensure the `-db` directory contains the specific miRBase files for your target organism to avoid cross-species mapping errors.

### Pre-processing: Adapter Removal
Small RNA inserts are typically shorter than the sequencing read length, meaning the 3' adapter is almost always sequenced.
- **Tool**: `adrec` (or the adapter removal module within the suite).
- **Best Practice**: Always perform 3' adapter trimming before running `miraligner`. If using external tools like Cutadapt or Trimmomatic, ensure that only reads within the 18-26nt range are retained for optimal miRNA mapping.

### Output Interpretation
The tool generates a tabular file containing:
1. **Read Sequence**: The actual sequence detected.
2. **miRNA Name**: The base miRNA from miRBase.
3. **isomiR Type**: Categorization of the variation (e.g., 5' trim, 3' addition, substitution).
4. **Counts**: Number of times the sequence was observed.

## Reference documentation
- [SeqBuster GitHub Repository](./references/github_com_lpantano_seqbuster.md)
- [SeqBuster Wiki and Documentation](./references/github_com_lpantano_seqbuster_wiki.md)
- [Bioconda SeqBuster Package Overview](./references/anaconda_org_channels_bioconda_packages_seqbuster_overview.md)