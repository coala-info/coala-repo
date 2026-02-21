# conifer CWL Generation Report

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


## Metadata
- **Skill**: generated
