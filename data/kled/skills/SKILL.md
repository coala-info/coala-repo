---
name: kled
description: kled is a high-performance structural variant caller designed for long-read sequencing data. Use when user asks to identify structural variants from long-read BAM files, call variants using technology-specific presets for ONT or PacBio, or perform haplotype-aware variant calling.
homepage: https://github.com/CoREse/kled
metadata:
  docker_image: "quay.io/biocontainers/kled:1.2.10--h4f462e4_0"
---

# kled

## Overview

kled is a high-performance structural variant caller designed specifically for long-read sequencing data. It processes mapped reads (BAM/SAM/CRAM) against a reference genome to identify structural variants, outputting results in standard VCF format. The tool is optimized for speed and sensitivity, capable of processing whole-genome data in minutes on modern hardware. It includes specialized modes for different sequencing technologies and a haplotype-aware extension called HapKled.

## Basic Usage

The core command requires a reference genome and a mapped reads file. By default, kled outputs to `stdout`.

```bash
# Standard usage (optimized for ONT by default)
kled -R reference.fasta sample.bam > output_svs.vcf
```

## Technology-Specific Presets

While the default parameters are tuned for Oxford Nanopore (ONT) data, you must use specific flags for PacBio data to ensure optimal sensitivity and precision:

- **PacBio HiFi/CCS**: Use the `--CCS` flag.
- **PacBio CLR**: Use the `--CLR` flag.

```bash
# For PacBio HiFi/CCS data
kled -R reference.fasta --CCS sample.ccs.bam > output_ccs_svs.vcf

# For PacBio CLR data
kled -R reference.fasta --CLR sample.clr.bam > output_clr_svs.vcf
```

## Haplotype-Aware Calling (HapKled)

HapKled is a specialized script for handling haplotype-tagged input. It requires external dependencies (Clair3 and WhatsHap) and specific environment variables.

### Setup Requirements
Before running HapKled, ensure the following environment variables are set:
- `HapAwareKled`: Path to the haplotype-aware kled binary.
- `Clair3ModelPath`: Path to the Clair3 models directory.

### Execution
```bash
HapKled -R reference.fasta sample.tagged.bam > output_haplotype_svs.vcf
```

## Best Practices and Tips

- **Input Formats**: kled supports SAM, BAM, and CRAM formats. Ensure your input is properly indexed (`.bai` or `.crai`) for efficient processing.
- **Standard Output**: Since kled writes to `stdout`, always remember to redirect the output to a `.vcf` file to avoid flooding the terminal.
- **Hardware Utilization**: kled is designed to be ultra-fast. When compiling from source, using `cmake --build . -j <threads>` allows for faster builds, and the tool itself is optimized for modern multi-core CPUs.
- **Help Command**: For a full list of advanced parameters (such as filtering thresholds or specific SV type parameters), use:
  ```bash
  kled --help
  ```

## Reference documentation
- [kled GitHub Repository](./references/github_com_CoREse_kled.md)
- [kled Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_kled_overview.md)