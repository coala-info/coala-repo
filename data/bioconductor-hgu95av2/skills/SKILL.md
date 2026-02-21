---
name: bioconductor-hgu95av2
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/annotation/html/hgu95av2.html
---

# bioconductor-hgu95av2

name: bioconductor-hgu95av2
description: Provides annotation data for the Affymetrix Human Genome U95av2 chip. Use this skill when you need to map manufacturer probe identifiers to various biological annotations such as Entrez Gene IDs, Gene Symbols, Chromosomal locations, GO terms, KEGG pathways, and PubMed references within an R environment.

## Overview

The `hgu95av2` package is a Bioconductor annotation data package for the Affymetrix Human Genome U95av2 array. It provides R environments that map manufacturer probe IDs to various public identifiers and functional annotations. This is essential for downstream analysis of microarray data, such as converting probe-level results into gene-level biological insights.

## Core Workflows

### Loading the Package
```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("hgu95av2")

library(hgu95av2)
```

### Basic Mapping (Probe to Gene Symbol/ID)
To map probe IDs to Gene Symbols or Entrez IDs, convert the specific environment to a list or use the `mget` function.

```R
# Get Gene Symbols for specific probes
probes <- c("1000_at", "1001_at")
symbols <- mget(probes, hgu95av2SYMBOL)

# Convert entire environment to a list
all_symbols <- as.list(hgu95av2SYMBOL)
# Filter out probes with no mapping
all_symbols <- all_symbols[!is.na(all_symbols)]
```

### Functional Annotation (GO and KEGG)
Map probes to Gene Ontology (GO) terms or KEGG pathways for enrichment analysis.

```R
# Map probes to GO terms
go_mappings <- as.list(hgu95av2GO)
# Accessing GO details for a probe
if(length(go_mappings) > 0){
  first_probe_go <- go_mappings[[1]]
  # Each entry contains GOID, Ontology (BP, CC, MF), and Evidence code
}

# Map probes to KEGG pathways
pathways <- as.list(hgu95av2PATH)
```

### Genomic Location
Retrieve chromosome information and physical locations.

```R
# Get chromosome for probes
chroms <- as.list(hgu95av2CHR)

# Get chromosomal start positions (base pairs)
# Negative values indicate the antisense strand
locations <- as.list(hgu95av2CHRLOC)

# Get total chromosome lengths
lengths <- hgu95av2CHRLENGTHS
```

### Reverse Mappings
Many environments have "2PROBE" counterparts to map from an annotation back to all associated manufacturer probes.

```R
# Find all probes associated with a specific KEGG pathway
path_to_probes <- as.list(hgu95av2PATH2PROBE)

# Find all probes associated with an Enzyme Commission (EC) number
ec_to_probes <- as.list(hgu95av2ENZYME2PROBE)
```

## Key Annotation Environments

| Environment | Description |
| :--- | :--- |
| `hgu95av2ACCNUM` | Manufacturer ID to GenBank Accession Numbers |
| `hgu95av2ENTREZID` | Manufacturer ID to Entrez Gene ID |
| `hgu95av2SYMBOL` | Manufacturer ID to Gene Symbol |
| `hgu95av2GENENAME` | Manufacturer ID to Full Gene Name |
| `hgu95av2MAP` | Manufacturer ID to Cytogenetic Band |
| `hgu95av2OMIM` | Manufacturer ID to Mendelian Inheritance in Man (MIM) ID |
| `hgu95av2PMID` | Manufacturer ID to PubMed Identifiers |
| `hgu95av2REFSEQ` | Manufacturer ID to RefSeq Identifiers |
| `hgu95av2UNIGENE` | Manufacturer ID to UniGene Cluster ID |
| `hgu95av2ORGANISM` | Returns "Homo sapiens" |

## Tips
- **Check Package Info**: Run `hgu95av2()` (the function) to see quality control information and data source versions.
- **Handling Multiple Mappings**: Some probes may map to multiple identifiers (e.g., multiple PubMed IDs or GO terms). These are returned as vectors or lists.
- **Missing Data**: Probes that cannot be mapped to a specific database will return `NA`. Always filter these out before downstream processing using `is.na()`.

## Reference documentation
- [hgu95av2](./references/reference_manual.md)