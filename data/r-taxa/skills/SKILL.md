---
name: r-taxa
description: "Provides classes for storing and manipulating taxonomic data.   Most of the classes can be treated like base R vectors (e.g. can be used   in tables as columns and can be named). Vectorized classes can store taxon names  and authorities, taxon IDs from databases, taxon ranks, and other types of  information. More complex classes are provided to store taxonomic trees and  user-defined data associated with them.</p>"
homepage: https://cloud.r-project.org/web/packages/taxa/index.html
---

# r-taxa

name: r-taxa
description: Expert guidance for the 'taxa' R package. Use this skill when you need to store, manipulate, or analyze taxonomic data in R using specialized classes like taxon, taxonomy, and classification. It is particularly useful for handling taxonomic hierarchies, database IDs (NCBI, ITIS, etc.), and mapping data to taxonomic trees.

# r-taxa

## Overview
The `taxa` package provides a robust framework for taxonomic data in R. It treats taxonomic entities as first-class objects (vectors) that can be used in data frames and tibbles. It supports taxon names, ranks, authorities, and database IDs, as well as complex tree structures for hierarchical relationships.

## Installation
```R
install.packages("taxa")
library(taxa)
```

## Core Classes and Constructors
The package uses a vectorized approach. Most classes can be used as columns in a `data.frame`.

- `taxon()`: The primary class for a single taxon. Combines name, rank, ID, and authority.
- `taxon_id()`: Stores database-specific identifiers (e.g., NCBI TaxIDs).
- `taxon_rank()`: Stores taxonomic ranks with optional ordering (e.g., species < genus < family).
- `taxon_authority()`: Stores author names, dates, and citations.
- `taxon_db()`: Defines the source database (e.g., 'ncbi', 'itis', 'gbif').

### Example: Creating a Taxon Vector
```R
# Create a complex taxon vector
x <- taxon(
  name = c('Homo sapiens', 'Bacillus', 'Ascomycota'),
  rank = c('species', 'genus', 'phylum'),
  id = taxon_id(c('9606', '1386', '4890'), db = 'ncbi'),
  auth = c('Linnaeus, 1758', 'Cohn 1872', NA)
)

# Access components
tax_name(x)
tax_rank(x)
tax_id(x)
```

## Taxonomic Hierarchies
For working with trees and nested classifications:

- `taxonomy()`: Stores a taxonomic tree (taxa + supertaxa relationships).
- `classification()`: Stores a list of nested classifications (e.g., Kingdom to Species paths).

### Example: Building a Taxonomy
```R
# Define a tree using supertaxa indexes
# 1: Carnivora, 2: Felidae (child of 1), 3: Panthera (child of 2)
tree <- taxonomy(
  c('Carnivora', 'Felidae', 'Panthera', 'Panthera leo'),
  supertaxa = c(NA, 1, 2, 3)
)

# Query the tree
roots(tree)      # Get root indexes
leaves(tree)     # Get leaf indexes
subtaxa(tree)    # Get all descendants
supertaxa(tree)  # Get all ancestors
```

## Common Workflows

### 1. Converting to Data Frames
`taxa` objects are designed to be "tidy".
```R
# Convert taxon vector to a tibble/data.frame
as_data_frame(x)
tibble::as_tibble(x)
```

### 2. Filtering by Rank
You can use logical comparisons on ranks if levels are defined.
```R
# Filter taxa higher than family
x[tax_rank(x) > 'family']
```

### 3. Database References
Use `db_ref` to manage supported databases and ID validation.
```R
# List supported databases
db_ref$get()

# Add a custom database
db_ref$set(name = "my_db", url = "http://example.com", id_regex = "^[0-9]+$")
```

### 4. Tree Navigation Functions
- `is_root()` / `is_leaf()`: Logical tests for position in hierarchy.
- `n_subtaxa()` / `n_supertaxa()`: Count relatives.
- `internodes()`: Find taxa with exactly one parent and one child (useful for tree simplification).

## Tips
- **Vectorization**: Treat `taxon` objects like character vectors; you can subset them with `[]`, name them with `names()`, and use them in `dplyr` pipelines.
- **Coercion**: Use `as_taxon()` to convert character vectors or factors into taxon objects quickly.
- **Missing Data**: Use `is.na()` to check for empty taxonomic slots.

## Reference documentation
- [Package ‘taxa’ Reference Manual](./references/reference_manual.md)