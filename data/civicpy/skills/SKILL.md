---
name: civicpy
description: The `civicpy` skill enables programmatic access to the CIViC knowledgebase, a community-curated resource for clinical interpretations of cancer variants.
homepage: http://civicpy.org
---

# civicpy

## Overview
The `civicpy` skill enables programmatic access to the CIViC knowledgebase, a community-curated resource for clinical interpretations of cancer variants. This toolkit is designed for bioinformaticians and researchers who need to integrate CIViC's structured evidence into analysis pipelines. It provides a high-level SDK for navigating complex relationships between genes, variants, and evidence items, while offering powerful CLI utilities for data synchronization and VCF annotation.

## Quick Start: Python SDK
The `civic` module uses dynamic objects and caching to simplify data exploration.

```python
from civicpy import civic

# Retrieve specific variants
variants = civic.get_variants_by_ids([12, 306])
for v in variants:
    print(f"Gene: {v.gene.name}, Variant: {v.name}")

# Search by genomic coordinates (GRCh37/38)
# build, chrom, pos, ref, alt
query = civic.CoordinateQuery("17", 7577121, 7577121, "G", "A")
results = civic.search_variants_by_coordinates(query)
```

## Core Record Types
Navigate the CIViC hierarchy using these primary object classes:
- **Gene/Feature**: The top-level genomic entity.
- **Variant/MolecularProfile**: Specific genomic alterations or combinations.
- **Evidence**: Individual pieces of literature-backed clinical data.
- **Assertion**: Synthesized clinical claims (e.g., "Predictive", "Prognostic").

## Command Line Utilities
Use the CLI for bulk operations and file transformations.

| Task | Command |
| :--- | :--- |
| **Update Cache** | `civicpy update` (Run this first to ensure data is current) |
| **Create VCF** | `civicpy create-vcf --output civic_variants.vcf` |
| **Annotate VCF** | `civicpy annotate-vcf --input my_sample.vcf --output annotated.vcf` |
| **Export GKS** | `civicpy create-gks-json --output clinvar_submission.json` |

## Expert Tips
- **Caching**: `civicpy` caches the entire CIViC database locally to minimize API overhead. Always run `civicpy update` before starting a new analysis session to ensure you are working with the latest curated data.
- **Coordinate Searches**: When searching by coordinates, ensure your genome build matches the CIViC records (typically GRCh37).
- **Relationship Traversal**: Objects are linked. For example, `variant.evidence_items` returns a list of all evidence supporting that variant, and `evidence.source` provides the PubMed metadata.

## Reference documentation
- [CIViCpy Documentation Overview](./references/docs_civicpy_org_en_latest.md)
- [Bioconda Package Summary](./references/anaconda_org_channels_bioconda_packages_civicpy_overview.md)