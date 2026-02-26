# sc3-scripts CWL Generation Report

## sc3-scripts_sc3-sc3-prepare.R

### Tool Description
Prepare SingleCellExperiment object for SC3 clustering.

### Metadata
- **Docker Image**: quay.io/biocontainers/sc3-scripts:0.0.6--r351_0
- **Homepage**: https://github.com/ebi-gene-expression-group/bioconductor-sc3-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/sc3-scripts/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sc3-scripts/overview
- **Total Downloads**: 9.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ebi-gene-expression-group/bioconductor-sc3-scripts
- **Stars**: N/A
### Original Help Text
```text
Usage: /usr/local/bin/sc3-sc3-prepare.R [options]


Options:
	-i INPUT-OBJECT-FILE, --input-object-file=INPUT-OBJECT-FILE
		File name in which a serialized R SingleCellExperiment object where object matrix found

	-f GENE-FILTER, --gene-filter=GENE-FILTER
		A boolean variable which defines whether to perform gene filtering before SC3 clustering.

	-p PCT-DROPOUT-MIN, --pct-dropout-min=PCT-DROPOUT-MIN
		If gene_filter = TRUE, then genes with percent of dropouts smaller than pct_dropout_min are filtered out before clustering.

	-q PCT-DROPOUT-MAX, --pct-dropout-max=PCT-DROPOUT-MAX
		If gene_filter = TRUE, then genes with percent of dropouts larger than pct_dropout_max are filtered out before clustering.

	-d D-REGION-MIN, --d-region-min=D-REGION-MIN
		Defines the minimum number of eigenvectors used for kmeans clustering as a fraction of the total number of cells. Default is 0.04. See SC3 paper for more details.

	-e D-REGION-MAX, --d-region-max=D-REGION-MAX
		Defines the maximum number of eigenvectors used for kmeans clustering as a fraction of the total number of cells. Default is 0.07. See SC3 paper for more details.

	-n SVM-NUM-CELLS, --svm-num-cells=SVM-NUM-CELLS
		Number of randomly selected training cells to be used for SVM prediction. Default is NULL.

	-r SVM-TRAIN-INDS, --svm-train-inds=SVM-TRAIN-INDS
		Text file with one integer per line. Will be used to create a numeric vector defining indices of training cells that should be used for SVM training. The default is NULL.

	-m SVM-MAX, --svm-max=SVM-MAX
		Define the maximum number of cells below which SVM are not run.

	-t N-CORES, --n-cores=N-CORES
		Number of threads/cores to be used in the user's machine.

	-s RAND-SEED, --rand-seed=RAND-SEED
		sets the seed of the random number generator. SC3 is a stochastic method, so setting the rand_seed to a fixed values can be used for reproducibility purposes.

	-k KMEANS-NSTART, --kmeans-nstart=KMEANS-NSTART
		nstart parameter passed to kmeans function. Default is 1000 for up to 2000 cells and 50 for more than 2000 cells.

	-a KMEANS-ITER-MAX, --kmeans-iter-max=KMEANS-ITER-MAX
		iter.max parameter passed to kmeans function. Default is 1e+09.

	-o OUTPUT-OBJECT-FILE, --output-object-file=OUTPUT-OBJECT-FILE
		File name in which to store serialized R object of type 'SingleCellExperiment'.'

	-h, --help
		Show this help message and exit
```


## sc3-scripts_sc3-sc3-estimate-k.R

### Tool Description
Estimate the number of clusters (k) for SC3.

### Metadata
- **Docker Image**: quay.io/biocontainers/sc3-scripts:0.0.6--r351_0
- **Homepage**: https://github.com/ebi-gene-expression-group/bioconductor-sc3-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/sc3-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/sc3-sc3-estimate-k.R [options]


Options:
	-i INPUT-OBJECT-FILE, --input-object-file=INPUT-OBJECT-FILE
		File name in which a processed SC3 object can be found.

	-o OUTPUT-OBJECT-FILE, --output-object-file=OUTPUT-OBJECT-FILE
		File name in which to store the SingleCellExperiment object with estimated k'.

	-t OUTPUT-TEXT-FILE, --output-text-file=OUTPUT-TEXT-FILE
		Text file name in which to store the estimated k'.

	-h, --help
		Show this help message and exit
```


## sc3-scripts_sc3-sc3-calc-dists.R

### Tool Description
Calculates distances between cells.

### Metadata
- **Docker Image**: quay.io/biocontainers/sc3-scripts:0.0.6--r351_0
- **Homepage**: https://github.com/ebi-gene-expression-group/bioconductor-sc3-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/sc3-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/sc3-sc3-calc-dists.R [options]


Options:
	-i INPUT-OBJECT-FILE, --input-object-file=INPUT-OBJECT-FILE
		File name in which a serialized R SingleCellExperiment object where object matrix found

	-o OUTPUT-OBJECT-FILE, --output-object-file=OUTPUT-OBJECT-FILE
		File name in which to store serialized R object of type 'SingleCellExperiment'.'

	-h, --help
		Show this help message and exit
```


## sc3-scripts_sc3-sc3-calc-transfs.R

### Tool Description
Calculates transformations for SC3.

### Metadata
- **Docker Image**: quay.io/biocontainers/sc3-scripts:0.0.6--r351_0
- **Homepage**: https://github.com/ebi-gene-expression-group/bioconductor-sc3-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/sc3-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/sc3-sc3-calc-transfs.R [options]


Options:
	-i INPUT-OBJECT-FILE, --input-object-file=INPUT-OBJECT-FILE
		File name in which a processed SC3 'SingleCellExperiment' object has been stored

	-o OUTPUT-OBJECT-FILE, --output-object-file=OUTPUT-OBJECT-FILE
		File name in which to store a transformed R object of type 'SingleCellExperiment' from SC3.

	-h, --help
		Show this help message and exit
```


## sc3-scripts_sc3-sc3-kmeans.R

### Tool Description
Performs k-means clustering on a SC3 SingleCellExperiment object.

### Metadata
- **Docker Image**: quay.io/biocontainers/sc3-scripts:0.0.6--r351_0
- **Homepage**: https://github.com/ebi-gene-expression-group/bioconductor-sc3-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/sc3-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/sc3-sc3-kmeans.R [options]


Options:
	-i INPUT-OBJECT-FILE, --input-object-file=INPUT-OBJECT-FILE
		File name in which a transformed SC3 'SingleCellExperiment' object has been stored after processed with sc3_calc_transfs()

	-k KS, --ks=KS
		A comma-separated string or single value representing the number of clusters k to be used for SC3 clustering.

	-o OUTPUT-OBJECT-FILE, --output-object-file=OUTPUT-OBJECT-FILE
		File name for R object of type 'SingleCellExperiment' from SC3 in which to store the kmeans clustering as metadata.

	-h, --help
		Show this help message and exit
```


## sc3-scripts_sc3-sc3-calc-consens.R

### Tool Description
Calculates the consensus matrix for SC3.

### Metadata
- **Docker Image**: quay.io/biocontainers/sc3-scripts:0.0.6--r351_0
- **Homepage**: https://github.com/ebi-gene-expression-group/bioconductor-sc3-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/sc3-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/sc3-sc3-calc-consens.R [options]


Options:
	-i INPUT-OBJECT-FILE, --input-object-file=INPUT-OBJECT-FILE
		File name in which a SC3 'SingleCellExperiment' object has been stored after kmeans clustering.

	-t OUTPUT-TEXT-FILE, --output-text-file=OUTPUT-TEXT-FILE
		Text file name in which to store clusters, one column for every k value.

	-o OUTPUT-OBJECT-FILE, --output-object-file=OUTPUT-OBJECT-FILE
		File name for R object of type 'SingleCellExperiment' from SC3 in which to store the consensus matrix.

	-h, --help
		Show this help message and exit
```

