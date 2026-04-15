---
name: duet
description: Duet performs SNP calling, phasing, and structural variant detection for Oxford Nanopore long-read data to produce high-confidence phased structural variants. Use when user asks to call phased structural variants, integrate SNP and SV signatures, or detect variants in low-coverage ONT datasets.
homepage: https://github.com/yekaizhou/duet
metadata:
  docker_image: "quay.io/biocontainers/duet:1.0--pyhdfd78af_0"
---

# duet

## Overview

Duet is a specialized bioinformatics tool designed for Oxford Nanopore Technologies (ONT) long-read data. It integrates SNP calling and phasing with structural variant detection to produce high-confidence phased SVs. By combining SNP signatures with SV signatures, Duet can accurately distinguish true haplotypes from false signals, making it a robust choice for clinical applications and genomic research involving long-read datasets.

## Installation

Duet is primarily distributed via Bioconda. It is recommended to use a dedicated environment to manage its dependencies (Clair3, WhatsHap, cuteSV, Sniffles, SVIM, and bcftools).

```bash
conda create -n duet -c bioconda duet -y
conda activate duet
```

## Core Usage

The basic command requires an aligned BAM file, a reference FASTA, and an output directory. Both the BAM and FASTA files must be indexed (`.bai` and `.fai` files present in the same directory).

```bash
duet <ALN.bam> <REF.fa> <OUTPUT_DIR> [options]
```

### Primary Output
The main result is stored in `<OUTPUT_DIR>/phased_sv.vcf`. Intermediate results for SNP calling and phasing are also preserved in subdirectories within the output folder.

## CLI Parameters and Best Practices

### SV Caller Selection
Duet supports three base SV callers. Use the `--sv_caller` (or `-b`) flag to choose the one best suited for your project:
- `cutesv` (Default): Generally recommended for a balance of speed and sensitivity.
- `sniffles`: Often preferred for complex SV detection.
- `svim`: Useful for specific clustering needs.

### Performance Tuning
- **Threading**: Use `--threads` (or `-t`) to match your available CPU cores. The default is 4.
- **Contig Handling**: By default, Duet only calls variants on `chr1..22, X, Y`. To process all contigs (e.g., for non-human genomes or unplaced scaffolds), use the `--include_all_ctgs` (or `-a`) flag.

### Filtering and Sensitivity
- **Minimum SV Size**: Adjust `--sv_min_size` (or `-s`) if you are looking for variants smaller than the default 50bp.
- **Support Thresholds**: For low-coverage data, you may need to lower `--min_support_read` (or `-r`), though the default is already set to a sensitive 2 reads.
- **SNP Frequency**: The `--min_allele_frequency` (or `-m`) defaults to 0.25. Adjust this if you suspect low-frequency mosaicism or have specific sample purity concerns.

## Expert Tips
- **Data Preparation**: Ensure your ONT reads are aligned with `minimap2` using the `-x map-ont` or `-x splice` preset for best results before running Duet.
- **Disk Space**: Because Duet runs multiple intermediate tools (Clair3, WhatsHap, etc.), ensure the output directory has sufficient space for temporary VCFs and BAMs.
- **Low Coverage**: Duet is specifically optimized for low-coverage ONT data. If working with <10x coverage, rely on the default `cutesv` integration as it is highly tuned for these scenarios.

## Reference documentation
- [GitHub Repository](./references/github_com_yekaizhou_duet.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_duet_overview.md)