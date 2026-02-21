---
name: bioconductor-hom.ce.inp.db
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.8/data/annotation/html/hom.Ce.inp.db.html
---

# bioconductor-hom.ce.inp.db

name: bioconductor-hom.ce.inp.db
description: Provides orthology and paralogy mappings for Caenorhabditis elegans (C. elegans) based on the Inparanoid algorithm. Use this skill to retrieve predicted orthologs between C. elegans and other organisms (e.g., Human, Mouse, Rat) or to perform cross-species gene ID conversions using Inparanoid data.

## Overview

The `hom.Ce.inp.db` package is a Bioconductor annotation data package containing orthology mappings for *Caenorhabditis elegans*. It uses the Inparanoid algorithm to identify orthologous gene pairs. The package provides multiple R objects (maps) that link C. elegans gene identifiers to their predicted paralogs/orthologs in other species.

## Core Workflows

### Loading the Package
```r
library(hom.Ce.inp.db)
# List all available mapping objects
ls("package:hom.Ce.inp.db")
```

### Mapping C. elegans IDs to Other Species
Mappings are named using the "INPARANOID style": the first three letters of the genus followed by the first two letters of the species (e.g., `HOMSA` for *Homo sapiens*).

```r
# Example: Map C. elegans to Human (HOMSA)
x <- hom.Ce.inpHOMSA

# Get mapped keys (C. elegans IDs)
mapped_ids <- mappedkeys(x)

# Convert to a list to see mappings
xx <- as.list(x[mapped_ids])

# View the first few mappings
if(length(xx) > 0) {
  xx[1:5]
}
```

### Reverse Mapping (Other Species to C. elegans)
Use `revmap()` to find C. elegans orthologs for genes from another species.

```r
# Example: Map Human IDs back to C. elegans
rev_map <- revmap(hom.Ce.inpHOMSA)
human_to_ce <- as.list(rev_map)
```

### Common Species Abbreviations
- `HOMSA`: *Homo sapiens* (Human)
- `MUSMU`: *Mus musculus* (Mouse)
- `RATNO`: *Rattus norvegicus* (Rat)
- `DANRE`: *Danio rerio* (Zebrafish)
- `DROME`: *Drosophila melanogaster* (Fruit fly)
- `SACCE`: *Saccharomyces cerevisiae* (Yeast)

## Advanced Usage: Cross-Species ID Conversion
Inparanoid uses Ensembl Protein IDs. To map between Entrez Gene IDs of different species, you must combine this package with organism-specific packages (e.g., `org.Hs.eg.db`).

1.  **Start** with Source Species Entrez IDs.
2.  **Map** to Source Species Ensembl Protein IDs (using `org.XX.eg.db`).
3.  **Map** to Target Species Ensembl Protein IDs (using `hom.Ce.inp.db`).
4.  **Map** back to Target Species Entrez IDs (using `org.YY.eg.db`).

## Database Utilities
Access metadata and connection information:
```r
# Get the organism name
hom.Ce.inpORGANISM

# Get map counts (number of mapped keys)
hom.Ce.inpMAPCOUNTS

# Database connection info
hom.Ce.inp_dbconn()
hom.Ce.inp_dbschema()
```

## Tips
- **Score Filter**: This package only includes paralogs that have an Inparanoid score of 100 (the "seed" orthologs).
- **Naming Convention**: If you are unsure of a species code, use `ls("package:hom.Ce.inp.db")` to see all available maps.

## Reference documentation
- [hom.Ce.inp.db Reference Manual](./references/reference_manual.md)