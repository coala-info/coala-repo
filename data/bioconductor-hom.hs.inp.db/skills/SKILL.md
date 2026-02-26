---
name: bioconductor-hom.hs.inp.db
description: This package provides orthology and paralogy mappings between human genes and other species based on the Inparanoid algorithm. Use when user asks to identify human gene counterparts in other organisms, map Ensembl protein IDs across species, or retrieve ortholog data for species like mouse, rat, or yeast.
homepage: https://bioconductor.org/packages/3.11/data/annotation/html/hom.Hs.inp.db.html
---


# bioconductor-hom.hs.inp.db

name: bioconductor-hom.hs.inp.db
description: Use this skill when working with the Bioconductor annotation package hom.Hs.inp.db. This package provides orthology and paralogy mappings between Homo sapiens (human) and other organisms based on the Inparanoid algorithm. Use it to identify human gene counterparts in species like mouse (MUSMU), rat (RATNO), or yeast (SACCE).

## Overview

The `hom.Hs.inp.db` package is a specialized annotation database containing Inparanoid ortholog mappings for human genes. Unlike standard organism-level packages (like `org.Hs.eg.db`), this package focuses specifically on cross-species protein-to-protein relationships.

Key characteristics:
- **Source**: Inparanoid algorithm data.
- **Filtering**: Only paralogs with an Inparanoid score of 100 (seed status) are included.
- **Identifiers**: Primarily uses Ensembl Protein IDs for mappings.
- **Naming Convention**: Maps are named `hom.Hs.inp[SPECIES]`, where `[SPECIES]` is a 5-letter code (e.g., `MUSMU` for Mus musculus).

## Basic Usage

To explore the available species maps within the package:

```R
library(hom.Hs.inp.db)

# List all available mapping objects
ls("package:hom.Hs.inp.db")

# Check the organism this package is built for
hom.Hs.inpORGANISM

# Get counts of mapped keys for all species
hom.Hs.inpMAPCOUNTS
```

## Mapping Orthologs

Mappings are provided from Human Ensembl Protein IDs to the target organism's IDs.

```R
# Example: Mapping Human to Mouse (MUSMU)
x <- hom.Hs.inpMUSMU

# Get all mapped human protein IDs
mapped_ids <- mappedkeys(x)

# Convert to a list to see mappings for specific proteins
# Returns a list where names are Human IDs and values are Mouse IDs
xx <- as.list(x[mapped_ids[1:5]])
```

### Reverse Mapping

To map from another organism back to Human, use the `revmap` function:

```R
# Map Mouse IDs back to Human
mouse_to_human <- revmap(hom.Hs.inpMUSMU)
xx <- as.list(mouse_to_human)
```

## Common Species Codes

- `MUSMU`: Mus musculus (Mouse)
- `RATNO`: Rattus norvegicus (Rat)
- `DANRE`: Danio rerio (Zebrafish)
- `DROME`: Drosophila melanogaster (Fruit fly)
- `SACCE`: Saccharomyces cerevisiae (Yeast)
- `CANFA`: Canis familiaris (Dog)
- `PANTR`: Pan troglodytes (Chimpanzee)

## Workflow: Entrez ID to Ortholog

Since `hom.Hs.inp.db` uses Ensembl Protein IDs, you often need to bridge from Entrez Gene IDs using `org.Hs.eg.db`.

```R
library(org.Hs.eg.db)
library(hom.Hs.inp.db)

# 1. Start with Human Entrez IDs
human_entrez <- c("4488", "4487")

# 2. Map Entrez IDs to Ensembl Protein IDs
human_prot_ids <- mget(human_entrez, org.Hs.egENSEMBLPROT, ifnotfound=NA)

# 3. Map to Mouse Protein IDs using hom.Hs.inp.db
# Note: Inparanoid maps only the primary translation product
mouse_prot_ids <- mget(unlist(human_prot_ids), hom.Hs.inpMUSMU, ifnotfound=NA)

# 4. Clean up NAs
mouse_prot_ids <- mouse_prot_ids[!is.na(mouse_prot_ids)]
```

## Database Information

For low-level database access or metadata:

```R
# Get database connection
conn <- hom.Hs.inp_dbconn()

# Show database schema
hom.Hs.inp_dbschema()

# Get metadata about the database
hom.Hs.inp_dbInfo()
```

## Reference documentation

- [hom.Hs.inp.db Reference Manual](./references/reference_manual.md)