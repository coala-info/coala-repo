# atlas-data-import CWL Generation Report

## atlas-data-import_get_experiment_data.R

### Tool Description
Downloads data from the ArrayExpress database.

### Metadata
- **Docker Image**: quay.io/biocontainers/atlas-data-import:0.1.1--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/atlas-data-import
- **Package**: https://anaconda.org/channels/bioconda/packages/atlas-data-import/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/atlas-data-import/overview
- **Total Downloads**: 19.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ebi-gene-expression-group/atlas-data-import
- **Stars**: N/A
### Original Help Text
```text
Usage: /usr/local/bin/get_experiment_data.R [options]


Options:
	-a ACCESSION-CODE, --accession-code=ACCESSION-CODE
		Accession code of the data set to be extracted.

	-e, --get-expression-data
		Should expression data be downloaded? Default: False.

	-d MATRIX-TYPE, --matrix-type=MATRIX-TYPE
		Type of expression data to download. Must be one of 'raw', 'filtered', 'TPM' or 'CPM'

	-c, --decorated-rows
		Should the decorated version of row names be downloaded? Deafult: FALSE

	-o OUTPUT-DIR-NAME, --output-dir-name=OUTPUT-DIR-NAME
		Name of the output directory containing study data. Default directory name is the provided accession code

	-x, --use-default-expr-names
		Should default (non 10x-type) file names be used for expression data? Default: FALSE

	-t EXP-DATA-DIR, --exp-data-dir=EXP-DATA-DIR
		Output name for expression data directory

	-m, --get-sdrf
		Should SDRF file(s) be downloaded? Default: FALSE

	-k, --get-condensed-sdrf
		Should condensed SDRF file(s) be downloaded? Default: FALSE

	-i, --get-idf
		Should IDF file(s) be downloaded? Default: FALSE

	-z, --get-exp-design
		Should experimental design file be downloaded? Default: FALSE

	-r, --get-marker-genes
		Should marker gene file(s) be downloaded? Default: FALSE

	-g MARKERS-CELL-GROUPING, --markers-cell-grouping=MARKERS-CELL-GROUPING
		What type of cell grouping is used for marker gene file? By default, markers 
                for inferred cell types are downloaded. If supplying an integer value, 
                an automatically-derived marker gene file for a corresponding number of clusters
                will be imported.

	-u, --use-full-names
		Should non-expression data files be named with full file names? Default: FALSE

	--experiments-prefix=EXPERIMENTS-PREFIX
		URL prefix for scxa experiments.

	-h, --help
		Show this help message and exit
```


## atlas-data-import_import_classification_data.R

### Tool Description
Imports classifiers for specified dataset accession codes, tools, or species.

### Metadata
- **Docker Image**: quay.io/biocontainers/atlas-data-import:0.1.1--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/atlas-data-import
- **Package**: https://anaconda.org/channels/bioconda/packages/atlas-data-import/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/import_classification_data.R [options]


Options:
	-a ACCESSION-CODE, --accession-code=ACCESSION-CODE
		One or more dataset accession codes of the data set for which 
                    to download the classifiers. By default, all classifiers are downloaded 
                    for a given dataset.

	-t TOOL, --tool=TOOL
		Which tool's classifiers should be imported?

	-e SPECIES, --species=SPECIES
		Which species' classifiers should be imported?

	-c, --classifiers-output-dir
		Path for directory storing imported classifiers

	-s, --get-sdrf
		Should SDRF file(s) be downloaded? Default: FALSE

	-k, --condensed-sdrf
		If --get-sdrf is set to TRUE, import condensed SDRF? By default, a normal version is imported. Default: FALSE

	-d SDRF-OUTPUT-DIR, --sdrf-output-dir=SDRF-OUTPUT-DIR
		Output path for imported SDRF files directory

	-p, --get-tool-perf-table
		Should the tool performance table be imported? Default: FALSE

	--tool-perf-table-url=TOOL-PERF-TABLE-URL
		URL for import of tool performance table

	--classifiers-prefix=CLASSIFIERS-PREFIX
		URL prefix for imported classifiers.

	--experiments-prefix=EXPERIMENTS-PREFIX
		URL prefix for imported experiment data.

	-h, --help
		Show this help message and exit
```


## Metadata
- **Skill**: generated
