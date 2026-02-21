---
name: fgap
description: FGAP (Functional Gap-filler) is a tool designed to improve the continuity of genome assemblies by replacing gap regions with actual sequences.
homepage: https://github.com/pirovc/fgap
---

# fgap

## Overview

FGAP (Functional Gap-filler) is a tool designed to improve the continuity of genome assemblies by replacing gap regions with actual sequences. It works by taking the sequences flanking a gap in a draft assembly and using BLAST+ to find matching sequences in provided datasets. It can handle positive gaps (inserting new bases), zero gaps (closing gaps where no bases are missing), and negative gaps (resolving overlaps between contig ends).

## Installation and Environment

The most efficient way to use fgap is via Bioconda:

```bash
conda install bioconda::fgap
```

Ensure that BLAST+ (specifically `makeblastdb` and `blastn` version 2.2.28+ or higher) is installed and available in your system PATH. If BLAST+ is in a non-standard location, use the `-b` flag to specify the path.

## Common CLI Patterns

### Basic Gap Closing
To close gaps in a draft genome using a single dataset:
```bash
fgap -d draft_assembly.fasta -a dataset_reads.fasta -o output_folder/result
```

### Using Multiple Datasets
You can provide multiple datasets separated by commas. This is useful when combining different sequencing technologies or multiple assembly versions:
```bash
fgap -d draft.fasta -a 'dataset1.fasta,dataset2.fasta' -t 4 -o multi_dataset_results
```

### Strict Alignment Filtering
For high-confidence gap filling, increase the identity and score thresholds:
```bash
fgap -d draft.fasta -a dataset.fasta -i 95 -s 50 -e 1e-10
```

### Handling Overlapping Contigs (Negative Gaps)
If you suspect your assembly has artificial gaps where contigs actually overlap, enable negative gap closing:
```bash
fgap -d draft.fasta -a dataset.fasta -g 1 -z 1
```

## Parameter Reference

| Parameter | Flag | Description | Default |
|-----------|------|-------------|---------|
| **Draft File** | `-d` | The genome assembly to be fixed (FASTA). | Required |
| **Datasets** | `-a` | Comma-separated list of FASTA files to use for filling. | Required |
| **Min Identity** | `-i` | Minimum percentage identity for BLAST hits (0-100). | 70 |
| **Min Score** | `-s` | Minimum raw BLAST score. | 25 |
| **Contig End** | `-C` | Length (bp) of the flanking region used for BLAST. | 300 |
| **Max Insert** | `-I` | Maximum number of bases to insert into a gap. | 500 |
| **Max Remove** | `-R` | Maximum number of bases to remove (for overlaps). | 500 |
| **Threads** | `-t` | Number of CPU threads to use. | 1 |
| **Output** | `-o` | Prefix for output files or directory. | output_fgap |

## Expert Tips

1.  **Flanking Regions**: The `-C` (contig-end-length) parameter determines how much sequence on either side of the gap is used to search the datasets. If your datasets contain very short reads, you might need to decrease this; for long reads or contigs, the default 300bp is usually sufficient.
2.  **Gap Character**: By default, FGAP looks for 'N'. If your assembly uses a different character (like 'X'), specify it using `-c 'X'`.
3.  **Edge Trimming**: If the ends of your contigs are of low quality, use `-T` (edge-trim-length) to ignore a specific number of bases immediately adjacent to the gap before performing the BLAST alignment.
4.  **Memory and Performance**: FGAP is implemented in MATLAB/Octave. When running on large datasets, ensure your environment has sufficient RAM for the BLAST+ operations and the sequence loading.
5.  **Verification**: Use the `-m 1` flag to generate additional output files containing the gap regions before and after closing. This allows for manual inspection of the filled sequences.

## Reference documentation
- [fgap Overview](./references/anaconda_org_channels_bioconda_packages_fgap_overview.md)
- [fgap GitHub Repository](./references/github_com_pirovc_fgap.md)