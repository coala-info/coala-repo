---
name: emvc-2
description: EMVC-2 is a specialized tool for identifying Single Nucleotide Variants (SNVs) in genomic sequencing data.
homepage: https://github.com/guilledufort/EMVC-2
---

# emvc-2

## Overview

EMVC-2 is a specialized tool for identifying Single Nucleotide Variants (SNVs) in genomic sequencing data. By leveraging an Expectation Maximization (EM) algorithm, it provides an efficient alternative to traditional variant callers. It is implemented in C with a Python wrapper to ensure high performance during the computationally intensive candidate variant finding phase while maintaining ease of use. This skill is best suited for researchers working with aligned BAM files who require a fast, statistically-driven approach to variant discovery.

## Usage Patterns

### Basic SNV Calling
The most common use case involves providing an aligned BAM file and a corresponding reference genome.

```bash
emvc-2 -i input.bam -r reference.fasta -o variants.vcf
```

### Optimized Performance
For larger datasets, utilize the multithreading capability to speed up the process. The default is 8 threads.

```bash
emvc-2 -i input.bam -r reference.fasta -p 16 -o variants.vcf
```

### Tuning the EM Algorithm
You can adjust the sensitivity and behavior of the Expectation Maximization algorithm using the iterations and learners parameters.

*   **Increasing Iterations**: Higher values may improve convergence at the cost of time (default is 5).
*   **Adjusting Learners**: Modifies the number of learners used in the model (default is 7).

```bash
emvc-2 -i input.bam -r reference.fasta -t 10 -m 10 -o variants.vcf
```

## Expert Tips and Best Practices

*   **Input Preparation**: Ensure your BAM file is properly sorted and indexed using `samtools` before running EMVC-2. The tool expects high-quality alignments (e.g., from BWA MEM).
*   **Reference Compatibility**: While the tool supports various references, it was extensively tested with the `hs37d5` human reference genome. Ensure your reference file is in FASTA format (compressed `.fa.gz` is supported).
*   **Environment Management**: EMVC-2 has specific dependency requirements (Python 3.8.1, Samtools 1.9). It is highly recommended to run this tool within a dedicated Conda environment to avoid library conflicts, especially with `scikit-learn` and `numpy` versions.
*   **SNV Focus**: Note that EMVC-2 is specifically an SNV caller. If your workflow requires Indel (insertion/deletion) detection, you will need to complement this tool with a specialized Indel caller.
*   **Memory Considerations**: When increasing the number of threads (`-p`), ensure the system has sufficient RAM to handle the parallel processing of genomic regions.

## Reference documentation
- [EMVC-2 GitHub Repository](./references/github_com_guilledufort_EMVC-2.md)
- [EMVC-2 Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_emvc-2_overview.md)