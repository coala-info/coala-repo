---
name: gprofiler-official
description: The gprofiler-official tool performs functional enrichment analysis, gene identifier conversion, and orthology mapping for biological data interpretation. Use when user asks to find enriched biological pathways, convert gene identifiers, or map orthologs between species.
homepage: http://biit.cs.ut.ee/gprofiler
metadata:
  docker_image: "quay.io/biocontainers/gprofiler-official:1.0.0--pyh7e72e81_1"
---

# gprofiler-official

## Overview
The `gprofiler-official` skill provides a programmatic interface to the g:Profiler service, a gold-standard tool for biological data interpretation. It excels at "functional profiling," which involves taking a list of genes (e.g., from a differential expression experiment) and determining which biological processes or pathways are statistically overrepresented. It also serves as a robust utility for translating unstable or varied gene identifiers into standardized formats.

## Usage Guidelines

### Functional Enrichment (g:GOSt)
Use this to find significantly enriched Gene Ontology (GO) terms, biological pathways, and regulatory motifs.
- **Input**: A list of gene identifiers (Ensembl IDs, Entrez, Gene Symbols, etc.).
- **Organism**: Ensure the correct organism code is specified (e.g., `hsapiens` for human, `mmusculus` for mouse).
- **Significance**: By default, g:Profiler uses the "g:SCS" method for multiple testing correction, which is specifically tailored for the hierarchical structure of GO terms.

### Identifier Conversion (g:Convert)
Use this when dealing with mixed ID types or when preparing data for downstream tools that require specific formats (like Ensembl IDs).
- It can handle conversions between proteins, transcripts, and genes.
- It is highly effective for mapping retired IDs to current versions.

### Orthology Mapping (g:Orth)
Use this to translate gene lists between species (e.g., mapping a mouse gene signature to its human orthologs).

### Best Practices
- **Background Gene Lists**: For more accurate enrichment results, always provide a custom background list (the "universe" of genes measured in your experiment) if available.
- **Ordered Queries**: If your gene list is ranked (e.g., by fold change), use the "ordered query" option to perform a GSEA-like incremental enrichment analysis.
- **Namespace**: If the input IDs are ambiguous, explicitly define the target namespace to improve mapping accuracy.

## Reference documentation
- [g:Profiler Web Service and Toolkit](./references/biit_cs_ut_ee_gprofiler.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_gprofiler-official_overview.md)