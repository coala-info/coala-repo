---
name: perl-bio-easel
description: The `perl-bio-easel` package provides a Perl interface to Sean Eddy's Easel C library, which is the foundation for HMMER and Infernal.
homepage: https://github.com/nawrockie/Bio-Easel
---

# perl-bio-easel

## Overview

The `perl-bio-easel` package provides a Perl interface to Sean Eddy's Easel C library, which is the foundation for HMMER and Infernal. It is designed for high-performance sequence analysis and Multiple Sequence Alignment (MSA) manipulation. Use this skill when you need to perform complex alignment operations that require Easel's specific handling of biological sequence data, particularly when working with RNA secondary structures or large-scale genomic alignments where standard Perl Bio modules may be insufficient.

## Installation and Setup

The most reliable way to access the tool is via Bioconda:

```bash
conda install bioconda::perl-bio-easel
```

For developers, the module requires the Easel C library to be present in a `src/easel` directory relative to the build path and depends on the `Inline::C` Perl module.

## Common CLI Tool Patterns

The package includes several specialized scripts for alignment processing:

### esl-aliconsensus
Generates a consensus sequence from an input MSA.
- **Basic usage**: `esl-aliconsensus <msa_file>`
- **Key Options**:
  - `--cons2rf`: Map the consensus sequence to the Reference (RF) line.
  - `--consgap`: Handle gaps in the consensus generation.
  - `--gf`: Output in Stockholm format with #=GF (Global Feature) annotation.

### esl-alicompare2rf
Compares alignment positions to a reference frame.
- **Key Options**:
  - `--seqrf`: Use a specific sequence as the reference frame.
  - `--alldel`: Report all deletions relative to the reference.

### esl-alitransfer
Used for transferring annotations (like GC lines) between alignments.

## Perl API Usage (Bio::Easel)

When writing Perl scripts using the library, focus on these core objects and methods:

### MSA Manipulation
- **Loading**: Use `Bio::Easel::MSA` to parse Stockholm or FASTA alignments.
- **Metadata**: Access alignment properties using `{get,set}_{Name,Accession,Desc,Author}`.
- **Sequence Info**: Check sequence types using `isRna()`.
- **Gap Analysis**: Use `pos_gap()` to analyze gap distributions at specific positions.

### Advanced Analysis
- **Relative Entropy**: Use `pos_relentropy()` to calculate the information content at specific alignment columns.
- **IUPAC Consensus**: Use `consensus_iupac_sequence()` to generate a consensus string using IUPAC ambiguity codes.
- **Specialized Annotations**: The library provides methods to handle `sa_cons` (Surface Accessibility), `pp_cons` (Posterior Probability), and `mm` (Masking) lines.

## Expert Tips

1. **Stockholm Format**: Easel is optimized for Stockholm format. When performing complex MSA manipulations (like preserving secondary structure), ensure your input files are in Stockholm format rather than Clustal or FASTA.
2. **Inline::C Dependency**: If you encounter compilation errors during manual installation, ensure `Inline` and `Inline::C` are installed via CPAN, as these are required to bridge the Perl and C layers.
3. **Documentation**: Detailed method documentation is available via `perldoc Bio::Easel` after installation.
4. **Reference Coordinates**: When working with VADR or Infernal outputs, use `esl-alicompare2rf` to reconcile coordinate systems between different alignment versions.

## Reference documentation
- [Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_perl-bio-easel_overview.md)
- [Bio-Easel GitHub README](./references/github_com_nawrockie_Bio-Easel.md)
- [Bio-Easel Wiki](./references/github_com_nawrockie_Bio-Easel_wiki.md)
- [Commit History (Script Options)](./references/github_com_nawrockie_Bio-Easel_commits_master.md)