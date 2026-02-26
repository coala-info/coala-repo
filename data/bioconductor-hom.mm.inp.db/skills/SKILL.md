---
name: bioconductor-hom.mm.inp.db
description: This tool maps mouse gene identifiers to orthologous genes in other species using Inparanoid data. Use when user asks to find mouse orthologs in other organisms, map Ensembl protein IDs across species, or perform cross-species genomic analysis.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/hom.Mm.inp.db.html
---


# bioconductor-hom.mm.inp.db

name: bioconductor-hom.mm.inp.db
description: Use this skill to map Mus musculus (mouse) gene identifiers to orthologous genes in other species using Inparanoid data. This skill is essential for cross-species genomic analysis, specifically for finding mouse orthologs in organisms like humans (HOMSA), rats (RATNO), and others.

## Overview

The `hom.Mm.inp.db` package is a Bioconductor annotation data package providing mappings between mouse genes and their predicted orthologs (referred to as paralogs in Inparanoid) in various other organisms. These mappings are based on the Inparanoid algorithm and are filtered to include only those with a score of 100.

## Core Workflows

### Load and Explore the Package

Load the library and list all available mapping objects:

```r
library(hom.Mm.inp.db)
# List all available maps
ls("package:hom.Mm.inp.db")
# Check the organism name
hom.Mm.inpORGANISM
```

### Map Mouse IDs to Other Species

Mappings are named using the "INPARANOID style": the first three letters of the genus followed by the first two letters of the species (e.g., `HOMSA` for Homo sapiens, `RATNO` for Rattus norvegicus).

```r
# Example: Map Mouse to Human (HOMSA)
# Get the mapping object
x <- hom.Mm.inpHOMSA

# Get mapped keys (Ensembl Protein IDs)
mapped_ids <- mappedkeys(x)

# Convert to a list to see orthologs for specific mouse proteins
xx <- as.list(x[mapped_ids])
# View the first few entries
head(xx)
```

### Reverse Mappings (Other Species to Mouse)

Use the `revmap` function to find mouse orthologs for genes from another species.

```r
# Example: Map Human IDs back to Mouse
human_to_mouse <- revmap(hom.Mm.inpHOMSA)
mapped_human_ids <- mappedkeys(human_to_mouse)
xx_rev <- as.list(human_to_mouse[mapped_human_ids])
```

### Cross-Referencing with Entrez IDs

Inparanoid uses Ensembl Protein IDs. To work with Entrez Gene IDs, you must use organism-specific annotation packages (like `org.Mm.eg.db` for mouse or `org.Hs.eg.db` for human) to perform a two-step mapping.

1.  Map Entrez ID to Ensembl Protein ID using `org.Mm.eg.db`.
2.  Map Ensembl Protein ID to the target species using `hom.Mm.inp.db`.

```r
library(org.Mm.eg.db)
# Get Ensembl Protein IDs for Mouse Entrez IDs
mouse_entrez <- c("12345", "67890")
mouse_prot <- mget(mouse_entrez, org.Mm.egENSEMBLPROT, ifnotfound=NA)

# Map to Human Protein IDs
human_prot <- mget(unlist(mouse_prot), hom.Mm.inpHOMSA, ifnotfound=NA)
```

## Database Utilities

Access the underlying SQLite database for direct querying or metadata inspection:

```r
# Get database connection
conn <- hom.Mm.inp_dbconn()
# Show database schema
hom.Mm.inp_dbschema()
# Get number of mapped keys for all maps
hom.Mm.inpMAPCOUNTS
```

## Tips and Constraints

- **ID Types**: Always remember that Inparanoid maps use Ensembl Protein IDs, not Entrez Gene IDs or Gene Symbols.
- **Score Filter**: This package only contains mappings with an Inparanoid score of 100 (the "seed" orthologs).
- **Naming Convention**: If you are unsure of a species code, use `ls("package:hom.Mm.inp.db")` to find the correct `hom.Mm.inp[CODE]` object.
- **Database Connection**: Do not call `dbDisconnect()` on the object returned by `hom.Mm.inp_dbconn()`, as it will break the package's internal objects.

## Reference documentation

- [hom.Mm.inp.db Reference Manual](./references/reference_manual.md)