---
name: perl-ensembl-variation
description: The `perl-ensembl-variation` skill enables programmatic access to the Ensembl Variation database.
homepage: https://www.ensembl.org/info/docs/api/index.html
---

# perl-ensembl-variation

## Overview
The `perl-ensembl-variation` skill enables programmatic access to the Ensembl Variation database. It is designed for bioinformaticians needing to retrieve variant information, genotypes, phenotypes, and variant consequences (e.g., missense, stop-gained) across various species. This skill focuses on the object-oriented Perl interface which abstracts complex SQL joins into intuitive objects like `Variation`, `Allele`, and `TranscriptVariation`.

## Core API Patterns

### 1. Database Connection via Registry
The Ensembl Registry is the standard way to manage database connections. Use it to load all species or specific ones.

```perl
use Bio::EnsEMBL::Registry;

my $registry = 'Bio::EnsEMBL::Registry';

# Load from the public Ensembl MySQL server
$registry->load_registry_from_db(
    -host => 'ensembldb.ensembl.org',
    -user => 'anonymous'
);
```

### 2. Fetching Variation Objects
To retrieve data, first obtain a `VariationAdaptor` for the target species.

```perl
my $va = $registry->get_adaptor('human', 'variation', 'variation');

# Fetch by RSID
my $v = $va->fetch_by_name('rs123');

print "Name: ", $v->name, "\n";
print "Source: ", $v->source, "\n";
print "Ambiguity code: ", $v->ambiguity_code, "\n";
```

### 3. Retrieving Genomic Locations
Variations are mapped to the genome via `VariationFeature` objects.

```perl
my $vfa = $registry->get_adaptor('human', 'variation', 'variationfeature');

foreach my $vf (@{$vfa->fetch_all_by_Variation($v)}) {
    printf("%s:%d-%d (%s)\n", 
        $vf->seq_region_name, 
        $vf->start, 
        $vf->end, 
        $vf->allele_string
    );
}
```

### 4. Calculating Consequences
To determine the effect of a variant on transcripts, use the `TranscriptVariation` objects associated with a `VariationFeature`.

```perl
foreach my $tv (@{$vf->get_all_TranscriptVariations}) {
    print "Transcript: ", $tv->transcript->stable_id, "\n";
    foreach my $consequence (@{$tv->get_all_OverlapConsequences}) {
        print "Consequence: ", $consequence->display_term, "\n";
    }
}
```

## Best Practices
- **Memory Management**: When fetching large numbers of variations (e.g., across a whole chromosome), use `fetch_Iterator` or `fetch_all_by_Slice` to avoid exhausting memory.
- **Database Versioning**: Ensure your API version matches the database version (e.g., API v98 for Ensembl Release 98).
- **Species Aliases**: Use standard aliases (e.g., 'human', 'homo_sapiens', 'mouse') consistently within the Registry calls.
- **Structural Variations**: For large-scale deletions or inversions, use the `StructuralVariationAdaptor` instead of the standard `VariationAdaptor`.

## Reference documentation
- [Ensembl API Documentation](./references/useast_ensembl_org_info_docs_api_index.html.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-ensembl-variation_overview.md)