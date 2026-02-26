---
name: perl-bio-coordinate
description: This tool manages and transforms coordinates between different biological scales such as genomic DNA, mRNA, and protein sequences. Use when user asks to map coordinates between different biological systems, handle DNA to protein translation mapping, or manage complex coordinate transformations across multiple exons.
homepage: https://metacpan.org/release/Bio-Coordinate
---


# perl-bio-coordinate

## Overview
The `perl-bio-coordinate` skill provides a framework for managing and transforming coordinates across different biological scales. It is particularly useful for bioinformatics workflows that require precise mapping between genomic DNA, transcript sequences (mRNA/cDNA), and translated protein products. By utilizing a system of "mappers" and "pairs," it handles the complexities of frame shifts, introns, and coordinate offsets.

## Core Concepts
- **Mappers**: Objects that define the relationship between two coordinate systems.
- **Collection**: A series of mappers linked together to allow multi-step transformations (e.g., Genomic -> cDNA -> Protein).
- **In-bounds vs. Out-of-bounds**: Transformations return specific objects indicating whether a coordinate successfully mapped to the target system.

## Common Usage Patterns

### Basic Coordinate Mapping
To map a position from one system to another, define the start and end points for both the source and the target.

```perl
use Bio::Coordinate::Pair;

# Define a mapping from a genomic region (100-200) to a cDNA (1-101)
my $pair = Bio::Coordinate::Pair->new(
    -source => Bio::Location::Simple->new(-start => 100, -end => 200, -strand => 1),
    -target => Bio::Location::Simple->new(-start => 1, -end => 101, -strand => 1)
);

my $res = $pair->map(Bio::Location::Simple->new(-start => 150, -end => 150));
print $res->start; # Outputs the corresponding coordinate in the target system
```

### DNA to Protein Translation Mapping
When mapping DNA to Protein, the tool automatically handles the 3-to-1 ratio of nucleotides to amino acids.

```perl
use Bio::Coordinate::GeneMapper;

my $mapper = Bio::Coordinate::GeneMapper->new();
# Define CDS structure here...
# Map a DNA coordinate to a peptide position
my $pos = Bio::Location::Simple->new(-start => 3, -end => 3);
my $match = $mapper->map($pos); 
```

### Handling Multiple Exons
For complex gene structures, use a collection of pairs to represent spliced alignments.

1. Create a `Bio::Coordinate::Collection` object.
2. Add `Bio::Coordinate::Pair` objects for each exon.
3. Use the `map()` method on the collection to find the relative position within the spliced transcript.

## Expert Tips
- **Strand Awareness**: Always verify the strand orientation (-1 or 1). Mapping between opposite strands requires careful definition of the source and target locations to avoid off-by-one errors.
- **Result Validation**: The `map()` function returns a `Bio::Location` object if successful, but may return a `Bio::Coordinate::Result` containing "Gap" objects if the coordinate falls into an unmapped region (like an intron when mapping to cDNA). Always check the return type.
- **Performance**: If performing thousands of mappings, reuse the Mapper objects rather than re-instantiating them for every coordinate.

## Reference documentation
- [Bio-Coordinate Release Info](./references/metacpan_org_release_Bio-Coordinate.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-bio-coordinate_overview.md)