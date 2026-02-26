---
name: micro_razers
description: MicroRazerS is a high-performance alignment tool specifically engineered for mapping small RNA sequencing data to a reference genome. Use when user asks to align short reads, map small RNA sequences, or identify small RNA species with mismatches.
homepage: https://github.com/seqan/seqan/tree/seqan-v2.1.1/apps/micro_razers
---


# micro_razers

## Overview
MicroRazerS is a high-performance alignment tool specifically engineered for the unique requirements of small RNA sequencing data. Unlike general-purpose aligners, it is optimized for very short read lengths and provides the sensitivity required to identify small RNA species even with mismatches or sequencing errors. It is part of the SeqAn library and is particularly effective when working with Bioconda-based bioinformatics pipelines.

## Usage Patterns

### Basic Alignment
The standard workflow involves mapping a set of small RNA reads (FASTA/FASTQ) against a reference genome (FASTA).

```bash
micro_razers [OPTIONS] <REFERENCE_FILE> <READS_FILE>
```

### Common CLI Options
*   **-m, --max-hits**: Specify the maximum number of hits to report for each read.
*   **-pa, --purge-ambiguous**: Remove reads that map to more than the maximum allowed hits.
*   **-s, --seed-length**: Adjust the seed length (default is usually optimized for ~20bp).
*   **-e, --errors**: Set the maximum number of allowed mismatches/errors.
*   **-o, --output**: Specify the output filename (typically in SAM or RazerS format).

### Expert Tips
*   **Sensitivity vs. Speed**: For small RNA, it is often better to allow 1-2 mismatches (`-e 1` or `-e 2`) to account for post-transcriptional modifications (like uridylation) or sequencing errors in the 3' ends.
*   **Memory Management**: When working with large reference genomes (e.g., Human), ensure you are using the `linux-64` version as it is optimized for 64-bit memory addressing.
*   **Bioconda Environment**: It is recommended to run micro_razers within a dedicated conda environment to manage dependencies:
    ```bash
    conda create -n srna_env micro_razers
    conda activate srna_env
    ```

## Reference documentation
- [MicroRazerS Overview](./references/anaconda_org_channels_bioconda_packages_micro_razers_overview.md)
- [SeqAn Apps Repository](./references/github_com_seqan_seqan_tree_seqan-v2.1.1_apps_micro_razers.md)