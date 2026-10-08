# conifer CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| conifer | PASS |  |
| conifer_is_a_parent_of_b | PASS | On the Conifer test taxo.k2d, Clostridia vs F. prausnitzii gives 1 and Bacteroides vs F. prausnitzii gives 0, in single-pair and list modes. |
| conifer_show_ancestors | PASS | On the Conifer test taxo.k2d, taxid 853 gives the correct lineage from F. prausnitzii up to root. |
| conifer_taxid_name | PASS | On the Conifer test taxo.k2d, taxid 816 gives Bacteroides. |

## conifer

### Tool Description
Conifer: A tool for processing Kraken2 files and taxonomy data

### Metadata
- **Docker Image**: quay.io/biocontainers/conifer:1.0.3--h577a1d6_0
- **Homepage**: https://github.com/Ivarz/Conifer/
- **Package**: https://anaconda.org/channels/bioconda/packages/conifer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/conifer/overview
- **Total Downloads**: 3.4K
- **Last updated**: 2025-09-24
- **GitHub**: https://github.com/Ivarz/Conifer
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...
Conifer 1.0.3
Usage:
conifer [OPTIONS] -i <KRAKEN_FILE> -d <TAXO_K2D>
	-i,--input		input file
	-d,--db			kraken2 taxo.k2d file
	-a,--all		output all reads (including unclassified)
	-s,--summary		output summary statistics for each taxonomy
	-f,--filter		filter kraken file by confidence score
	-r,--rtl		report root-to-leaf score instead of confidence score
	-b,--both_scores	report confidence and root-to-leaf score
	-h,--help		print this message
	-v,--version		show version
```


## conifer_is_a_parent_of_b

### Tool Description
Check whether taxid1 is an ancestor of taxid2 in a Kraken2 taxonomy (taxo.k2d).

### Metadata
- **Docker Image**: quay.io/biocontainers/conifer:1.0.3--h577a1d6_0
- **Homepage**: https://github.com/Ivarz/Conifer/
- **Package**: https://anaconda.org/channels/bioconda/packages/conifer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/conifer/overview
- **Total Downloads**: 3.4K
- **Last updated**: 2025-09-24
- **GitHub**: https://github.com/Ivarz/Conifer
- **Stars**: N/A
### Original Help Text
```text
is_a_parent_of_b -1 taxid1 -2 taxid2 --db taxo.k2d
is_a_parent_of_b --list taxid_pair_list --db taxo.k2d
is_a_parent_of_b --any --labels --list taxid_pair_list --db taxo.k2d
```


## conifer_show_ancestors

### Tool Description
Print the lineage of a taxid from a Kraken2 taxonomy (taxo.k2d).

### Metadata
- **Docker Image**: quay.io/biocontainers/conifer:1.0.3--h577a1d6_0
- **Homepage**: https://github.com/Ivarz/Conifer/
- **Package**: https://anaconda.org/channels/bioconda/packages/conifer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/conifer/overview
- **Total Downloads**: 3.4K
- **Last updated**: 2025-09-24
- **GitHub**: https://github.com/Ivarz/Conifer
- **Stars**: N/A
### Original Help Text
```text
taxo.k2d file missing
show_parents -t taxid -d taxo.k2d
show_parents --taxid taxid --db taxo.k2d
```


## conifer_taxid_name

### Tool Description
Print the scientific name of a taxid from a Kraken2 taxonomy (taxo.k2d).

### Metadata
- **Docker Image**: quay.io/biocontainers/conifer:1.0.3--h577a1d6_0
- **Homepage**: https://github.com/Ivarz/Conifer/
- **Package**: https://anaconda.org/channels/bioconda/packages/conifer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/conifer/overview
- **Total Downloads**: 3.4K
- **Last updated**: 2025-09-24
- **GitHub**: https://github.com/Ivarz/Conifer
- **Stars**: N/A
### Original Help Text
```text
taxid_name taxid taxo.k2d
```


## Metadata
- **Skill**: generated
