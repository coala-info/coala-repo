---
name: conduit-assembler
description: CONDUIT (CONsensus Decomposition Utility In Transcriptome-assembly) is a tool for building transcriptomes independent of a reference genome.
homepage: https://github.com/NatPRoach/conduit
---

# conduit-assembler

## Overview
CONDUIT (CONsensus Decomposition Utility In Transcriptome-assembly) is a tool for building transcriptomes independent of a reference genome. It excels at processing long-read data by decomposing gene-level clusters into distinct isoforms. While it supports a long-read-only "nano" mode, it is optimized for a "hybrid" approach where Illumina RNA-seq data is used to polish and validate the long-read consensus sequences. This tool is particularly useful for researchers working with non-model organisms or complex alternative splicing patterns where high-accuracy isoform discovery is required.

## Installation
The most reliable way to install CONDUIT is via Bioconda:
```bash
conda install -c bioconda conduit-assembler
```

## Core Workflow and Best Practices

### 1. Pre-processing Requirements
Before running CONDUIT, reads must be prepared to ensure high-quality assembly:
*   **Adapter Trimming**: Trim all adapters. Use `porechop` or `ont-guppy` for ONT reads.
*   **Length Filtering**: Filter ONT reads to keep only those $\ge$ 150 bp.
*   **Clustering**: CONDUIT requires reads to be pre-clustered at the gene level. The recommended tool is **RATTLE**.

### 2. Preparing Input Clusters
CONDUIT expects a directory containing one FASTA or FASTQ file per gene cluster. If using RATTLE, follow these steps:
1.  Cluster the reads: `rattle cluster -i reads.fastq --rna --fastq -o clusters/`
2.  Extract the clusters into individual files:
    ```bash
    rattle extract_clusters -i reads.fastq -c clusters/clusters.out --fastq -m 1 -o clusters_dir/
    ```

### 3. Running Assembly

#### Hybrid Mode (Recommended)
This mode uses Illumina data to improve consensus accuracy.
```bash
conduit hybrid -o output_dir/ --tmp-dir tmp_dir/ clusters_dir/ -1 mate_1.fastq.gz -2 mate_2.fastq.gz
```

#### Nano Mode (ONT Only)
Use this if Illumina data is unavailable, though error rates will be higher.
```bash
conduit nano -o output_dir/ --tmp-dir tmp_dir/ clusters_dir/
```

### 4. Key CLI Options

| Option | Description |
| :--- | :--- |
| `--drna` | (Default) Scaffold reads are stranded forward (dRNA-seq). |
| `--cdna` | Scaffold reads are NOT stranded. |
| `--cdna-rev-stranded` | Scaffold reads are reverse complemented relative to coding strand. |
| `-f` / `--fwd-stranded` | Illumina mates originate from the RNA strand. |
| `-r` / `--rev-stranded` | (Default) Illumina mate 1 is the reverse complement of the RNA strand. |
| `-u` / `--unstranded` | Illumina reads are unstranded. |

## Expert Tips
*   **Memory Management**: Use the `--tmp-dir` flag to point to a drive with sufficient space, as the decomposition process can generate significant intermediate data.
*   **Input Format**: While CONDUIT supports both FASTA and FASTQ for scaffold reads, FASTQ (`--sfq`) is the default and generally preferred for retaining quality information.
*   **Strandedness**: Ensure your Illumina strandedness settings (`-f`, `-r`, or `-u`) match your library preparation protocol, as incorrect strandedness will significantly degrade the assembly quality.

## Reference documentation
- [CONDUIT GitHub Repository](./references/github_com_NatPRoach_conduit.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_conduit-assembler_overview.md)