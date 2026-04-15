---
name: bioconductor-interminer
description: This tool provides an R interface to programmatically query and retrieve biological data from InterMine-powered warehouses. Use when user asks to connect to biological databases like HumanMine or FlyMine, run template queries, or build custom data mining queries for genomic and protein information.
homepage: https://bioconductor.org/packages/3.6/bioc/html/InterMineR.html
---

# bioconductor-interminer

name: bioconductor-interminer
description: Interface with InterMine biological data warehouses (e.g., FlyMine, HumanMine, YeastMine). Use this skill to programmatically query genomic, expression, and protein data from various organisms using the InterMineR Bioconductor package.

# bioconductor-interminer

## Overview

InterMineR provides an R interface to InterMine-powered databases. It allows users to perform sophisticated data mining queries across integrated biological datasets (genes, proteins, pathways, GO terms, etc.) using web services. The package supports using pre-built "templates" or constructing custom queries from scratch.

## Core Workflow

### 1. Initialize a Mine Connection
First, identify the available databases and initialize a connection to a specific "Mine".

```r
library(InterMineR)

# List all available InterMine instances
mines <- listMines()

# Initialize connection (e.g., to HumanMine)
im <- initInterMine(mine = mines["HumanMine"])
```

### 2. Using Template Queries
Templates are pre-defined queries with fixed output columns and constraints. This is the easiest way to retrieve data.

```r
# List available templates
templates <- getTemplates(im)

# Retrieve a specific template query by name
query <- getTemplateQuery(im = im, name = "Gene_Pathway")

# Run the query
results <- runQuery(im, query)
```

### 3. Modifying Queries
Queries are list objects in R. You can modify their `select` (columns), `where` (constraints), and `constraintLogic`.

#### Edit Constraints
```r
# Method 1: Direct list modification
query$where[[1]][["value"]] <- "ABO"

# Method 2: Using setConstraints helper
query$where <- setConstraints(
  modifyQueryConstraints = query,
  m.index = 1,
  values = list("ABO")
)
```

#### Add New Constraints
A constraint requires a `path` (data model path), `op` (operator like "=", "LOOKUP", "ONE OF"), `value`, and a unique `code`.

```r
newConstraint <- list(
  path = "Gene.pathways.name",
  op = "=",
  value = "ABO blood group biosynthesis",
  code = "B"
)
query$where[[2]] <- newConstraint
```

#### Add Columns (Select)
```r
# Add a column to the output view
query$select <- c(query$select, "Gene.diseases.name")
```

### 4. Building Custom Queries
For complex tasks, use `setQuery` and `setConstraints` to build a query from scratch.

```r
constraints <- setConstraints(
  paths = c("Gene.symbol", "Gene.organism.name"),
  operators = c("=", "="),
  values = list("ABCA6", "Homo sapiens")
)

customQuery <- setQuery(
  select = c("Gene.primaryIdentifier", "Gene.symbol", "Gene.locations.start"),
  where = constraints
)

res <- runQuery(im, customQuery)
```

## Data Model Navigation
To understand what paths are available (e.g., `Gene.symbol`), you can inspect the data model:
- Use `getModel(im)` to retrieve the schema.
- Paths follow the format `Class.attribute` or `Class.reference.attribute` (e.g., `Gene.pathways.name`).

## Common Operators
- `=`: Exact match.
- `LOOKUP`: Search for a term (often requires `extraValue` for organism).
- `ONE OF`: Match any in a list.
- `LIKE`: Pattern matching.

## Reference documentation
- [InterMineR Vignette](./references/InterMineR.Rmd)