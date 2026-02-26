---
name: telogator2
description: Telogator2 extracts and analyzes telomeric regions from long-read sequencing datasets to provide allele-specific measurements. Use when user asks to extract telomeric reads, characterize variant repeat patterns, or measure telomere length from PacBio or Nanopore data.
homepage: https://github.com/zstephens/telogator2
---


# telogator2

## Overview
Telogator2 is a specialized bioinformatics tool designed to extract and analyze telomeric regions from long-read sequencing datasets. Unlike general-purpose aligners, it focuses on the repetitive and often difficult-to-map terminal regions of chromosomes. It provides allele-specific measurements by anchoring reads to subtelomeric references and characterizing the specific patterns of variant repeats. This skill enables the configuration of the tool for different sequencing platforms (PacBio vs. ONT) and the interpretation of its tabular and visual outputs.

## Installation and Setup
Telogator2 can be installed via Conda or Pip. An aligner (minimap2, winnowmap, or pbmm2) must be available in the system path or specified during execution.

- **Conda**: `conda install bioconda::telogator2`
- **Pip**: `pip install git+https://github.com/zstephens/telogator2.git`

## Command Line Usage
The basic execution pattern requires an input file, an output directory, and the sequencing technology type.

```bash
telogator2 -i <input_reads> -o <output_dir> -r <read_type> [options]
```

### Recommended Platform Settings
Adjust the `-n` (minimum supporting reads) and `-r` (read type) flags based on the sequencing technology and coverage:

| Platform | Flag | Recommended `-n` | Notes |
| :--- | :--- | :--- | :--- |
| **PacBio Revio HiFi** | `-r hifi` | `-n 4` | High accuracy; standard 30x coverage. |
| **PacBio Sequel II** | `-r hifi` | `-n 3` | Lower coverage (10x). |
| **Nanopore R10** | `-r ont` | `-n 4` | Standard 30x coverage. |
| **Enrichment Data** | `-r ont` | `-n 10` | Use higher thresholds to reduce false positives. |

### Input Handling
- **Multiple Files**: Use `-i read1.fa read2.fa` to process multiple libraries.
- **PacBio Revio**: It is recommended to include both "hifi" and "fail" BAM files as input to capture all relevant telomeric reads.
- **Aligner Specification**: If the aligner is not in your PATH, use `--minimap2 /path/to/minimap2`.

## Advanced Workflows
### Non-Human References
To analyze species other than humans, provide a custom subtelomere reference and k-mer file:
```bash
telogator2 -i input.fa -o results/ -t source/resources/non-human/telogator-ref-mouse.fa.gz
```
For specific crops like maize, include the k-mer TSV:
```bash
telogator2 -i maize_reads.fa -o results/ -r hifi -t telogator-ref-maize.fa.gz -k kmers_maize.tsv
```

### Performance Optimization
- **Parallelization**: Use `-p` to specify CPU cores. For large datasets, `-p 8` or `-p 16` significantly reduces runtime.
- **Memory**: Ensure sufficient RAM is available for the aligner when processing large subtelomeric reference sets.

## Interpreting Results
The primary output is `tlens_by_allele.tsv`. Key columns include:
- **chr / anchor**: The chromosome arm identified. `chrU` indicates unmapped subtelomeres.
- **allele_id**: Unique ID for the allele. IDs ending in `i` indicate **interstitial telomere regions**, which should generally be excluded from length analysis as they do not represent true chromosome ends.
- **TL_p75**: The 75th percentile telomere length, which is the default reported ATL.
- **tvr_consensus**: The consensus sequence of the Telomere Variant Repeat region.

## Expert Tips
- **Guppy Warning**: Avoid using older Nanopore data basecalled with Guppy, as the error rates in telomeric repeats are often too high for accurate characterization.
- **Visualization**: Check `all_final_alleles.png` to visually confirm the TVR and telomere region boundaries if the TSV results show unexpected length variances.
- **Reference Creation**: For custom genomes, use the `make_telogator_ref.py` script included in the source to generate compatible subtelomere anchors.

## Reference documentation
- [Telogator2 GitHub Repository](./references/github_com_zstephens_telogator2.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_telogator2_overview.md)