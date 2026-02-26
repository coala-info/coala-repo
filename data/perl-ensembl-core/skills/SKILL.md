---
name: perl-ensembl-core
description: This tool provides a Perl interface to interact with the Ensembl database for retrieving and manipulating genomic data. Use when user asks to fetch gene models, retrieve genomic sequences via slices, perform coordinate conversions, or automate data extraction from the Ensembl database.
homepage: https://www.ensembl.org/info/docs/api/index.html
---


# perl-ensembl-core

## Overview
The `perl-ensembl-core` skill enables efficient interaction with the Ensembl database system using its native Perl API. It abstracts complex SQL schemas into high-level objects like `Slice`, `Gene`, and `Transcript`. Use this skill to automate genomic data extraction, perform coordinate conversions, or integrate Ensembl annotation into bioinformatics pipelines without writing raw SQL queries.

## Core API Patterns

### 1. Initializing the Registry
The Registry is the entry point for all Ensembl API scripts. It manages database connections and species aliases.

```perl
use Bio::EnsEMBL::Registry;

my $registry = 'Bio::EnsEMBL::Registry';

# Connect to the public Ensembl MySQL server
$registry->load_registry_from_db(
    -host => 'ensembldb.ensembl.org',
    -user => 'anonymous'
);
```

### 2. Fetching Data via Adaptors
Data access in Ensembl follows the Adaptor pattern. You fetch an adaptor for a specific object type and species, then use it to retrieve objects.

```perl
# Get the Gene Adaptor for Human
my $gene_adaptor = $registry->get_adaptor('Human', 'Core', 'Gene');

# Fetch a gene by its stable ID
my $gene = $gene_adaptor->fetch_by_stable_id('ENSG00000139618');

# Fetch genes by display label (symbol)
my @genes = @{$gene_adaptor->fetch_all_by_display_label('BRCA2')};
```

### 3. Working with Slices (Genomic Regions)
A `Slice` represents a continuous fragment of a genome. It is the primary way to retrieve sequence-based features.

```perl
my $slice_adaptor = $registry->get_adaptor('Human', 'Core', 'Slice');

# Fetch a slice by region: coord_system, name, start, end, strand
my $slice = $slice_adaptor->fetch_by_region('chromosome', '1', 1000000, 1010000);

# Get all genes overlapping this slice
my $genes = $slice->get_all_Genes();
```

### 4. Traversing the Gene Model
Ensembl objects are hierarchical. You can navigate from Genes to Transcripts to Translations.

```perl
foreach my $transcript (@{$gene->get_all_Transcripts()}) {
    print "Transcript: ", $transcript->stable_id, "\n";
    
    my $translation = $transcript->translation();
    if ($translation) {
        print "Protein ID: ", $translation->stable_id, "\n";
        print "Sequence: ", $transcript->translate()->seq(), "\n";
    }
}
```

## Best Practices
- **Use the Registry**: Always use `Bio::EnsEMBL::Registry` rather than hard-coding database connections to ensure compatibility across different Ensembl releases.
- **Memory Management**: When fetching large numbers of objects (e.g., `fetch_all`), process them in a loop or use iterators to avoid exhausting memory.
- **Coordinate Systems**: Be mindful of the coordinate system (e.g., 'chromosome' vs 'scaffold'). Use the `transform()` method on objects to move between different coordinate systems or assemblies.
- **API Versioning**: Ensure your local API version matches the database version you are connecting to (e.g., Ensembl 98 API for Ensembl 98 databases).

## Reference documentation
- [Ensembl API Overview](./references/useast_ensembl_org_info_docs_api_index.html.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_perl-ensembl-core_overview.md)