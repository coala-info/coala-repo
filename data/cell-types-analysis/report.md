# cell-types-analysis CWL Generation Report

## cell-types-analysis_build_cell_ontology_dict.R

### Tool Description
Builds a dictionary mapping cell labels to cell ontology terms from SDRF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/cell-types-analysis:0.1.11--hdfd78af_1
- **Homepage**: https://github.com/ebi-gene-expression-group/cell-types-analysis
- **Package**: https://anaconda.org/channels/bioconda/packages/cell-types-analysis/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cell-types-analysis/overview
- **Total Downloads**: 38.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ebi-gene-expression-group/cell-types-analysis
- **Stars**: N/A
### Original Help Text
```text
Usage: /usr/local/bin/build_cell_ontology_dict.R [options]


Options:
	-i INPUT-DIR, --input-dir=INPUT-DIR
		Path to the directory with condensed SDRF files

	-k, --condensed-sdrf
		Boolean: is the provided SDRF file in a condensed form? 
                Default: TRUE

	-b BARCODE-COL-NAME, --barcode-col-name=BARCODE-COL-NAME
		Name of the barcode column in SDRF files (must be identical 
                across all files)

	-l CELL-LABEL-COL-NAME, --cell-label-col-name=CELL-LABEL-COL-NAME
		Name of the cell label column in SDRF files 
                (must be identical across all files)

	-c CELL-ONTOLOGY-COL-NAME, --cell-ontology-col-name=CELL-ONTOLOGY-COL-NAME
		Name of the cell ontology terms column in SDRF files 
                (must be identical across all files)

	-o OUTPUT-DICT-PATH, --output-dict-path=OUTPUT-DICT-PATH
		Output path for serialised object containing the dictionary

	-t OUTPUT-TEXT-PATH, --output-text-path=OUTPUT-TEXT-PATH
		Output path for txt version of label - term mapping

	-h, --help
		Show this help message and exit
```


## cell-types-analysis_get_tool_performance_table.R

### Tool Description
Generates a performance table for cell type annotation tools.

### Metadata
- **Docker Image**: quay.io/biocontainers/cell-types-analysis:0.1.11--hdfd78af_1
- **Homepage**: https://github.com/ebi-gene-expression-group/cell-types-analysis
- **Package**: https://anaconda.org/channels/bioconda/packages/cell-types-analysis/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/get_tool_performance_table.R [options]


Options:
	-i INPUT-DIR, --input-dir=INPUT-DIR
		Path to the directory with standardised output .tsv files
                from multiple methods

	-r REF-FILE, --ref-file=REF-FILE
		Path to the file with reference, "true" cell type assignments

	-n, --parallel
		Boolean: Should computation be run in parallel? Default: FALSE

	-c NUM-CORES, --num-cores=NUM-CORES
		Number of cores to run the process on. Default: all available cores. --parallel must be set to "true" for this to take effect

	-e EXCLUSIONS, --exclusions=EXCLUSIONS
		Path to the yaml file with excluded terms. Must contain fields
               'unlabelled' and 'trivial_terms'

	-d TMPDIR, --tmpdir=TMPDIR
		Cache directory path

	-f ONTOLOGY-GRAPH, --ontology-graph=ONTOLOGY-GRAPH
		Path to the ontology graph in .obo or .xml format.
                Import link can also be provided.

	-m LAB-CL-MAPPING, --lab-cl-mapping=LAB-CL-MAPPING
		Path to serialised object containing cell label - CL terms mapping

	-b BARCODE-COL-REF, --barcode-col-ref=BARCODE-COL-REF
		Name of the cell id field in reference file

	-a BARCODE-COL-PRED, --barcode-col-pred=BARCODE-COL-PRED
		Name of the cell id field in prediction file

	-l LABEL-COLUMN-REF, --label-column-ref=LABEL-COLUMN-REF
		Name of the label column in reference file

	-p LABEL-COLUMN-PRED, --label-column-pred=LABEL-COLUMN-PRED
		Name of the label column in prediction file

	-s SEMANTIC-SIM-METRIC, --semantic-sim-metric=SEMANTIC-SIM-METRIC
		Semantic similarity scoring method. Must be supported by Onassis
                package. See listSimilarities()$pairwiseMeasures for a list
                of accepted options. 
                NB: if included in combined score calculation, make sure to
                select a metric with values in the [0;1] range.

	-k, --include-sem-siml
		Should semantic similarity be included into combined score
                calculation? Default: FALSE. If setting to TRUE, note that this
                confines the options on semantic similarity metric
                to those with range in the [0;1] interval only.

	-o OUTPUT-PATH, --output-path=OUTPUT-PATH
		Path to the output table in .tsv format

	-h, --help
		Show this help message and exit
```


## cell-types-analysis_combine_tool_outputs.R

### Tool Description
Combines standardized output TSV files from multiple classifiers.

### Metadata
- **Docker Image**: quay.io/biocontainers/cell-types-analysis:0.1.11--hdfd78af_1
- **Homepage**: https://github.com/ebi-gene-expression-group/cell-types-analysis
- **Package**: https://anaconda.org/channels/bioconda/packages/cell-types-analysis/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/combine_tool_outputs.R [options]


Options:
	-i INPUT-DIR, --input-dir=INPUT-DIR
		Path to the directory with standardised output .tsv files from 
                multiple classifiers. It is expected that input files follow 
                the format: A_B_final-labs.tsv, where A is dataset or origin and
                B is classifier used to obtain predictions.

	-n TOP-LABELS-NUM, --top-labels-num=TOP-LABELS-NUM
		Number of top labels to keep

	-e EXCLUSIONS, --exclusions=EXCLUSIONS
		Path to the yaml file with excluded terms. Must contain fields
                'unlabelled' and 'trivial_terms'

	-s, --scores
		Boolean: Are prediction scores available for the given method?
                Default: FALSE

	-o OUTPUT-TABLE, --output-table=OUTPUT-TABLE
		Path to the output table in text format

	-h, --help
		Show this help message and exit
```


## cell-types-analysis_get_consensus_output.R

### Tool Description
Generates consensus output for cell type analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/cell-types-analysis:0.1.11--hdfd78af_1
- **Homepage**: https://github.com/ebi-gene-expression-group/cell-types-analysis
- **Package**: https://anaconda.org/channels/bioconda/packages/cell-types-analysis/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/get_consensus_output.R [options]


Options:
	-i INPUT-DIR, --input-dir=INPUT-DIR
		Path to the directory with standardised .tsv files from multiple
                methods

	-t TOOL-TABLE, --tool-table=TOOL-TABLE
		Path to the tool evaluation table in text format

	-p, --parallel
		Boolean: Should computation be run in parallel? Default: FALSE

	-c NUM-CORES, --num-cores=NUM-CORES
		Number of cores to run the process on. Default: all available cores.
                --parallel must be set to "true" for this to take effect

	-d CL-DICTIONARY, --cl-dictionary=CL-DICTIONARY
		Path to the mapping between labels and CL terms in .rds format

	-e EXCLUSIONS, --exclusions=EXCLUSIONS
		Path to the yaml file with excluded terms. Must contain fields
                'unlabelled' and 'trivial_terms'

	-g TMPDIR, --tmpdir=TMPDIR
		Cache directory path

	-f ONTOLOGY-GRAPH, --ontology-graph=ONTOLOGY-GRAPH
		Path to the ontology graph in .obo or .xml format. 
                Import link can also be provided.

	-m SEMANTIC-SIM-METRIC, --semantic-sim-metric=SEMANTIC-SIM-METRIC
		Semantic similarity scoring method. 
                Must be supported by Onassis package.
                See listSimilarities()$pairwiseMeasures for a list of accepted
                options. NB: if included in combined score calculation,
                make sure to select a metric with values in the [0;1] range.

	-k, --include-sem-siml
		Should semantic similarity be included into combined score
                calculation? Default: FALSE. If setting to TRUE, note that this
                confines the options on semantic similarity metric
                to those with range in the [0;1] interval only.

	-s, --sort-by-agg-score
		Should cells be sorted by their aggregated scores? Default: TRUE

	-l TRUE-LABELS, --true-labels=TRUE-LABELS
		(OPTIONAL) Path to the true labels tsv file in case tool
                performance is evaluated. Expected columns: cell_id, true_label, ontology_term

	-o SUMMARY-TABLE-OUTPUT-PATH, --summary-table-output-path=SUMMARY-TABLE-OUTPUT-PATH
		Path to the output table with top labels and per-cell metrics in .tsv format

	-r RAW-TABLE-OUTPUT-PATH, --raw-table-output-path=RAW-TABLE-OUTPUT-PATH
		Path to the output table with all labels in .tsv format

	-h, --help
		Show this help message and exit
```


## cell-types-analysis_get_empirical_dist.R

### Tool Description
Computes empirical distributions for cell type analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/cell-types-analysis:0.1.11--hdfd78af_1
- **Homepage**: https://github.com/ebi-gene-expression-group/cell-types-analysis
- **Package**: https://anaconda.org/channels/bioconda/packages/cell-types-analysis/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/get_empirical_dist.R [options]


Options:
	-i INPUT-REF-FILE, --input-ref-file=INPUT-REF-FILE
		Path to file with reference cell types

	-e EXCLUSIONS, --exclusions=EXCLUSIONS
		Path to the yaml file with excluded terms. 
                Must contain fields 'unlabelled' and 'trivial_terms'

	-l LABEL-COLUMN-REF, --label-column-ref=LABEL-COLUMN-REF
		Name of the label column in reference file

	-m LAB-CL-MAPPING, --lab-cl-mapping=LAB-CL-MAPPING
		Path to serialised object containing cell label to CL terms mapping

	-p, --parallel
		Boolean: Should computation be run in parallel? Default: FALSE

	-n NUM-ITERATIONS, --num-iterations=NUM-ITERATIONS
		Number of sampling iterations to construct empirical distribution

	-a SAMPLE-LABS, --sample-labs=SAMPLE-LABS
		Labels sample size to infer the distribution from.

	-c NUM-CORES, --num-cores=NUM-CORES
		Number of cores to run the process on. Default: all available cores. --parallel must be set to "true" for this to take effect

	-r TMPDIR, --tmpdir=TMPDIR
		Cache directory path

	-g ONTOLOGY-GRAPH, --ontology-graph=ONTOLOGY-GRAPH
		Path to the ontology graph in .obo or .xml format. 
                Import link can also be provided.

	-s SEMANTIC-SIM-METRIC, --semantic-sim-metric=SEMANTIC-SIM-METRIC
		Semantic similarity scoring method. Must be supported by
                Onassis package. See listSimilarities()$pairwiseMeasures 
                for a list of accepted options. Obviously must correspond 
                to similarity metric used in other scripts.

	-o OUTPUT-PATH, --output-path=OUTPUT-PATH
		Path to the output CDF list object in .rds format

	-h, --help
		Show this help message and exit
```


## cell-types-analysis_get_tool_pvals.R

### Tool Description
Calculate p-values for tool performance statistics.

### Metadata
- **Docker Image**: quay.io/biocontainers/cell-types-analysis:0.1.11--hdfd78af_1
- **Homepage**: https://github.com/ebi-gene-expression-group/cell-types-analysis
- **Package**: https://anaconda.org/channels/bioconda/packages/cell-types-analysis/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/get_tool_pvals.R [options]


Options:
	-i INPUT-TABLE, --input-table=INPUT-TABLE
		Path to the table of tool statistics from get_tool_performance_table.R

	-d EMP-DIST-LIST, --emp-dist-list=EMP-DIST-LIST
		Path to the list of empirical distributions in .rds format

	-o OUTPUT-TABLE, --output-table=OUTPUT-TABLE
		Path to the modified output table in text format

	-h, --help
		Show this help message and exit
```

