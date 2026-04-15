---
name: bioconductor-rsbml
description: This package provides an R interface to the libsbml library for parsing, manipulating, and generating Systems Biology Markup Language (SBML) files. Use when user asks to read or write SBML files, convert models into S4 objects or graph representations, and validate SBML model consistency.
homepage: https://bioconductor.org/packages/release/bioc/html/rsbml.html
---

# bioconductor-rsbml

## Overview

The `rsbml` package provides an R interface to the `libsbml` library, allowing for high-performance parsing and generation of SBML (Systems Biology Markup Language) files. It supports converting SBML models into two primary formats: an S4-based Document Object Model (DOM) for detailed attribute manipulation and a standard Bioconductor `graph` object for topological analysis.

## Typical Workflow

### 1. Importing SBML Data
Read an SBML file or character vector into an opaque libsbml document object.

```r
library(rsbml)
# Read from a file
doc <- rsbml_read("path/to/model.xml")

# Read from a character vector
# doc <- rsbml_read(text = xml_string)
```

### 2. Accessing Model Data (S4 DOM)
Convert the document to an S4 object to access specific elements like species, reactions, and parameters.

```r
dom <- rsbml_dom(doc)

# Access species IDs
species_list <- species(model(dom))
sapply(species_list, id)

# Access reactions
reac_list <- reactions(model(dom))
```

### 3. Network Analysis (Graph Representation)
Convert the SBML structure into a Bioconductor graph object to use with packages like `RBGL` or `Rgraphviz`.

```r
g <- rsbml_graph(doc)

# View nodes (includes both species and reaction nodes)
graph::nodes(g)

# View edges
graph::edges(g)
```

### 4. Validation and Consistency Checking
Check if the model adheres to SBML specification rules.

```r
# Returns TRUE if consistent, otherwise throws warnings/errors
is_consistent <- rsbml_check(doc)

# Handling specific SBML errors
tryCatch(rsbml_read("malformed.xml"), 
         error = function(err) {
           cat("SBML Error:", err$msg, "\n")
         })
```

### 5. Exporting SBML
Convert the document object back into XML format or write it directly to a file.

```r
# To character vector
xml_text <- rsbml_xml(doc)

# To file
# rsbml_write(doc, file = "output_model.xml")
```

## Tips and Best Practices
- **DOM vs Graph**: Use `rsbml_dom` when you need to modify parameters, initial concentrations, or kinetic laws. Use `rsbml_graph` when you want to perform pathfinding, clustering, or visualization of the biochemical network.
- **Validation**: Always run `rsbml_check()` after programmatically modifying a DOM and before exporting to ensure the resulting XML is valid SBML.
- **Error Types**: The package uses specific condition classes: `SBMLFatal`, `SBMLError` (both inherit from `error`), and `SBMLWarning` (inherits from `warning`).

## Reference documentation
- [Quick Introduction to rsbml](./references/quick-start.md)