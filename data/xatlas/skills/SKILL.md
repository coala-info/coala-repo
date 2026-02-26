---
name: xatlas
description: xatlas is a high-performance small variant caller. Use when user asks to call variants, retrain variant calling models, or filter for strand bias.
homepage: https://github.com/jfarek/xatlas
---


# xatlas

## Overview
xatlas is a high-performance small variant caller developed by the Baylor College of Medicine Human Genome Sequencing Center. It is designed to be both fast and scalable, providing a retrainable framework for identifying genomic variants. It is particularly useful in pipelines requiring VCF v4.3 compliance and efficient handling of high-throughput sequencing data.

## Installation and Setup

### Bioconda (Recommended)
The most efficient way to deploy xatlas is via conda:
```bash
conda install -c bioconda xatlas
```

### Building from Source
If a pre-compiled binary is unavailable for your architecture, build using CMake. Ensure `HTSlib` (v1.6+) and `libpthread` are installed.

```bash
mkdir build
cd build
# If HTSlib is in a non-standard path, use -DHTSLIB_PREFIX=/path/to/htslib
cmake ..
make
```

## Usage Patterns

### Basic Variant Calling
While specific CLI flags often depend on the version, the core workflow involves providing a reference genome and a coordinate-sorted BAM file.

**Key Operational Notes:**
- **VCF Version:** xatlas outputs variants in VCF v4.3 format.
- **Indel Alignment:** The tool automatically left-aligns indel start positions for better consistency with standard representation.
- **Strand Bias:** As of version 0.2, the strand filter is disabled by default. If your specific project requires strand bias filtering, check for the relevant toggle in the help menu (`xatlas --help`).
- **Mismatches:** The tool calculates the number of mismatches in reads directly to inform calling logic.

### Performance Optimization
- **Memory Management:** xatlas is optimized for speed; ensure the environment has sufficient memory for the reference genome index.
- **Nexus Integration:** For cloud-based or specific pipeline architectures, the `xatlas_nexus` component is used for integrated testing and deployment.

## Expert Tips
- **HTSlib Dependency:** If you encounter link errors during a source build, explicitly define the HTSlib path using the `HTSLIB_PREFIX` variable during the `cmake` step.
- **Retraining:** xatlas is "retrainable." For advanced users, this allows for model adjustments to better fit specific sequencing technologies or capture kits, though this typically requires a gold-standard truth set.
- **Validation:** Always ensure your input BAM files are indexed (`.bai`) to allow the tool to perform random access across the genome.

## Reference documentation
- [xatlas Overview - Bioconda](./references/anaconda_org_channels_bioconda_packages_xatlas_overview.md)
- [xatlas GitHub Repository](./references/github_com_jfarek_xatlas.md)