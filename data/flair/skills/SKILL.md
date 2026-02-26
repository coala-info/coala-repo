---
name: flair
description: FLAIR is a bioinformatics suite designed to identify, correct, and quantify high-confidence transcripts from noisy long-read sequencing data. Use when user asks to align long reads, correct splice sites, collapse reads into isoforms, quantify transcript abundance, or perform differential splicing analysis.
homepage: https://github.com/BrooksLabUCSC/flair
---


# flair

## Overview

FLAIR (Full-Length Alternative Isoform analysis of RNA) is a specialized bioinformatics suite designed to handle the unique challenges of noisy long-read sequencing data. While long reads provide the advantage of spanning entire transcripts, their higher error rates (particularly in Nanopore data) can lead to false splice site detection. FLAIR solves this by using a multi-step pipeline that aligns reads, corrects them using known splice sites or high-confidence data, collapses them into a set of representative isoforms, and then quantifies those isoforms for differential expression or splicing analysis.

## Core Workflow and CLI Patterns

The standard FLAIR pipeline follows a sequential execution of subcommands.

### 1. Alignment (flair align)
Align your raw reads (FastQ) to the reference genome. FLAIR typically uses minimap2 internally.
- **Best Practice**: Ensure your reference genome index is compatible with the version of minimap2 bundled or used by FLAIR.

### 2. Correction (flair correct)
Correct misaligned splice sites using a reference GTF or short-read splice site evidence.
- **Pattern**: `flair correct -f annotation.gtf -q aligned_reads.bed -g genome.fa`
- **Tip**: This step is critical for noisy ONT reads to ensure that exon boundaries align with known biology.

### 3. Isoform Definition (flair collapse)
Collapse corrected reads into a set of high-confidence isoforms.
- **Pattern**: `flair collapse -g genome.fa -r reads.fastq -q corrected_reads.bed`
- **Expert Tip**: Use the `--remove_internal_priming` flag to filter out transcripts that may have originated from internal poly-A priming rather than the true 3' end of the mRNA.

### 4. Quantification (flair quantify)
Estimate the abundance of the defined isoforms across your samples.
- **Pattern**: `flair quantify -r reads_manifest.tsv -i collapsed_isoforms.fa`
- **Manifest Format**: The manifest should be a tab-delimited file containing: `sample_name`, `condition`, `batch`, and `reads_fastq_path`.

### 5. Differential Analysis (flair diffexp & flair diffsplice)
Perform statistical testing for differential isoform usage or alternative splicing events.
- **diffexp**: Identifies changes in total transcript abundance.
- **diffsplice**: Specifically looks for changes in the proportion of isoforms used (Percent Spliced In - PSI).

## Expert Tips and Troubleshooting

- **Genome Annotation**: Always ensure your GTF and reference FASTA use the same chromosome naming convention (e.g., both using "chr1" or both using "1").
- **Memory Management**: For very large BED files, ensure your environment has sufficient RAM, as the `collapse` step can be memory-intensive.
- **Version Compatibility**: As of version 3.0.0, some legacy scripts (like `bam2Bed12`) have been integrated or removed. Always use the main `flair <subcommand>` entry point rather than calling scripts in the `bin/` directory directly.
- **Strand Specificity**: If your library preparation was strand-specific, ensure you pass the appropriate parameters to `flair align` and `flair collapse` to improve isoform accuracy.

## Reference documentation

- [flair - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_flair_overview.md)
- [BrooksLabUCSC/flair: Full-Length Alternative Isoform analysis of RNA](./references/github_com_BrooksLabUCSC_flair.md)
- [Issues · BrooksLabUCSC/flair](./references/github_com_BrooksLabUCSC_flair_issues.md)