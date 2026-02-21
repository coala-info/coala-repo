---
name: devider
description: The `devider` tool facilitates the separation of long reads into distinct groups based on shared alleles using a SNP-encoded positional de Bruijn graph approach.
homepage: https://github.com/bluenote-1577/devider
---

# devider

## Overview
The `devider` tool facilitates the separation of long reads into distinct groups based on shared alleles using a SNP-encoded positional de Bruijn graph approach. It is optimized for high-depth sequencing (up to 30,000x) and high heterogeneity, where more than 10 haplotypes may be present. Unlike genome-scale haplotypers, `devider` excels at "local" phasing where the target sequence length is comparable to the read length, providing rapid and memory-efficient processing that scales linearly with depth and SNP count.

## Installation
The recommended method is via Bioconda:
```bash
mamba install -c bioconda devider
```

## Core Workflows

### 1. The Automated Pipeline (Recommended)
If installed via conda, use the wrapper script to handle alignment and variant calling automatically. This is the easiest way to go from raw reads to haplotagged results.
```bash
run_devider_pipeline -i <reads.fastq.gz> -r <reference.fasta> -o <output_dir>
```
*   **Requirements**: `minimap2`, `lofreq`, and `tabix` must be in your PATH.
*   **Outputs**: Check `<output_dir>/pipeline_files` for intermediate BAM and VCF files.

### 2. Manual Execution (Granular Control)
Use the core `devider` binary when you already have aligned data and identified variants.
```bash
devider -b <input.bam> -v <variants.vcf.gz> -r <reference.fasta> -o <output_dir>
```

## CLI Parameters and Best Practices
*   **Input Requirements**: VCF files must be compressed and indexed (using `bgzip` and `tabix`).
*   **Target Scale**: Only use `devider` for sequences that fit within the span of your long reads (e.g., a 1kb-10kb gene or viral genome). For whole bacterial genomes, use tools like `floria`.
*   **Performance**: Because it uses a de Bruijn graph approach, it is highly effective for samples with high SNP density and many competing haplotypes.
*   **Interpreting Results**: The tool generates haplotagged BAM files or Multiple Sequence Alignments (MSA), allowing you to visualize the separated groups in genome browsers like IGV.

## Expert Tips
*   **High Depth Handling**: If working with extremely high coverage (>10,000x), `devider` remains efficient where other tools might stall, making it ideal for deep amplicon sequencing.
*   **Environment Setup**: If not using the Conda installation, ensure the `scripts/` directory from the source repository is added to your PATH to utilize the `run_devider_pipeline` helper.
*   **Reference Selection**: Ensure your reference FASTA matches the one used to generate the VCF/BAM to avoid coordinate mismatches during the graph construction.

## Reference documentation
- [github_com_bluenote-1577_devider.md](./references/github_com_bluenote-1577_devider.md)
- [anaconda_org_channels_bioconda_packages_devider_overview.md](./references/anaconda_org_channels_bioconda_packages_devider_overview.md)
- [github_com_bluenote-1577_devider_wiki.md](./references/github_com_bluenote-1577_devider_wiki.md)