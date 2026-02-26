---
name: bioconductor-cmap
description: This tool provides access to molecular interactions, molecule metadata, and pathway definitions from the NCICB Pathway Interaction Database via the cMAP Bioconductor package. Use when user asks to retrieve pathway mappings from BioCarta or KEGG, find molecular interaction partners, or access metadata for proteins, complexes, and compounds.
homepage: https://bioconductor.org/packages/release/data/annotation/html/cMAP.html
---


# bioconductor-cmap

name: bioconductor-cmap
description: Access and query the cMAP Bioconductor annotation package, which provides mappings for the NCICB Pathway Interaction Database (PID). Use this skill when you need to retrieve molecular interactions, molecule metadata (proteins, complexes, compounds), or pathway definitions from BioCarta and KEGG as represented in the cMAP data package.

# bioconductor-cmap

## Overview

The `cMAP` package is a Bioconductor annotation data package containing mappings for the NCICB Pathway Interaction Database. It organizes data into environment objects that map molecule identifiers to detailed lists containing interaction partners, molecular types (protein, complex, compound, rna), external identifiers (Entrez Gene, GO, KEGG), and pathway memberships. The data is primarily split into two sources: BioCarta (CARTA) and KEGG.

## Loading and Exploration

To use the package, load the library and use the main `cMAP()` function to view quality control and build information.

```r
library(cMAP)
# View package metadata and QC information
cMAP()
```

## Data Objects and Workflows

The package provides several environment objects. To access the data, it is often easiest to convert these environments to lists.

### 1. Molecular Interactions
Use `cMAPCARTAINTERACTION` or `cMAPKEGGINTERACTION` to find how molecules interact.
- **Keys**: Molecule identifiers.
- **Values**: Lists containing `source`, `process` (e.g., "modification", "transcription"), `reversible` (boolean), and `component` (interacting molecules and their roles like "inhibitor" or "agent").

```r
# Example: Accessing BioCarta interactions
interactions <- as.list(cMAPCARTAINTERACTION)
if(length(interactions) > 0) {
  interactions[[1]] # View first interaction record
}
```

### 2. Molecule Metadata
Use `cMAPCARTAMOLECULE` or `cMAPKEGGMOLECULE` to get details about specific molecules.
- **Type**: protein, complex, compound, or rna.
- **Extid**: External IDs (LL for Entrez Gene, GO for Gene Ontology, KG for KEGG).
- **Component**: For complexes, lists the constituent molecule IDs.
- **Member**: Identifiers for molecules in the same protein family.

```r
# Example: Finding external IDs for a molecule
mol_data <- as.list(cMAPCARTAMOLECULE)
mol_data[["some_id"]]$extid
```

### 3. Pathway Definitions
Use `cMAPCARTAPATHWAY` or `cMAPKEGGPATHWAY` to map short pathway names to full descriptions.
- **Fields**: `name` (full descriptive name), `organism` (e.g., "Hs"), and `component` (vector of molecule IDs involved in the pathway).

```r
# Example: Listing molecules in a specific pathway
pathways <- as.list(cMAPKEGGPATHWAY)
pathways[[1]]$name
pathways[[1]]$component
```

## Tips for Usage

- **Environment Access**: Since these are environment objects, you can use `get("ID", cMAPCARTAINTERACTION)` for direct lookups or `ls(cMAPCARTAINTERACTION)` to see all available keys.
- **Complexes**: When dealing with "complex" molecule types, always check the `component` element in the Molecule objects to see the individual members of that complex.
- **GO Terms**: Many fields (process, condition, location, role) use Gene Ontology vocabulary.

## Reference documentation

- [cMAP Reference Manual](./references/reference_manual.md)