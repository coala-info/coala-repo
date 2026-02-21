---
name: dysgu
description: Dysgu is a high-performance toolkit designed for the detection and characterization of structural variants.
homepage: https://github.com/kcleal/dysgu
---

# dysgu

## Overview
Dysgu is a high-performance toolkit designed for the detection and characterization of structural variants. It operates by analyzing split-reads, discordant pairs, and soft-clipped alignments to identify genomic rearrangements with high precision. The tool is optimized for efficiency, typically processing a 30X human genome in approximately one hour with low memory overhead. It is particularly effective for researchers working with diverse sequencing platforms who require a unified framework for both germline and complex somatic variant analysis.

## Core Workflows

### Paired-End (Short-Read) Calling
For standard Illumina data, use the `run` command, which automates the `fetch` and `call` stages.
```bash
# Standard execution with 4 threads
dysgu run -p 4 reference.fa temp_dir input.bam > output.vcf

# Recommended: Use --ibam to improve insert size metrics for paired-end data
dysgu run --ibam input.bam reference.fa temp_dir input.bam > output.vcf
```

### Long-Read Calling
Use the `call` command with the appropriate `--mode` preset for your platform.
```bash
# PacBio Revio
dysgu call --mode pacbio-revio reference.fa temp_dir input.bam > output.vcf

# Oxford Nanopore R10
dysgu call --mode nanopore-r10 reference.fa temp_dir input.bam > output.vcf
```

### Somatic and Tumor-Normal Analysis
To identify somatic variants, use the `filter` command to compare a tumor VCF against a normal sample or a panel of normals.
```bash
# Filter tumor calls against a matched normal
dysgu filter --normal-vcf normal.vcf tumor_input.vcf > somatic_output.vcf
```

## Expert Tips and Parameters

- **Model Selection**: 
  - Use the default **diploid** model for germline samples to maximize precision.
  - Set `--diploid False` for somatic samples, tumors, or polyploid organisms where allelic fractions may be low or non-standard.
  - Use `--contigs False` as a fallback if specific SVs are not being picked up; this uses a simpler model based only on read support.
- **Read Accuracy**: For long reads with higher error rates or unknown accuracy, set `--divergence auto` to allow Dysgu to infer the optimal stringency.
- **Phasing**: If your input BAM/CRAM contains `HP` and `PS` tags (from tools like HiPhase or WhatsHap), Dysgu will automatically produce phased output calls.
- **Resource Management**: 
  - Dysgu generates large temporary files (often >5GB). Use the `--clean` flag to automatically delete these files upon completion.
  - Ensure the `temp_dir` is on a fast disk (SSD) to improve performance during the `fetch` stage.
- **Input Handling**: Dysgu supports streaming from stdin, which is useful for processing specific genomic regions.
  ```bash
  samtools view -bh input.bam chr21 | dysgu run --clean reference.fa temp_dir - > chr21_svs.vcf
  ```

## Reference documentation
- [Dysgu GitHub Repository](./references/github_com_kcleal_dysgu.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_dysgu_overview.md)