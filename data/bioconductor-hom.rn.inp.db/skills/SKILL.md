---
name: bioconductor-hom.rn.inp.db
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/hom.Rn.inp.db.html
---

# bioconductor-hom.rn.inp.db

name: bioconductor-hom.rn.inp.db
description: Provides orthology and paralogy mappings for Rattus norvegicus (Rat) based on the Inparanoid algorithm. Use this skill when you need to translate gene or protein identifiers between Rat and other organisms (such as Human, Mouse, or Yeast) using high-confidence Inparanoid data (score 100).

## Overview

The `hom.Rn.inp.db` package is a Bioconductor annotation data package containing ortholog mappings for *Rattus norvegicus*. It uses the Inparanoid algorithm to identify paralogs and orthologs between Rat and a wide variety of other organisms. The mappings are primarily based on Ensembl protein identifiers.

## Core Usage

### Loading and Exploration

Load the package and list all available mapping objects:

```R
library(hom.Rn.inp.db)
# List all available maps
ls("package:hom.Rn.inp.db")
# Check the source organism
hom.Rn.inpORGANISM
```

### Mapping to Other Organisms

Maps are named using an "INPARANOID style" abbreviation: the first three letters of the genus followed by the first two letters of the species (e.g., `HOMSA` for *Homo sapiens*, `MUSMU` for *Mus musculus*).

To map Rat IDs to Human IDs:

```R
# Access the Human map
x <- hom.Rn.inpHOMSA
# Get mapped keys (Rat IDs)
mapped_IDs <- mappedkeys(x)
# Convert to a list to see Human paralogs for Rat IDs
xx <- as.list(x[mapped_IDs])
# View the first few mappings
xx[1:5]
```

### Reverse Mapping

To map from a target organism back to Rat, use the `revmap` function:

```R
# Map Human IDs back to Rat
human_to_rat <- revmap(hom.Rn.inpHOMSA)
# Convert to list
as.list(human_to_rat[1:5])
```

## Common Organism Abbreviations

- **HOMSA**: *Homo sapiens* (Human)
- **MUSMU**: *Mus musculus* (Mouse)
- **DANRE**: *Danio rerio* (Zebrafish)
- **DROME**: *Drosophila melanogaster* (Fly)
- **SACCE**: *Saccharomyces cerevisiae* (Yeast)
- **CANFA**: *Canis familiaris* (Dog)

## Workflow: Mapping to Entrez IDs

Inparanoid maps typically use protein IDs. To get Entrez Gene IDs, you must combine this package with organism-specific annotation packages (e.g., `org.Hs.eg.db` for Human).

1. Start with Rat IDs.
2. Map to target organism protein IDs using `hom.Rn.inp.db`.
3. Use the target organism's `org.db` package to map those protein IDs to Entrez IDs (using `ENSEMBLPROT2EG` or similar maps).

## Database Utilities

Access underlying SQLite database information:

```R
# Get DB connection
conn <- hom.Rn.inp_dbconn()
# Show DB schema
hom.Rn.inp_dbschema()
# Get number of mapped keys for all maps
hom.Rn.inpMAPCOUNTS
```

## Reference documentation

- [hom.Rn.inp.db Reference Manual](./references/reference_manual.md)