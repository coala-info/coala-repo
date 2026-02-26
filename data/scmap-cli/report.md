# scmap-cli CWL Generation Report

## scmap-cli_scmap-preprocess-sce.R

### Tool Description
Preprocesses a SingleCellExperiment object for scmap.

### Metadata
- **Docker Image**: quay.io/biocontainers/scmap-cli:0.1.0--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scmap-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/scmap-cli/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/scmap-cli/overview
- **Total Downloads**: 23.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ebi-gene-expression-group/scmap-cli
- **Stars**: N/A
### Original Help Text
```text
Usage: /usr/local/bin/scmap-preprocess-sce.R [options]


Options:
	-i INPUT-OBJECT, --input-object=INPUT-OBJECT
		Path to an SCE object in .rds format

	-o OUTPUT-SCE-OBJECT, --output-sce-object=OUTPUT-SCE-OBJECT
		Path for the output object in .rds format

	-h, --help
		Show this help message and exit
```


## scmap-cli_scmap-select-features.R

### Tool Description
Selects features based on expression and dropout distributions.

### Metadata
- **Docker Image**: quay.io/biocontainers/scmap-cli:0.1.0--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scmap-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/scmap-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/scmap-select-features.R [options]


Options:
	-i INPUT-OBJECT-FILE, --input-object-file=INPUT-OBJECT-FILE
		singleCellExperiment object containing expression values and experimental information. Must have been appropriately prepared.

	-n N-FEATURES, --n-features=N-FEATURES
		Number of the features to be selected.

	-p OUTPUT-PLOT-FILE, --output-plot-file=OUTPUT-PLOT-FILE
		Optional file name in which to store a PNG-format plot of log(expression) versus log(dropout) distribution for all genes. Selected features are highlighted with the red colour.

	-o OUTPUT-OBJECT-FILE, --output-object-file=OUTPUT-OBJECT-FILE
		File name in which to store serialized R object of type 'SingleCellExperiment'.

	-h, --help
		Show this help message and exit
```


## scmap-cli_scmap-index-cluster.R

### Tool Description
Index clustering information for scmap

### Metadata
- **Docker Image**: quay.io/biocontainers/scmap-cli:0.1.0--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scmap-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/scmap-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/scmap-index-cluster.R [options]


Options:
	-i INPUT-OBJECT-FILE, --input-object-file=INPUT-OBJECT-FILE
		singleCellExperiment object containing expression values and experimental information. Must have been appropriately prepared.

	-c CLUSTER-COL, --cluster-col=CLUSTER-COL
		Column name in the 'colData' slot of the SingleCellExperiment object containing the cell classification information.

	-f TRAIN-ID, --train-id=TRAIN-ID
		ID of the training dataset (optional)

	-r, --remove-mat
		Should expression data be removed from index object? Default: FALSE

	-p OUTPUT-PLOT-FILE, --output-plot-file=OUTPUT-PLOT-FILE
		Optional file name in which to store a PNG-format heatmap-style index visualisation.

	-o OUTPUT-OBJECT-FILE, --output-object-file=OUTPUT-OBJECT-FILE
		File name in which to store serialized R object of type 'SingleCellExperiment'.

	-h, --help
		Show this help message and exit
```


## scmap-cli_scmap-index-cell.R

### Tool Description
Index cell data for scmap

### Metadata
- **Docker Image**: quay.io/biocontainers/scmap-cli:0.1.0--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scmap-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/scmap-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/scmap-index-cell.R [options]


Options:
	-i INPUT-OBJECT-FILE, --input-object-file=INPUT-OBJECT-FILE
		singleCellExperiment object containing expression values and experimental information. Must have been appropriately prepared.

	-m NUMBER-CHUNKS, --number-chunks=NUMBER-CHUNKS
		Number of chunks into which the expr matrix is split.

	-k NUMBER-CLUSTERS, --number-clusters=NUMBER-CLUSTERS
		Number of clusters per group for k-means clustering.

	-f TRAIN-ID, --train-id=TRAIN-ID
		ID of the training dataset (optional)

	-e, --remove-mat
		Should expression data be removed from index object? Default: FALSE

	-r RANDOM-SEED, --random-seed=RANDOM-SEED
		Set random seed to make scmap-cell reproducible.

	-o OUTPUT-OBJECT-FILE, --output-object-file=OUTPUT-OBJECT-FILE
		File name in which to store serialized R object of type 'SingleCellExperiment'.

	-h, --help
		Show this help message and exit
```


## scmap-cli_scmap-scmap-cluster.R

### Tool Description
Assigns cell types to cells in a SingleCellExperiment object using pre-computed cluster assignments.

### Metadata
- **Docker Image**: quay.io/biocontainers/scmap-cli:0.1.0--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scmap-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/scmap-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/scmap-scmap-cluster.R [options]


Options:
	-i INDEX-OBJECT-FILE, --index-object-file=INDEX-OBJECT-FILE
		'SingleCellExperiment' object previously prepared with the scmap-index-cluster.R script.

	-p PROJECTION-OBJECT-FILE, --projection-object-file=PROJECTION-OBJECT-FILE
		'SingleCellExperiment' object to project.

	-r THRESHOLD, --threshold=THRESHOLD
		Threshold on similarity (or probability for SVM and RF).

	-t OUTPUT-TEXT-FILE, --output-text-file=OUTPUT-TEXT-FILE
		File name in which to text-format cell type assignments.

	-o OUTPUT-OBJECT-FILE, --output-object-file=OUTPUT-OBJECT-FILE
		File name in which to store serialized R object of type 'SingleCellExperiment'.

	-h, --help
		Show this help message and exit
```


## scmap-cli_scmap-scmap-cell.R

### Tool Description
Annotates cells of a projection dataset using labels of a reference dataset.

### Metadata
- **Docker Image**: quay.io/biocontainers/scmap-cli:0.1.0--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scmap-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/scmap-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/scmap-scmap-cell.R [options]


Options:
	-i INDEX-OBJECT-FILE, --index-object-file=INDEX-OBJECT-FILE
		'SingleCellExperiment' object previously prepared with the scmap-index-cluster.R script.

	-p PROJECTION-OBJECT-FILE, --projection-object-file=PROJECTION-OBJECT-FILE
		'SingleCellExperiment' object to project.

	-w NUMBER-NEAREST-NEIGHBOURS, --number-nearest-neighbours=NUMBER-NEAREST-NEIGHBOURS
		A positive integer specifying the number of nearest neighbours to find.

	-n NEAREST-NEIGHBOURS-THRESHOLD, --nearest-neighbours-threshold=NEAREST-NEIGHBOURS-THRESHOLD
		A positive integer specifying the number of matching nearest neighbours required to label a cell.

	-r THRESHOLD, --threshold=THRESHOLD
		Threshold on similarity (or probability for SVM and RF).

	-c CLUSTER-COL, --cluster-col=CLUSTER-COL
		Column name in the 'colData' slot of the SingleCellExperiment index object containing the cell classification information. If found in the index object, scmapCell2Cluster() will be run to annotate cells of the projection dataset using labels of the reference.

	-o OUTPUT-OBJECT-FILE, --output-object-file=OUTPUT-OBJECT-FILE
		File name in which to store serialized R object of type 'SingleCellExperiment', containing the input object specified by --projection-object-file with cluster labels in its colData (where --cluster-col is set and scmapCell2Cluster() is run).

	-t OUTPUT-CLUSTERS-TEXT-FILE, --output-clusters-text-file=OUTPUT-CLUSTERS-TEXT-FILE
		File name in which to text-format cell type assignments.

	-l CLOSEST-CELLS-TEXT-FILE, --closest-cells-text-file=CLOSEST-CELLS-TEXT-FILE
		File name in which to store the top cell IDs of the cells of the reference dataset that a given cell of the projection dataset is closest to.

	-s CLOSEST-CELLS-SIMILARITIES-TEXT-FILE, --closest-cells-similarities-text-file=CLOSEST-CELLS-SIMILARITIES-TEXT-FILE
		File name in which to store cosine similarities for the top cells of the reference dataset that a given cell of the projection dataset is closest to.

	-h, --help
		Show this help message and exit
```


## scmap-cli_scmap_get_std_output.R

### Tool Description
Get standard output from scmap predictions

### Metadata
- **Docker Image**: quay.io/biocontainers/scmap-cli:0.1.0--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/scmap-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/scmap-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/scmap_get_std_output.R [options]


Options:
	-i PREDICTIONS-FILE, --predictions-file=PREDICTIONS-FILE
		Path to the predictions file in text format

	-o OUTPUT-TABLE, --output-table=OUTPUT-TABLE
		Path to the final output file in text format

	-s, --include-scores
		Should prediction scores be included in output? Default: FALSE

	-l INDEX, --index=INDEX
		Path to the index object in .rds format (Optional; required to add dataset of origin to output table)

	-t TOOL, --tool=TOOL
		What tool produced output? scmap-cell or scmap-cluster

	-k SIM-COL-NAME, --sim-col-name=SIM-COL-NAME
		Column name of similarity scores

	-h, --help
		Show this help message and exit
```

