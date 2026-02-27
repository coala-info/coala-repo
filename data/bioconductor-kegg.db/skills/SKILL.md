---
name: bioconductor-kegg.db
description: This tool provides access to legacy KEGG pathway annotation data for mapping between Entrez Gene IDs, Enzyme Commission numbers, and pathway identifiers. Use when user asks to map biological identifiers to KEGG pathways, retrieve pathway names from IDs, or query historical KEGG database snapshots for human, mouse, rat, and yeast.
homepage: https://bioconductor.org/packages/3.11/data/annotation/html/KEGG.db.html
---


# bioconductor-kegg.db

name: bioconductor-kegg.db
description: Access legacy KEGG pathway annotation data including mappings between Entrez Gene IDs, Enzyme Commission (EC) numbers, and KEGG pathway names/identifiers. Use this skill when a user needs to map biological identifiers to KEGG pathways using the Bioconductor KEGG.db package, specifically for human, mouse, rat, and yeast.

## Overview

KEGG.db is a legacy Bioconductor annotation package providing a snapshot of the Kyoto Encyclopedia of Genes and Genomes (KEGG) database. Due to changes in KEGG's data sharing policy, this package is no longer updated and contains static historical data (last major update circa 2011). For current data, users should be directed to `KEGGREST` or `reactome.db`.

The package uses the `AnnotationDbi` interface, allowing for standardized data retrieval using `select()`, `keys()`, and `columns()`.

## Core Workflows

### Loading the Package
```r
library(KEGG.db)
```

### Using the Select Interface (Recommended)
The `select` interface is the modern way to query the database.

1. **List available columns:**
   ```r
   columns(KEGG.db)
   # Typical output: "PATHID", "PATHNAME", "EXTID", "GO", "ENZYMEID"
   ```

2. **List available key types:**
   ```r
   keytypes(KEGG.db)
   ```

3. **Perform a query:**
   Map Entrez IDs to KEGG Pathway IDs and Names.
   ```r
   # Map Entrez Gene IDs to Pathways
   select(KEGG.db, keys = c("1", "10"), columns = c("PATHID", "PATHNAME"), keytype = "EXTID")
   ```

### Using the Bimap Interface (Legacy)
The package also supports direct mapping objects (Bimaps).

*   **Map Entrez/ORF IDs to Pathways:** `KEGGEXTID2PATHID`
*   **Map Pathways to Entrez/ORF IDs:** `KEGGPATHID2EXTID`
*   **Map Pathway IDs to Names:** `KEGGPATHID2NAME`
*   **Map Pathway Names to IDs:** `KEGGPATHNAME2ID`
*   **Map Enzyme Commission (EC) to GO:** `KEGGENZYMEID2GO`
*   **Map GO to Enzyme Commission (EC):** `KEGGGO2ENZYMEID`

**Example usage:**
```r
# Convert a map to a list
pathway_map <- as.list(KEGGPATHID2NAME)
# Access a specific pathway name by ID
pathway_map[["00010"]]
```

### Database Metadata and Connection
To inspect the underlying SQLite database:
```r
# Get database metadata
KEGG_dbInfo()

# Get the database schema
KEGG_dbschema()

# Execute a direct SQL query (requires DBI package)
library(DBI)
dbGetQuery(KEGG_dbconn(), "SELECT * FROM pathway2name LIMIT 5")
```

## Important Considerations
*   **Data Currency:** The data is frozen. If the user requires the latest pathway information, suggest `KEGGREST`.
*   **Organism Support:** Primarily supports Human, Mouse, Rat (Entrez Gene IDs), and Yeast (ORF identifiers).
*   **Map Counts:** Use `checkMAPCOUNTS("KEGG.db")` to verify the number of mapped keys across all tables.

## Reference documentation
- [KEGG.db Reference Manual](./references/reference_manual.md)