---
name: breakinator
description: Breakinator identifies structural artifacts like foldbacks and chimeras in long-read sequencing alignment files. Use when user asks to detect sequencing artifacts, identify foldbacks or chimeras, resolve diploid assemblies, or generate consensus breakpoints.
homepage: https://github.com/jheinz27/breakinator
metadata:
  docker_image: "quay.io/biocontainers/breakinator:1.1.1--h067a5f5_1"
---

# breakinator

## Overview
The breakinator skill provides a specialized workflow for identifying structural artifacts in long-read sequencing datasets. It parses alignment files to distinguish between true genomic features and technical artifacts such as foldbacks (inverted repeats within a single read) and chimeras (artificial joins of disparate DNA fragments). This tool is particularly useful for cleaning up Oxford Nanopore (ONT) or PacBio data before structural variant calling or assembly.

## Core Workflows

### Basic Artifact Detection
Run breakinator on alignment files. The tool requires name-sorted files where all alignments for a single read ID are grouped together.

```bash
# For SAM, BAM, or CRAM files
breakinator -i alignments.bam -o artifacts.txt

# For PAF files (must include the --paf flag)
breakinator -i alignments.paf --paf -o artifacts.txt
```

### Handling Diploid Assemblies
When working with diploid genomes (e.g., HG002), standard mapping quality may drop due to multi-mapping between haplotypes. Use the `diploidinator` utility to resolve these:

1. Align reads to maternal and paternal haplotypes separately using `minimap2` with `--secondary=no --paf-no-hit`.
2. Run the diploidinator to select the superior alignment:
   ```bash
   diploidinator maternal.paf paternal.paf > diploid_merged.paf
   ```
3. Proceed with breakinator using the merged PAF.

### Generating Consensus Breakpoints
To collapse individual read flags into high-confidence genomic locations, use the merge script:

```bash
python merge_breaks.py -i artifacts.txt -w 100 -s 2 > consensus_locations.txt
```
*   `-w`: Window size for merging (default 100bp).
*   `-s`: Minimum read support required to report a breakpoint (default 2).

## Tool-Specific Best Practices

### Input Requirements
- **Name Sorting**: Breakinator processes reads sequentially to save memory. It will fail or produce incorrect results on coordinate-sorted files. Always run it on the raw output of `minimap2` or use `samtools sort -n` first.
- **CRAM Files**: When using CRAM input, the reference genome FASTA must be provided via the `-g` or `--genome` flag.

### Parameter Tuning
- **Symmetry Filter**: By default, the tool focuses on symmetric foldbacks (near the middle of the read). Use `--no-sym` to report every detected foldback regardless of its position.
- **Distance Thresholds**: 
    - Use `-c` (default 1,000,000) to define the minimum genomic distance for a "chimeric" flag.
    - Use `-f` (default 200) to define the maximum distance for a "foldback" flag.
- **Mapping Quality**: The default minimum MAPQ is 10. Increase this using `-q` if working in highly repetitive regions to reduce false positives.

### Output Formats
- **Tabular Mode**: Use the `--tabular` flag to generate a TSV table. This is highly recommended when processing multiple samples or when the output will be parsed by downstream scripts (like R or Pandas).
- **Read Coordinates**: Use `--rcoord` to include the specific read-relative coordinates of the detected breakpoint in the output.

## Reference documentation
- [The Breakinator Main Documentation](./references/github_com_jheinz27_breakinator.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_breakinator_overview.md)