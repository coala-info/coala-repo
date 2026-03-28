# gb_taxonomy_tools CWL Generation Report

## gb_taxonomy_tools_gid-taxid

### Tool Description
Maps GenBank IDs to TaxIDs using a provided mapping file.

### Metadata
- **Docker Image**: quay.io/biocontainers/gb_taxonomy_tools:1.0.1--h503566f_7
- **Homepage**: https://github.com/spond/gb_taxonomy_tools
- **Package**: https://anaconda.org/channels/bioconda/packages/gb_taxonomy_tools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/gb_taxonomy_tools/overview
- **Total Downloads**: 12.4K
- **Last updated**: 2025-07-18
- **GitHub**: https://github.com/spond/gb_taxonomy_tools
- **Stars**: N/A
### Original Help Text
```text
Usage: gid-taxid <list of genbank ids> <GenBank file mapping gids to taxids (gi_taxid files from ftp://ftp.ncbi.nih.gov/pub/taxonomy/)>
```


## gb_taxonomy_tools_taxonomy-reader

### Tool Description
Reads GenBank taxonomic information from provided map and hierarchy files.

### Metadata
- **Docker Image**: quay.io/biocontainers/gb_taxonomy_tools:1.0.1--h503566f_7
- **Homepage**: https://github.com/spond/gb_taxonomy_tools
- **Package**: https://anaconda.org/channels/bioconda/packages/gb_taxonomy_tools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: taxonomy-reader
	<GenBank taxid to name map file (e.g. taxdump/names from ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxdump.tar.gz)>
	<GenBank taxonomic hierarcy file (e.g. taxdump/nodes from ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxdump.tar.gz)>
	[ integer index (0-based) of the field containing tax ID in each tab-separated input line; the default is field 1]
```


## gb_taxonomy_tools_taxonomy2tree

### Tool Description
Converts a taxonomy dump file into a tree structure and a summary.

### Metadata
- **Docker Image**: quay.io/biocontainers/gb_taxonomy_tools:1.0.1--h503566f_7
- **Homepage**: https://github.com/spond/gb_taxonomy_tools
- **Package**: https://anaconda.org/channels/bioconda/packages/gb_taxonomy_tools/overview
- **Validation**: PASS

### Original Help Text
```text
taxonomy2tree 
	<tax dump file(tab separated taxonomy dump)>
	<max tree level (<=0 to show all)>
	<write tree file here>
	<write tab separated summary here>
	include empty nodes; 0 or 1; default 0)]
```


## gb_taxonomy_tools_tree2ps

### Tool Description
Converts a Newick tree file to a PostScript file.

### Metadata
- **Docker Image**: quay.io/biocontainers/gb_taxonomy_tools:1.0.1--h503566f_7
- **Homepage**: https://github.com/spond/gb_taxonomy_tools
- **Package**: https://anaconda.org/channels/bioconda/packages/gb_taxonomy_tools/overview
- **Validation**: PASS

### Original Help Text
```text
tree2ps <newick_file> <PostScript output file> <maximum taxonomic depth (<=0 to show all levels)> <font_size (in 2-255, 8 is a good default)> <nmax_leaves (<=0 to show all)> <count_duplicate_tax_id (0 or 1; with 0 multiple copies of the same taxid count as 1)>
```


## Metadata
- **Skill**: generated
