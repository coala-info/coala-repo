---
name: bioconductor-tidysbml
description: This tool converts Systems Biology Markup Language (SBML) files into tidy R dataframes for biological pathway analysis. Use when user asks to extract species, reactions, or compartments from SBML files, convert biological models into tabular formats, or prepare SBML data for tidyverse and network visualization workflows.
homepage: https://bioconductor.org/packages/release/bioc/html/tidysbml.html
---


# bioconductor-tidysbml

name: bioconductor-tidysbml
description: Convert Systems Biology Markup Language (SBML) files into tidy R dataframes. Use this skill when you need to extract biological pathway information (species, compartments, reactions) from SBML files for analysis with tidyverse, biomaRt, or network visualization tools like RCy3.

## Overview
The `tidysbml` package provides a bridge between the XML-based SBML standard and R's tabular data structures. It simplifies the extraction of metadata, annotations, and structural relationships from biological models, making them accessible for standard data science workflows.

## Core Workflow

### 1. Load the Package
```r
library(tidysbml)
```

### 2. Convert SBML to R List
Most functions require an intermediate list object created by `sbml_as_list()`.
```r
# Convert entire model
sbml_list <- sbml_as_list("path/to/model.sbml")

# Convert specific component only (species, compartments, or reactions)
list_species <- sbml_as_list("path/to/model.sbml", component = "species")
```

### 3. Extract Dataframes
Use `as_dfs()` for a complete extraction or `as_df()` for specific components.

**Complete Extraction:**
Returns a list of up to 4 dataframes: `df_compartments`, `df_species`, `df_reactions`, and `df_species_in_reactions`.
```r
# Direct from file
list_of_dfs <- as_dfs("path/to/model.sbml", type = "file")

# From pre-converted list (preferred for efficiency)
list_of_dfs <- as_dfs(sbml_list, type = "list")
```

**Partial Extraction:**
```r
# Extract only species
df_species <- as_df(list_species)

# Extract reactions (returns a list of 2: reactions and species_in_reactions)
list_react <- sbml_as_list(filepath, component = "reactions")
dfs_about_reactions <- as_df(list_react)
df_reactions <- dfs_about_reactions[[1]]
df_participants <- dfs_about_reactions[[2]]
```

## Data Structure Details
- **Attributes**: Standard SBML tags (id, name, metaid) become column names.
- **Notes**: Stored in a `notes` column; multiple values are separated by `|`.
- **Annotations**: Prefixed with `annotation_` (e.g., `bqbiol:is` becomes `annotation_is`). Multiple URIs are separated by spaces.
- **Reaction Participants**: The `df_species_in_reactions` table includes `reaction_id` and `container_list` (identifying if the species is a reactant, product, or modifier).

## Integration Examples

### Network Analysis (RCy3)
Create an edgelist for Cytoscape:
```r
library(dplyr)
edgelist <- list_of_dfs$df_species_in_reactions %>% 
  select(source = reaction_id, target = species)
```

### External Annotation (biomaRt)
Extract Uniprot IDs from annotations to fetch gene symbols:
```r
# Example: Extracting IDs from annotation_hasPart
# 1. Split URIs by " "
# 2. Filter for "uniprot" strings
# 3. Use biomaRt::getBM() with the extracted IDs
```

## Tips
- **Input Validation**: `as_dfs()` requires the SBML file to have standard `<sbml>` and `<model>` root tags.
- **Efficiency**: If you need to call extraction functions multiple times, run `sbml_as_list()` once and pass the resulting list to `as_dfs(..., type = "list")`.
- **Missing Data**: Columns for annotations or notes that are empty in the SBML will be filled with `NA`.

## Reference documentation
- [Introduction to the tidysbml package](./references/tidysbml-introduction.md)