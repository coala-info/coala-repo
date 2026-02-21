---
name: lr_gapcloser
description: `lr_gapcloser` is a bioinformatics tool designed to fill gaps in genomic scaffolds using long-read data.
homepage: https://github.com/CAFS-bioinformatics/LR_Gapcloser
---

# lr_gapcloser

## Overview
`lr_gapcloser` is a bioinformatics tool designed to fill gaps in genomic scaffolds using long-read data. It works by fragmenting long reads into "tags," aligning them to the scaffold using an internal BWA mem implementation, and identifying reads that bridge gaps. Once a bridge is found, the tool inserts the corresponding sequence from the long read into the assembly. It is particularly effective when you have high-quality, error-corrected long reads and wish to reduce the number of Ns in your draft genome.

## Usage Guidelines

### Prerequisites
- **Input Formats**: Both the scaffold file (`-i`) and the long-read file (`-l`) must be in FASTA format.
- **Read Quality**: Long reads **must be error-corrected** before running this tool.
- **Naming Constraints**: Sequence headers in your FASTA files must not contain the character string `(:` as it is used as an internal delimiter.

### Basic Command Syntax
Run the tool using the shell script provided in the installation directory.

**For Ubuntu/Debian:**
```bash
bash LR_Gapcloser.sh -i scaffolds.fasta -l corrected_long_reads.fasta -s [p|n] -t 12 -o output_dir
```

**For CentOS/RHEL:**
```bash
sh LR_Gapcloser.sh -i scaffolds.fasta -l corrected_long_reads.fasta -s [p|n] -t 12 -o output_dir
```

### Key Options
- `-s`: Sequencing platform. Use `p` for PacBio (default) or `n` for Nanopore.
- `-t`: Number of threads. Increase this to speed up the BWA mem alignment and coverage filtration.
- `-r`: Number of iterations (default: 3). Multiple passes can help close gaps that were missed in the first round.
- `-c`: Coverage threshold (default: 0.8). Adjust this to control the stringency of alignment selection.

### Expert Tips and Best Practices
- **Memory and Environment**: Ensure `Perl` and `BioPerl` are installed. The tool includes a precompiled version of BWA, so you do not need to install it separately, but `GLIBC 2.14` or higher is required.
- **Output Location**: The final gap-filled assembly is located deep in the output directory structure, typically at `[output_dir]/iteration-[N]/gapclosed.fasta` (where N is the number of iterations).
- **Gap Length Deviation**: If you suspect your estimated gap lengths (the number of Ns) are highly inaccurate, consider adjusting the `-a` parameter (default: 0.2), which controls the allowed deviation between the gap length and the filled sequence length.
- **Tag Length**: The tool divides long reads into tags (default: 300bp via `-g`). If your reads are exceptionally long or you are dealing with very large gaps, you might experiment with the tag length and the maximal allowed distance to gap boundaries (`-m`, default: 600bp).

## Reference documentation
- [GitHub Repository and README](./references/github_com_CAFS-bioinformatics_LR_Gapcloser.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_lr_gapcloser_overview.md)