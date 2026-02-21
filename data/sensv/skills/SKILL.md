---
name: sensv
description: SENSV is a structural variant detection pipeline that processes raw sequencing reads to identify genomic rearrangements.
homepage: https://github.com/HKU-BAL/SENSV
---

# sensv

## Overview

SENSV is a structural variant detection pipeline that processes raw sequencing reads to identify genomic rearrangements. It leverages a combination of alignment tools and specialized calling modules to produce a final VCF file. This skill assists in navigating the multi-step installation process, managing external data dependencies (such as reference indices and pre-computed data files), and executing the primary CLI for variant discovery.

## Installation and Environment Setup

The most reliable way to deploy SENSV is via Conda.

### Bioconda Installation
```bash
# Create and activate the environment
conda create -n sensv-env -c bioconda sensv python=3.7
conda activate sensv-env

# CRITICAL: Run the post-setup script to link necessary modules
cd $(dirname `which sensv`) && make post_link && cd -
```

### Required Data Resources
SENSV requires specific data files and a properly indexed reference genome to function.

1.  **SENSV Data Package**: Download and extract the supporting data files.
    ```bash
    curl http://www.bio8.cs.hku.hk/sensv/data_v1.0.4.tar.gz --output data.tar.gz
    tar -xf data.tar.gz
    ```
2.  **Reference Indexing**: Ensure your reference FASTA has a corresponding `.fai` index.
    ```bash
    samtools faidx hs37d5.fa
    ```

## Command Line Usage

The basic syntax for running a variant calling task is:

```bash
sensv -sample_name <NAME> -fastq <READS.fq.gz> -ref <REF.fa> -output_prefix <DIR/PREFIX>
```

### Required Arguments
- `-sample_name`: Identifier for the sample being processed.
- `-fastq`: Path to the input reads (supports raw or gzipped FASTQ).
- `-ref`: Path to the reference genome FASTA file.
- `-output_prefix`: Path and prefix for all intermediate and final output files. It is recommended to point this into a dedicated output directory.

### Optional Filtering
You can constrain the size of the structural variants detected:
- `-min_sv_size`: Minimum SV size to be called (e.g., 50).
- `-max_sv_size`: Maximum SV size to be called.

## Best Practices and Tips

- **Output Management**: SENSV generates several intermediate files. Always provide an `-output_prefix` that includes a directory (e.g., `./results/sample1`) to keep the workspace organized.
- **Final Result**: The primary output file is located at `<output_prefix>_final.vcf`.
- **Reference Compatibility**: While the tool is often used with GRCh37 (hs37d5), ensure the chromosome naming convention in your FASTQ matches your reference file to avoid alignment errors.
- **Resource Allocation**: SENSV utilizes tools like `minimap2` and `pigz` internally; ensure your environment has sufficient CPU and memory for high-depth FASTQ processing.

## Reference documentation
- [SENSV Overview](./references/anaconda_org_channels_bioconda_packages_sensv_overview.md)
- [SENSV GitHub Repository](./references/github_com_HKU-BAL_SENSV.md)