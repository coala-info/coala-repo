---
name: novasplice
description: NovaSplice identifies novel intronic splice sites created by genomic variants by comparing their MaxEntScan scores to canonical sites. Use when user asks to identify novel splice sites, evaluate the impact of intronic variants, or perform comparative splice site scoring using VCF and BED files.
homepage: https://github.com/aryakaul/novasplice
---


# novasplice

## Overview
NovaSplice is a specialized bioinformatics tool that identifies potential novel intronic splice sites created by genomic variants. By leveraging MaxEntScan scoring, it evaluates the strength of canonical splice sites relative to new sites induced by variants provided in a VCF file. This tool is essential for researchers investigating the functional impact of intronic mutations that are often overlooked in standard coding-region analyses. It automates the process of intersecting variants with exon boundaries, retrieving reference sequences, and performing comparative splice site scoring.

## Installation and Setup
NovaSplice is primarily distributed via Bioconda. Ensure your environment has the necessary dependencies (Python 3, maxentpy, and pybedtools).

```bash
conda install -c bioconda novasplice
```

## Core CLI Usage
The tool requires four primary inputs to function.

```bash
novasplice -v <VCF_FILE> -r <REFERENCE_FASTA> -b <EXON_BED> -c <CHR_LENS>
```

### Required Arguments
- `-v` or `-vz`: Path to the input VCF file (use `-vz` for gzipped files).
- `-r` or `-rz`: Path to the reference genome FASTA file.
- `-b`: A BED file containing exon boundaries.
- `-c`: A file containing chromosome lengths.

### Optional Parameters for Tuning
- `-p, --percent`: Sets the sensitivity threshold (default: 0.05). If a canonical site scores 100, a setting of 0.1 means any novel site scoring above 90 (100 - 0.1 * 100) is reported.
- `-l, --libraryname`: Custom prefix for the output predictions file (default: 'novasplice-predictions').
- `-o, --output`: Directory for final results.
- `-i, --intermediate`: Directory for intermediate files. If files exist here from a previous run, NovaSplice will skip those steps to save time.
- `-t, --temp`: Custom directory for temporary file processing.

## Expert Tips and Best Practices

### Workflow Efficiency
- **Use Intermediate Directories**: When running multiple VCFs against the same reference and BED files, always specify an intermediate directory (`-i`). NovaSplice generates a `splice-sites.bed` and `subset.vcf` (coding-excluded variants). Reusing these files significantly reduces computation time for subsequent runs.
- **VCF Pre-processing**: Ensure your VCF is sorted and has a proper header. NovaSplice uses `bedtools intersect` internally; unsorted files may cause errors or silent failures.

### Interpreting Results
- **Scoring Logic**: NovaSplice reports a site if the variant-induced site score is greater than the canonical score, or within the user-defined percentage bound.
- **Filtering**: The tool automatically excludes variants that fall within exons to focus specifically on intronic/non-coding regions. If you need to analyze exonic splice-switching variants, this tool may require pre-processing to "trick" the intersection logic.
- **MaxEntScan Requirements**: Remember that the underlying scoring tool requires specific sequence lengths (9bp for 5' sites, 23bp for 3' sites). NovaSplice handles this extraction, but ensure your reference FASTA is indexed and accessible.

### Common Pitfalls
- **Strand Awareness**: NovaSplice is strand-aware. Ensure your Exon BED file includes the strand column (column 6), as the tool uses this to determine the directionality of 3' and 5' splice sites.
- **Chromosome Naming**: Ensure the chromosome names in your VCF, FASTA, and BED files match exactly (e.g., "chr1" vs "1").

## Reference documentation
- [NovaSplice Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_novasplice_overview.md)
- [NovaSplice GitHub Documentation](./references/github_com_aryakaul_novasplice.md)