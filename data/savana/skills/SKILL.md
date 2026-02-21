---
name: savana
description: SAVANA is a specialized somatic structural variant (SV) and copy number aberration (SCNA) caller optimized for long-read sequencing technologies like Oxford Nanopore (ONT) and PacBio HiFi.
homepage: https://github.com/cortes-ciriano-lab/savana
---

# savana

## Overview

SAVANA is a specialized somatic structural variant (SV) and copy number aberration (SCNA) caller optimized for long-read sequencing technologies like Oxford Nanopore (ONT) and PacBio HiFi. It processes aligned BAM files to identify, cluster, and classify somatic breakpoints. The tool is particularly effective because it integrates SV detection with copy number analysis, allowing for absolute copy number fitting and tumour purity estimation within a single workflow.

## Installation and Setup

The recommended installation method is via Bioconda:

```bash
conda install -c bioconda savana
```

For successful execution, ensure your input BAM files are aligned using `minimap2` or `winnowmap`.

## Core Command Line Usage

### Standard Somatic SV Calling
To call somatic SVs from a matched tumour-normal pair:

```bash
savana --tumour tumour.bam --normal normal.bam --outdir ./results --ref reference.fasta
```

### SV and Copy Number Aberration (CNA) Calling
To enable CNA detection, you must provide germline SNP information. Using a matched germline SNP VCF is strongly recommended for optimal performance:

```bash
savana --tumour tumour.bam --normal normal.bam --outdir ./results --ref reference.fasta --snp_vcf germline_snps.vcf
```

Alternatively, use built-in population resources for human data:
- `--g1000_vcf 1000g_hg38` (for hg38)
- `--g1000_vcf 1000g_hg19` (for hg19)

### Tumour-Only Mode
When a matched normal sample is unavailable, use the `to` subcommand. Note that population filtering is critical in this mode to remove germline variants:

```bash
savana to --tumour tumour.bam --outdir ./results --ref reference.fasta --g1000_vcf population_snps.vcf
```

## Expert Tips and Best Practices

- **Phasing**: For the highest quality results, phase your input BAM files before running SAVANA. Phased data significantly improves the accuracy of breakpoint consensus and allele-specific copy number calls.
- **Contig Filtering**: Use the `--contigs` argument (e.g., `--contigs chromosomes.txt`) to restrict analysis to primary chromosomes. This reduces runtime and avoids artifacts in unplaced or decoy contigs.
- **Blacklisting**: For CNA calling, provide a BED file of problematic regions (e.g., centromeres, telomeres) using `--blacklist` to reduce false positives.
- **Resource Management**: For a standard 50x/30x WGS pair, ensure adequate memory (typically 16GB+ depending on depth) and use `--threads` to parallelize the clustering and classification steps.
- **Visualization**: SAVANA outputs are compatible with `ReconPlot`. Use it to generate integrated views of SVs and CNAs for manual curation of complex events.
- **Tumour-Only Filtering**: If running in tumour-only mode, post-filter results against gnomadSV (filtering for >10% AF) and a Panel of Normals (PoN) to minimize germline contamination.

## Subcommand Reference

- `run`: Identify and cluster breakpoints (raw variants).
- `classify`: Apply the classification model to an existing VCF.
- `cna`: Run the copy number pipeline independently.
- `to`: Execute the specialized tumour-only workflow.
- `evaluate`: Compare SAVANA outputs against a truth set VCF.

## Reference documentation
- [SAVANA GitHub Repository](./references/github_com_cortes-ciriano-lab_savana.md)
- [Bioconda SAVANA Overview](./references/anaconda_org_channels_bioconda_packages_savana_overview.md)