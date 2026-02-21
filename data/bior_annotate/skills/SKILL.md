---
name: bior_annotate
description: The `bior_annotate_lite` tool is a streamlined, interactive implementation of the BioR (Biological Resources) toolkit.
homepage: https://github.com/michaelmeiners/biorAnnotateLite
---

# bior_annotate

## Overview
The `bior_annotate_lite` tool is a streamlined, interactive implementation of the BioR (Biological Resources) toolkit. It allows for the enrichment of VCF files with metadata from external genomic catalogs. By using a configuration file known as a "catalog-drill" file, you can specify exactly which fields to extract from catalogs based on variant position or genomic overlap. This skill is particularly useful for bioinformaticians who need a lightweight, command-line approach to variant annotation without the overhead of full-scale pipelines.

## Environment Setup
Before running the tool, ensure the following environment variables are exported to your path:

- `BIOR_LITE_HOME`: Path to the BioR pipeline scripts.
- `BGZIP_DIR`: Path to the `bgzip` executable.
- `BIOR_ANNOTATE_LITE`: Path to the `bior_annotate_lite` script directory.

Example setup:
```bash
export PATH=$BIOR_LITE_HOME/bin:$BGZIP_DIR:$BIOR_ANNOTATE_LITE:$PATH
```

## Command Usage
The primary command follows a simple positional argument structure:

```bash
bior_annotate_lite <input.vcf> <catalogDrill.txt> <output.vcf.bgz> <log_file>
```

### The Catalog-Drill File
The `catalogDrill.txt` file is a tab-delimited configuration that defines the annotation logic. It requires three columns:

1.  **Operation**: The BioR method used to find matches.
    - `bior_same_variant`: Used for exact coordinate and allele matches (e.g., dbSNP).
    - `bior_overlap`: Used for range-based matches (e.g., OMIM genes, cytobands).
2.  **CatalogPath**: The absolute path to the `.tsv.bgz` BioR catalog.
3.  **DrillPaths**: A comma-separated list of JSON keys/fields to extract from the catalog.

**Example catalog-drill content:**
```text
bior_same_variant    /path/to/dbSNP/variants.v1/All_dbSNP.tsv.bgz    ID,RSPOS,dbSNPBuildId,GENEINFO
bior_overlap         /path/to/omim/disease.v1/omim_genes.tsv.bgz     MIMNumber,ApprovedSymbol,EntrezGeneID
```

## Advanced Workflows

### Parallel Processing (Chunking)
For large VCF files, it is more efficient to split the file into chunks, annotate them in parallel, and then merge the results.

1.  **Split and Prepare**: Use `cutOutVcfSamples_splitAlts_chunkFile.sh` to divide the VCF into manageable segments.
2.  **Annotate**: Run `bior_annotate_lite` on each individual chunk.
3.  **Merge**: Use `merge.sh` to recombine the annotated chunks into a single, valid VCF.

## Expert Tips
- **Tab Delimitation**: Ensure the catalog-drill file uses actual tabs, not spaces, as the tool is sensitive to whitespace formatting.
- **Log Monitoring**: Always check the `<log_file>` for "pipefail" errors, especially when working with custom catalogs, to ensure all annotations were applied correctly.
- **Empty VCFs**: The tool includes logic to handle VCFs with no variant lines (header only) without crashing, ensuring pipeline stability.
- **JSON Drill Paths**: BioR catalogs often store data in JSON format. Ensure your `DrillPaths` match the exact keys found in the catalog's JSON blobs.

## Reference documentation
- [BioR Annotate Lite README](./references/github_com_michaelmeiners_biorAnnotateLite.md)
- [VCF Chunking and Merging](./references/github_com_michaelmeiners_biorAnnotateLite_tree_master_Test2.md)