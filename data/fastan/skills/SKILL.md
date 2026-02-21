---
name: fastan
description: FasTAN (Fast Tandem Repeat Finder) is a high-performance utility developed by Gene Myers for the rapid identification of tandem repeats within DNA sequences.
homepage: https://github.com/thegenemyers/FASTAN
---

# fastan

## Overview

FasTAN (Fast Tandem Repeat Finder) is a high-performance utility developed by Gene Myers for the rapid identification of tandem repeats within DNA sequences. It works by detecting off-diagonal alignments that signify repetitive structures and their specific periods. The tool is essential for researchers working on genome assembly, annotation, or satellite DNA analysis who require a fast, scalable solution for repeat detection. It produces a specialized `.1aln` output which serves as a compact representation of these repeats, ready for conversion into standard formats like BED, PAF, or PSL.

## Command Line Usage

The basic syntax for FasTAN follows a source-to-target pattern:

```bash
FasTAN <source_path>[<precursor>] <target_path>[.1aln]
```

### Input Formats
FasTAN supports several input types, automatically detecting them based on extension:
- **FASTA**: `.fa`, `.fna`, `.fasta` (including gzipped `.gz` versions).
- **1GDB**: Gene Myers' 1-code database format (`.1gdb`).
- **1-code**: Any valid 1-code sequence file type.

### Options and Features
- **Masking**: Use the `-m` option to enable masking functionality during the repeat finding process.
- **Error Reporting**: Recent versions (v1.5+) include upgraded error reporting for troubleshooting input issues.

## Workflow Integration and Best Practices

### Downstream Conversion
Since FasTAN outputs a proprietary `.1aln` format, you will typically need to convert the results for use in other bioinformatics tools:
- **To BED format**: Use the `tanbed` utility from Richard Durbin's `alntools` to create a BED file that includes the repeat period.
- **To PAF/PSL format**: Refer to the `FASTGA` repository for tools that convert `.1aln` files into standard alignment formats.

### Performance Optimization
- FasTAN is optimized for speed and is often used as a precursor to masking or as part of a larger "FastGA" suite workflow.
- When working with large-scale genomic data, using the `.1gdb` format can offer performance advantages over raw FASTA files.

### Installation
The most reliable way to install FasTAN is via Bioconda:
```bash
conda install bioconda::fastan
```

## Reference documentation
- [FasTAN GitHub Repository](./references/github_com_thegenemyers_FASTAN.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_fastan_overview.md)
- [FasTAN Commit History](./references/github_com_thegenemyers_FASTAN_commits_main.md)