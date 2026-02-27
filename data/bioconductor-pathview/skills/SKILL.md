---
name: bioconductor-pathview
description: This tool integrates and visualizes gene or compound data by mapping it onto KEGG pathway diagrams. Use when user asks to map expression or metabolite data to pathways, generate high-quality KEGG pathway maps, or perform pathway-based data integration across different species and ID types.
homepage: https://bioconductor.org/packages/release/bioc/html/pathview.html
---


# bioconductor-pathview

name: bioconductor-pathview
description: Visualization and data integration for KEGG pathways. Use this skill when you need to map gene or compound data (expression, metabolites, etc.) onto KEGG pathway diagrams, generate high-quality pathway maps (PNG or PDF), or perform pathway-based data integration across multiple species and ID types.

# bioconductor-pathview

## Overview
The `pathview` package is a toolset for pathway-based data integration and visualization. it maps user-supplied gene or compound data onto KEGG pathway graphs. It handles the automated downloading of pathway data, parsing of XML/KGML files, and rendering of data-mapped diagrams. It supports over 4,800 species and provides two primary view modes: Native KEGG (raster PNG) and Graphviz (vector PDF).

## Core Workflow

### 1. Data Preparation
Input data should be a named vector or matrix where names are Gene IDs (e.g., Entrez) or Compound IDs (e.g., KEGG accession).

```r
library(pathview)
# Example gene data (log2 ratios)
data(gse16873.d)
gene.data <- gse16873.d[, 1]

# Example compound data
sim.cpd.data <- sim.mol.data(mol.type="cpd", nmol=3000)
```

### 2. Basic Pathway Rendering
The `pathview()` function is the primary interface.

```r
pv.out <- pathview(gene.data = gene.data, 
                   pathway.id = "04110", 
                   species = "hsa", 
                   out.suffix = "test_output")
```

### 3. Key Parameters
- `kegg.native`: `TRUE` (default) outputs a PNG matching the KEGG website. `FALSE` uses Graphviz to produce a PDF with more layout control.
- `same.layer`: `TRUE` (default) controls whether data is rendered on the same layer as the pathway or an added layer.
- `multi.state`: Set to `TRUE` if `gene.data` or `cpd.data` has multiple columns (samples) to be displayed as sliced nodes in a single plot.
- `split.group`: (Graphviz only) If `TRUE`, split node groups into individual genes.
- `expand.node`: (Graphviz only) If `TRUE`, expand multiple-gene nodes into individual nodes.

## ID Mapping and Species
Pathview includes a powerful `Mapper` module to handle various ID types.

- **Gene IDs**: Supports Entrez (default), Symbol, Ensembl, etc. Use `gene.idtype` to specify.
- **Compound IDs**: Supports KEGG, CAS, ChEBI, etc. Use `cpd.idtype` to specify.
- **Species**: Use 3-letter KEGG codes (e.g., "hsa" for human, "mmu" for mouse). Use `species = "ko"` for metagenomic data or unannotated species.

```r
# Mapping Ensembl Protein IDs
pv.out <- pathview(gene.data = gene.ensprot, 
                   gene.idtype = "ENSEMBLPROT",
                   pathway.id = "00640", 
                   species = "hsa")
```

## Advanced Visualization Tips
- **Discrete Data**: For gene lists (significant vs. not), use `discrete = list(gene = T, cpd = T)`.
- **Color Control**: Adjust `limit`, `bins`, `low`, `mid`, and `high` arguments. Note: these should be passed as lists, e.g., `limit = list(gene = 2, cpd = 1)`.
- **Legend Positioning**: Use `key.pos` (for KEGG native) or `sign.pos` (for Graphviz) to move the color key if it overlaps with the pathway.

## Common Troubleshooting
- **ID Mismatch**: Ensure `gene.idtype` matches the names in your `gene.data`.
- **Pathway ID**: Must be a 5-digit string (e.g., "04110", not "4110").
- **Missing Files**: Pathview downloads `.xml` and `.png` files from KEGG. Ensure internet access or provide local copies in the working directory.

## Reference documentation
- [Pathview: pathway based data integration and visualization](./references/pathview.md)