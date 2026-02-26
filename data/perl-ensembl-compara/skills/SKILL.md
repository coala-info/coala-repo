---
name: perl-ensembl-compara
description: This tool provides programmatic access to the Ensembl Comparative Genomics database via a Perl API to retrieve evolutionary data. Use when user asks to fetch orthologs or paralogs, access gene trees, or retrieve whole-genome alignments between species.
homepage: https://www.ensembl.org/info/docs/api/index.html
---


# perl-ensembl-compara

## Overview
The `perl-ensembl-compara` skill enables programmatic access to the Ensembl Comparative Genomics database. It is designed for bioinformaticians needing to automate the retrieval of evolutionary data, such as orthologs, paralogs, and whole-genome alignments. This skill focuses on the Perl API layer, which abstracts complex SQL schemas into high-level objects like Member, Homology, and ProteinTree.

## Core API Usage Patterns

### 1. Initializing the Registry
The Registry is the entry point for all Ensembl API scripts. It manages database connections and allows you to fetch "Adaptors" for specific data types.

```perl
use strict;
use warnings;
use Bio::EnsEMBL::Registry;

my $registry = 'Bio::EnsEMBL::Registry';

# Load from the public Ensembl MySQL server
$registry->load_registry_from_db(
    -host => 'ensembldb.ensembl.org',
    -user => 'anonymous'
);
```

### 2. Fetching Homologies
To find orthologs between two species, use the `HomologyAdaptor`.

```perl
my $homology_adaptor = $registry->get_adaptor('Multi', 'compara', 'Homology');
my $gene_member_adaptor = $registry->get_adaptor('Multi', 'compara', 'GeneMember');

# 1. Get the gene member for your query gene
my $gene_member = $gene_member_adaptor->fetch_by_stable_id('ENSG00000139618'); # BRCA2

# 2. Fetch homologies for a specific target species (e.g., Mus musculus)
my $homologies = $homology_adaptor->fetch_all_by_Member_paired_species($gene_member, 'mus_musculus');

foreach my $homology (@$homologies) {
    print $homology->description(), "\n";
}
```

### 3. Accessing Gene Trees
Gene trees provide the evolutionary context for gene families.

```perl
my $gene_tree_adaptor = $registry->get_adaptor('Multi', 'compara', 'GeneTree');

# Fetch a tree by a member gene
my $tree = $gene_tree_adaptor->fetch_all_by_Member($gene_member);

# Root node of the tree
my $root = $tree->root();

# Print the tree in Newick format
print $root->newick_format('name'), "\n";
```

### 4. Genomic Alignments
Use the `MethodLinkSpeciesSetAdaptor` to find specific alignment types (e.g., LASTZ_NET, EPO) between species.

```perl
my $mlss_adaptor = $registry->get_adaptor('Multi', 'compara', 'MethodLinkSpeciesSet');

# Fetch the alignment set for Human and Chimp BLASTZ_NET
my $mlss = $mlss_adaptor->fetch_by_method_link_type_registry_aliases(
    "BLASTZ_NET", ["human", "chimp"]
);

print "MLSS ID: ", $mlss->dbID(), "\n";
```

## Best Practices
- **Use the Registry**: Never hard-code database connection strings for individual adaptors. Use `load_registry_from_db` or a configuration file.
- **Memory Management**: When iterating over large sets of homologies or trees, use `$tree->release_tree()` to free memory once processing of a specific tree is complete.
- **Stable IDs**: Always prefer Ensembl Stable IDs (e.g., ENSG...) over display names to ensure reproducible results across different Ensembl releases.
- **Species Aliases**: Use standard production names (e.g., `homo_sapiens`) or common names (e.g., `human`) supported by the Registry.

## Reference documentation
- [Ensembl API Documentation](./references/useast_ensembl_org_info_docs_api_index.html.md)
- [Perl-Ensembl-Compara Overview](./references/anaconda_org_channels_bioconda_packages_perl-ensembl-compara_overview.md)