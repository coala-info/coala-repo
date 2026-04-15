---
name: bioconductor-hom.dm.inp.db
description: This tool extracts Inparanoid-based orthology mappings between Drosophila melanogaster and other species from the hom.Dm.inp.db Bioconductor package. Use when user asks to translate fruit fly gene identifiers to orthologs in other organisms, perform reverse mappings from foreign species back to fly IDs, or access high-confidence seed ortholog data.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/hom.Dm.inp.db.html
---

# bioconductor-hom.dm.inp.db

name: bioconductor-hom.dm.inp.db
description: Use this skill to navigate and extract orthology data from the hom.Dm.inp.db Bioconductor package. This package provides Inparanoid-based mappings between Drosophila melanogaster (fruit fly) genes and their predicted orthologs/paralogs in other species. Use this when you need to translate fly gene identifiers to other organisms (like Human, Mouse, or Rat) or vice versa using high-confidence (score 100) Inparanoid data.

## Overview

The hom.Dm.inp.db package is a specialized annotation database containing orthology information for Drosophila melanogaster. It utilizes the Inparanoid algorithm to identify clusters of orthologs and paralogs. By default, the mappings provided in this package are filtered to include only those with an Inparanoid score of 100 (the "seed" orthologs).

## Key Functions and Objects

### Exploration
To see all available mapping objects in the package:
ls("package:hom.Dm.inp.db")

To identify the target organism of the package:
hom.Dm.inpORGANISM

### Mapping Orthologs
Mappings are named using a 5-letter "INPARANOID style" code (3 letters of Genus + 2 letters of Species).
Common codes include:
- HOMSA: Homo sapiens (Human)
- MUSMU: Mus musculus (Mouse)
- RATNO: Rattus norvegicus (Rat)
- CAEEL: Caenorhabditis elegans (Worm)
- SACCE: Saccharomyces cerevisiae (Yeast)

Example: Mapping Fly IDs to Human IDs
library(hom.Dm.inp.db)
# Select the Human map
x <- hom.Dm.inpHOMSA
# Get keys (Fly IDs) that have mappings
mapped_ids <- mappedkeys(x)
# Convert to a list to see the Human orthologs
ortholog_list <- as.list(x[mapped_ids])
# Access specific gene
ortholog_list[[1]]

### Reverse Mapping
To map from a foreign organism back to Drosophila melanogaster, use the revmap function:
# Map Human IDs back to Fly IDs
human_to_fly <- revmap(hom.Dm.inpHOMSA)
fly_ids <- as.list(human_to_fly["ENSG00000139618"])

### Database Connection and Metadata
To inspect the underlying SQLite database:
hom.Dm.inp_dbconn()    # Returns the DB connection
hom.Dm.inp_dbschema()  # Prints the schema
hom.Dm.inp_dbInfo()    # Prints package metadata

## Workflow: Fly to Mouse via Ensembl Protein IDs
Inparanoid typically uses Ensembl Protein IDs. If you have Entrez IDs, you must first map them to Ensembl Protein IDs using an organism-level package (like org.Dm.eg.db) before using hom.Dm.inp.db.

1. Start with Fly Entrez IDs.
2. Map Fly Entrez IDs -> Fly Ensembl Protein IDs (using org.Dm.eg.db).
3. Map Fly Ensembl Protein IDs -> Mouse Ensembl Protein IDs (using hom.Dm.inpMUSMU).
4. Map Mouse Ensembl Protein IDs -> Mouse Entrez IDs (using org.Mm.eg.db).

## Tips
- Inparanoid scores: This package only contains mappings with a score of 100. If a gene is missing, it may have a lower confidence score in the raw Inparanoid database.
- Map Counts: Use hom.Dm.inpMAPCOUNTS to see the number of mapped keys for every organism map in the package.
- Package Updates: Bioconductor typically updates these packages biannually, though the underlying Inparanoid source data may update less frequently.

## Reference documentation
- [hom.Dm.inp.db Reference Manual](./references/reference_manual.md)