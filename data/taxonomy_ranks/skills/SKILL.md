---
name: taxonomy_ranks
description: This tool queries the NCBI Taxonomy database to retrieve standardized rank information and lineage strings for TaxIDs or species names. Use when user asks to obtain taxonomic annotations, resolve species names, or generate lineage data for a list of taxa.
homepage: https://github.com/linzhi2013/taxonomy_ranks
metadata:
  docker_image: "quay.io/biocontainers/taxonomy:0.10.3--py310h7e03b2b_0"
---

# taxonomy_ranks

## Overview
The `taxonomy_ranks` skill provides a streamlined interface for querying the NCBI Taxonomy database to obtain standardized rank information. It is built upon the ETE3 Python framework and is specifically designed to handle bulk queries of TaxIDs, species names, or higher-level taxonomic ranks (e.g., Genus or Family). This tool is essential for bioinformatics workflows that require taxonomic annotation, name resolution, or the construction of lineage strings for downstream analysis.

## Command Line Interface (CLI) Patterns
The primary command for this tool is `taxaranks`.

### Basic Usage
To process a list of taxa and generate a tab-separated output of their lineages:
```bash
taxaranks -i taxa_list.txt -o results.tsv
```

### Advanced Flags
- **Include TaxIDs**: Use the `-t` flag to include the specific NCBI TaxID for every rank in the lineage, rather than just the names.
- **Error Tracking**: Use the `-e` flag to ensure that input records with no found lineage information are still printed to the output file (marked as 'NA'). This is critical for maintaining row-to-row correspondence between input and output files.
- **Verbose Mode**: Use `-v` to see detailed processing logs.

### Input File Format
The input file (`-i`) should be a simple text file containing one entry per line. It supports:
- NCBI TaxIDs (e.g., `9606`)
- Species names (e.g., `Homo sapiens`)
- Higher ranks (e.g., `Hominidae` or `Primates`)
- A mixture of IDs and names.

## Python Module Usage
For integration into Python scripts, use the `TaxonomyRanks` class.

```python
from taxonomy_ranks import TaxonomyRanks

# Initialize with a name or TaxID
taxa_name = 'homo sapiens'
rank_taxon = TaxonomyRanks(taxa_name)

# Retrieve lineage data
rank_taxon.get_lineage_taxids_and_taxanames()

# Access results via the lineages dictionary
# potential_taxid is the key as one name may map to multiple IDs
for potential_taxid in rank_taxon.lineages:
    data = rank_taxon.lineages[potential_taxid]
    print(data['genus'], data['species'])
```

## Expert Tips and Best Practices
- **Ambiguity Handling**: Be aware that a single rank name may map to multiple TaxIDs (e.g., *Pieris* can refer to a genus of butterflies or a genus of angiosperms). The tool will return lineages for all matches found.
- **Automatic Fallback**: If a specific species name cannot be found in the database, the tool automatically attempts to search for the first word (the Genus) to provide at least partial taxonomic context.
- **Database Initialization**: On the first execution, the tool will automatically download the NCBI Taxonomy database via ETE3. Ensure the environment has internet access for this initial setup. Once downloaded, the tool operates offline.
- **Output Parsing**: The output is structured with a standard set of ranks: `superkingdom`, `kingdom`, `superphylum`, `phylum`, `subphylum`, `superclass`, `class`, `subclass`, `superorder`, `order`, `suborder`, `superfamily`, `family`, `subfamily`, `genus`, `subgenus`, and `species`. Ranks not present in the NCBI record for a specific taxon will be returned as `NA`.

## Reference documentation
- [taxonomy_ranks GitHub README](./references/github_com_linzhi2013_taxonomy_ranks.md)
- [bioconda taxonomy_ranks Overview](./references/anaconda_org_channels_bioconda_packages_taxonomy_ranks_overview.md)