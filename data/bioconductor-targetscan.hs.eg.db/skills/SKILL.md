---
name: bioconductor-targetscan.hs.eg.db
description: This package provides human miRNA target predictions from the TargetScan database, mapping miRNA families to their predicted mRNA targets and binding site details. Use when user asks to map miRNA families to miRBase identifiers, retrieve predicted mRNA targets for specific miRNAs, or access detailed binding site information like UTR positions and PCT scores.
homepage: https://bioconductor.org/packages/3.7/data/annotation/html/targetscan.Hs.eg.db.html
---


# bioconductor-targetscan.hs.eg.db

name: bioconductor-targetscan.hs.eg.db
description: Provides detailed information about the TargetScan miRNA target prediction database for Human (Homo sapiens). Use this skill when you need to map miRNA families to miRBase identifiers, retrieve predicted mRNA targets (Entrez Gene IDs) for specific miRNAs, or access detailed binding site information (UTR positions, seed match types, and PCT scores) for conserved miRNA targets.

# bioconductor-targetscan.hs.eg.db

## Overview

The `targetscan.Hs.eg.db` package is a Bioconductor annotation data package that provides a local interface to the TargetScan database for human miRNA target predictions. It specifically focuses on **conserved** miRNA targets (those conserved across mammals). The package uses a mapping-based architecture where keys (like Entrez Gene IDs or miRNA families) can be used to retrieve associated biological data.

## Core Objects and Mappings

To see all available mapping objects in the package:
```r
library(targetscan.Hs.eg.db)
ls("package:targetscan.Hs.eg.db")
```

### miRNA and Family Identifiers
*   `targetscan.Hs.egFAMILY2MIRBASE`: Maps miRNA family names (e.g., "miR-10abc/10a-5p") to miRBase identifiers (e.g., "hsa-miR-10a").
*   `targetscan.Hs.egMIRBASE2FAMILY`: Maps miRBase identifiers back to miRNA family names.
*   `targetscan.Hs.egMIRNA`: Provides metadata for miRBase IDs, including the seed sequence (Seed.m8), species, and mature sequence.

### Target Predictions
*   `targetscan.Hs.egTARGETS`: Maps Entrez Gene IDs to the miRNA families predicted to target them.
*   `targetscan.Hs.egTARGETSFULL`: Maps Entrez Gene IDs to a detailed list of targeting information, including:
    *   `UTR.start` / `UTR.end`: Position on the 3' UTR.
    *   `Seed.match`: Type of match (8mer, m8, or 1A).
    *   `PCT`: The probability of conserved targeting.

## Typical Workflows

### 1. Finding Targets for a Specific miRNA Family
Since the primary mapping `targetscan.Hs.egTARGETS` is keyed by Gene ID, use `revmap` to search by miRNA family.

```r
# Get all Entrez Gene IDs targeted by a specific miRNA family
miRNA_fam <- "miR-10abc/10a-5p"
targets <- mget(miRNA_fam, revmap(targetscan.Hs.egTARGETS))
```

### 2. Identifying miRNA Families Targeting a Gene
If you have a list of Entrez Gene IDs and want to know which miRNAs regulate them:

```r
gene_ids <- c("100", "101") # Example Entrez IDs
mget(gene_ids, targetscan.Hs.egTARGETS)
```

### 3. Retrieving Detailed Binding Site Info
To get specific coordinates and match types for a gene:

```r
# Returns a list of lists with UTR positions and PCT scores
detailed_targets <- mget("7040", targetscan.Hs.egTARGETSFULL)
```

### 4. Direct SQL Access
For complex queries, you can access the underlying SQLite database directly:

```r
conn <- targetscan.Hs.eg_dbconn()
dbGetQuery(conn, "SELECT * FROM mirna_family LIMIT 5")
```

## Tips and Usage Notes
*   **Conserved Targets Only**: This package only contains predictions for targets conserved across mammals. Non-conserved targets are not included.
*   **Entrez IDs**: The package uses Entrez Gene identifiers as the primary key for genes. If you have Gene Symbols or Ensembl IDs, use `org.Hs.eg.db` to convert them to Entrez IDs first.
*   **miRBase Versions**: miRNA nomenclature changes; use `targetscan.Hs.egFAMILY2MIRBASE` to ensure you are using the correct family names recognized by TargetScan.

## Reference documentation
- [targetscan.Hs.eg.db Reference Manual](./references/reference_manual.md)