---
name: htseq-clip
description: htseq-clip processes eCLIP/iCLIP sequencing data to generate files for downstream analysis. Use when user asks to process eCLIP/iCLIP data, generate count matrices, or prepare data for DEWSeq.
homepage: https://github.com/EMBL-Hentze-group/htseq-clip
---

# htseq-clip

A toolset for the analysis of eCLIP/iCLIP datasets. Use when Claude needs to process and analyze eCLIP/iCLIP data, particularly for generating files compatible with the DEWSeq R/Bioconductor package. This tool is designed for command-line usage.
---
## Overview

`htseq-clip` is a Python-based command-line toolset specifically designed for the post-processing and analysis of eCLIP (enhanced CLIP) and iCLIP (individual-nucleotide resolution crosslinking and immunoprecipitation) sequencing data. It generates essential files that can be used as input for downstream analysis, notably with the DEWSeq R/Bioconductor package. This tool is primarily for users who need to prepare their CLIP-seq data for further statistical analysis and interpretation of protein-RNA interactions.

## Usage and Best Practices

`htseq-clip` is a command-line utility. The primary function involves processing alignment files (e.g., BAM or BED) to identify and quantify crosslinking events.

### Core Functionality

The tool's main purpose is to take aligned sequencing reads and summarize them into formats suitable for downstream analysis. This typically involves:

*   **Counting reads:** Quantifying the number of reads mapping to specific genomic regions or features.
*   **Generating count matrices:** Creating tables that represent read counts across different samples and genomic annotations.
*   **Handling strand specificity:** Accounting for the strandedness of sequencing libraries.

### Command-Line Interface (CLI) Patterns

While the provided documentation does not detail specific subcommands or their arguments, general usage patterns for bioinformatics tools like `htseq-clip` typically involve:

1.  **Input files:** Specifying input alignment files (e.g., `.bam`, `.bed`).
2.  **Annotation files:** Providing genomic annotation files (e.g., `.gtf`, `.gff`, `.bed`) to define regions of interest (e.g., exons, introns, UTRs).
3.  **Output files:** Defining the path and format for the output files.
4.  **Parameters:** Adjusting parameters for read counting, strand specificity, duplicate handling, and filtering.

**Example (Conceptual - actual command may vary):**

```bash
htseq-clip --input reads.bam --annotation genes.gtf --output counts.tsv --strand specific
```

### Expert Tips

*   **Strand Specificity:** Pay close attention to the `--strand` or equivalent parameter. eCLIP and iCLIP protocols can be strand-specific, and correctly setting this parameter is crucial for accurate analysis. Refer to the documentation for options like `yes`, `no`, `reverse`.
*   **Duplicate Handling:** Consider how PCR duplicates are handled. Some tools offer options to either keep or remove duplicates, which can impact read counts.
*   **Annotation Quality:** Ensure your annotation file is of high quality and matches the genome build used for alignment. Mismatched annotations can lead to incorrect read assignments.
*   **Input Format:** Verify that your input alignment files are properly sorted and indexed if required by the tool.
*   **Output Format:** Understand the format of the output files (e.g., TSV, BEDGraph) as it will dictate how you can use them with other tools like DEWSeq.

**Note:** The `htseq-clip` project is noted as no longer actively maintained, with a recommendation to use "Shoji" instead. For current projects, consider migrating to Shoji if possible.



## Subcommands

| Command | Description |
|---------|-------------|
| htseq-clip | htseq-clip: error: argument subparser: invalid choice: 'createmaxcountmatrix' (choose from 'annotation', 'createSlidingWindows', 'mapToId', 'extract', 'count', 'createMatrix', 'createMaxCountMatrix', 'trimAnnotation') |
| htseq-clip | htseq-clip: error: argument subparser: invalid choice: 'createmtrix' (choose from 'annotation', 'createSlidingWindows', 'mapToId', 'extract', 'count', 'createMatrix', 'createMaxCountMatrix', 'trimAnnotation') |
| htseq-clip | htseq-clip: error: argument subparser: invalid choice: 'createslidingwindows' (choose from 'annotation', 'createSlidingWindows', 'mapToId', 'extract', 'count', 'createMatrix', 'createMaxCountMatrix', 'trimAnnotation') |
| htseq-clip | htseq-clip: error: argument subparser: invalid choice: 'maptold' (choose from 'annotation', 'createSlidingWindows', 'mapToId', 'extract', 'count', 'createMatrix', 'createMaxCountMatrix', 'trimAnnotation') |
| htseq-clip | htseq-clip: error: argument subparser: invalid choice: 'trimannotation' (choose from 'annotation', 'createSlidingWindows', 'mapToId', 'extract', 'count', 'createMatrix', 'createMaxCountMatrix', 'trimAnnotation') |
| htseq-clip annotation | annotation: flattens (to BED format) the given annotation file (in GFF format) |
| htseq-clip count | counts the number of crosslink/deletion/insertion sites |
| htseq-clip extract | extracts crosslink sites, insertions or deletions |

## Reference documentation
- [htseq-clip: a toolset for the analysis of eCLIP/iCLIP datasets](./references/anaconda_org_channels_bioconda_packages_htseq-clip_overview.md)
- [htseq-clip README](./references/github_com_EMBL-Hentze-group_htseq-clip.md)