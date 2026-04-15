---
name: tiddit
description: TIDDIT is a structural variant caller that also calculates genomic coverage. Use when user asks to detect structural variants, identify chromosomal rearrangements, calculate genomic coverage, or identify copy number variations.
homepage: https://github.com/SciLifeLab/TIDDIT
metadata:
  docker_image: "quay.io/biocontainers/tiddit:3.9.4--py311h93dcfea_0"
---

# tiddit

## Overview
TIDDIT is a structural variant caller designed to identify large-scale genomic alterations by analyzing discordant read pairs and supplementary (split-read) alignments. It utilizes a combination of signal clustering (DBSCAN) and local de novo assembly to pinpoint breakpoints. The tool is divided into two primary functional modules: one for comprehensive SV detection and another for calculating genomic coverage across specified bin sizes.

## Structural Variant Calling (--sv)
The SV module is the primary tool for detecting chromosomal rearrangements. It requires a position-sorted BAM or CRAM file and the corresponding reference fasta.

### Basic Usage
```bash
tiddit --sv --bam input.bam --ref reference.fasta -o output_prefix
```

### Key Parameters for Fine-Tuning
- **Support Thresholds**: Use `-p` (min pairs) and `-r` (min split reads) to control sensitivity. Default is 3 for both.
- **Insert Size**: Use `-i` to manually set the maximum allowed insert size if the library has a non-standard distribution.
- **Ploidy**: Use `-n` to specify organism ploidy (default is 2). Use `--force_ploidy` to skip coverage normalization across chromosomes.
- **Performance**: Use `--threads` to parallelize the analysis.

### Local Assembly
By default, TIDDIT performs local assembly using `fermi2` and `ropebwt2`. 
- If these dependencies are not in your PATH, provide them via `--fermi2` and `--ropebwt2`.
- To significantly speed up processing at the cost of some sensitivity, use the `--skip_assembly` flag.

## Coverage Analysis (--cov)
The coverage module calculates read depth across the genome, which is useful for identifying copy number variations or library quality.

### Basic Usage
```bash
tiddit --cov --bam input.bam -z 500 -o coverage_output
```

### Configuration
- **Bin Size**: Use `-z` to define the window size (default 500 bp).
- **Output Format**: By default, it produces a bed-like file. Use `-w` to generate a WIG file instead.
- **CRAM Support**: When using CRAM files, the `--ref` parameter is mandatory.

## Expert Tips and Best Practices
- **Filtering Results**: TIDDIT applies internal filters (`Expectedlinks`, `FewLinks`, `Unexpectedcoverage`). To extract only high-confidence calls, filter the VCF for "PASS" entries:
  ```bash
  grep -E "#|PASS" input.vcf > filtered.vcf
  ```
- **Memory Management**: On a standard 30X human genome, TIDDIT typically requires less than 10GB of RAM and completes within 5 hours.
- **Reference Consistency**: Ensure the reference fasta provided with `--ref` is the exact same file used during the alignment of the BAM/CRAM file, or the tool will crash.
- **Small Contigs**: By default, TIDDIT skips calling on contigs smaller than 10kb. Adjust this using `--min_contig` if working with highly fragmented assemblies.

## Reference documentation
- [TIDDIT Main Documentation](./references/github_com_SciLifeLab_TIDDIT.md)
- [Bioconda TIDDIT Overview](./references/anaconda_org_channels_bioconda_packages_tiddit_overview.md)