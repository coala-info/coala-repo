---
name: seer
description: Performs sequence element (kmer) enrichment analysis to identify genetic patterns associated with specific phenotypes. Use when user asks to find enriched sequence motifs or kmers that differentiate between sample groups or correlate with continuous traits.
homepage: https://github.com/johnlees/seer
---


# seer

yaml
name: seer
description: |
  Performs sequence element (kmer) enrichment analysis to identify genetic patterns associated with specific phenotypes in biological samples. Use when analyzing genomic data to find enriched sequence motifs or kmers that differentiate between sample groups or correlate with continuous traits.
```
## Overview
The `seer` tool is designed for sequence element (kmer) enrichment analysis. It helps identify recurring DNA or RNA sequence patterns (kmers) that are significantly more common in one set of biological samples compared to another, or that correlate with a specific phenotypic trait. This is particularly useful in genomics and microbial research for understanding the genetic basis of phenotypes.

## Usage Instructions

`seer` is a command-line tool. The primary function involves comparing sequence data from different sample groups to find enriched k-mers.

### Core Functionality

The main command structure typically involves specifying input files and output options. While the exact command can vary based on the specific analysis, a common pattern is:

```bash
seer [options] <input_files>
```

### Key Concepts and Options

*   **Input Data**: `seer` operates on sequence data, often provided in FASTA or FASTQ formats. Phenotype data (e.g., binary traits like "disease/healthy" or continuous traits like "growth rate") is also crucial and typically provided in a separate file.
*   **Kmer Length**: You can specify the length of the sequence elements (kmers) to analyze. Shorter kmers are more common but less specific, while longer kmers are more specific but rarer.
*   **Phenotype File**: This file maps samples to their corresponding phenotypic values. The format and structure of this file are critical for correct analysis. Refer to the documentation for specific formatting requirements.
*   **Output**: `seer` generates reports detailing the enriched kmers, their frequencies, and statistical significance (e.g., p-values). These outputs are essential for interpreting the results.

### Common CLI Patterns and Expert Tips

1.  **Specify Phenotype Data Clearly**: Ensure your phenotype file is correctly formatted and aligned with your sequence data. Mismatches here are a common source of errors.
2.  **Experiment with Kmer Lengths**: The optimal kmer length can vary significantly depending on the biological question and the dataset. Start with a reasonable range (e.g., 3-10) and explore if results change with different lengths.
3.  **Understand Statistical Significance**: Pay close attention to the p-values and other statistical measures provided in the output. These indicate the confidence in the observed enrichment.
4.  **Consult the Wiki for Detailed Usage**: For specific command-line arguments, input file formats, and detailed interpretation of results, the `seer` wiki is an invaluable resource. The README also provides installation and basic usage information.

## Reference documentation
- [README.md](./references/github_com_johnlees_seer.md)
- [seer Wiki Home](./references/github_com_johnlees_seer_wiki.md)