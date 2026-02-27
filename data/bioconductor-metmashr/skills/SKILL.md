---
name: bioconductor-metmashr
description: MetMashR is an R package designed to manage, standardize, and merge metabolomics annotation data from various software tools and databases. Use when user asks to import metabolomics results, build modular annotation workflows, perform database lookups via APIs, or combine and resolve multiple annotation sources.
homepage: https://bioconductor.org/packages/release/bioc/html/MetMashR.html
---


# bioconductor-metmashr

## Overview
MetMashR is an R package built on the `struct` framework designed to manage metabolomics annotation data. It provides a standardized way to "mash" together results from different software tools and databases. The package centers around `annotation_source` objects (like `lcms_table` or `annotation_database`) and uses a modular workflow approach where steps (models) are added together using the `+` operator and executed via `model_apply()`.

## Core Workflow Patterns

### 1. Initializing and Reading Sources
MetMashR supports specific importers for common software outputs.
```r
library(MetMashR)
library(struct)

# Import LipidSearch results
at <- ls_source(source = "path/to/lipidsearch_output.txt")
at <- read_source(at)

# Import Compound Discoverer results
cd <- cd_source(source = "path/to/cd_output.xlsx")
cd <- read_source(cd)

# Access the underlying data.frame
df <- at$data
```

### 2. Building a Model Sequence
Workflows are constructed by chaining models. The `import_source()` model is typically the first step to allow the workflow to be applied to a source object.
```r
# Define a cleaning and filtering workflow
wf <- import_source() +
    filter_labels(
        column_name = "Grade",
        labels = c("A", "B"),
        mode = "include"
    ) +
    normalise_strings(
        search_column = "LipidName",
        output_column = "clean_name",
        dictionary = racemic_dictionary
    )

# Execute the workflow
results <- model_apply(wf, at)

# Extract the processed annotation table
final_table <- predicted(results)
```

### 3. Database Lookups and REST APIs
MetMashR integrates with several external APIs and local databases to add identifiers (InChIKey, CID, etc.).
```r
# Lookup PubChem CIDs based on metabolite names
wf_api <- import_source() +
    pubchem_compound_lookup(
        query_column = "metabolite_name",
        search_by = "name",
        output = "cids"
    )

# Use a local database (e.g., MTox700+) for lookup
wf_db <- import_source() +
    database_lookup(
        query_column = "inchikey",
        database = MTox700plus_database(),
        database_column = "inchikey",
        include = "hmdb_id"
    )
```

### 4. Combining and Resolving Records
When merging sources or handling one-to-many database matches, use `combine_sources` and `combine_records`.
```r
# Combine multiple tables vertically
combined <- combine_sources(
    source_list = list(table1, table2),
    matching_columns = c(name = "compound", adduct = "ion")
)

# Collapse multiple rows (e.g., multiple hits for one peak)
cr <- combine_records(
    group_by = "metabolite_name",
    default_fcn = fuse_unique(separator = "; ")
)
```

## Key Functions and Objects
- `annotation_table()` / `lcms_table()`: Containers for experimental annotations.
- `annotation_database()`: Containers for reference metadata.
- `model_apply(model, source)`: The primary execution function.
- `predicted(model_seq)`: Retrieves the output of the last step in a sequence.
- `read_source()` / `read_database()`: Methods to load data into objects or data.frames.
- `filter_labels()`, `filter_range()`, `filter_na()`: Standard cleaning steps.

## Tips for Success
- **Indexing Workflows**: You can access intermediate results of a sequence using brackets, e.g., `predicted(wf[2])` returns the data after the second step.
- **Caching**: For REST API calls, always provide a cache object (e.g., `rds_database(source = "cache.rds")`) to avoid redundant network requests.
- **Dictionaries**: Use built-in dictionaries like `greek_dictionary` or `racemic_dictionary` within `normalise_strings()` to improve hit rates for name-based lookups.
- **LCMS Specifics**: Use `lcms_table` if you need to perform `mz_match()` or `rt_match()`, as these require specific m/z and retention time columns.

## Reference documentation
- [Extending MetMashR](./references/Extending_MetMashR.md)
- [Annotation of mixtures of standards](./references/annotate_mixtures.md)
- [Exploring the MTox700+ library](./references/exploring_mtox.md)
- [Using MetMashR](./references/using_MetMashR.md)