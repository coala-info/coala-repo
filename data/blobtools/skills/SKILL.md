---
name: blobtools
description: BlobTools visualizes and analyzes genome assemblies by integrating coverage, GC content, and taxonomic data to identify and filter contaminants. Use when user asks to assess assembly quality, visualize taxonomic distribution, identify contamination, or filter scaffolds based on coverage and taxonomy.
homepage: https://blobtools.readme.io/docs/what-is-blobtools
---


# blobtools

## Overview
BlobTools is a specialized suite for assessing the quality of genome assemblies by integrating assembly statistics (GC content and length), read coverage, and taxonomic information into a unified database (BlobDB). It is primarily used to visualize the "blob" of sequences, allowing researchers to distinguish between the target organism and potential contaminants—such as bacteria, fungi, or symbionts—based on their distinct clustering in a 2D plot.

## Core CLI Workflow
The standard workflow involves initializing a database and then layering coverage and taxonomic information onto it before generating visualizations.

### 1. Initialization
Create the base BlobDB from your assembly FASTA file.
```bash
blobtools create -i assembly.fasta -o project_name
```

### 2. Adding Coverage Data
Incorporate mapping information (BAM files) to calculate base coverage per scaffold.
```bash
blobtools map2cov -i project_name.blobDB.json -b reads_mapped.bam
```

### 3. Adding Taxonomic Hits
Import search results (e.g., BLAST or Diamond output) to assign taxonomy. This requires the NCBI taxdump files.
```bash
blobtools taxify -i project_name.blobDB.json -f blast_results.out -t nodes.dmp -n names.dmp
```

### 4. Visualization and Export
Generate the BlobPlot and a tabular summary of the data.
```bash
# Generate plots (PDF/PNG)
blobtools plot -i project_name.blobDB.json

# Generate a text-based TSV report for manual inspection
blobtools view -i project_name.blobDB.json
```

## Common Modules and Patterns
- **`seqfilter`**: Used to extract or exclude specific scaffolds. This is the primary tool for "cleaning" an assembly after identifying contaminants.
- **`covplot`**: Generates a plot focusing specifically on read coverage distribution across scaffolds.
- **`taxrule`**: Determines the logic for taxonomic assignment when multiple hits exist (e.g., `bestsum` or `bestsumorder`).
- **`bamfilter`**: Filters BAM files based on the content of a BlobDB, useful for extracting reads that map to specific taxa.

## Expert Tips
- **Taxonomy Formatting**: When using `taxify`, ensure your BLAST/Diamond output is in tabular format (`-outfmt 6`) and includes the `staxids` column.
- **NodesDB**: Keep your `nodes.dmp` and `names.dmp` files updated to ensure taxonomic assignments reflect the current NCBI taxonomy.
- **Filtering Strategy**: Use the output from `blobtools view` to identify the exact headers of scaffolds you wish to remove, then pass that list to `seqfilter`.
- **Visual Customization**: The `plot` module supports various parameters to adjust the scale (e.g., `--log`) and the taxonomic rank displayed (e.g., `--rank phylum`).

## Reference documentation
- [BlobTools Overview](./references/anaconda_org_channels_bioconda_packages_blobtools_overview.md)
- [What is BlobTools](./references/blobtools_readme_io_docs_what-is-blobtools.md)