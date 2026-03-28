# scater-scripts CWL Generation Report

## scater-scripts_scater-calculate-qc-metrics.R

### Tool Description
Calculate QC metrics for single-cell RNA-seq data.

### Metadata
- **Docker Image**: quay.io/biocontainers/scater-scripts:0.0.5--0
- **Homepage**: https://github.com/ebi-gene-expression-group/bioconductor-scater-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scater-scripts/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/scater-scripts/overview
- **Total Downloads**: 3.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ebi-gene-expression-group/bioconductor-scater-scripts
- **Stars**: N/A
### Original Help Text
```text
Usage: /usr/local/bin/scater-calculate-qc-metrics.R [options]


Options:
	-i INPUT-OBJECT-FILE, --input-object-file=INPUT-OBJECT-FILE
		singleCellExperiment object containing expression values and experimental information. Must have been appropriately prepared.

	-e EXPRS-VALUES, --exprs-values=EXPRS-VALUES
		A string indicating which ‘assays’ in the ‘object’ should be used to define expression.

	-f FEATURE-CONTROLS, --feature-controls=FEATURE-CONTROLS
		file containing a list of the control files with one file per line. Each control file should have one feature (e.g. gene) per line. A named list is created (names derived from control file names) containing one or more vectors to identify feature controls (for example, ERCC spike-in genes, mitochondrial genes, etc)

	-c CELL-CONTROLS, --cell-controls=CELL-CONTROLS
		file (one cell per line) to be used to derive a vector of cell (sample) names used to identify cell controls (for example, blank wells or bulk controls).

	-p PERCENT-TOP, --percent-top=PERCENT-TOP
		Comma-separated list of integers. Each element is treated as a number of top genes to compute the percentage of library size occupied by the most highly expressed genes in each cell.

	-d DETECTION-LIMIT, --detection-limit=DETECTION-LIMIT
		A numeric scalar to be passed to 'nexprs', specifying the lower detection limit for expression.

	-s USE-SPIKES, --use-spikes=USE-SPIKES
		A logical scalar indicating whether existing spike-in sets in ‘object’ should be automatically added to 'feature_controls', see '?isSpike'.

	-o OUTPUT-OBJECT-FILE, --output-object-file=OUTPUT-OBJECT-FILE
		file name in which to store serialized R object of type 'SingleCellExperiment'.

	-h, --help
		Show this help message and exit
```


## scater-scripts_scater-filter.R

### Tool Description
Filters cells and features from a SingleCellExperiment object based on specified criteria.

### Metadata
- **Docker Image**: quay.io/biocontainers/scater-scripts:0.0.5--0
- **Homepage**: https://github.com/ebi-gene-expression-group/bioconductor-scater-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scater-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/scater-filter.R [options]


Options:
	-i INPUT-OBJECT-FILE, --input-object-file=INPUT-OBJECT-FILE
		A serialized SingleCellExperiment object file in RDS format.

	-s SUBSET-CELL-VARIABLES, --subset-cell-variables=SUBSET-CELL-VARIABLES
		Comma-separated parameters to subset on. Any variable available in the colData of the supplied object.

	-l LOW-CELL-THRESHOLDS, --low-cell-thresholds=LOW-CELL-THRESHOLDS
		Comma-separated low cutoffs for the parameters (default is -Inf).

	-j HIGH-CELL-THRESHOLDS, --high-cell-thresholds=HIGH-CELL-THRESHOLDS
		Comma-separated high cutoffs for the parameters (default is Inf).

	-c CELLS-USE, --cells-use=CELLS-USE
		Comma-separated list of cell names to use as a subset. Alternatively, text file with one cell per line providing cell names to use as a subset.

	-C CELLS-DISCARD, --cells-discard=CELLS-DISCARD
		Comma-separated list of cell names to discard as a subset. Alternatively, text file with one cell per line providing cell names to discard as a subset.

	-t SUBSET-FEATURE-VARIABLES, --subset-feature-variables=SUBSET-FEATURE-VARIABLES
		Comma-separated parameters to subset on. Any variable available in the colData of the supplied object.

	-m LOW-FEATURE-THRESHOLDS, --low-feature-thresholds=LOW-FEATURE-THRESHOLDS
		Comma-separated low cutoffs for the parameters (default is -Inf).

	-n HIGH-FEATURE-THRESHOLDS, --high-feature-thresholds=HIGH-FEATURE-THRESHOLDS
		Comma-separated high cutoffs for the parameters (default is Inf).

	-f FEATURES-USE, --features-use=FEATURES-USE
		Comma-separated list of feature names to use as a subset. Alternatively, text file with one feature per line providing feature names to use as a subset.

	-o OUTPUT-OBJECT-FILE, --output-object-file=OUTPUT-OBJECT-FILE
		File name in which to store serialized R object of type 'Seurat'.'

	-u OUTPUT-CELLSELECT-FILE, --output-cellselect-file=OUTPUT-CELLSELECT-FILE
		File name in which to store a matrix showing results of applying individual cell selection criteria.

	-v OUTPUT-FEATURESELECT-FILE, --output-featureselect-file=OUTPUT-FEATURESELECT-FILE
		File name in which to store a matrix showing results of applying individual feature selection criteria.

	-h, --help
		Show this help message and exit
```


## scater-scripts_scater-normalize.R

### Tool Description
Normalizes expression values in a SingleCellExperiment object.

### Metadata
- **Docker Image**: quay.io/biocontainers/scater-scripts:0.0.5--0
- **Homepage**: https://github.com/ebi-gene-expression-group/bioconductor-scater-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scater-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/scater-normalize.R [options]


Options:
	-i INPUT-OBJECT-FILE, --input-object-file=INPUT-OBJECT-FILE
		File name in which a serialized R SingleCellExperiment object where object matrix found

	-e EXPRS-VALUES, --exprs-values=EXPRS-VALUES
		String indicating which assay contains the count data that should be used to compute log-transformed expression values.

	-l RETURN-LOG, --return-log=RETURN-LOG
		Logical scalar, should normalized values be returned on the log2 scale?

	-f LOG-EXPRS-OFFSET, --log-exprs-offset=LOG-EXPRS-OFFSET
		Numeric scalar specifying the offset to add when log-transforming expression values. If ‘NULL’, value is taken from ‘metadata(object)$log.exprs.offset’ if defined, otherwise 1.

	-c CENTRE-SIZE-FACTORS, --centre-size-factors=CENTRE-SIZE-FACTORS
		 Logical scalar indicating whether size fators should be centred.

	-o OUTPUT-OBJECT-FILE, --output-object-file=OUTPUT-OBJECT-FILE
		File name in which to store serialized R object of type 'SingleCellExperiment'.'

	-h, --help
		Show this help message and exit
```


## scater-scripts_scater-run-pca.R

### Tool Description
Performs Principal Component Analysis (PCA) on a SingleCellExperiment object.

### Metadata
- **Docker Image**: quay.io/biocontainers/scater-scripts:0.0.5--0
- **Homepage**: https://github.com/ebi-gene-expression-group/bioconductor-scater-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scater-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/scater-run-pca.R [options]


Options:
	-i INPUT-OBJECT-FILE, --input-object-file=INPUT-OBJECT-FILE
		singleCellExperiment object containing expression values and experimental information. Must have been appropriately prepared.

	-n NCOMPONENTS, --ncomponents=NCOMPONENTS
		Numeric scalar indicating the number of principal components to obtain.

	-m METHOD, --method=METHOD
		String specifying how the PCA should be performed. (default: prcomp)

	-t NTOP, --ntop=NTOP
		Numeric scalar specifying the number of most variable features to use for PCA.

	-e EXPRS-VALUES, --exprs-values=EXPRS-VALUES
		Integer scalar or string indicating which assay of object should be used to obtain the expression values for the calculations.

	-f FEATURE-SET, --feature-set=FEATURE-SET
		file (one cell per line) to be used to derive a character vector of row names indicating a set of features to use for PCA. This will override any ntop argument if specified.

	-s SCALE-FEATURES, --scale-features=SCALE-FEATURES
		Logical scalar, should the expression values be standardised so that each feature has unit variance? This will also remove features with standard deviations below 1e-8.

	-c USE-COLDATA, --use-coldata=USE-COLDATA
		Logical scalar specifying whether the column data should be used instead of expression values to perform PCA.

	-l SELECTED-VARIABLES, --selected-variables=SELECTED-VARIABLES
		Comma-separated list of strings indicating which variables in colData(object) to use for PCA when use_coldata=TRUE.

	-d DETECT-OUTLIERS, --detect-outliers=DETECT-OUTLIERS
		Logical scalar, should outliers be detected based on PCA coordinates generated from column-level metadata?

	-o OUTPUT-OBJECT-FILE, --output-object-file=OUTPUT-OBJECT-FILE
		file name in which to store serialized R object of type 'SingleCellExperiment'.

	-h, --help
		Show this help message and exit
```


## scater-scripts_scater-run-tsne.R

### Tool Description
Performs t-SNE dimensionality reduction on a SingleCellExperiment object.

### Metadata
- **Docker Image**: quay.io/biocontainers/scater-scripts:0.0.5--0
- **Homepage**: https://github.com/ebi-gene-expression-group/bioconductor-scater-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scater-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/scater-run-tsne.R [options]


Options:
	-i INPUT-OBJECT-FILE, --input-object-file=INPUT-OBJECT-FILE
		singleCellExperiment object containing expression values and experimental information. Must have been appropriately prepared.

	-n NCOMPONENTS, --ncomponents=NCOMPONENTS
		Numeric scalar indicating the number of principal components to obtain.

	-t NTOP, --ntop=NTOP
		Numeric scalar specifying the number of most variable features to use for PCA.

	-f FEATURE-SET, --feature-set=FEATURE-SET
		file (one cell per line) to be used to derive a character vector of row names, indicating a set of features to use for t-SNE. This will override any ntop argument if specified.

	-e EXPRS-VALUES, --exprs-values=EXPRS-VALUES
		Integer scalar or string indicating which assay of object should be used to obtain the expression values for the calculations.

	-s SCALE-FEATURES, --scale-features=SCALE-FEATURES
		Logical scalar, should the expression values be standardised so that each feature has unit variance?

	-d USE-DIMRED, --use-dimred=USE-DIMRED
		String or integer scalar specifying the entry of reducedDims(object) to use as input to Rtsne. Default is to not use existing reduced dimension results.

	-m N-DIMRED, --n-dimred=N-DIMRED
		Integer scalar, number of dimensions of the reduced dimension slot to use when use_dimred is supplied. Defaults to all available dimensions.

	-p PERPLEXITY, --perplexity=PERPLEXITY
		Numeric scalar defining the perplexity parameter, see ?Rtsne for more details.

	-q PCA, --pca=PCA
		Logical scalar passed to Rtsne, indicating whether an initial PCA step should be performed. This is ignored if use_dimred is specified.

	-g INITIAL-DIMS, --initial-dims=INITIAL-DIMS
		Integer scalar passed to Rtsne, specifying the number of principal components to be retained if pca=TRUE.

	-o OUTPUT-OBJECT-FILE, --output-object-file=OUTPUT-OBJECT-FILE
		file name in which to store serialized R object of type 'SingleCellExperiment'.

	-h, --help
		Show this help message and exit
```


## scater-scripts_scater-extract-qc-metric.R

### Tool Description
Extracts a specified quality control metric from a singleCellExperiment object and saves it to a file.

### Metadata
- **Docker Image**: quay.io/biocontainers/scater-scripts:0.0.5--0
- **Homepage**: https://github.com/ebi-gene-expression-group/bioconductor-scater-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scater-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/scater-extract-qc-metric.R [options]


Options:
	-i INPUT-OBJECT-FILE, --input-object-file=INPUT-OBJECT-FILE
		singleCellExperiment object containing expression values and experimental information. Must have been appropriately prepared.

	-m METRIC, --metric=METRIC
		Metric name.

	-o OUTPUT-FILE, --output-file=OUTPUT-FILE
		Output file name, will be comma-separated cell,value.

	-h, --help
		Show this help message and exit
```


## scater-scripts_scater-is-outlier.R

### Tool Description
Detects outliers in a numeric QC metric for each cell.

### Metadata
- **Docker Image**: quay.io/biocontainers/scater-scripts:0.0.5--0
- **Homepage**: https://github.com/ebi-gene-expression-group/bioconductor-scater-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/scater-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/scater-is-outlier.R [options]


Options:
	-m METRIC-FILE, --metric-file=METRIC-FILE
		Two column table with cell names on the first column and numeric QC metric on the second column.

	-n NMADS, --nmads=NMADS
		scalar, number of median-absolute-deviations away from median required for a value to be called an outlier.

	-t TYPE, --type=TYPE
		character scalar, choice indicate whether outliers should be looked for at both tails (default: "both") or only at the lower end ("lower") or the higher end ("higher").

	-l LOG, --log=LOG
		logical, should the values of the metric be transformed to the log10 scale before computing median-absolute-deviation for outlier detection?

	-d MIN-DIFF, --min-diff=MIN-DIFF
		numeric scalar indicating the minimum difference from the median to consider as an outlier. The outlier threshold is defined from the larger of nmads MADs and min.diff, to avoid calling many outliers when the MAD is very small. If NA, it is ignored.

	-o OUTPUT-FILE, --output-file=OUTPUT-FILE
		File name in which to store the output vector of outliers (one value per line)

	-h, --help
		Show this help message and exit
```


## Metadata
- **Skill**: generated
