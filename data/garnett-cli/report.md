# garnett-cli CWL Generation Report

## garnett-cli_transform_marker_file.R

### Tool Description
Transforms marker gene files into a format suitable for Garnett.

### Metadata
- **Docker Image**: quay.io/biocontainers/garnett-cli:0.0.5--hdfd78af_1
- **Homepage**: https://github.com/ebi-gene-expression-group/garnett-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/garnett-cli/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/garnett-cli/overview
- **Total Downloads**: 18.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ebi-gene-expression-group/garnett-cli
- **Stars**: N/A
### Original Help Text
```text
Usage: /usr/local/bin/transform_marker_file.R [options]


Options:
	-i INPUT-MARKER-FILE, --input-marker-file=INPUT-MARKER-FILE
		Path to the SCXA-style marker gene file in .txt format

	-l MARKER-LIST, --marker-list=MARKER-LIST
		Path to a serialised object containing marker genes

	-p PVAL-COL, --pval-col=PVAL-COL
		Column name of marker p-values

	-t PVAL-THRESHOLD, --pval-threshold=PVAL-THRESHOLD
		Cut-off p-value for marker genes

	-g GROUPS-COL, --groups-col=GROUPS-COL
		Column name of cell groups (i.e. cluster IDs or cell types) in marker file

	-n GENE-NAMES, --gene-names=GENE-NAMES
		Column containing gene names in marker file

	-o GARNETT-MARKER-FILE, --garnett-marker-file=GARNETT-MARKER-FILE
		Path to the garnett format marker gene file in .txt format

	-h, --help
		Show this help message and exit
```


## garnett-cli_garnett_check_markers.R

### Tool Description
Check marker genes for cell types.

### Metadata
- **Docker Image**: quay.io/biocontainers/garnett-cli:0.0.5--hdfd78af_1
- **Homepage**: https://github.com/ebi-gene-expression-group/garnett-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/garnett-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/garnett_check_markers.R [options]


Options:
	-c CDS-OBJECT, --cds-object=CDS-OBJECT
		CDS object with expression data

	-m MARKER-FILE-PATH, --marker-file-path=MARKER-FILE-PATH
		File with marker genes specifying cell types. See 
        https://cole-trapnell-lab.github.io/garnett/docs/#constructing-a-marker-file
        for specification of the file format.

	-d DATABASE, --database=DATABASE
		argument for Bioconductor AnnotationDb-class package
                used for converting gene IDs.
                For example, use org.Hs.eg.db for Homo Sapiens genes.

	--cds-gene-id-type=CDS-GENE-ID-TYPE
		Format of the gene IDs in your CDS object.
                The default is "ENSEMBL".

	--marker-file-gene-id-type=MARKER-FILE-GENE-ID-TYPE
		Format of the gene IDs in your marker file.
                The default is "ENSEMBL".

	-o MARKER-OUTPUT-PATH, --marker-output-path=MARKER-OUTPUT-PATH
		Path to the output file with marker scores

	--plot-output-path=PLOT-OUTPUT-PATH
		Optional. If you would like to make a marker plot,
                provide a name (path) for it.

	--propogate-markers
		Optional. Should markers from child nodes of a cell type be used
                in finding representatives of the parent type?
                Default: TRUE.

	--use-tf-idf
		Optional. Should TF-IDF matrix be calculated during estimation?
                If TRUE, estimates will be more accurate, but calculation is slower
                with very large datasets.
                Default: TRUE.

	--classifier-gene-id-type=CLASSIFIER-GENE-ID-TYPE
		Optional. The type of gene ID that will be used in the
                classifier. If possible for your organism, this should be 'ENSEMBL',
                which is the default. Ignored if db = 'none'.

	--amb-marker-cutoff=AMB-MARKER-CUTOFF
		(Plotting option). Numeric; Cutoff at which to label ambiguous markers.
                Default 0.5.

	--label-size=LABEL-SIZE
		(Plotting option). Numeric, size of the text labels for ambiguous
                markers and unplotted markers.

	-h, --help
		Show this help message and exit
```


## garnett-cli_update_marker_file.R

### Tool Description
Update marker gene list based on assessment file.

### Metadata
- **Docker Image**: quay.io/biocontainers/garnett-cli:0.0.5--hdfd78af_1
- **Homepage**: https://github.com/ebi-gene-expression-group/garnett-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/garnett-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/update_marker_file.R [options]


Options:
	-i MARKER-LIST-OBJ, --marker-list-obj=MARKER-LIST-OBJ
		Path to the original marker gene list serialised object

	-f MARKER-CHECK-FILE, --marker-check-file=MARKER-CHECK-FILE
		Path to the file with marker gene assessment done by garnett

	-s SUMMARY-COL, --summary-col=SUMMARY-COL
		Marker gene assessment column name

	-c CELL-TYPE-COL, --cell-type-col=CELL-TYPE-COL
		Marker gene assessment column name

	-g GENE-ID-COL, --gene-id-col=GENE-ID-COL
		Gene id column name in marker assessment file

	-o UPDATED-MARKER-FILE, --updated-marker-file=UPDATED-MARKER-FILE
		Path to the updated marker file

	-h, --help
		Show this help message and exit
```


## garnett-cli_garnett_train_classifier.R

### Tool Description
Train a cell type classifier using Garnett.

### Metadata
- **Docker Image**: quay.io/biocontainers/garnett-cli:0.0.5--hdfd78af_1
- **Homepage**: https://github.com/ebi-gene-expression-group/garnett-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/garnett-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/garnett_train_classifier.R [options]


Options:
	-c CDS-OBJECT, --cds-object=CDS-OBJECT
		CDS object with expression data for training

	-m MARKER-FILE-PATH, --marker-file-path=MARKER-FILE-PATH
		File with marker genes specifying cell types. 
        See https://cole-trapnell-lab.github.io/garnett/docs/#constructing-a-marker-file
        for specification of the file format.

	-d DATABASE, --database=DATABASE
		argument for Bioconductor AnnotationDb-class package used
                for converting gene IDs
                For example, use org.Hs.eg.db for Homo Sapiens genes.

	-f TRAIN-ID, --train-id=TRAIN-ID
		ID of the training dataset

	--cds-gene-id-type=CDS-GENE-ID-TYPE
		Format of the gene IDs in your CDS object. 
        The default is "ENSEMBL".

	--marker-file-gene-id-type=MARKER-FILE-GENE-ID-TYPE
		Format of the gene IDs in your marker file.
        The default is "SYMBOL".

	-n NUM-UNKNOWN, --num-unknown=NUM-UNKNOWN
		Number of outgroups to compare against. Default 500.

	--min-observations=MIN-OBSERVATIONS
		An integer. The minimum number of representative cells per 
        cell type required to include the cell type in the predictive model.
        Default is 8.

	--max-training-samples=MAX-TRAINING-SAMPLES
		An integer. The maximum number of representative cells per cell
        type to be included in the model training. Decreasing this number 
        increases speed, but may hurt performance of the model. Default is 500.

	--propogate-markers
		Optional. Should markers from child nodes of a cell type be used
        in finding representatives of the parent type?
        Default: TRUE.

	--cores=CORES
		Optional. The number of cores to use for computation. 
        Default: number returned by detectCores().

	--lambdas=LAMBDAS
		Optional. Path to user-supplied lambda sequence
                (numeric vector in .rds format); default is NULL,
                and glmnet chooses its own sequence. 

	--classifier-gene-id-type=CLASSIFIER-GENE-ID-TYPE
		Optional. The type of gene ID that will be used in the classifier.
        If possible for your organism, this should be 'ENSEMBL', which is
        the default. Ignored if db = 'none'.

	-o OUTPUT-PATH, --output-path=OUTPUT-PATH
		Path to the output file

	-h, --help
		Show this help message and exit
```


## garnett-cli_garnett_classify_cells.R

### Tool Description
Query CDS object holding expression data to be classified

### Metadata
- **Docker Image**: quay.io/biocontainers/garnett-cli:0.0.5--hdfd78af_1
- **Homepage**: https://github.com/ebi-gene-expression-group/garnett-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/garnett-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/garnett_classify_cells.R [options]


Options:
	-i CDS-OBJECT, --cds-object=CDS-OBJECT
		Query CDS object holding expression data to be classified

	-c CLASSIFIER-OBJECT, --classifier-object=CLASSIFIER-OBJECT
		Path to the object of class garnett_classifier, which is either
                trained via garnett_train_classifier.R or obtained previously

	-d DATABASE, --database=DATABASE
		Argument for Bioconductor AnnotationDb-class package used for
                converting gene IDs. For example, use org.Hs.eg.db for
                Homo Sapiens genes.

	--cds-gene-id-type=CDS-GENE-ID-TYPE
		Format of the gene IDs in your CDS object. The default
                is "ENSEMBL".

	-e, --cluster-extend
		Boolean, tells Garnett whether to create a second set of
                assignments that expands classifications to cells in the same
                cluster. Default: TRUE

	--rank-prob-ratio=RANK-PROB-RATIO
		Numeric value greater than 1. This is the minimum odds ratio
        between the probability of the most likely cell type to the second most
        likely cell type to allow assignment. Default is 1.5. 
        Higher values are more conservative.

	-v, --verbose
		Logical. Should progress messages be printed. Default: FASLE.

	-p PLOT-OUTPUT-PATH, --plot-output-path=PLOT-OUTPUT-PATH
		output path for the t-SNE plots. In case --cluster-extend
                tag is provided, two plots will be made. If no path is provided,
                plots will not be produced.

	-o CDS-OUTPUT-OBJ, --cds-output-obj=CDS-OUTPUT-OBJ
		Output path for cds object holding predicted labels on query data

	-h, --help
		Show this help message and exit
```


## garnett-cli_garnett_get_std_output.R

### Tool Description
Get standard output from a CDS object

### Metadata
- **Docker Image**: quay.io/biocontainers/garnett-cli:0.0.5--hdfd78af_1
- **Homepage**: https://github.com/ebi-gene-expression-group/garnett-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/garnett-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/garnett_get_std_output.R [options]


Options:
	-i INPUT-OBJECT, --input-object=INPUT-OBJECT
		Path to the input CDS object in .rds format

	-c CELL-ID-FIELD, --cell-id-field=CELL-ID-FIELD
		Column name of the cell id annotations. If not supplied, it is assumed
                that cell ids are represented by index

	-p PREDICTED-CELL-TYPE-FIELD, --predicted-cell-type-field=PREDICTED-CELL-TYPE-FIELD
		Column name of the predicted cell type annotation

	-k CLASSIFIER, --classifier=CLASSIFIER
		Path to the classifier object in .rds format (Optional; required to add dataset of origin to output table)

	-o OUTPUT-FILE-PATH, --output-file-path=OUTPUT-FILE-PATH
		Path to the produced output file in .tsv format

	-h, --help
		Show this help message and exit
```


## garnett-cli_garnett_get_feature_genes.R

### Tool Description
Get feature genes for a given classifier object.

### Metadata
- **Docker Image**: quay.io/biocontainers/garnett-cli:0.0.5--hdfd78af_1
- **Homepage**: https://github.com/ebi-gene-expression-group/garnett-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/garnett-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/garnett_get_feature_genes.R [options]


Options:
	-c CLASSIFIER-OBJECT, --classifier-object=CLASSIFIER-OBJECT
		path to the object of class garnett_classifier, which is either
                trained via garnett_train_classifier.R or obtained previously

	-n NODE, --node=NODE
		In case a hierarchical marker tree was used to train the 
                classifier, specify which node features should be shown. Default
                is 'root'. For other nodes, use the corresponding parent cell
                type name

	-d DATABASE, --database=DATABASE
		argument for Bioconductor AnnotationDb-class package used for
                converting gene IDs. For example, use org.Hs.eg.db for
                Homo Sapiens genes.

	--convert-ids
		Boolean that indicates whether the gene IDs should be converted
                into SYMBOL notation. Default: FALSE

	-o OUTPUT-PATH, --output-path=OUTPUT-PATH
		Path to the output file

	-h, --help
		Show this help message and exit
```


## Metadata
- **Skill**: generated
