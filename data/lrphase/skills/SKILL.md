---
name: lrphase
description: lrphase phases individual long reads by mapping their variants to known haplotype information from a phased VCF. Use when user asks to phase long reads, haplotag BAM or FASTQ files, or classify reads into maternal and paternal categories.
homepage: https://github.com/Boyle-Lab/LRphase.git
---


# lrphase

## Overview
`lrphase` (executed via the `HaplotagLR` command) is a tool designed to phase individual long reads by leveraging known haplotype information. It maps the variants found within long-read sequences to a provided set of phased genotypes, allowing for the classification of reads into maternal, paternal, or unphased categories. This process is critical for resolving complex genomic regions and conducting allele-specific studies.

## Core Workflow

The primary command for this tool is `HaplotagLR haplotag`.

### Required Inputs
- **Phased VCF (`-v`)**: Must be a bgzipped VCF file (`.vcf.gz`) with a corresponding tabix index (`.tbi`) in the same directory.
- **Input Reads (`-i`)**: Supports `.bam`, `.sam`, or `.fastq`.
    - If using `.fastq`, the reference genome (`-r`) is **required**.
    - If using `.sam` or an unindexed `.bam`, the tool will automatically attempt to sort and index using SAMtools.

### Common Command Patterns

**Standard haplotagging from a BAM file:**
```bash
HaplotagLR haplotag -v phased_variants.vcf.gz -i alignments.sorted.bam -o output_dir/
```

**Haplotagging from FASTQ (includes alignment step):**
```bash
HaplotagLR haplotag -v phased_variants.vcf.gz -i reads.fastq -r reference.fasta -o output_dir/ -t 8
```

**Specifying Output Organization:**
Use the `-O` flag to control how results are saved:
- `combined`: (Default) All reads in one file with an `HP:i:N` tag.
- `phase_tagged`: Phased reads in one file; unphased/nonphasable in others.
- `full`: Separate files for maternal, paternal, unphased, and nonphasable reads.

```bash
HaplotagLR haplotag -v phased.vcf.gz -i input.bam -O full -o phased_results/
```

## Expert Tips and Best Practices

### Error Rate Calibration
The tool's accuracy depends on the sequencing error rate (epsilon).
- **Default**: Uses the gap-compressed per-base divergence rate (from `de` or `mg` tags in the BAM).
- **Quality-based**: Use `-c` to calculate epsilon directly from Phred scores in the BAM record.
- **Fixed**: Use `-e <value>` (e.g., `-e 0.05`) to set a global error rate if the read-level estimates are unreliable.

### Filtering for High Confidence
To reduce false assignments:
- **FDR Threshold (`-F`)**: Set a False Discovery Rate (e.g., `-F 0.05`). The tool will reassign the lowest-likelihood reads to "Untagged" to maintain the target FDR.
- **Log-Likelihood Threshold**: Use `--log_likelihood_threshold <value>` to ignore assignments that do not meet a specific statistical confidence level.

### Performance
- Always provide the number of threads (`-t`) for mapping and sorting steps to significantly reduce processing time.
- Ensure `minimap2`, `samtools`, and `tabix` are in your PATH, as `lrphase` relies on these for background operations.

## Reference documentation
- [HaplotagLR GitHub Repository](./references/github_com_Boyle-Lab_HaplotagLR.md)
- [lrphase Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_lrphase_overview.md)