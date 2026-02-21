---
name: ctxcore
description: The `ctxcore` package provides the foundational computational logic for the SCENIC (Single-Cell rEgulatory Network Inference and Clustering) suite.
homepage: https://scenic.aertslab.org
---

# ctxcore

## Overview
The `ctxcore` package provides the foundational computational logic for the SCENIC (Single-Cell rEgulatory Network Inference and Clustering) suite. It is primarily used as a dependency for `pySCENIC` and `SCENIC+` to handle motif enrichment and the mapping of candidate regulators to target genes. Use this skill to understand the underlying mechanics of motif-to-TF linking and to troubleshoot core functions used during the pruning of regulons.

## Usage and Best Practices

### Core Functionality
`ctxcore` serves as the engine for `pycisTarget`. Its primary role is to:
- Implement the recovery of transcription factors from co-expression modules.
- Manage the scoring of motifs across genomic regions or gene promoters.
- Provide the logic for "pruning" modules based on motif evidence to create "regulons."

### Motif-to-TF Mapping
When working with `ctxcore` through the SCENIC suite, be aware of the three layers of annotation it supports:
1. **Direct Annotation**: The motif is explicitly linked to a TF in the source database.
2. **Orthology-based**: The motif is linked to a TF because it is annotated for an orthologous TF in another species (e.g., Drosophila to Human).
3. **Similarity-based**: Unannotated motifs are linked to TFs based on PWM (Position Weight Matrix) similarity to known motifs. *Note: This layer is typically disabled by default to maintain high confidence.*

### Integration with pySCENIC
In a standard `pySCENIC` workflow, `ctxcore` functions are invoked during the `ctx` (cisTarget) step. 
- **Input**: A co-expression module (from GRNBoost2/Arboreto) and a feather/arrow database of motif rankings.
- **Output**: A list of enriched motifs and the corresponding "pruned" regulons.

### Performance and Scalability
- `ctxcore` is designed to handle large-scale single-cell data.
- When running enrichment, ensure that the `rankings` database matches the species (Human, Mouse, or Fly) and the genomic regions (e.g., 500bp upstream, 10kb around TSS) being analyzed.
- For custom species, `ctxcore` logic can be applied if a custom cisTarget database is provided.

## Reference documentation
- [SCENIC Suite Overview](./references/scenic_aertslab_org_index.md)
- [SCENIC Tutorials and Workflows](./references/scenic_aertslab_org_tutorials.md)
- [ctxcore Bioconda Metadata](./references/anaconda_org_channels_bioconda_packages_ctxcore_overview.md)