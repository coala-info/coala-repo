---
name: ssdrippipeline
description: The ssdrippipeline is a bioinformatics suite designed to automate the processing and analysis of ssDRIP-seq data from raw reads to biological insights. Use when user asks to align reads, call peaks, perform differential analysis, or generate clustering and metaplots for ssDRIP-seq experiments.
homepage: https://github.com/PEHGP/ssDripPipeline
metadata:
  docker_image: "quay.io/biocontainers/ssdrippipeline:0.0.5--kuan"
---

# ssdrippipeline

## Overview
The `ssdrippipeline` is a comprehensive bioinformatics suite designed specifically for the unique requirements of ssDRIP-seq data. It automates a multi-stage workflow that transitions from raw sequencing data to high-level biological insights. Use this skill to configure the pipeline's JSON-based environment, manage sample metadata via target files, and execute specific analysis modules—ranging from basic alignment and strand-splitting to complex clustering and metaplot generation.

## Installation and Environment
The pipeline is optimized for Python 3.7 and is best managed via Conda.

```bash
# Create and activate the environment
conda create -n ssDripPipeline_env -c conda-forge -c bioconda ssdrippipeline python=3.7
conda activate ssDripPipeline_env
```

## Core Workflow Execution
The primary entry point is `ssDRIPSeqAnalysis.py`. It requires a configuration JSON and a subcommand.

| Subcommand | Description |
| :--- | :--- |
| `BaseAnalysis` | Alignment, duplicate removal, strand splitting, peak calling, and BigWig generation. |
| `DeseqAnalysis` | Differential peak analysis using DESeq2 (requires BaseAnalysis results). |
| `DownstreamAnalysis` | Mfuzz clustering, motif discovery, and skew metaplots (requires DeseqAnalysis). |
| `AllPip` | Executes all three stages sequentially. |

**Basic Usage Pattern:**
```bash
ssDRIPSeqAnalysis.py DripConfig.json <Subcommand>
```

## Configuration Best Practices

### 1. The DripConfig.json File
The pipeline relies heavily on a central JSON configuration. 
*   **Critical**: JSON does not support comments. Ensure all comments are removed before execution.
*   **Paths**: Always use absolute paths for `SeqDataPath`, `GenomeIndex`, `FilterChromFile`, `ChromSize`, `GenomeFastaFile`, and `GeneBed`.
*   **GenomeSize**: This value is essential for accurate peak calling and normalization; ensure it matches your specific assembly.
*   **Spike-in**: If not using spike-in normalization, you can ignore the `SpikeNameList` parameter.

### 2. The Target File
The `Target` parameter in the JSON points to a Tab-Separated Values (TSV) file defining your samples.

**Standard Format (No Spike-in - 4 Columns):**
`Group_Name    Sample_Name    Read1.fastq.gz    Read2.fastq.gz`

**Spike-in Format (7 Columns):**
`Group_Name    Sample_Name    Read1.fastq.gz    Read2.fastq.gz    Input_Name    Input_R1.fastq.gz    Input_R2.fastq.gz`

## Expert Tips and Troubleshooting
*   **Strand Specificity**: The pipeline automatically handles strand splitting. If your results show unexpected strand bias, verify the `MetaplotExtend` and `ContentExtend` parameters in your config to ensure they match your library's expected insert sizes.
*   **Memory Management**: For large genomes, ensure the `Thread` count in the config matches your available hardware, as Bowtie2 and Samtools operations are resource-intensive.
*   **Filtering**: Use the `FilterChromFile` to exclude unplaced scaffolds, mitochondria (ChrM), or chloroplasts (ChrC) to prevent them from skewing normalization metrics.
*   **Output Structure**: The pipeline creates individual directories for each sample. The `Sample_Name_pip.sh` file generated inside each directory contains the specific shell commands executed during `BaseAnalysis`, which is useful for debugging.

## Reference documentation
- [ssDripPipeline GitHub Repository](./references/github_com_PEHGP_ssDripPipeline.md)
- [ssDripPipeline Wiki - Step-by-Step Protocols](./references/github_com_PEHGP_ssDripPipeline_wiki.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_ssdrippipeline_overview.md)