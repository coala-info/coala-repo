---
name: tag
description: This tool processes, analyzes, and manages genome annotation data, particularly in GFF3 format. Use when user asks to extract specific features, count elements within genes, or cross-reference genomic information.
homepage: https://github.com/standage/tag/
---


# tag

yaml
name: tag
description: A Python package for genome annotation data analysis and management. Use when Claude needs to process, analyze, or manipulate genomic annotation data, particularly in GFF3 format. This includes tasks like extracting specific features, counting elements within genes, or cross-referencing genomic information.
```
## Overview
The `tag` tool is a Python library designed for the analysis and management of genome annotation data. It is particularly useful for working with formats like GFF3, enabling tasks such as extracting gene features, counting elements like exons per gene, and performing various data manipulations on genomic annotations.

## Usage

The `tag` library is primarily used programmatically within Python scripts. Here are some common patterns and expert tips for its usage:

### Reading and Selecting Features

The core of `tag`'s functionality involves reading annotation files and selecting specific features.

*   **Reading GFF3 files:**
    Use `tag.GFF3Reader` to parse GFF3 files. It can handle gzipped files directly.

    ```python
    import tag

    reader = tag.GFF3Reader(infilename='/path/to/your/annotation.gff3.gz')
    ```

*   **Selecting features by type:**
    You can iterate through features and filter them by their `type` attribute.

    ```python
    for gene in tag.select.features(reader, type='gene'):
        # Process gene features
        pass
    ```

*   **Accessing sub-features:**
    Features can contain other features (e.g., genes contain exons). You can iterate over a feature to access its children.

    ```python
    for gene in tag.select.features(reader, type='gene'):
        exons = [feat for feat in gene if feat.type == 'exon']
        print(f"Gene has {len(exons)} exons.")
    ```

### Advanced Operations and Tips

*   **Feature attributes:**
    Access feature attributes using dot notation or dictionary-like access.

    ```python
    for gene in tag.select.features(reader, type='gene'):
        gene_id = gene.id
        gene_name = gene.name
        print(f"Processing gene: {gene_id} ({gene_name})")
    ```

*   **Cross-referencing and ID handling:**
    `tag` is designed to help with ID cross-referencing. Pay attention to how IDs are parsed and used, especially when dealing with complex annotation files. The library aims to simplify the process of linking related genomic features.

*   **Performance:**
    For very large annotation files, consider using `tag.GFF3Reader` with gzipped files, as it can be more memory-efficient. The `tag.select` module is optimized for efficient feature retrieval.

*   **Customization:**
    While `tag` provides a robust set of tools, you can extend its functionality by writing custom Python code that leverages the `tag` objects and readers.

## Reference documentation
- [GitHub Repository](https://github.com/standage/tag)
- [tag.readthedocs.io](https://tag.readthedocs.io/)