---
name: bioconductor-hom.at.inp.db
description: This package provides orthology and paralogy mappings for Arabidopsis thaliana based on the Inparanoid algorithm. Use when user asks to identify orthologous genes between Arabidopsis and other organisms, perform cross-species gene identifier conversions, or access Inparanoid seed mappings.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/hom.At.inp.db.html
---


# bioconductor-hom.at.inp.db

name: bioconductor-hom.at.inp.db
description: Provides orthology and paralogy mappings for Arabidopsis thaliana (At) based on the Inparanoid algorithm. Use this skill to identify orthologous genes between Arabidopsis and other organisms (e.g., Human, Mouse, Yeast) or to perform cross-species gene identifier conversions.

## Overview

The `hom.At.inp.db` package is a Bioconductor annotation data package containing orthology mappings for *Arabidopsis thaliana*. It uses data from the Inparanoid database, specifically filtering for paralogs with a confidence score of 100. The package allows for bidirectional mapping between Arabidopsis gene identifiers and those of numerous other model organisms.

## Getting Started

Load the package to access the mapping objects:

```r
library(hom.At.inp.db)
```

To see all available mapping objects (species) supported by this package:

```r
ls("package:hom.At.inp.db")
```

## Core Functionality

### Identifying the Target Organism
Confirm the organism for which the package was built:

```r
hom.At.inpORGANISM
```

### Mapping Arabidopsis to Other Species
Mappings are named using the "INPARANOID style" (first three letters of Genus + first two letters of Species). For example, `hom.At.inpHOMSA` maps Arabidopsis to *Homo sapiens*.

To extract mappings:

```r
# Example: Mapping to Honeybee (APIME)
x <- hom.At.inpAPIME
mapped_ids <- mappedkeys(x)
# Convert to list to see paralogs
as.list(x[mapped_ids[1:5]])
```

### Reverse Mapping (Other Species to Arabidopsis)
Use the `revmap` function to find Arabidopsis orthologs for a different species:

```r
# Example: Mapping Honeybee IDs back to Arabidopsis
x_rev <- revmap(hom.At.inpAPIME)
as.list(x_rev[1:5])
```

### Common Species Abbreviations
- **HOMSA**: *Homo sapiens* (Human)
- **MUSMU**: *Mus musculus* (Mouse)
- **RATNO**: *Rattus norvegicus* (Rat)
- **DROME**: *Drosophila melanogaster* (Fly)
- **SACCE**: *Saccharomyces cerevisiae* (Yeast)
- **DANRE**: *Danio rerio* (Zebrafish)

## Workflows

### Cross-Species ID Conversion
Inparanoid typically uses Ensembl Protein IDs. To convert from Entrez Gene IDs in one species to Entrez Gene IDs in Arabidopsis, you must combine this package with organism-specific packages (like `org.Hs.eg.db` and `org.At.tair.db`).

1. Map Source Entrez ID -> Source Ensembl Protein ID (using `org.XX.eg.db`).
2. Map Source Ensembl Protein ID -> Arabidopsis Protein ID (using `hom.At.inpXXXXX`).
3. Map Arabidopsis Protein ID -> Arabidopsis TAIR/Entrez ID (using `org.At.tair.db`).

### Database Connectivity
Access underlying SQLite metadata or schema information:

```r
# Get DB connection
conn <- hom.At.inp_dbconn()
# Show schema
hom.At.inp_dbschema()
# Get map counts (number of mapped keys)
hom.At.inpMAPCOUNTS
```

## Tips and Limitations
- **Score Filter**: This package only contains mappings with an Inparanoid score of 100 (seed status).
- **ID Types**: Always verify the identifier type used by the specific map; it is usually protein-based (Ensembl or UniProt).
- **Updates**: Inparanoid data sources are updated infrequently; check `hom.At.inp_dbInfo()` for versioning details.

## Reference documentation

- [hom.At.inp.db Reference Manual](./references/reference_manual.md)