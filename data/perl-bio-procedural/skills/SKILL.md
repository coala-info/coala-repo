---
name: perl-bio-procedural
description: This library provides a procedural wrapper for the BioPerl toolkit to simplify common biological data tasks. Use when user asks to read or write sequences, translate DNA to protein, or generate reverse complements using a functional interface.
homepage: https://metacpan.org/release/Bio-Procedural
---


# perl-bio-procedural

## Overview
The `perl-bio-procedural` library provides a streamlined, procedural wrapper around the BioPerl toolkit. It is designed to reduce the boilerplate code typically associated with BioPerl objects, making it ideal for quick scripts, data transformation pipelines, and users who prefer direct function calls for common biological data tasks.

## Usage Guidelines

### Core Functions
The library exports functions into the main namespace to simplify sequence handling. Use these primary procedures:

- `read_sequence($file)`: Loads a sequence from a file (FASTA, GenBank, etc.).
- `write_sequence($seq_object, $file, $format)`: Exports sequence data to a specified format.
- `translate($seq_object)`: Performs DNA to Protein translation.
- `revcom($seq_object)`: Generates the reverse complement of a sequence.

### Best Practices
- **Low Dependency**: Use this module in environments where a full, heavy BioPerl installation is overkill or where minimal dependencies are required for portability.
- **Functional Chaining**: Since the interface is procedural, you can easily chain operations within standard Perl map/grep blocks or custom subroutines.
- **Format Support**: While procedural, the tool still leverages BioPerl's underlying IO engines. Always specify the file format (e.g., 'fasta', 'genbank', 'swiss') when dealing with non-standard extensions to ensure correct parsing.

### Example Pattern
```perl
use Bio::Procedural qw(read_sequence translate write_sequence);

# Procedural workflow: Read, Translate, and Save
my $seq = read_sequence("input.fasta");
my $prot = translate($seq);
write_sequence($prot, "output.faa", "fasta");
```

## Reference documentation
- [Bio-Procedural CPAN Release](./references/metacpan_org_release_Bio-Procedural.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-bio-procedural_overview.md)