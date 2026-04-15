---
name: saspector
description: SASpector evaluates the completeness of bacterial draft genomes by aligning them against a high-quality reference to identify and characterize missing genomic regions. Use when user asks to evaluate assembly completeness, identify missing regions in a draft genome, or characterize gaps through gene prediction and k-mer analysis.
homepage: https://github.com/alejocrojo09/SASpector
metadata:
  docker_image: "quay.io/biocontainers/saspector:0.0.5--pyhdfd78af_0"
---

# saspector

## Overview
SASpector (Short-read Assembly inSpector) is a comparative genomics tool designed to evaluate the completeness of bacterial draft genomes. It aligns a short-read assembly against a high-quality reference (such as one generated via hybrid assembly) to pinpoint "missing" regions. Beyond simple identification, the tool automates the characterization of these gaps through gene prediction, k-mer composition analysis, and coverage checks, helping researchers determine if critical functional elements were lost during the assembly process.

## Installation and Environment
The tool is available via Bioconda and pip. Ensure third-party dependencies (Mauve, Prokka, BLAST+, QUAST, SAMtools, and TRF) are in your PATH.

```bash
# Installation via Conda
conda install bioconda::saspector

# Installation via pip
pip install SASpector
```

## Core CLI Usage
The basic command requires a reference genome and the assembly contigs.

```bash
SASpector reference.fasta contigs.fasta [options]
```

### Common Options
- `-p, --prefix`: Set a unique identifier for the run (e.g., strain ID).
- `-dir, --outdir`: Specify the output directory for alignments and reports.
- `-f, --flanking [LENGTH]`: Add flanking sequences (default 100bp) to extracted missing regions to provide genomic context.
- `-db, --proteindb [FILE]`: Provide a FASTA protein database to BLAST against Prokka-predicted genes in missing regions.
- `-k, --kmers [K]`: Calculate k-mer frequencies for the missing regions.
- `-q, --quast`: Generate a QUAST quality assessment and Icarus genome viewer for unmapped regions.
- `-c, --coverage [BAM]`: Use a BAM file (reads mapped to reference) to calculate average coverage in missing vs. mapped regions.

## Best Practices and Workflow
1. **Input Preparation**: If your reference genome consists of multiple sequences (e.g., chromosome and plasmids), concatenate them into a single FASTA file, as SASpector primarily focuses on the first sequence.
2. **Dependency Check**: Run `SASpectorcheck` before starting a large analysis to ensure all third-party binaries (like `progressiveMauve` or `trf409.linux64`) are correctly installed and accessible.
3. **Functional Analysis**: Always provide a protein database via `-db` if you are looking for specific missing functions. You can use the provided `saspector_proteindb.fasta` or a custom UniprotKB subset.
4. **Interpreting Results**:
   - **prefix.alignment/**: Contains the backbone file from Mauve showing coordinates.
   - **summary/**: Contains tab-delimited files for GC content, length, and amino acid frequencies of missing regions.
   - **Prokka output**: Look here for GFF/GBK files of genes found only in the reference.

## Troubleshooting
- **TRF Errors**: SASpector expects Tandem Repeats Finder to be named `trf409.linux64`. If your binary has a different name, create a symbolic link.
- **Alignment Failures**: Ensure your contig headers do not contain complex characters that might break the Mauve parser.

## Reference documentation
- [SASpector GitHub Repository](./references/github_com_alejocrojo09_SASpector.md)
- [Bioconda SASpector Overview](./references/anaconda_org_channels_bioconda_packages_saspector_overview.md)