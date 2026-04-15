---
name: bioconductor-targetscan.mm.eg.db
description: This package provides annotation data for conserved miRNA target predictions in mouse (Mus musculus) from the TargetScan database. Use when user asks to map between miRNA families and miRBase identifiers, retrieve Entrez Gene targets for specific miRNAs, or access detailed UTR coordinate and conservation data for mouse miRNA target sites.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/targetscan.Mm.eg.db.html
---

# bioconductor-targetscan.mm.eg.db

name: bioconductor-targetscan.mm.eg.db
description: Provides annotation data for TargetScan miRNA target predictions in Mouse (Mus musculus). Use this skill when you need to map between miRNA families, miRBase identifiers, and Entrez Gene targets, or when analyzing conserved miRNA target sites in mouse genomic data.

# bioconductor-targetscan.mm.eg.db

## Overview

The `targetscan.Mm.eg.db` package is a Bioconductor annotation data package that provides detailed information from the TargetScan database for Mouse. It specifically focuses on **conserved** miRNA targets (conserved across mammals). The package allows for seamless mapping between miRNA families, miRBase IDs, and Entrez Gene IDs, including spatial information about target sites in the UTR.

## Key Objects and Usage

### Loading the Package
```r
library(targetscan.Mm.eg.db)
# List all available maps in the package
ls("package:targetscan.Mm.eg.db")
```

### miRNA Family and miRBase Mappings
TargetScan groups miRNAs into families based on seed sequence similarity.
- `targetscan.Mm.egFAMILY2MIRBASE`: Maps miRNA family names to miRBase identifiers.
- `targetscan.Mm.egMIRBASE2FAMILY`: Maps miRBase identifiers to miRNA family names.

```r
# Get miRBase IDs for a specific family
mget("miR-10abc/10a-5p", targetscan.Mm.egFAMILY2MIRBASE)

# Find the family for a specific miRBase ID
mget("mmu-let-7a-5p", targetscan.Mm.egMIRBASE2FAMILY)
```

### miRNA Metadata
The `targetscan.Mm.egMIRNA` object provides metadata for miRBase identifiers, including seed sequences and conservation status.

```r
# Get metadata for a miRNA
mget("mmu-miR-10a-5p", targetscan.Mm.egMIRNA)
# Returns: MiRBase.ID, MiRBase.Accession, Seed.m8, Species, Mature.sequence, Family.conservation
```

### Target Predictions
- `targetscan.Mm.egTARGETS`: Maps Entrez Gene IDs to miRNA families.
- `targetscan.Mm.egTARGETSFULL`: Provides detailed mapping including UTR coordinates and Probability of Conserved Targeting (PCT).

```r
# Find miRNA families targeting a specific Entrez Gene ID
mget("12345", targetscan.Mm.egTARGETS)

# Get all targets for a specific miRNA family using revmap
mget("miR-10abc/10a-5p", revmap(targetscan.Mm.egTARGETS))

# Get detailed target information (coordinates and PCT)
mget("12345", targetscan.Mm.egTARGETSFULL)
```

### Database Connectivity and Schema
For advanced users, you can query the underlying SQLite database directly.

```r
# Get the DB connection
conn <- targetscan.Mm.eg_dbconn()

# List tables
dbListTables(conn)

# Custom SQL query
dbGetQuery(conn, "SELECT * FROM mirna_family LIMIT 5")
```

## Workflow Tips

1.  **Conserved Targets Only**: Remember that this package only contains predictions for targets conserved across mammals.
2.  **Entrez IDs**: The primary gene identifier used is the Entrez Gene ID. If you have Gene Symbols or Ensembl IDs, use `org.Mm.eg.db` to convert them first.
3.  **Many-to-Many**: A single gene can be targeted by multiple miRNA families, and a single miRNA family can have multiple target sites on the same gene's UTR. `targetscan.Mm.egTARGETS` will return the family name multiple times if there are multiple sites.
4.  **PCT Scores**: When using `targetscan.Mm.egTARGETSFULL`, use the `PCT` (Probability of Conserved Targeting) value to prioritize targets; higher values indicate a higher probability that the target is biologically relevant.

## Reference documentation
- [targetscan.Mm.eg.db Reference Manual](./references/reference_manual.md)