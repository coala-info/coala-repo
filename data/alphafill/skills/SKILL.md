name: alphafill
description: Enrich AlphaFold protein models with ligands, cofactors, and ions. Use when you need to add molecular context to "apo" AlphaFold structures to better understand protein function, structural integrity, or to design downstream wet-lab experiments.

# AlphaFill

AlphaFill is an algorithm that "transplants" missing ligands, cofactors, and (metal) ions into AlphaFold models using sequence and structure similarity to known structures in the PDB-REDO databank.

## Quick Access (REST API)

The fastest way to retrieve filled models is via the REST interface.

- **Download mmCIF structure**: `https://alphafill.eu/v1/aff/${uniprot_id}`
- **Download Metadata (JSON)**: `https://alphafill.eu/v1/aff/${uniprot_id}/json`

The JSON metadata provides details on the origin of the ligands and quality metrics (global and local RMSd values).

## Installation

Install the AlphaFill suite via Bioconda:

```bash
conda install bioconda::alphafill
```

## CLI Toolset

The `alphafill` package includes several specialized binaries:

- `alphafill process`: The core engine used to transplant compounds into a specific structure.
- `alphafill create-index`: Used to index the PDB-REDO data for fast searching.
- `alphafill rebuild-db`: Manages the local databank of filled models.
- `alphafill server`: Runs a local instance of the AlphaFill web interface.

## Bulk Data Access

To download the entire AlphaFill databank (all enriched AlphaFold models), use rsync:

```bash
rsync -av rsync://rsync.alphafill.eu/alphafill/ alphafill/
```

## Expert Tips & Best Practices

### Quality Assessment
Always check the RMSd values in the provided JSON metadata. AlphaFill provides:
1. **Global RMSd**: Overall similarity between the AlphaFold model and the PDB-REDO template.
2. **Local RMSd**: Similarity specifically around the binding site. Low local RMSd indicates high confidence in the ligand placement.

### Custom Models
If a specific UniProt ID is not in the pre-computed databank, you can use the `alphafill-process` tool or the "Create your own AlphaFill model" feature on the AlphaFill website by submitting a custom structure file.

### Ligand Analogues
AlphaFill often transplants "analogues." If the exact ligand is not available in a high-similarity template, it may use a chemically similar compound. Check the `analogue` field in the metadata to verify if the transplanted molecule is the exact cofactor or a structural relative.

### Integration with AlphaFold DB
AlphaFill is designed to complement the AlphaFold Protein Structure Database. When analyzing a new protein, first check the AlphaFold DB for the fold, then use AlphaFill to provide the functional context (e.g., finding where ATP, Heme, or Zinc ions should be located).
