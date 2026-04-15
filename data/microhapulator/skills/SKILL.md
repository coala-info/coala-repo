---
name: microhapulator
description: MicroHapulator is a forensic bioinformatics toolset for calling, filtering, and analyzing microhaplotype data from sequencing outputs. Use when user asks to call haplotypes from BAM files, filter alleles, calculate forensic statistics like likelihood ratios, or simulate synthetic genotypes and sequencing reads.
homepage: https://github.com/bioforensics/MicroHapulator/
metadata:
  docker_image: "quay.io/biocontainers/microhapulator:0.8.4--pyhdfd78af_0"
---

# microhapulator

## Overview

MicroHapulator is a specialized forensic bioinformatics toolset designed to process microhaplotype data. It bridges the gap between raw Illumina sequencing outputs and forensic interpretation by providing a robust pipeline for haplotype calling, filtering, and statistical analysis. Beyond empirical data processing, it includes powerful simulation capabilities to create mock genotypes and sequencing reads, which are essential for validating forensic workflows and testing mixture interpretation models.

## Core CLI Patterns

The primary entry point for the tool is the `mhpl8r` command.

### Haplotype Calling and Filtering
To call haplotypes from aligned sequence data (BAM files) and apply quality filters:

*   **Call Haplotypes**: `mhpl8r type --bam sample.bam --marker-defs markers.tsv > calls.json`
*   **Apply Filters**: Use `mhpl8r filter` to refine calls based on static or dynamic thresholds.
    *   `mhpl8r filter --static 0.05` (removes alleles with frequency < 5%)
    *   `mhpl8r filter --dynamic 0.1` (removes alleles based on a fraction of the total locus coverage)

### Forensic Analysis and Interpretation
*   **Interlocus Balance**: Calculate and visualize how evenly markers are amplified.
    *   `mhpl8r balance --typing-results calls.json --plot balance_plot.png`
*   **Sample Containment**: Determine if alleles from one sample are present in another (useful for mixture screening).
    *   `mhpl8r contain --query sample1.json --reference sample2.json`
*   **Probabilistic Interpretation**: Calculate likelihood ratios or random match probabilities.
    *   `mhpl8r prob --typing-results calls.json --freqs population_freqs.tsv`

### Simulation Workflow
Generate synthetic data for validation or training:

1.  **Simulate Genotype**: `mhpl8r sim --marker-defs markers.tsv > profile.json`
2.  **Create Mixture**: `mhpl8r mixture --profiles p1.json p2.json --weights 3 1 > mix.json`
3.  **Generate Reads**: `mhpl8r seq --profile mix.json --refr hg38.fasta > reads.fq`

### End-to-End Pipeline
For a complete analysis from FASTQ to HTML report, use the automated pipeline:
`mhpl8r pipe --fastq1 R1.fq.gz --fastq2 R2.fq.gz --outdir results_dir`

## Expert Tips

*   **Reference Data**: Use [MicroHapDB](https://github.com/bioforensics/microhapdb) to obtain standardized marker definitions and population frequencies compatible with MicroHapulator.
*   **Base Quality**: When calling haplotypes from noisy data, use the `--base-qual` parameter in `mhpl8r type` to ignore low-quality bases during pileup processing.
*   **Depth Limits**: For high-coverage targeted sequencing, the default `pysam` pileup depth may be too low. MicroHapulator defaults to 1,000,000, but this can be adjusted via the CLI if needed.
*   **Windows Usage**: MicroHapulator is not natively supported on Windows; always execute via WSL2 (Windows Subsystem for Linux).



## Subcommands

| Command | Description |
|---------|-------------|
| mhpl8r | Microhaplotype analysis tool |
| mhpl8r | Invoke `mhpl8r <subcmd> --help` and replace `<subcmd>` with one of the subcommands listed below to see instructions for that operation. |
| mhpl8r filter | Apply static and/or dynamic thresholds to distinguish true and false haplotypes. Thresholds are applied to the haplotype read counts of a raw typing result. Static integer thresholds are commonly used as detection thresholds, below which any haplotype count is considered noise. Dynamic thresholds are commonly used as analytical thresholds and represent a percentage of the total read count at the marker, after any haplotypes failing a static threshold are discarded. |
| mhpl8r pipe | Perform a complete end-to-end microhap analysis pipeline |
| mhpl8r seq | Simulate paired-end Illumina MiSeq sequencing of the given profile(s) |

## Reference documentation

- [MicroHapulator GitHub README](./references/github_com_bioforensics_MicroHapulator_blob_main_README.md)
- [MicroHapulator Change Log](./references/github_com_bioforensics_MicroHapulator_blob_main_CHANGELOG.md)
- [MicroHapulator CLI Reference](./references/microhapulator_readthedocs_io_en_stable_cli.html.md)
- [MicroHapulator User Manual](./references/microhapulator_readthedocs_io_en_stable_manual.html.md)