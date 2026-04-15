---
name: reditools3
description: REDItools3 profiles RNA editing events in large-scale transcriptomic datasets by identifying base substitutions in RNA-seq alignments. Use when user asks to detect RNA editing sites, filter genomic polymorphisms using matched DNA-seq data, or calculate RNA editing indices.
homepage: https://github.com/BioinfoUNIBA/REDItools3
metadata:
  docker_image: "quay.io/biocontainers/reditools3:3.6--pyhdfd78af_0"
---

# reditools3

## Overview
REDItools3 is a high-performance Python 3 implementation designed for profiling RNA editing events in large-scale transcriptomic datasets. It identifies base substitutions by comparing RNA-seq alignments against a reference genome. The tool is particularly effective for distinguishing true editing events from genomic polymorphisms when matched DNA-seq data is available, and it includes specialized modules for calculating editing indices and identifying repetitive elements.

## Installation and Execution
Install the tool via Bioconda or PyPi:
```bash
conda install bioconda::reditools3
# OR
pip install REDItools3
```

Run the suite using the Python module interface:
```bash
python -m reditools <tool_name> [options]
```

## Core Tool Workflows

### 1. Event Detection (analyze)
The `analyze` tool is the primary engine for detecting substitutions. It processes one or more BAM files and produces a tab-separated table.
- **Input**: RNA-seq BAM files and a reference genome.
- **Output**: A TSV containing position-level data including coverage, base counts [A, C, G, T], and substitution frequency.
- **Best Practice**: By default, REDItools3 (v3.4+) includes supplementary reads and sets the minimum number of edits to 1. Ensure your BAM files are indexed.

### 2. Genomic Filtering (annotate)
To eliminate false positives caused by genomic SNPs, use the `annotate` tool to cross-reference RNA results with DNA-seq data.
- **Workflow**: 
    1. Run `analyze` on your RNA-seq BAM to create `rna_output.txt`.
    2. Run `analyze` on your matched DNA-seq BAM to create `dna_output.txt`.
    3. Run `annotate` to merge them:
       ```bash
       python -m reditools annotate rna_output.txt dna_output.txt > annotated_output.txt
       ```
- **Result**: The last five columns of the RNA file (gCoverage, gMeanQ, gBaseCount, gAllSubs, gFrequency) will be populated with DNA-seq evidence. Positions where the DNA-seq shows the same "variant" as the RNA-seq are likely SNPs rather than editing sites.

### 3. Editing Index Calculation (index)
The `index` tool computes the RNA editing index from the output of the `analyze` tool.
- **Utility**: Provides a global metric of editing activity across the transcriptome.
- **Note**: While A-to-I (A-to-G) is the most common target, the tool computes indices for all possible substitution types.

## Expert Tips and Best Practices
- **Strand Detection**: REDItools3 handles strand information (+, -, or *). If your library is strand-specific, ensure the strand column is correctly interpreted to avoid misidentifying A-to-G as T-to-C.
- **Quality Thresholds**: Pay close attention to the `Coverage` and `MeanQ` (Mean Quality) columns. High-confidence editing sites typically require a minimum coverage depth and high base call quality to rule out sequencing errors.
- **Edit Filters**: Starting with version 3.4, the tool implements default filters for AG and CT transitions. If you are looking for non-canonical editing, you may need to adjust specific edit filter parameters.
- **Repetitive Elements**: Use the `find-repeats` tool if you need to identify or mask repetitive regions in your FASTQ files before or during analysis, as editing often clusters in Alu/repetitive elements.

## Reference documentation
- [REDItools3 GitHub Repository](./references/github_com_BioinfoUNIBA_REDItools3.md)
- [Bioconda reditools3 Overview](./references/anaconda_org_channels_bioconda_packages_reditools3_overview.md)