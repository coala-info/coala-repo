---
name: perl-bio-tools-run-alignment-tcoffee
description: This tool provides a BioPerl wrapper to run the T-Coffee multiple sequence alignment program. Use when user asks to perform consistency-based multiple sequence alignments, integrate structural information into alignments, or generate alignment consistency scores.
homepage: https://metacpan.org/release/Bio-Tools-Run-Alignment-TCoffee
metadata:
  docker_image: "quay.io/biocontainers/perl-bio-tools-run-alignment-tcoffee:1.7.4--pl526_0"
---

# perl-bio-tools-run-alignment-tcoffee

## Overview
This skill provides guidance for using the BioPerl wrapper for T-Coffee, a versatile multiple sequence alignment tool. T-Coffee is distinguished by its "consistency-based" approach, which allows it to integrate information from various sources (like structural alignments or different MSA algorithms) to produce a more accurate final result than standard progressive aligners. This tool is ideal for researchers needing high-accuracy alignments for phylogenetics, structural biology, or comparative genomics.

## Usage Patterns

### Basic Alignment
To run a standard alignment using the default T-Coffee parameters:
```perl
use Bio::Tools::Run::Alignment::TCoffee;

# Initialize the factory
my $factory = Bio::Tools::Run::Alignment::TCoffee->new();

# Run alignment on a sequence object or file
my $aln = $factory->align($seq_array_ref);
```

### Advanced Configuration
T-Coffee's strength lies in its parameters. You can pass any valid T-Coffee command-line flag through the constructor:

- **Method Selection**: Use `-method` to specify underlying aligners (e.g., `clustalw_pair`, `slow_pair`).
- **Output Formats**: Control output using `-output` (e.g., `clustalw`, `fasta`, `score_ascii`).
- **Library Integration**: Use `-lib` to include pre-computed alignment libraries.

```perl
my $factory = Bio::Tools::Run::Alignment::TCoffee->new(
    -method => 'clustalw_pair',
    -outfile => 'results.aln'
);
```

### Expert Tips
1. **Consistency Scoring**: T-Coffee provides a "CORE" score indicating the consistency of the alignment. Use the `-output => 'score_ascii'` option to identify well-aligned vs. poorly-aligned regions.
2. **Large Datasets**: T-Coffee is computationally intensive. For more than 50-100 sequences, consider using the "M-Coffee" mode or "Fast" flavors if available in your local installation.
3. **Environment Variables**: Ensure the `TCOFFEE_4_TCOFFEE` environment variable is set if the binary is in a non-standard location, though the BioPerl wrapper usually detects it automatically in a Conda environment.

## Reference documentation
- [Bio-Tools-Run-Alignment-TCoffee Release](./references/metacpan_org_release_Bio-Tools-Run-Alignment-TCoffee.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-bio-tools-run-alignment-tcoffee_overview.md)