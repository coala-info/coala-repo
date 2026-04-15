---
name: bioconductor-rpsixml
description: This tool parses PSI-MI XML 2.5 molecular interaction data into R graph objects and specialized interaction entries for network analysis. Use when user asks to parse PSI-MI XML files from databases like IntAct or BioGRID, convert molecular interaction data into graphNEL objects, or extract protein complex information for network analysis in R.
homepage: https://bioconductor.org/packages/3.6/bioc/html/RpsiXML.html
---

# bioconductor-rpsixml

name: bioconductor-rpsixml
description: Programmatic interface for PSI-MI XML2.5 molecular interaction data. Use this skill to parse XML files from databases like IntAct, MINT, DIP, HPRD, and BioGRID into R graph objects (graphNEL) or specialized interaction/complex entry objects for network analysis.

# bioconductor-rpsixml

## Overview

The `RpsiXML` package provides a bridge between the Protein Standardization Initiative Molecular Interaction (PSI-MI) XML 2.5 format and the R/Bioconductor environment. It allows users to convert complex XML data into standard R objects, such as `graphNEL` objects, which can then be analyzed using network analysis packages like `RBGL`, `ppiStats`, and `Rgraphviz`.

## Core Workflow

### 1. Loading the Package and Data
To use `RpsiXML`, you must identify the source database, as each implements the PSI-MI standard with slight variations.

```r
library(RpsiXML)

# Define the path to your PSI-MI XML file
xml_file <- "path/to/your/data.xml"

# Specify the source (e.g., INTACT.PSIMI25, MINT.PSIMI25, DIP.PSIMI25, 
# HPRD.PSIMI25, BIOGRID.PSIMI25, MIPS.PSIMI25)
source_db <- INTACT.PSIMI25
```

### 2. Parsing XML into R Objects
There are two primary ways to bring data into R:

**Method A: High-level Interaction/Complex Objects**
Use this when you need detailed metadata about every interaction (e.g., pubmed IDs, confidence values).
```r
# For bait-prey/binary interactions
int_entry <- parsePsimi25Interaction(xml_file, source_db)

# For curated protein complexes
comp_entry <- parsePsimi25Complex(xml_file, source_db)

# Extracting data
all_interactions <- interactions(int_entry)
first_int <- all_interactions[[1]]
participant(first_int)
bait(first_int)
prey(first_int)
```

**Method B: Direct Graph Conversion**
Use this for immediate computational or topological analysis.
```r
# Create a graphNEL object
# type can be "interaction" or "complex"
ppi_graph <- psimi25XML2Graph(xml_file, source_db, type="interaction")

# Basic graph stats
nodes(ppi_graph)
degree(ppi_graph)
```

### 3. Advanced Parsing by Experiment
If an XML file contains data from multiple publications, you can split them into a list of graphs indexed by PubMed ID.
```r
graphs_by_expt <- separateXMLDataByExpt(xmlFiles = xml_file, 
                                        psimi25source = source_db, 
                                        type = "indirect", 
                                        directed = TRUE, 
                                        abstract = TRUE)

# Access a specific experiment's graph
pmid <- names(graphs_by_expt)[1]
plot(graphs_by_expt[[pmid]])
```

### 4. ID Translation
PSI-MI files typically use UniProtKB IDs. You can translate these to database-specific IDs (like IntAct IDs) using `translateID`.
```r
translated_graph <- translateID(ppi_graph, to = "intact")
```

## Common Analysis Tasks

### Network Statistics
Once converted to a graph, use standard Bioconductor tools:
```r
library(RBGL)
# Find cliques (functional complexes)
cliques <- maxClique(ppi_graph)

# Remove self-loops (dimers)
# Use ppiStats or manual filtering
is_self_loop <- sapply(nodes(ppi_graph), function(n) n %in% adj(ppi_graph, n)[[1]])
```

### Assessing Reciprocity
For bait-prey systems, check if interactions were observed in both directions (A->B and B->A).
```r
library(ppiStats)
symmetry_stats <- assessSymmetry(ppi_graph, bpGraph = TRUE)
```

## Tips and Best Practices
- **Memory Management**: PSI-MI XML files can be very large. If parsing fails due to memory, consider splitting the XML file or using `separateXMLDataByExpt`.
- **Abstract Fetching**: When using `separateXMLDataByExpt`, set `abstract = FALSE` if processing many files to avoid being rate-limited or banned by NCBI/PubMed.
- **Source Objects**: Always match the `psimi25source` argument to the database that generated the XML file (e.g., use `BIOGRID.PSIMI25` for BioGRID data).

## Reference documentation
- [RpsiXML](./references/RpsiXML.md)
- [RpsiXMLApp](./references/RpsiXMLApp.md)