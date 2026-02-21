---
name: berokka
description: Berokka is a specialized utility designed to "clean up" bacterial genome assemblies produced by long-read sequencing technologies.
homepage: https://github.com/tseemann/berokka
---

# berokka

## Overview

Berokka is a specialized utility designed to "clean up" bacterial genome assemblies produced by long-read sequencing technologies. Its primary function is to identify and remove redundant overlaps—often referred to as "overhangs"—that occur at the ends of contigs when an assembler successfully traverses a circular chromosome or plasmid but fails to trim the terminal redundancy. By resolving these overlaps, Berokka produces clean, circularized FASTA sequences suitable for downstream analysis and annotation.

## Usage and Best Practices

### Basic Execution
The standard command requires an output directory and an input FASTA file containing your assembly contigs:

```bash
berokka --outdir <output_directory> <input_assembly.fasta>
```

### Key Command Line Options
- `--filter <FASTA>`: By default, Berokka filters out contigs matching 50% of the standard PacBio control sequence. To provide a custom filter file, pass the FASTA path. To disable filtering entirely, use `--filter 0`.
- `--readlen <LENGTH>`: If a contig fails to circularize, adjusting this parameter can help. It modifies the length of the match Berokka attempts to make using BLAST.
- `--noanno`: Prevents Berokka from adding metadata (like `circular=true` or `overhang=N`) to the FASTA headers in the output.

### Interpreting Results
Berokka generates three primary files in the specified output directory:
1. `01.input.fa`: A copy of the original input sequences.
2. `02.trimmed.fa`: The final processed sequences, including trimmed and circularized contigs.
3. `03.results.tab`: A TSV summary detailing the status of each contig (trimmed, kept, or removed), original length, and new length.

### Expert Tips
- **Fallback Tooling**: Berokka is intended as a lightweight alternative to Circlator. Use it specifically when you lack the original corrected reads required by more complex tools or when dealing with simple cases that have clear, manual-detectable overhangs.
- **Header Metadata**: Unless `--noanno` is used, Berokka adds useful tags to the FASTA headers. The `circular=true` tag is specifically recognized by other tools like Rebaler.
- **Contig Removal**: Always inspect `03.results.tab`. Small contigs that match the filter criteria (like the PacBio control) will be marked as `removed` and will not appear in the `02.trimmed.fa` file.

## Reference documentation
- [Berokka GitHub Repository](./references/github_com_tseemann_berokka.md)
- [Berokka Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_berokka_overview.md)