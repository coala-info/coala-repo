---
name: ibdseq
description: The ibdseq tool identifies and analyzes Identity-By-Descent (IBD) segments in genetic data. Use when user asks to detect IBD segments, perform genetic linkage analysis, or reconstruct pedigrees.
homepage: https://anaconda.org/channels/bioconda/packages/ibdseq/overview
---


# ibdseq

yaml
name: ibdseq
description: |
  Tools for identifying and analyzing Identity-By-Descent (IBD) segments in genetic data.
  Use when Claude needs to perform analyses related to IBD segment detection,
  genotyping, and related genetic data processing tasks.
```

## Overview

The `ibdseq` tool is designed for the identification and analysis of Identity-By-Descent (IBD) segments within genetic datasets. It is particularly useful for researchers and bioinformaticians working with population genetics, linkage analysis, and pedigree reconstruction. This skill provides guidance on using `ibdseq` effectively via its command-line interface.

## Usage Instructions

The `ibdseq` tool is typically used for detecting IBD segments between pairs of individuals. The primary input is usually a VCF (Variant Call Format) file containing genotype data.

### Basic IBD Detection

The most common use case involves specifying input VCF files and outputting the detected IBD segments.

**Command Structure:**

```bash
ibdseq -g <input.vcf> -p <output_prefix> [options]
```

*   `-g <input.vcf>`: Specifies the input VCF file containing genotype data.
*   `-p <output_prefix>`: Sets a prefix for the output files. `ibdseq` will generate files like `<output_prefix>.ibdseg` and `<output_prefix>.indiv`.

### Key Options and Best Practices

*   **Minimum Segment Length (`-m` or `--min-len`):**
    *   Specify the minimum length of an IBD segment to be reported (in Morgans).
    *   **Expert Tip:** The optimal value depends on the population structure and recombination rates. For human populations, values between 1 and 5 Morgans are common starting points. Experimentation may be needed.
    *   Example: `-m 2`

*   **Minimum Individuals for IBD (`-n` or `--min-n`):**
    *   Defines the minimum number of individuals that must share an IBD segment for it to be reported. This is crucial for population-level analyses.
    *   **Expert Tip:** For pairwise IBD, this is typically set to 2. For detecting segments shared by a larger group, increase this value.
    *   Example: `-n 2`

*   **Window Size (`-w` or `--window`):**
    *   Determines the size of the sliding window used for IBD detection.
    *   **Expert Tip:** A smaller window size can detect shorter IBD segments but may increase computational time and false positives. A larger window is more robust for longer segments.
    *   Example: `-w 0.1`

*   **Outputting Individual Information (`-o` or `--output-indiv`):**
    *   By default, `ibdseq` outputs IBD segments. Use this option to also output individual-level information, which can be useful for downstream analyses.
    *   Example: `-o`

### Example Workflow

To detect IBD segments between all pairs of individuals in `my_genotypes.vcf`, with a minimum segment length of 3 Morgans, and save the output with the prefix `ibd_results`:

```bash
ibdseq -g my_genotypes.vcf -p ibd_results -m 3
```

This will generate files such as `ibd_results.ibdseg` (containing the detected IBD segments) and `ibd_results.indiv` (containing individual-specific information).

## Reference documentation

*   [Anaconda.org Channels Bioconda Packages IBDseq Overview](./references/anaconda_org_channels_bioconda_packages_ibdseq_overview.md)