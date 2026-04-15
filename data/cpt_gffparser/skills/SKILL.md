---
name: cpt_gffparser
description: cpt_gffparser parses and writes GFF3 files while preserving hierarchical parent-child feature relationships through a specialized Biopython extension. Use when user asks to parse GFF3 data into SeqRecord objects, export genomic features to GFF3 format, or manage nested sub-features in bioinformatics workflows.
homepage: https://pypi.org/project/CPT-GFFParser/
metadata:
  docker_image: "quay.io/biocontainers/cpt_gffparser:1.2.2--pyh5e36f6f_0"
---

# cpt_gffparser

## Overview
cpt_gffparser is a specialized Biopython extension designed to handle the complexities of the GFF3 format. While standard Biopython has deprecated nested sub-features in favor of compound locations, cpt_gffparser reintroduces a hierarchical structure through the `gffSeqFeature` class. This makes it the preferred tool for phage genomics and other bioinformatics workflows where parent-child relationships between features (like gene-mRNA-exon) must be preserved during I/O operations. It is highly portable and provides detailed error logging to identify problematic lines in non-compliant GFF files.

## Library Usage and Best Practices

### Parsing GFF3 Files
The `gffParse` function reads GFF3 data into Biopython `SeqRecord` objects.

```python
from CPT_GFFParser import gffParse

with open("genome.gff", "r") as handle:
    # Returns a list of SeqRecord objects
    records = gffParse(handle, suppressMeta=1)
```

**Expert Tips for Parsing:**
- **Error Diagnostics:** Pass a specific stream to `outStream` (default is `sys.stderr`) to capture a comprehensive list of formatting errors found during parsing.
- **Metadata Control:** Use the `suppressMeta` argument to manage how pragmas and metadata features are handled:
    - `0`: All metadata read into `.annotations`.
    - `1`: Metadata recorded in `.annotations`, but metadata-only features are removed from the feature list.
    - `2`: Total suppression (only essential pragmas like `##FASTA` or `##sequence-region` are processed).
- **Coding Types:** If working with non-standard feature types that require a phase, add them to the `codingTypes` list argument.

### Writing GFF3 Files
The `gffWrite` function exports `SeqRecord` objects back to GFF3 format.

```python
from CPT_GFFParser import gffWrite

with open("output.gff", "w") as out_handle:
    gffWrite(records, outStream=out_handle, suppressFasta=True)
```

**Expert Tips for Writing:**
- **FASTA Export:** Set `suppressFasta=False` if you want to include the sequence data at the end of the GFF file using the `##FASTA` directive.
- **Object Compatibility:** Ensure features are `gffSeqFeature` objects if you need to preserve specific GFF columns like `phase` and `score` as direct attributes rather than qualifiers.

### Working with gffSeqFeature
This class extends `Bio.SeqFeature.SeqFeature`.

- **Hierarchy:** Access child features via the `.sub_features` list.
- **Direct Attributes:** Use `.phase` and `.score` directly instead of searching through the `.qualifiers` dictionary.
- **Conversion:** Use `gffSeqFeature.convertSeqFeat(standard_feature)` to upgrade a standard Biopython feature to a GFF-aware one.

## Reference documentation
- [CPT-GFFParser Project Description](./references/pypi_org_project_CPT-GFFParser.md)
- [CPT-GFFParser 1.2.2 Details](./references/pypi_org_project_CPT-GFFParser_1.2.2.md)