---
name: aprfinder
description: The aprfinder tool detects A-phased repeats within FASTA or Multi-FASTA genomic files and outputs the results in GFF format. Use when user asks to identify A/T nucleotide tracts, find periodic genomic repeats, or locate specific spacer lengths between nucleotide tracks.
homepage: https://github.com/jaroslav-kubin/aprfinder
---


# aprfinder

## Overview

The `aprfinder` tool is a specialized utility for detecting A-phased repeats within FASTA or Multi-FASTA genomic files. These repeats are characterized by tracts of consecutive A/T nucleotides separated by "spacers" of varying lengths. The tool allows for fine-grained control over the tract size, spacer size, and the number of tracks required to define a repeat. Results are generated in GFF (General Feature Format), making them compatible with most genome browsers and downstream bioinformatics pipelines.

## Command Line Usage

### Basic Execution
To run a search with default parameters:
```bash
aprfinder --input sequences.fasta --output results.gff
```

### Parameter Constraints
The tool provides three ways to define constraints for spacers, A/T tracts, and track counts:
1.  **Range-based**: Use `--min-X` and `--max-X` to define a window.
2.  **Exact**: Use `--exact-X` to set both bounds to the same value.
3.  **Defaults**: If not specified, the tool uses internal defaults for finding standard A-phased repeats.

### Common CLI Patterns

**Finding repeats with specific spacer lengths:**
To find repeats where the spacer between A/T tracts is exactly 10 nucleotides:
```bash
aprfinder --input input.fa --exact-bound 10 --output exact_spacer.gff
```

**Searching for long A/T tracts:**
To find repeats consisting of at least 5 consecutive A/T nucleotides:
```bash
aprfinder --input input.fa --min-AT 5 --output long_tracts.gff
```

**Increasing stringency:**
To filter for regions with a high number of periodic tracks (e.g., at least 3 tracks):
```bash
aprfinder --input input.fa --min-tracks 3 --output high_stringency.gff
```

## Expert Tips and Best Practices

*   **Output Management**: Always specify the `--output` flag. By default, the tool writes to `result.gff`. Running the tool multiple times in the same directory without specifying a unique output name will overwrite previous results.
*   **File Extensions**: Ensure your output filename ends in `.gff` to maintain compatibility with genomic tools, as the software does not automatically append the extension.
*   **Multi-FASTA Support**: The tool natively handles Multi-FASTA files, processing each record sequentially and aggregating all found repeats into the single specified GFF output.
*   **Memory Allocation**: For very large genomes or complex search parameters, the `--memory-size` flag can be used to adjust the internal buffer, though the default is usually sufficient for standard bacterial or small eukaryotic scaffolds.

## Reference documentation
- [aprfinder README](./references/github_com_jaroslav-kubin_aprfinder_blob_main_README.md)
- [aprfinder Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_aprfinder_overview.md)