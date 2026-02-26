---
name: crispector2
description: CRISPECTOR2 evaluates genome editing efficiency by using Bayesian inference to distinguish true editing activity from sequencing noise. Use when user asks to quantify NHEJ activity, perform allele-specific analysis, or detect translocations in multiplex-PCR data.
homepage: https://github.com/theAguy/crispector2
---


# crispector2

## Overview
CRISPECTOR2.0 is a bioinformatics tool designed to evaluate genome editing efficiency by comparing treated samples against unedited (mock) controls. It utilizes Bayesian inference to accurately distinguish true Non-Homologous End Joining (NHEJ) activity from sequencing noise and background variation. The tool is unique in its ability to perform allele-specific quantification and detect translocations between interrogated loci when using multiplex-PCR data.

## Installation and Dependencies
Ensure the environment is prepared before execution:
- **Conda**: `conda install bioconda::crispector2` (Python 3.8 recommended).
- **PIP**: `python3 -m pip install crispector2`.
- **Requirement**: The `fastp` package must be installed independently and available in your PATH.

## Command Line Usage

### Multiplex-PCR Input (Default)
Use this mode when your FASTQ files contain reads from multiple loci amplified in a single reaction. This is the only mode that supports translocation detection.

```bash
# Standard run with allele-specific analysis
crispector --allele -t_r1 tx_R1.fq.gz -t_r2 tx_R2.fq.gz -m_r1 mock_R1.fq.gz -m_r2 mock_R2.fq.gz -c exp_config.csv

# Basic run without allele analysis
crispector -t_r1 tx_R1.fq.gz -t_r2 tx_R2.fq.gz -m_r1 mock_R1.fq.gz -m_r2 mock_R2.fq.gz -c exp_config.csv
```

### Singleplex-PCR Input
Use this mode when you have separate FASTQ files for each locus. In this mode, you must omit the `-t` and `-m` flags and instead provide the full file paths within the configuration CSV.

```bash
crispector --allele -c singleplex_config.csv
```

## Configuration File (CSV) Requirements
The experiment config file (`-c`) is a CSV with 11 specific columns. 

| Column | Requirement | Description |
| :--- | :--- | :--- |
| **SiteName** | Required | Unique identifier for the locus. |
| **AmpliconReference** | Required | 5'->3' sequence of the amplicon. |
| **gRNA** | Required | Guide sequence (exclude PAM, insertions, or deletions). |
| **OnTarget** | Required | `True` for the target site, `False` for off-targets. |
| **ForwardPrimer** | Optional | Inferred from amplicon if left empty. |
| **ReversePrimer** | Optional | Inferred from amplicon if left empty. |
| **TxInput1Path** | Conditional | Path to Treatment R1 (Singleplex mode only). |
| **TxInput2Path** | Conditional | Path to Treatment R2 (Singleplex mode only). |
| **MockInput1Path** | Conditional | Path to Mock R1 (Singleplex mode only). |
| **MockInput2Path** | Conditional | Path to Mock R2 (Singleplex mode only). |
| **DonorReference** | Optional | Amplicon sequence for HDR experiments (Note: HDR activity is not quantified). |

## Expert Tips and Best Practices
- **Background Noise**: Never mix singleplex FASTQ files from different experiments. CRISPECTOR2.0 estimates background noise from the mock sample; mixing experiments will lead to inaccurate statistical modeling.
- **Translocations**: Translocation detection is only possible in Multiplex-PCR mode. If translocations are a primary concern, ensure your library preparation follows a multiplexed workflow.
- **Allele Analysis**: Always use the `--allele` flag if you suspect allele-specific editing patterns or are working with heterozygous samples, as it provides a more granular view of the editing landscape.
- **Input Compression**: The tool natively supports gzip-compressed FASTQ files (`.fq.gz` or `.fastq.gz`), which should be used to save disk space and I/O time.
- **Single-End Data**: If working with single-end or already merged paired-end data, simply omit the `-t_r2` and `-m_r2` arguments.

## Reference documentation
- [CRISPECTOR2 GitHub Repository](./references/github_com_theAguy_crispector2.md)
- [CRISPECTOR2 Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_crispector2_overview.md)