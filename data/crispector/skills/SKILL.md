---
name: crispector
description: Crispector detects and quantifies genome editing activity and translocations by applying Bayesian inference to multiplex-PCR NGS data. Use when user asks to detect NHEJ activity, estimate editing rates from treatment and mock samples, or identify genomic rearrangements.
homepage: https://github.com/YakhiniGroup/crispector
---


# crispector

## Overview

`crispector` is a specialized tool for the detection and quantification of genome editing activity, including NHEJ (Non-Homologous End Joining) and translocations. By comparing treatment samples against mock controls, it applies Bayesian inference to accurately estimate editing rates while accounting for background sequencing noise. It is most effective when used with multiplex-PCR NGS data, allowing for the simultaneous evaluation of multiple interrogated loci and the detection of genomic rearrangements.

## Installation

The tool is available via Bioconda or Docker.

**Conda (Python 3.7 required):**
```bash
conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge
conda install crispector
```

**Docker:**
```bash
docker pull quay.io/biocontainers/crispector:1.0.2b9--py_0
docker image tag quay.io/biocontainers/crispector:1.0.2b9--py_0 crispector_image:latest
```

## Command Line Usage

### Multiplex-PCR Input (Default)
This is the standard mode for analyzing experiments where multiple sites are amplified together. This mode supports translocation detection.

```bash
crispector -t_r1 tx_R1.fq.gz -t_r2 tx_R2.fq.gz -m_r1 mock_R1.fq.gz -m_r2 mock_R2.fq.gz -c exp_config.csv
```

**Arguments:**
- `-t_r1`, `-t_r2`: Treatment FASTQ files (Forward and Reverse). Omit `-t_r2` for single-end or merged reads.
- `-m_r1`, `-m_r2`: Mock/Control FASTQ files. Omit `-m_r2` for single-end or merged reads.
- `-c`: Path to the experiment configuration CSV.

### Singleplex-PCR Input
Use this mode when input consists of multiple singleplex-PCRs for loci from the same experiment. Note that translocation detection is disabled in this mode.

**Critical Warning:** Do not mix singleplex FASTQ files from different experiments, as this will lead to incorrect background noise estimation and invalid results.

## Configuration File (CSV)

The configuration file is a CSV with 11 columns. Ensure the header matches the expected format exactly.

| Column | Requirement | Description |
| :--- | :--- | :--- |
| **SiteName** | Required | Unique identifier for the locus. |
| **AmpliconReference** | Required | Full amplicon sequence (5'->3'). |
| **gRNA** | Required | gRNA sequence (without PAM, insertions, or deletions). |
| **OnTarget** | Required | `True` for the intended target, `False` for off-targets. |
| **ForwardPrimer** | Optional | Specific forward primer used. Inferred if empty. |
| **ReversePrimer** | Optional | Specific reverse primer used. Inferred if empty. |
| **TxInput1Path** | Optional | Leave empty for standard multiplex mode. |
| **TxInput2Path** | Optional | Leave empty for standard multiplex mode. |
| **MockInput1Path** | Optional | Leave empty for standard multiplex mode. |
| **MockInput2Path** | Optional | Leave empty for standard multiplex mode. |
| **DonorReference** | Optional | Amplicon sequence for HDR experiments (NHEJ only evaluated). |

## Best Practices and Expert Tips

- **Memory Allocation:** When running via Docker, ensure the container has at least 4GB of RAM allocated.
- **Input Compression:** `crispector` natively supports gzip-compressed FASTQ files (`.fq.gz` or `.fastq.gz`).
- **Docker Mounting:** Always use `${PWD}` to mount your data directory to ensure the tool can find your input files and write outputs correctly:
  `docker run -v ${PWD}:/DATA -w /DATA crispector_image crispector [args]`
- **gRNA Formatting:** Do not include the PAM sequence in the `gRNA` column of the config file. Including the PAM will result in incorrect alignment and activity estimation.
- **Translocation Detection:** Translocations are only detected in Multiplex-PCR mode. If translocations are a primary concern, ensure your library prep follows a multiplexed approach.

## Reference documentation
- [crispector GitHub Repository](./references/github_com_YakhiniGroup_crispector.md)
- [crispector Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_crispector_overview.md)