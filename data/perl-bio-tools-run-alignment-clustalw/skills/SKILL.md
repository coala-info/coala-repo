---
name: perl-bio-tools-run-alignment-clustalw
description: This skill provides guidance on using the BioPerl interface for ClustalW.
homepage: https://metacpan.org/release/Bio-Tools-Run-Alignment-Clustalw
---

# perl-bio-tools-run-alignment-clustalw

## Overview
This skill provides guidance on using the BioPerl interface for ClustalW. It allows for the automated execution of multiple sequence alignments from within Perl scripts, handling the conversion between BioPerl sequence objects and the ClustalW executable. It is particularly useful for bioinformatics pipelines requiring high-throughput alignment, profile-to-profile alignments, or automated tree generation (neighbor-joining) based on ClustalW output.

## Usage Patterns

### Basic Alignment
To align a set of unaligned sequences stored in an array of Bio::Seq objects:

```perl
use Bio::Tools::Run::Alignment::Clustalw;

# Initialize the factory
my $factory = Bio::Tools::Run::Alignment::Clustalw->new(-verbose => 1);

# Run alignment on an array of Bio::Seq objects
# Returns a Bio::SimpleAlign object
my $aln = $factory->align(\@seq_array);
```

### Profile Alignment
To align a set of sequences to an existing alignment (profile):

```perl
# $aln is an existing Bio::SimpleAlign object
# @seqs is an array of Bio::Seq objects to add
my $combined_aln = $factory->profile_align($aln, \@seqs);
```

### Parameter Customization
Pass ClustalW command-line flags as arguments during factory initialization:

- **-matrix**: Specify the substitution matrix (e.g., 'BLOSUM', 'PAM', 'ID').
- **-gapopen**: Set the gap opening penalty.
- **-gapext**: Set the gap extension penalty.
- **-type**: Specify sequence type ('DNA' or 'PROTEIN').
- **-outfile**: Define the output alignment filename.

```perl
my $factory = Bio::Tools::Run::Alignment::Clustalw->new(
    -matrix  => 'BLOSUM',
    -gapopen => 10,
    -gapext  => 0.1,
    -type    => 'PROTEIN'
);
```

### Generating Phylogenetic Trees
If the ClustalW run is intended to produce a tree file (.dnd), ensure the environment is configured to capture the output:

```perl
$factory->run(\@seqs);
# The guide tree is typically written to the working directory 
# or specified via the -tree parameter.
```

## Best Practices
- **Executable Path**: Ensure `clustalw` or `clustalw2` is in your system PATH. If it is in a non-standard location, set the environment variable `CLUSTALWDIR` before running the script.
- **Object Handling**: Always check that the input to `align()` is an array reference of `Bio::PrimarySeqI` objects.
- **Memory Management**: For very large datasets, ClustalW can be memory-intensive. Consider pre-filtering sequences or using the `Bio::SimpleAlign` object's `slice` methods to handle sub-alignments.
- **Error Handling**: Wrap the `align` call in an `eval` block to catch system errors or ClustalW execution failures.

## Reference documentation
- [Bio-Tools-Run-Alignment-Clustalw MetaCPAN](./references/metacpan_org_release_Bio-Tools-Run-Alignment-Clustalw.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-bio-tools-run-alignment-clustalw_overview.md)