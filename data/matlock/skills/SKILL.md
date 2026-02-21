---
name: matlock
description: Matlock is a specialized toolkit for handling Hi-C (High-throughput Chromosome Conformation Capture) data.
homepage: https://github.com/phasegenomics/matlock
---

# matlock

## Overview
Matlock is a specialized toolkit for handling Hi-C (High-throughput Chromosome Conformation Capture) data. It provides high-performance C-based utilities to filter raw alignments and convert them into the specific formats required by scaffolding and visualization tools such as Juicer, Lachesis, and various binning matrices.

## Command Line Usage

### BAM Filtering
Use `bamfilt` to clean up Hi-C BAM files before downstream analysis.
```bash
matlock bamfilt input.bam output.bam
```
*Note: Supports .sam, .bam, and .cram input formats.*

### Format Conversion
The `bam2` command converts standard alignments into specialized Hi-C formats.
```bash
matlock bam2 <mode> <input> <output_prefix>
```
**Supported Modes:**
- `juicer`: Generates files for the Juicer/Juicebox pipeline.
- `lachesis`: Formats data for the LACHESIS scaffolding tool.
- `binmat`: Creates a binary matrix representation.
- `counts`: Produces link counts between genomic regions.

### Motif Counting
Count occurrences of specific DNA motifs within a reference genome.
```bash
matlock motif reference.fasta MOTIF1 MOTIF2 ...
```

## Best Practices and Tips
- **Output Naming**: When using `bam2`, provide an output prefix rather than a full filename with an extension. The tool manages extensions automatically based on the selected mode.
- **Input Flexibility**: Matlock automatically detects whether the input is SAM, BAM, or CRAM; there is no need to specify the input format flag manually.
- **Juicer Integration**: If using the `juicer` mode, verify the resulting output compatibility with your specific version of Juicer tools, as some versions are sensitive to the exact text format produced.
- **Resource Management**: For large Hi-C datasets, ensure sufficient temporary disk space is available. Conversion processes, especially those generating text-based formats for Juicer, can result in significant file size expansion compared to the original compressed BAM.
- **Error Handling**: If you encounter "FATAL: something went wrong in process_pair", check that your input BAM is properly sorted by read name, as Hi-C pair processing typically requires paired-end reads to be adjacent in the file.

## Reference documentation
- [Matlock Overview](./references/anaconda_org_channels_bioconda_packages_matlock_overview.md)
- [Matlock GitHub Repository](./references/github_com_phasegenomics_matlock.md)
- [Known Issues and Troubleshooting](./references/github_com_phasegenomics_matlock_issues.md)