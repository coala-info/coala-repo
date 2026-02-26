---
name: bcbiogff
description: "bcbiogff parses and writes GFF3 files by converting them into Biopython SeqRecord objects. Use when user asks to parse GFF files, write genomic features to GFF3 format, or filter GFF data by feature type and location."
homepage: https://github.com/chapmanb/bcbb/blob/master/gff
---


# bcbiogff

## Overview
The `bcbiogff` library provides a bridge between the GFF (Generic Feature Format) file format and the Biopython biological computation framework. While Biopython has native support for many formats, `bcbiogff` is the preferred tool for handling GFF3 complexity, such as nested parent-child relationships (e.g., gene > mRNA > exon) and attribute parsing. It allows you to treat GFF files as collections of `SeqRecord` objects, making it easy to perform sequence analysis, filtering, and annotation updates within a standard Pythonic bioinformatics pipeline.

## Core Usage Patterns

### Parsing GFF Files
To read a GFF file and iterate through its records, use the `GFF.parse` function. This returns an iterator of Biopython `SeqRecord` objects.

```python
from BCBio import GFF

gff_file = "your_annotation.gff"
with open(gff_file) as in_handle:
    for record in GFF.parse(in_handle):
        print(f"Record ID: {record.id}")
        for feature in record.features:
            print(f"Feature: {feature.type}, Location: {feature.location}")
            # Access GFF attributes via the feature.qualifiers dictionary
            if "Name" in feature.qualifiers:
                print(f"Name: {feature.qualifiers['Name'][0]}")
```

### Writing GFF Files
To export Biopython `SeqRecord` objects to a GFF3 file, use `GFF.write`.

```python
from BCBio import GFF
from Bio.SeqRecord import SeqRecord

# Assuming 'records' is a list of SeqRecord objects
out_file = "output.gff"
with open(out_file, "w") as out_handle:
    GFF.write(records, out_handle)
```

### Filtering During Parsing
You can limit the data loaded into memory by using a `limit_info` dictionary. This is highly efficient for large genomic files where you only need specific feature types or specific scaffolds.

```python
from BCBio import GFF

# Only parse 'gene' and 'exon' features on chromosome 1
limit_info = {
    "gff_id": ["chr1"],
    "gff_type": ["gene", "exon"]
}

with open("large_file.gff") as in_handle:
    for record in GFF.parse(in_handle, limit_info=limit_info):
        # Process filtered records
        pass
```

## Expert Tips and Best Practices

- **Memory Management**: GFF files can be massive. Always use the iterator returned by `GFF.parse` rather than converting it to a list immediately, unless the file is small.
- **Attribute Handling**: `bcbiogff` stores GFF attributes in the `feature.qualifiers` dictionary. Note that GFF attributes can have multiple values, so `bcbiogff` stores them as lists (e.g., `feature.qualifiers['ID']` will return `['gene-001']`).
- **Parent-Child Relationships**: The parser automatically handles `ID` and `Parent` tags to create a hierarchy. Sub-features (like exons under an mRNA) are stored in the `sub_features` attribute of the parent `SeqFeature` object.
- **GFF3 Compliance**: When writing, ensure your `SeqFeature` objects have appropriate `type` and `qualifiers` to maintain valid GFF3 syntax. The library handles the formatting of the 9-column structure automatically.

## Reference documentation
- [bcbiogff - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_bcbiogff_overview.md)
- [GitHub - chapmanb/bcbb: Incubator for useful bioinformatics code](./references/github_com_chapmanb_bcbb.md)