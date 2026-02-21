---
name: n50
description: The `n50` tool is a specialized command-line utility for bioinformaticians to assess the quality and continuity of sequence assemblies.
homepage: http://metacpan.org/pod/Proch::N50
---

# n50

## Overview
The `n50` tool is a specialized command-line utility for bioinformaticians to assess the quality and continuity of sequence assemblies. It processes FASTA and FASTQ files to calculate the N50 value—the contig length at which 50% of the total assembly length is covered—along with other critical metrics like the area under the Nx curve (auN). It is designed to be lightweight with minimal dependencies, making it ideal for quick quality control checks in genomic workflows.

## Usage and Best Practices

### Installation
The tool is primarily distributed via Bioconda. To ensure all dependencies (like the `Proch::N50` Perl module) are correctly handled, install it within a Conda environment:
```bash
conda install -c bioconda n50
```

### Core Metrics
When interpreting output, focus on these key statistics provided by the tool:
- **N50**: The standard metric for assembly contiguity.
- **N75/N90**: Useful for assessing the "long tail" of shorter contigs in an assembly.
- **auN (area under the Nx curve)**: A more robust metric than N50 alone, as it is less sensitive to the specific choice of the 50% threshold.
- **L50**: The number of sequences required to reach the N50 length.

### Common CLI Patterns
While the tool is often used for simple N50 calculation, it supports more comprehensive data extraction:
- **Basic Calculation**: Run the tool directly on a FASTA or FASTQ file to get standard statistics.
- **JSON Output**: Use the JSON output flag (typically enabled via the CLI) when you need to pipe assembly statistics into downstream automated reporting tools or web dashboards.
- **Custom N-metrics**: You can specify custom N-values (e.g., N80) if your project requirements deviate from the standard N50/N90 benchmarks.

### Expert Tips
- **Input Flexibility**: The tool handles both FASTA and FASTQ formats. You do not need to convert your raw reads to FASTA just to check the N50 of your sequencing run.
- **Minimalist Workflows**: Because `n50` is designed with minimal dependencies, it is an excellent choice for use inside lightweight containers or environments where large bioinformatics suites (like QUAST) are too heavy.
- **Assembly Comparison**: When comparing two assemblies, always look at the `auN` value alongside the `N50`. A higher `auN` generally indicates a more contiguous assembly across the entire length distribution, not just at the median point.

## Reference documentation
- [anaconda_org_channels_bioconda_packages_n50_overview](./references/anaconda_org_channels_bioconda_packages_n50_overview.md)
- [metacpan_org_pod_Proch__N50](./references/metacpan_org_pod_Proch__N50.md)