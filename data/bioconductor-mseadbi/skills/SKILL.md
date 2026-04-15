---
name: bioconductor-mseadbi
description: This tool creates and manages metabolite set annotation packages for Metabolite Set Enrichment Analysis. Use when user asks to create custom annotation packages from PathBank data, map metabolite identifiers to biological pathways, or query metabolite-pathway mappings using AnnotationDbi interfaces.
homepage: https://bioconductor.org/packages/3.12/bioc/html/MSEADbi.html
---

# bioconductor-mseadbi

name: bioconductor-mseadbi
description: Create and use metabolite set annotation packages (MSEA.XXX.pb.db) for Metabolite Set Enrichment Analysis. Use this skill when you need to generate custom annotation packages from PathBank data or query existing metabolite-pathway mappings using standard AnnotationDbi interfaces (select, columns, keys).

## Overview

MSEADbi is a Bioconductor package designed to construct and manage metabolite set annotation data. It primarily facilitates the creation of organism-specific annotation packages (e.g., `MSEA.Ath.pb.db` for Arabidopsis thaliana) based on PathBank database downloads. Once created, these packages behave like standard Bioconductor `AnnotationDb` objects, allowing users to map between metabolite identifiers (HMDB, KEGG, CAS, ChEBI) and biological pathways.

## Core Workflows

### 1. Creating a Custom MSEA Package
To build a new annotation package, you need a CSV file from PathBank (Metabolite names linked to PathBank primary pathways) and a corresponding metadata table.

```r
library(MSEADbi)

# Load data (ensure column names do not contain dots)
ath_data <- read.csv("path/to/PathBank_data.csv", fileEncoding="utf8")
meta_data <- read.csv("path/to/metadata.csv")
names(ath_data) <- gsub("\\.", "", names(ath_data))
names(meta_data) <- gsub("\\.", "", names(meta_data))

# Generate the package
makeMSEAPackage(
    pkgname = "MSEA.Org.pb.db",
    data = ath_data,
    metadata = meta_data,
    organism = "Species Name",
    version = "0.99.0",
    maintainer = "Name <email@example.com>",
    author = "Author Name",
    destDir = tempdir(),
    license = "Artistic-2.0"
)

# Install the generated package
install.packages(file.path(tempdir(), "MSEA.Org.pb.db"), repos=NULL, type="source")
```

### 2. Querying Annotation Data
Once an MSEA package is installed and loaded, use `AnnotationDbi` methods to retrieve data.

```r
library(AnnotationDbi)
library(MSEA.Ath.pb.db) # Example package

# List available fields and key types
columns(MSEA.Ath.pb.db)
keytypes(MSEA.Ath.pb.db)

# Retrieve specific mappings
# Example: Map PathBank IDs to HMDB and KEGG IDs
ids <- c('SMP0012018', 'SMP0012019')
results <- select(
    MSEA.Ath.pb.db, 
    keys = ids, 
    columns = c("MetaboliteName", "HMDBID", "KEGGID"), 
    keytype = "PathBankID"
)
```

### 3. Database Inspection
Use helper functions to get metadata about the annotation source.

*   `species(MSEA.Ath.pb.db)`: Returns the common name of the organism.
*   `dbInfo(MSEA.Ath.pb.db)`: Displays source URLs and versioning.
*   `dbschema(MSEA.Ath.pb.db)`: Shows the underlying SQLite table structure.
*   `dbconn(MSEA.Ath.pb.db)`: Returns the connection object to the SQLite database.

## Key Columns and Identifiers
The packages typically support the following identifiers:
*   **Metabolite IDs**: `HMDBID`, `KEGGID`, `ChEBIID`, `DrugBankID`, `CAS`, `MetaboliteID`, `MetaboliteName`.
*   **Pathway IDs**: `PathBankID`, `PathwayName`, `PathwaySubject`.
*   **Chemical Info**: `Formula`, `IUPAC`, `SMILES`, `InChI`, `InChIKey`.

## Tips
*   **Data Cleaning**: When using `makeMSEAPackage`, always sanitize column names using `gsub("\\.", "", names(df))` because the underlying SQLite queries may fail with dot-separated names.
*   **Standard Interface**: Because these packages inherit from `AnnotationDb`, they are compatible with any workflow that accepts standard Bioconductor annotation objects.

## Reference documentation
- [Introduction to MSEADbi and MSEA.XXX.pb.db packages](./references/MSEADbi.md)