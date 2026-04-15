---
name: hiphase
description: Hiphase phases small, structural, and tandem repeat variants from PacBio HiFi reads. Use when user asks to phase variants, determine allelic phase of variants, or phase structural variants and short tandem repeats.
homepage: https://github.com/PacificBiosciences/HiPhase
metadata:
  docker_image: "quay.io/biocontainers/hiphase:1.6.0--h9ee0642_0"
---

# hiphase

Phases small, structural, and tandem repeat variants from PacBio HiFi reads.
  Use when needing to determine the allelic phase of variants within a genome,
  especially when dealing with complex structural variants and short tandem repeats
  from high-fidelity sequencing data.
---
## Overview

HiPhase is a specialized tool designed for the intricate task of phasing genetic variants. It excels at jointly phasing small variants (like SNPs), structural variants (SVs), and short tandem repeats (STRs) specifically from PacBio HiFi sequencing data. This means it can determine which variants are located on the same chromosome copy (haplotype), providing a more complete and accurate picture of genomic variation, especially for complex regions.

## Usage Instructions

HiPhase is a command-line tool. The primary command is `hiphase`.

### Core Functionality

The main purpose of `hiphase` is to take variant calls (typically in VCF format) and PacBio HiFi read alignments (BAM format) and output phased variants.

### Basic Command Structure

```bash
hiphase <input.bam> <input.vcf> <output_prefix>
```

- `<input.bam>`: Path to the PacBio HiFi read alignment file in BAM format.
- `<input.vcf>`: Path to the variant call file in VCF format. This file should contain small variants, structural variants, and/or STRs.
- `<output_prefix>`: A prefix for the output files. HiPhase will generate several output files, such as `<output_prefix>.phased.vcf.gz` and `<output_prefix>.haplotagged.bam`.

### Key Options and Considerations

*   **Input Formats**: Ensure your input BAM file is indexed (`.bai` file) and your input VCF file is sorted.
*   **Output Files**:
    *   `.phased.vcf.gz`: The primary output, containing variants with phasing information.
    *   `.haplotagged.bam`: The input BAM file with reads tagged with their assigned haplotype. This is useful for downstream analysis.
    *   Other files may be generated for statistics and intermediate results.
*   **Multi-threading**: HiPhase is designed with innate multi-threading for performance. It will typically utilize available CPU cores automatically.
*   **Memory Usage**: For large datasets, memory usage can be significant. Consider running on a system with ample RAM. The `feature/mem_reduce` branch in the repository suggests ongoing efforts to optimize memory.
*   **Variant Types**: HiPhase is specifically designed to handle the joint phasing of small variants, structural variants, and short tandem repeats, which is a key advantage over tools that focus on only one type.
*   **Citation**: If you use HiPhase in your research, please cite the publication: Holt, J. M., Saunders, C. T., Rowell, W. J., Kronenberg, Z., Wenger, A. M., & Eberle, M. (2024). HiPhase: Jointly phasing small, structural, and tandem repeat variants from HiFi sequencing. *Bioinformatics*, btae042.

### Expert Tips

*   **Input Quality**: The quality of the phasing output is highly dependent on the quality of the input variant calls and the read alignments. Ensure your variant calling pipeline is robust.
*   **STR Phasing**: HiPhase's ability to phase STRs is a notable feature, as STR phasing is often challenging.
*   **Troubleshooting**: If you encounter issues, such as missing features or bugs, it is recommended to open a GitHub issue on the [PacificBiosciences/HiPhase repository](https://github.com/PacificBiosciences/HiPhase).

## Reference documentation
- [README.md](./references/github_com_PacificBiosciences_HiPhase.md)