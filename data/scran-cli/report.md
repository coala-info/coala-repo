# scran-cli CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| scran-cli_igraph_extract_clusters.R | PASS |  |
| scran-cli_scran-build-snn-graph.R | Failed | tool bug: --transposed is ignored by the script; shared=FALSE calls a missing function; main SNN graph works |
| scran-cli_scran-cli-filter-sce.R | PASS |  |
| scran-cli_scran-compute-spike-factors.R | PASS |  |
| scran-cli_scran-compute-sum-factors.R | Failed | tool bug: --clusters is ignored (the script reads opt$custers); main mode works |
| scran-cli_scran-convert-to.R | PASS |  |
| scran-cli_scran-correlate-genes.R | PASS |  |
| scran-cli_scran-correlate-pairs.R | Failed | tool bug: --iters and --use-dimred are ignored by the script; main mode works only with the counts assay |
| scran-cli_scran-denoise-pca.R | PASS |  |
| scran-cli_scran-find-markers.R | Failed | tool bug: the output file is a copy of the input SCE object, not the marker table |
| scran-cli_scran-model-gene-var.R | Failed | image problem: the scran version in the image has no modelGeneVar function |
| scran-cli_scran-trend-var.R | PASS |  |

## scran-cli_scran-compute-sum-factors.R

### Tool Description
Computes size factors for single-cell RNA-seq data.

### Metadata
- **Docker Image**: quay.io/biocontainers/scran-cli:v0.0.1--hdfd78af_1
- **Homepage**: https://github.com/ebi-gene-expression-group/scran-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/scran-cli/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/scran-cli/overview
- **Total Downloads**: 5.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ebi-gene-expression-group/scran-cli
- **Stars**: N/A
### Original Help Text
```text
Usage: /usr/local/bin/scran-compute-sum-factors.R [options]


Options:
	-i INPUT-SCE-OBJECT, --input-sce-object=INPUT-SCE-OBJECT
		Path to the input SCE object in rds format.

	-a ASSAY-TYPE, --assay-type=ASSAY-TYPE
		Specify which assay values to use. Default: "logcounts".

	-s SIZES, --sizes=SIZES
		A numeric vector of pool sizes, i.e., number of cells per pool.

	-c CLUSTERS, --clusters=CLUSTERS
		An optional factor specifying which cells belong to which cluster, for deconvolution within clusters. For large data sets, clustering should be performed with the quickCluster function before normalization.

	-r SUBSET-ROW, --subset-row=SUBSET-ROW
		Logical, integer or character vector indicating the rows of SCE to use. If a character vector, it must contain the names of the rows in SCE.

	-g GET-SPIKES, --get-spikes=GET-SPIKES
		If get-spikes = FALSE, spike-in transcripts are automatically removed. If get.spikes=TRUE, no filtering on the spike-in transcripts will be performed.

	-l SCALING, --scaling=SCALING
		A numeric scalar containing scaling factors to adjust the counts prior to computing size factors.

	-m MIN_MEAN, --min_mean=MIN_MEAN
		A numeric scalar specifying the minimum (library size-adjusted) average count of genes to be used for normalization.

	-o OUTPUT-SCE-OBJECT, --output-sce-object=OUTPUT-SCE-OBJECT
		Path to the output SCE object containing the vector of size factors in sizeFactors(x).

	-h, --help
		Show this help message and exit
```


## scran-cli_scran-compute-spike-factors.R

### Tool Description
Compute spike-in size factors for SingleCellExperiment objects.

### Metadata
- **Docker Image**: quay.io/biocontainers/scran-cli:v0.0.1--hdfd78af_1
- **Homepage**: https://github.com/ebi-gene-expression-group/scran-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/scran-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/scran-compute-spike-factors.R [options]


Options:
	-i INPUT-SCE-OBJECT, --input-sce-object=INPUT-SCE-OBJECT
		Path to the input SCE object in rds format.

	-t TYPE, --type=TYPE
		A character vector specifying which spike-in sets to use. Default: "ERCC".

	-a ASSAY-TYPE, --assay-type=ASSAY-TYPE
		Specify which assay values to use. Default: "logcounts".

	-g GENERAL_USE, --general_use=GENERAL_USE
		A logical scalar indicating whether the size factors should be stored for general use by all genes.

	-o OUTPUT-SCE-OBJECT, --output-sce-object=OUTPUT-SCE-OBJECT
		Path to the output SCE object containing the vector of size factors in sizeFactors(x).

	-h, --help
		Show this help message and exit
```


## scran-cli_scran-model-gene-var.R

### Tool Description
Model gene variance using scran

### Metadata
- **Docker Image**: quay.io/biocontainers/scran-cli:v0.0.1--hdfd78af_1
- **Homepage**: https://github.com/ebi-gene-expression-group/scran-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/scran-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/scran-model-gene-var.R [options]


Options:
	-i INPUT-SCE-OBJECT, --input-sce-object=INPUT-SCE-OBJECT
		Path to the input SCE object in rds format.

	-b BLOCK, --block=BLOCK
		A factor specifying the blocking levels for each cell in sce, for instance a donor covariate. If specified, variance modelling is performed separately within each block and statistics are combined across blocks.

	-d DESIGN, --design=DESIGN
		A numeric matrix containing blocking terms for uninteresting factors of variation.

	-s SUBSET-ROW, --subset-row=SUBSET-ROW
		Logical, integer or character vector specifying the rows for which to model the variance. Defaults to all genes in x.

	-f SUBSET-FIT, --subset-fit=SUBSET-FIT
		Logical, integer or character vector specifying the rows to be used for trend fitting. Defaults to subset.row.

	-a ASSAY-TYPE, --assay-type=ASSAY-TYPE
		String or integer scalar specifying the assay containing the log-expression values.

	-m MIN-MEAN, --min-mean=MIN-MEAN
		A numeric scalar specifying the minimum mean to use for trend fitting.

	-p PARAMETRIC, --parametric=PARAMETRIC
		A logical scalar indicating whether a parametric fit should be attempted. f parametric=TRUE, a non-linear curve of the form: y = ax/(x^n + b) s fitted to the variances against the means.

	-e EQUIWEIGHT, --equiweight=EQUIWEIGHT
		A logical scalar indicating whether statistics from each block should be given equal weight. Otherwise, each block is weighted according to its number of cells. Only used if block is specified.

	-t METHOD, --method=METHOD
		String specifying how p-values should be combined when block is specified, see ?combinePValues.

	-o OUTPUT-GENEVAR-TABLE, --output-geneVar-table=OUTPUT-GENEVAR-TABLE
		Path to the table where each row corresponds to a gene in sce, and contains: mean, total var, bio var, tech var, p.value and FDR.

	-h, --help
		Show this help message and exit
```


## scran-cli_scran-denoise-pca.R

### Tool Description
Performs PCA-based denoising on a SingleCellExperiment object.

### Metadata
- **Docker Image**: quay.io/biocontainers/scran-cli:v0.0.1--hdfd78af_1
- **Homepage**: https://github.com/ebi-gene-expression-group/scran-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/scran-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/scran-denoise-pca.R [options]


Options:
	-i INPUT-SCE-OBJECT, --input-sce-object=INPUT-SCE-OBJECT
		Path to the input SCE object in rds format.

	-t TECHNICAL, --technical=TECHNICAL
		This can be: 1) a function that computes the technical component of the variance for a gene as FitTrendVar, 
                         2) a numeric vector of length equal to the number of rows in x, containing the technical component for each gene.  
                         3) a DataFrame of variance decomposition results generated by modelGeneVar or related functions. 

	-s SUBSET_ROW, --subset_row=SUBSET_ROW
		Logical, integer or character vector specifying the rows for which to model the variance. Defaults to all genes in x.

	-m MIN-RANK, --min-rank=MIN-RANK
		Integer scalars specifying the minimum number of PCs to retain.

	--max-rank=MAX-RANK
		Integer scalars specifying the maximum number of PCs to retain.

	-a ASSAY-TYPE, --assay-type=ASSAY-TYPE
		String or integer scalar specifying the assay containing the log-expression values.

	-g GET-SPIKES, --get-spikes=GET-SPIKES
		If get-spikes = FALSE, spike-in transcripts are automatically removed. If get.spikes=TRUE, no filtering on the spike-in transcripts will be performed.

	-v VALUE, --value=VALUE
		String specifying the type of value to return. "pca" will return the PCs, "n" will return the number of retained components, and "lowrank" will return a low-rank approximation.

	-o OUTPUT-SCE-OBJECT, --output-sce-object=OUTPUT-SCE-OBJECT
		Path to the output SCE object with denoised PC number.

	-h, --help
		Show this help message and exit
```


## scran-cli_scran-build-snn-graph.R

### Tool Description
Builds a Shared Nearest Neighbor (SNN) graph or a k-Nearest Neighbor (kNN) graph from a Single-Cell Experiment (SCE) object.

### Metadata
- **Docker Image**: quay.io/biocontainers/scran-cli:v0.0.1--hdfd78af_1
- **Homepage**: https://github.com/ebi-gene-expression-group/scran-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/scran-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/scran-build-snn-graph.R [options]


Options:
	-i INPUT-SCE-OBJECT, --input-sce-object=INPUT-SCE-OBJECT
		Path to the input SCE object in rds format.

	-s SHARED, --shared=SHARED
		Logical specifying wether to compute a Shared NN Graph (if shared=TRUE) or a kNN Graph(if shared=FALSE).

	-k K-VALUE, --k-value=K-VALUE
		An integer scalar specifying the number of nearest neighbors to consider during graph construction.

	-d D-VALUE, --d-value=D-VALUE
		An integer scalar specifying the number of dimensions to use for the search.

	-y TYPE, --type=TYPE
		A string specifying the type of weighting scheme to use for shared neighbors.

	-t TRANSPOSED, --transposed=TRANSPOSED
		A logical scalar indicating whether x is transposed (i.e., rows are cells).

	-r SUBSET_ROW, --subset_row=SUBSET_ROW
		Logical, integer or character vector specifying the rows for which to model the variance. Defaults to all genes in x.

	-a ASSAY-TYPE, --assay-type=ASSAY-TYPE
		A string specifying which assay values to use. Default: logcounts.

	-g GET-SPIKES, --get-spikes=GET-SPIKES
		Logical specifying wether to perform spike-ins filtering(FALSE) or not (TRUE).

	-u USE-DIMRED, --use-dimred=USE-DIMRED
		A string specifying whether existing values in reducedDims(x) should be used.

	-o OUTPUT-IGRAPH-OBJECT, --output-igraph-object=OUTPUT-IGRAPH-OBJECT
		Path to the output igraph object in RDS format.

	-h, --help
		Show this help message and exit
```


## scran-cli_igraph_extract_clusters.R

### Tool Description
Extracts cluster annotations from an igraph object and adds them to a SingleCellExperiment object.

### Metadata
- **Docker Image**: quay.io/biocontainers/scran-cli:v0.0.1--hdfd78af_1
- **Homepage**: https://github.com/ebi-gene-expression-group/scran-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/scran-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/igraph_extract_clusters.R [options]


Options:
	-i INPUT-IGRAPH-OBJECT, --input-igraph-object=INPUT-IGRAPH-OBJECT
		Path to the input igraph object in rds format.

	-s INPUT-SCE-OBJECT, --input-sce-object=INPUT-SCE-OBJECT
		Path to the input SCE object where to add the cluster annotation extracted from the igraph objecti.

	-o OUTPUT-SCE-OBJECT, --output-sce-object=OUTPUT-SCE-OBJECT
		Path to the output SCE object in rds format with cluster annotation in $cluster.

	-h, --help
		Show this help message and exit
```


## scran-cli_scran-find-markers.R

### Tool Description
Finds marker genes for each cluster/group in a SingleCellExperiment object.

### Metadata
- **Docker Image**: quay.io/biocontainers/scran-cli:v0.0.1--hdfd78af_1
- **Homepage**: https://github.com/ebi-gene-expression-group/scran-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/scran-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/scran-find-markers.R [options]


Options:
	-i INPUT-SCE-OBJECT, --input-sce-object=INPUT-SCE-OBJECT
		Path to the input SCE object in rds format.

	-c CLUSTERS, --clusters=CLUSTERS
		A vector of group assignments for all cells.

	-p PVALUE-TYPE, --pvalue-type=PVALUE-TYPE
		A character specifying how p-values are to be combined across pairwise comparisons for a given group/cluster. Setting pval.type="all" requires a gene to be DE between each cluster and every other cluster (rather than any other cluster, as is the default with pval.type="any").

	-s SUBSET_ROW, --subset_row=SUBSET_ROW
		Logical, integer or character vector specifying the rows for which to model the variance. Defaults to all genes in x.

	-a ASSAY-TYPE, --assay-type=ASSAY-TYPE
		A character specifying which assay values to use.

	-k GET-SPIKES, --get-spikes=GET-SPIKES
		Logical specifying wether to perform spike-ins filtering(FALSE) or not (TRUE).

	-o OUTPUT-MARKERS, --output-markers=OUTPUT-MARKERS
		Path to the rds list of DataFrames with a sorted marker gene list per cluster/group.

	-h, --help
		Show this help message and exit
```


## scran-cli_scran-cli-filter-sce.R

### Tool Description
Filter cells and genes of a SingleCellExperiment object, add spike-in genes and optionally log-transform counts

### Metadata
- **Docker Image**: quay.io/biocontainers/scran-cli:v0.0.1--hdfd78af_1
- **Homepage**: https://github.com/ebi-gene-expression-group/scran-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/scran-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/scran-cli-filter-sce.R [options]


Options:
	-i INPUT-SCE-OBJECT, --input-sce-object=INPUT-SCE-OBJECT
		Path to the input SCE object in rds format.

	-e EXPRS-VALUES, --exprs-values=EXPRS-VALUES
		String indicating which assay contains the count data that should be used to compute log-transformed expression values.

	--min-genes=MIN-GENES
		Minimum number of genes to be expressed per cell to pass filtering.

	--min-cells=MIN-CELLS
		Minimum number of cells for a gene to be expressed to pass filtering.

	-k SPIKES, --spikes=SPIKES
		String or integer scalar specifying the alternative experiment containing the spike-in transcripts. Default; "ERCC"

	-n N-SPIKES, --n-spikes=N-SPIKES
		Integer specifying the number of genes to add as spike-ins in case there is are no spike-ins in the "ERCC" slot. Default: 25.

	-l LOG, --log=LOG
		Logical specifying wether log-transformation of CPM counts should be performed.

	-o OUTPUT-SCE-OBJECT, --output-sce-object=OUTPUT-SCE-OBJECT
		File name in which to store serialized R object of type 'SingleCellExperiment'.

	-h, --help
		Show this help message and exit
```

## scran-cli_scran-trend-var.R

### Tool Description
Fit a mean-dependent trend to the gene-specific variances in single-cell RNA-seq data

### Metadata
- **Docker Image**: quay.io/biocontainers/scran-cli:v0.0.1--hdfd78af_1
- **Homepage**: https://github.com/ebi-gene-expression-group/scran-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/scran-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/scran-trend-var.R [options]


Options:
	-i INPUT-SCE-OBJECT, --input-sce-object=INPUT-SCE-OBJECT
		Path to the input SCE object in rds format.

	-m MIN-MEAN, --min-mean=MIN-MEAN
		A numeric scalar specifying the minimum mean to use for trend fitting.

	-t METHOD, --method=METHOD
		A string specifying the algorithm to use for smooth trend fitting.

	-p PARAMETRIC, --parametric=PARAMETRIC
		A logical scalar indicating whether a parametric fit should be attempted.

	-a ASSAY-TYPE, --assay-type=ASSAY-TYPE
		String or integer scalar specifying the assay containing the log-expression values. Default: "logcounts"

	-k USE-SPIKES, --use-spikes=USE-SPIKES
		If FALSE only the rows not labelled as spike-in transcripts will be used. If TRUE, nly rows labelled as spike-ins with isSpike(x) will be used.

	-o OUTPUT-TREND-VAR, --output-trend-var=OUTPUT-TREND-VAR
		Path to the RDS object with named list containing: mean, var, resid.df, block, design, trend, df2.

	-h, --help
		Show this help message and exit
```

## scran-cli_scran-correlate-pairs.R

### Tool Description
Identify pairs of genes with significant correlations (correlatePairs)

### Metadata
- **Docker Image**: quay.io/biocontainers/scran-cli:v0.0.1--hdfd78af_1
- **Homepage**: https://github.com/ebi-gene-expression-group/scran-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/scran-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/scran-correlate-pairs.R [options]


Options:
	-i INPUT-SCE-OBJECT, --input-sce-object=INPUT-SCE-OBJECT
		Path to the input SCE object in rds format.

	-b BLOCK, --block=BLOCK
		A factor specifying the blocking levels for each cell in sce, for instance a donor covariate. If specified, correlations are computed separately within each block and statistics are combined across blocks.

	-d DESIGN, --design=DESIGN
		A numeric design matrix containing uninteresting factors to be ignored.

	-a ASSAY-TYPE, --assay-type=ASSAY-TYPE
		A character specifying which assay values to use.

	-k ITERS, --iters=ITERS
		Integer scalar specifying the number of iterations to use in correlateNull to build the null distribution.

	-u USE-NAMES, --use-names=USE-NAMES
		A logical scalar specifying whether the row names of x should be used in the output. Alternatively, a character vector containing the names to use.

	-s SUBSET_ROW, --subset_row=SUBSET_ROW
		Logical, integer or character vector specifying the rows for which to model the variance. Defaults to all genes in x.

	-g GET-SPIKES, --get-spikes=GET-SPIKES
		Logical specifying wether to perform spike-ins filtering(FALSE) or not (TRUE).

	-m USE-DIMRED, --use-dimred=USE-DIMRED
		A string specifying whether existing values in reducedDims(x) should be used.

	-o OUTPUT-PAIRS-DF, --output-pairs-df=OUTPUT-PAIRS-DF
		Path to the output dataframe with one row per gene pair (rows order by increasing p-values) in txt format.

	-h, --help
		Show this help message and exit
```

## scran-cli_scran-correlate-genes.R

### Tool Description
Get per-gene correlation statistics from the gene-pair table made by correlatePairs

### Metadata
- **Docker Image**: quay.io/biocontainers/scran-cli:v0.0.1--hdfd78af_1
- **Homepage**: https://github.com/ebi-gene-expression-group/scran-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/scran-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/scran-correlate-genes.R [options]


Options:
	-i INPUT-CORR-PAIRS, --input-corr-pairs=INPUT-CORR-PAIRS
		Path to the  DataFrame of pairwise correlation statistics, returned by correlatePairs.

	-o OUTPUT-CORR-GENES, --output-corr-genes=OUTPUT-CORR-GENES
		A DataFrame with one row per unique gene in stats and containing the fields: gene, rho, p.value, FDR, limited.

	-h, --help
		Show this help message and exit
```

## scran-cli_scran-convert-to.R

### Tool Description
Convert a SingleCellExperiment object to an edgeR, DESeq2 or monocle object

### Metadata
- **Docker Image**: quay.io/biocontainers/scran-cli:v0.0.1--hdfd78af_1
- **Homepage**: https://github.com/ebi-gene-expression-group/scran-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/scran-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/scran-convert-to.R [options]


Options:
	-i INPUT-SCE-OBJECT, --input-sce-object=INPUT-SCE-OBJECT
		Path to the input SCE object in rds format.

	-t TYPE, --type=TYPE
		A string specifying the analysis for which the object should be prepared. Any of: "edgeR", "DESeq2", "monocle".

	-a ASSAY-TYPE, --assay-type=ASSAY-TYPE
		A string specifying which assay of x should be put in the returned object. For edgeR and DESeq2, assay is set to "counts" such that count data is stored in the output object

	-g GET-SPIKES, --get-spikes=GET-SPIKES
		Logical specifying wether to perform spike-ins filtering(FALSE) or not (TRUE).

	-o OUTPUT-CONVERTED, --output-converted=OUTPUT-CONVERTED
		Path to the converted object stored as RDS.

	-h, --help
		Show this help message and exit
```

## Metadata
- **Skill**: generated
