# seurat-scripts CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| seurat-scripts_seurat-classify-against-reference.R | PASS | synthetic data: query is a copy of pbmc_small with renamed barcodes (names must differ from the reference); 80 query cells got predicted cluster labels and an anchor set was saved (--transfer-dims crashes because the script passes it as text) |
| seurat-scripts_seurat-convert.R | PASS | pbmc_small (SeuratObject, 80 cells x 230 genes) exported to 10x files, Seurat object converted to a SingleCellExperiment RDS |
| seurat-scripts_seurat-dim-plot.R | PASS | pbmc_small (SeuratObject, 80 cells x 230 genes) exported to 10x files, t-SNE plot coloured by cluster written as a 1000 x 1000 PNG |
| seurat-scripts_seurat-export-cellbrowser.R | PASS | pbmc_small (SeuratObject, 80 cells x 230 genes) exported to 10x files, Cell Browser folder with expression matrix, t-SNE coordinates, metadata and config (--markers-file crashes: file_ext is missing in the script) |
| seurat-scripts_seurat-filter-cells.R | PASS | pbmc_small (SeuratObject, 80 cells x 230 genes) exported to 10x files, --low-thresholds on nFeature_RNA kept 53 of 80 cells (--cells-use crashes: the script calls a missing check_cells function) |
| seurat-scripts_seurat-find-clusters.R | PASS | pbmc_small (SeuratObject, 80 cells x 230 genes) exported to 10x files, 3 clusters for 53 cells, written to the object and the text file |
| seurat-scripts_seurat-find-conserved-markers.R | PASS | pbmc_small (SeuratObject, 80 cells x 230 genes) exported to 10x files, markers of cluster 0 conserved across the groups g1 and g2 of the pbmc_small metadata |
| seurat-scripts_seurat-find-markers.R | PASS | pbmc_small (SeuratObject, 80 cells x 230 genes) exported to 10x files, ranked marker table per cluster (CST3, LYZ, HLA-DRA among the top genes) |
| seurat-scripts_seurat-find-neighbours.R | PASS | pbmc_small (SeuratObject, 80 cells x 230 genes) exported to 10x files, RNA_nn and RNA_snn graphs added (--reduction must be given when --dims is used) |
| seurat-scripts_seurat-find-variable-genes.R | PASS | pbmc_small (SeuratObject, 80 cells x 230 genes) exported to 10x files, 100 variable genes stored and listed in the text file |
| seurat-scripts_seurat-get-random-genes.R | PASS | pbmc_small (SeuratObject, 80 cells x 230 genes) exported to 10x files, 5 reproducible random genes written, one per line |
| seurat-scripts_seurat-hover-locator.R | PASS | pbmc_small (SeuratObject, 80 cells x 230 genes) exported to 10x files, interactive HTML hover plot made from the DimPlot RDS (3.7 MB, self-contained) |
| seurat-scripts_seurat-integration.R | PASS | pbmc_small (SeuratObject, 80 cells x 230 genes) exported to 10x files, 2 objects (cells split by nFeature_RNA) integrated: integrated assay of 80 features x 79 cells |
| seurat-scripts_seurat-map-query.R | PASS | synthetic data: query is a copy of pbmc_small with renamed barcodes; the query was mapped onto a reference UMAP model, giving ref.pca, ref.umap and predicted labels for 80 cells |
| seurat-scripts_seurat-normalise-data.R | PASS | pbmc_small (SeuratObject, 80 cells x 230 genes) exported to 10x files, log-normalised the filtered object |
| seurat-scripts_seurat-plot.R | PASS | pbmc_small (SeuratObject, 80 cells x 230 genes) exported to 10x files, DimPlot on the t-SNE coordinates written as PNG and as RDS (the documented --plot-format PNG is rejected by ggsave; leave it unset) |
| seurat-scripts_seurat-read-10x.R | PASS | pbmc_small (SeuratObject, real PBMC data) exported to 10x files; read into a Seurat object of 230 genes x 80 cells, also with a cell metadata table |
| seurat-scripts_seurat-run-pca.R | PASS | pbmc_small (SeuratObject, 80 cells x 230 genes) exported to 10x files, PCA reduction added; embeddings, loadings and stdev files written |
| seurat-scripts_seurat-run-tsne.R | PASS | pbmc_small (SeuratObject, 80 cells x 230 genes) exported to 10x files, tsne reduction and embeddings table written for 53 cells |
| seurat-scripts_seurat-run-umap.R | PASS | input built with the image's own read-10x, normalise, variable-genes, scale and PCA scripts from real 10x data; output holds a 11089 x 2 UMAP embedding |
| seurat-scripts_seurat-scale-data.R | PASS | pbmc_small (SeuratObject, 80 cells x 230 genes) exported to 10x files, scaled the variable-gene object |
| seurat-scripts_seurat-select-integration-features.R | PASS | pbmc_small (SeuratObject, 80 cells x 230 genes) exported to 10x files, 80 integration features selected across 2 objects (cells split by nFeature_RNA) |
| seurat-scripts_seurat-split-object.R | Failed | tool bug: the script calls CreateSeuratObject on the object it just read, which fails with an as.sparse error for a Seurat RDS and for a SingleCellExperiment |

## seurat-scripts_seurat-classify-against-reference.R

### Tool Description
Classify query cells against a reference Seurat object (Seurat FindTransferAnchors and TransferData).

### Metadata
- **Docker Image**: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/r-seurat-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/seurat-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/seurat-classify-against-reference.R [options]


Options:
	-i QUERY-FILE, --query-file=QUERY-FILE
		File containing seurat object to use as the query.

	--query-format=QUERY-FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the output format.

	-r REFERENCE-FILE, --reference-file=REFERENCE-FILE
		File containing seurat object to use as the reference.

	--reference-format=REFERENCE-FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the output format.

	-o OUTPUT-OBJECT-FILE, --output-object-file=OUTPUT-OBJECT-FILE
		File name in which to store serialized R object of type 'Seurat'.'

	--output-format=OUTPUT-FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the output format.

	--output-anchorset-file=OUTPUT-ANCHORSET-FILE
		File name in which to store serialized R object for the anchorset.

	--output-anchorset-format=OUTPUT-ANCHORSET-FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the output format.

	-n NORMALIZATION-METHOD, --normalization-method=NORMALIZATION-METHOD
		Name of normalization method used: LogNormalize or SCT.

	--reference-assay=REFERENCE-ASSAY
		Assay to use from reference.

	--query-assay=QUERY-ASSAY
		Assay to use from query.

	--reduction=REDUCTION
		Dimensional reduction to perform when finding anchors.

	--reference_reduction=REFERENCE_REDUCTION
		Name of dimensional reduction to use from the reference if running the pcaproject workflow. Optionally enables reuse of precomputed reference dimensional reduction. If NULL (default), use a PCA computed on the reference object.

	--project-query
		Project the PCA from the query dataset onto the reference. Use only in rare cases.

	--l2-norm
		Execute a l2 normalization on the query.

	-f FEATURES, --features=FEATURES
		Features to use for dimensional reductionFeatures to use for dimensional reduction.

	--npcs=NPCS
		Number of PCs to compute on reference. If null, then use an existing PCA structure in the reference object.

	--dims=DIMS
		Which dimensions to use from the reduction to specify the neighbor search space.

	--k-anchor=K-ANCHOR
		How many neighbors (k) to use when picking anchors.

	--k-filter=K-FILTER
		How many neighbors (k) to use when filtering anchors.

	--k-score=K-SCORE
		How many neighbors (k) to use when scoring anchors.

	-m MAX-FEATURES, --max-features=MAX-FEATURES
		The maximum number of features to use when specifying the neighborhood search space in the anchor filtering.

	--nn-method=NN-METHOD
		Method for nearest neighbor finding. Options include: rann, annoy.

	--eps=EPS
		Error bound on the neighbor finding algorithm (from RANN).

	--approx-pca
		Use truncated singular value decomposition to approximate PCA.

	--verbose
		Print progress bars and output.

	--transfer-refdata=TRANSFER-REFDATA
		Data to transfer. The name of the metadata field or assay from the reference object provided. This requires the reference parameter to be specified. 

	--transfer-weight-reduction=TRANSFER-WEIGHT-REDUCTION
		Dimensional reduction to use for the weighting anchors. Options are: pcaproject - Use the projected PCA used for anchor building; pca - Use an internal PCA on the query only; cca - Use the CCA used for anchor building; custom DimReduc - User provided DimReduc paths as RDS, computed on the query cells

	--transfer-l2-norm
		Perform L2 normalization on the cell embeddings after dimensional reduction

	--transfer-dims=TRANSFER-DIMS
		Set of dimensions to use in the anchor weighting procedure.

	--transfer-k-weight=TRANSFER-K-WEIGHT
		Number of neighbors to consider when weighting anchors

	--transfer-sd-weight=TRANSFER-SD-WEIGHT
		Controls the bandwidth of the Gaussian kernel for weighting

	--transfer-eps=TRANSFER-EPS
		Error bound on the neighbor finding algorithm (from RANN), for transfer

	--transfer-prediction-assay
		Return an Assay object with the prediction scores for each class stored in the data slot.

	--transfer-n-trees=TRANSFER-N-TREES
		More trees gives higher precision when using annoy approximate nearest neighbor search.

	--transfer-slot=TRANSFER-SLOT
		Slot to store the imputed data. Must be either 'data' (default) or 'counts'

	--transfer-no-store-weights
		Don't store the weights matrix used for predictions in the returned query object.

	--metadata-col=METADATA-COL
		Col name to store metadata in.

	-h, --help
		Show this help message and exit
```

## seurat-scripts_seurat-convert.R

### Tool Description
Convert a Seurat object between formats (Seurat, h5seurat, Loom, SingleCellExperiment, AnnData).

### Metadata
- **Docker Image**: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/r-seurat-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/seurat-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/seurat-convert.R [options]


Options:
	-i INPUT FILE, --input-object-file=INPUT FILE
		Input file with Seurat object in either RDS-Seurat, Loom or SCE

	--input-format=INPUT FORMAT
		Either loom, seurat, h5seurat, anndata or singlecellexperiment for the input format to read.

	-o OUTPUT-OBJECT-FILE, --output-object-file=OUTPUT-OBJECT-FILE
		Path to the output file, when using Loom as output, the final file will contain .loom at the end of the given file name.

	--output-format=OUTPUT-FORMAT
		Either seurat, h5seurat, loom, singlecellexperiment or h5seurat (partial support)

	--input-assay=INPUT-ASSAY
		The assay to be read from the input object, if it corresponds

	-h, --help
		Show this help message and exit
```

## seurat-scripts_seurat-dim-plot.R

### Tool Description
Plot a dimensionality reduction (PCA, tSNE, UMAP) of a Seurat object (Seurat DimPlot).

### Metadata
- **Docker Image**: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/r-seurat-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/seurat-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/seurat-dim-plot.R [options]


Options:
	-i INPUT-OBJECT-FILE, --input-object-file=INPUT-OBJECT-FILE
		File name in which a serialized R matrix object may be found.

	--input-format=INPUT-FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the input format to read.

	-r REDUCTION-USE, --reduction-use=REDUCTION-USE
		Which dimensionality reduction to use. Default is "umap", can also be "tsne", or "pca", assuming these are precomputed.

	-a DIM-1, --dim-1=DIM-1
		Dimension for x-axis (default 1)

	-b DIM-2, --dim-2=DIM-2
		Dimension for y-axis (default 2)

	-c CELLS-USE, --cells-use=CELLS-USE
		File to be used to derive a vector of cells to plot (default is all cells).

	-p PT-SIZE, --pt-size=PT-SIZE
		Adjust point size for plotting

	-l LABEL-SIZE, --label-size=LABEL-SIZE
		Sets size of labels.

	-d DO-LABEL, --do-label=DO-LABEL
		Whether to label the clusters.

	--repel=REPEL
		Repel labels.

	-f GROUP-BY, --group-by=GROUP-BY
		Group (color) cells in different ways (for example, orig.ident).

	-u COLS-USE, --cols-use=COLS-USE
		Comma-separated list of colors, each color corresponds to an identity class. By default, ggplot assigns colors.

	-e PT-SHAPE, --pt-shape=PT-SHAPE
		If NULL, all points are circles (default). You can specify any cell attribute (that can be pulled with FetchData) allowing for both different colors and different shapes on cells.

	-q PLOT-ORDER, --plot-order=PLOT-ORDER
		Comma-separated string specifying the order of plotting for the idents (clusters). This can be useful for crowded plots if points of interest are being buried. Provide either a full list of valid idents or a subset to be plotted last (on top)..

	-w PNG-WIDTH, --png-width=PNG-WIDTH
		Width of png (px).

	-j PNG-HEIGHT, --png-height=PNG-HEIGHT
		Height of png file (px).

	-o OUTPUT-IMAGE-FILE, --output-image-file=OUTPUT-IMAGE-FILE
		File name in which to save the PCA image

	-h, --help
		Show this help message and exit
```

## seurat-scripts_seurat-export-cellbrowser.R

### Tool Description
Export a Seurat object to a UCSC Cell Browser directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/r-seurat-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/seurat-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/seurat-export-cellbrowser.R [options]


Options:
	-i INPUT-OBJECT-FILE, --input-object-file=INPUT-OBJECT-FILE
		File name in which a serialized R matrix object may be found.

	--input-format=INPUT-FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the input format to read.

	-o OUTPUT-DIRECTORY, --output-directory=OUTPUT-DIRECTORY
		File name in which to store serialized R object of type 'Seurat'.'

	-n STUDY-NAME, --study-name=STUDY-NAME
		Study name to be displayed in CellBrowser

	-m MARKERS-FILE, --markers-file=MARKERS-FILE
		Path to markers file computed by Seurat

	-h, --help
		Show this help message and exit
```

## seurat-scripts_seurat-filter-cells.R

### Tool Description
Filter cells of a Seurat object on gene, metadata or reduction values (Seurat subset).

### Metadata
- **Docker Image**: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/r-seurat-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/seurat-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/seurat-filter-cells.R [options]


Options:
	-i INPUT-OBJECT-FILE, --input-object-file=INPUT-OBJECT-FILE
		File name in which a serialized R matrix object may be found.

	--input-format=INPUT-FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the input format to read.

	--output-format=OUTPUT-FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the output format.

	-s SUBSET-NAMES, --subset-names=SUBSET-NAMES
		Parameters to subset on. Eg, the name of a gene, PC1, a column name in object@meta.data, etc. Any argument that can be retreived using FetchData.

	-l LOW-THRESHOLDS, --low-thresholds=LOW-THRESHOLDS
		Low cutoffs for the parameters (default is -Inf).

	-j HIGH-THRESHOLDS, --high-thresholds=HIGH-THRESHOLDS
		High cutoffs for the parameters (default is Inf).

	-c CELLS-USE, --cells-use=CELLS-USE
		Comma-separated list of cell names to use as a subset. Alternatively, text file with one cell per line.

	-o OUTPUT-OBJECT-FILE, --output-object-file=OUTPUT-OBJECT-FILE
		File name in which to store serialized R object of type 'Seurat'.'

	--idents=IDENT CLASSES TO KEEP
		Comma-separated list of identity classes to keep

	--features=FEATURES TO KEEP
		Comma-separated list or file path with features (normally genes) to keep

	-h, --help
		Show this help message and exit
```

## seurat-scripts_seurat-find-clusters.R

### Tool Description
Cluster the cells of a Seurat object with a shared nearest neighbour graph (Seurat FindClusters).

### Metadata
- **Docker Image**: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/r-seurat-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/seurat-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/seurat-find-clusters.R [options]


Options:
	-i INPUT-OBJECT-FILE, --input-object-file=INPUT-OBJECT-FILE
		File name in which a serialized R matrix object may be found.

	--input-format=INPUT-FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the input format to read.

	--output-format=OUTPUT-FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the output format.

	-r RESOLUTION, --resolution=RESOLUTION
		Value of the resolution parameter, use a value above (below) 1.0 if you want to obtain a larger (smaller) number of communities.

	-a ALGORITHM, --algorithm=ALGORITHM
		Algorithm for modularity optimization (1 = original Louvain algorithm; 2 = Louvain algorithm with multilevel refinement; 3 = SLM algorithm; 4 Leiden).

	-m TMP-FILE-LOCATION, --tmp-file-location=TMP-FILE-LOCATION
		Directory where intermediate files will be written. Specify the ABSOLUTE path.

	--modularity-fxn=MODULARITY-FXN
		Modularity function: 1 standard, 2 alternative.

	--method=METHOD
		Method for leiden  (defaults to matrix which is fast for small datasets). Enable method = "igraph" to avoid casting large data to a dense matrix.

	-o OUTPUT-OBJECT-FILE, --output-object-file=OUTPUT-OBJECT-FILE
		File name in which to store serialized R object of type 'Seurat'.'

	-t OUTPUT-TEXT-FILE, --output-text-file=OUTPUT-TEXT-FILE
		File name in which to store text format set of clusters.

	--graph-name=GRAPH-NAME
		Name of graph to use for the clustering algorithm.

	-s NRANDOM-STARTS, --nrandom-starts=NRANDOM-STARTS
		Number of random starts

	--n-iterations=N-ITERATIONS
		Maximal number of iterations per random start

	--no-group-singletons
		Do not group singletons into nearest cluster. If TRUE, assign all singletons to a "singleton" group

	--random-seed=RANDOM-SEED
		Seed of the random number generator

	-h, --help
		Show this help message and exit
```

## seurat-scripts_seurat-find-conserved-markers.R

### Tool Description
Find markers conserved across groups of cells (Seurat FindConservedMarkers).

### Metadata
- **Docker Image**: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/r-seurat-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/seurat-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/seurat-find-conserved-markers.R [options]


Options:
	-i INPUT FILE, --input-object-file=INPUT FILE
		Query file with Seurat object in either RDS-Seurat, Loom or SCE

	--input-format=INPUT FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the input format to read.

	--ident-1=IDENT-1
		Identity class to define markers for

	--ident-2=IDENT-2
		A second identity class for comparison. If NULL (default) - use all other cells for comparison.

	--grouping-var=GROUPING-VAR
		grouping variable

	--assay=ASSAY
		of assay to fetch data for (default is RNA)

	--slot=SLOT
		Slot to pull data from; note that if test.use is negbinom, poisson, or DESeq2, slot  will be set to counts.

	--meta-method=META-METHOD
		method for combining p-values. Should be a function from the metap package: invchisq, invt, logitp, meanp, meanz, maximump, minimump, sumlog, sumz, truncated, votep, wilkinsonp

	--reduction=REDUCTION
		Reduction to use in differential expression testing - will test for DE on cell embeddings

	--features=FEATURES
		Genes to test. Default is to use all genes

	--logfc-threshold=LOGFC-THRESHOLD
		Limit testing to genes which show, on average, at least X-fold difference (log-scale) between the two groups of cells. Default is 0.25 Increasing logfc.threshold speeds up the function, but can miss weaker signals.

	--test-use=TEST-USE
		Identifies differentially expressed genes between two groups using (see options)

	--min-pct=MIN-PCT
		only test genes that are detected in a minimum fraction of min.pct cells in either of the two populations. Meant to speed up the function by not testing genes that are very infrequently expressed. Default is 0.1

	--min-diff-pct=MIN-DIFF-PCT
		only test genes that show a minimum difference in the fraction of detection between the two groups. Set to -Inf by default

	--do-not-verbose
		Print a progress bar once expression testing begins

	--only-pos
		Only return positive markers (FALSE by default)

	--max-cells-per-ident=MAX-CELLS-PER-IDENT
		Down sample each identity class to a max number. Default is no downsampling. Not activated by default (set to Inf)

	--random-seed=RANDOM-SEED
		Random seed for downsampling

	--latent-vars=LATENT-VARS
		Variables to test, used only when test.use is one of LR, negbinom, poisson, or MAST.

	--min-cells-feature=MIN-CELLS-FEATURE
		Minimum number of cells expressing the feature in at least one of the two groups, currently only used for poisson and negative binomial tests

	--min-cells-group=MIN-CELLS-GROUP
		Minimum number of cells in one of the groups

	--pseudocount-use=PSEUDOCOUNT-USE
		Pseudocount to add to averaged expression values when calculating logFC. 1 by default.

	--mean-fxn=MEAN-FXN
		Function to use for fold change or average difference calculation. If NULL, the appropriate function will be chose according to the slot used

	--fc-name=FC-NAME
		Name of the fold change, average difference, or custom function column in the output data.frame. If NULL, the fold change column will be named according to the logarithm base (eg, avg_log2FC), or if using the scale.data slot avg_diff.

	--base=BASE
		The base with respect to which logarithms are computed.

	-o MARKERS_OUTPUT_FILE, --markers_output_file=MARKERS_OUTPUT_FILE
		Output path for tab separated conserved marker genes file.

	-h, --help
		Show this help message and exit
```

## seurat-scripts_seurat-find-markers.R

### Tool Description
Find markers (differentially expressed genes) for each cluster (Seurat FindMarkers).

### Metadata
- **Docker Image**: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/r-seurat-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/seurat-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/seurat-find-markers.R [options]


Options:
	-i INPUT-OBJECT-FILE, --input-object-file=INPUT-OBJECT-FILE
		File name in which a serialized R matrix object may be found.

	-e GENES-USE, --genes-use=GENES-USE
		File to be used to derive a vector of genes to test. Default is to use all genes.

	--input-format=INPUT-FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the input format to read.

	-l LOGFC-THRESHOLD, --logfc-threshold=LOGFC-THRESHOLD
		Limit testing to genes which show, on average, at least X-fold difference (log-scale) between the two groups of cells. Default is 0.25 Increasing logfc.threshold speeds up the function, but can miss weaker signals.

	-m MIN-PCT, --min-pct=MIN-PCT
		Only test genes that are detected in a minimum fraction of min.pct cells in either of the two populations. Meant to speed up the function by not testing genes that are very infrequently expressed. Default is 0.1.

	-n MIN-DIFF-PCT, --min-diff-pct=MIN-DIFF-PCT
		Only test genes that show a minimum difference in the fraction of detection between the two groups. Set to -Inf by default.

	-p ONLY-POS, --only-pos=ONLY-POS
		Only return positive markers (FALSE by default).

	-t TEST-USE, --test-use=TEST-USE
		Denotes which test to use. Available options are 'wilcox', 'bimod', 'roc', 't', 'tobit', 'poisson', 'negbinom', 'MAST', 'DESeq2'. See ?FindMarkers() for more info.

	-x MAX-CELLS-PER-IDENT, --max-cells-per-ident=MAX-CELLS-PER-IDENT
		Down sample each identity class to a max number. Default is no downsampling. Not activated by default (set to Inf).

	-c MIN-CELLS-GENE, --min-cells-gene=MIN-CELLS-GENE
		Minimum number of cells expressing the gene in at least one of the two groups, currently only used for poisson and negative binomial tests.

	-d MIN-CELLS-GROUP, --min-cells-group=MIN-CELLS-GROUP
		Minimum number of cells in one of the groups.

	-o OUTPUT-TEXT-FILE, --output-text-file=OUTPUT-TEXT-FILE
		File name in which to store text format matrix containing a ranked list of putative markers, and associated statistics (p-values, ROC score, etc.).

	-h, --help
		Show this help message and exit
```

## seurat-scripts_seurat-find-neighbours.R

### Tool Description
Build a shared nearest neighbour graph from a Seurat object (Seurat FindNeighbors).

### Metadata
- **Docker Image**: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/r-seurat-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/seurat-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/seurat-find-neighbours.R [options]


Options:
	-i INPUT-OBJECT-FILE, --input-object-file=INPUT-OBJECT-FILE
		File name in which a serialized R matrix object may be found.

	--input-format=INPUT-FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the input format to read.

	--output-format=OUTPUT-FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the output format.

	-d, --distance-matrix
		Boolean value of whether the provided matrix is a distance matrix; note, for objects of class dist, this parameter will be set automatically.

	-k K-PARAM, --k-param=K-PARAM
		Defines k for the k-nearest neighbor algorithm

	--no-compute-snn
		Avoid computing the shared nearest neighbor graph. Default is to have it computed.

	--prune-snn=PRUNE-SNN
		Sets the cutoff for acceptable Jaccard index when computing the neighborhood overlap for the SNN construction. Any edges with values less than or equal to this will be set to 0 and removed from the SNN graph. Essentially sets the strigency of pruning (0 --- no pruning, 1 --- prune everything).

	--nn-method=NN-METHOD
		Method for nearest neighbor finding. Options include: rann (default), annoy

	-o OUTPUT-OBJECT-FILE, --output-object-file=OUTPUT-OBJECT-FILE
		File name in which to store serialized R object of type 'Seurat'.'

	-a ANNOY-METRIC, --annoy-metric=ANNOY-METRIC
		Distance metric for annoy. Options include: euclidean (default), cosine, manhattan, and hamming

	--graph-name=GRAPH-NAME
		Name of graph to use for the clustering algorithm.

	--nn-eps=NN-EPS
		Error bound when performing nearest neighbor seach using RANN; default of 0.0 implies exact nearest neighbor search

	--verbose
		Maximal number of iterations per random start

	--force-recalc
		Force recalculation of SNN

	-f FEATURES, --features=FEATURES
		Comma-separated list of genes to use for building SNN. Alternatively, text file with one gene per line.

	--reduction=REDUCTION
		Reduction to use as input for building the SNN

	--dims=DIMS
		Dimensions of reduction to use as input. A comma-separated list of the dimensions to use in construction of the SNN graph (e.g. To use the first 5 PCs, pass 1,2,3,4,5).

	--assay=ASSAY
		Assay to use in construction of SNN

	--do-plot
		Plot SNN graph on tSNE coordinates

	-h, --help
		Show this help message and exit
```

## seurat-scripts_seurat-find-variable-genes.R

### Tool Description
Find highly variable genes in a Seurat object (Seurat FindVariableFeatures).

### Metadata
- **Docker Image**: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/r-seurat-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/seurat-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/seurat-find-variable-genes.R [options]


Options:
	-i INPUT-OBJECT-FILE, --input-object-file=INPUT-OBJECT-FILE
		File name in which a serialized R matrix object may be found.

	--input-format=INPUT-FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the input format to read.

	--output-format=OUTPUT-FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the output format.

	-s SELECTION-METHOD, --selection-method=SELECTION-METHOD
		How to choose top variable features. Choose one of: 'vst', 'mvp', disp.

	-m MEAN-FUNCTION, --mean-function=MEAN-FUNCTION
		Function to compute x-axis value (average expression). Default is to take the mean of the detected (i.e. non-zero) values.

	-d DISPERSION-FUNCTION, --dispersion-function=DISPERSION-FUNCTION
		Function to compute y-axis value (dispersion). Default is to take the standard deviation of all values.

	-l X-LOW-CUTOFF, --x-low-cutoff=X-LOW-CUTOFF
		Bottom cutoff on x-axis (mean) for identifying variable genes.

	-j X-HIGH-CUTOFF, --x-high-cutoff=X-HIGH-CUTOFF
		Top cutoff on x-axis (mean) for identifying variable genes.

	-n NFEATURES, --nfeatures=NFEATURES
		Number of features to return.

	-y Y-LOW-CUTOFF, --y-low-cutoff=Y-LOW-CUTOFF
		Bottom cutoff on y-axis (dispersion) for identifying variable genes.

	-z Y-HIGH-CUTOFF, --y-high-cutoff=Y-HIGH-CUTOFF
		Top cutoff on y-axis (dispersion) for identifying variable genes.

	-o OUTPUT-OBJECT-FILE, --output-object-file=OUTPUT-OBJECT-FILE
		File name in which to store serialized R object of type 'Seurat'.'

	-t OUTPUT-TEXT-FILE, --output-text-file=OUTPUT-TEXT-FILE
		File name in which to store variable genes in plain text.

	--loess-span=LOESS SPAN PARAMETER FOR VST
		(vst method) Loess span parameter used when fitting the variance-mean relationship. Default: 0.3

	--clip-max=CLIP MAX FOR VST
		(vst method) After standardization values larger than clip.max will be set to clip.max; default is 'auto' which sets this value to the square root of the number of cells.

	--num-bin=BINS FOR SCALED ANALYSIS
		Total number of bins to use in the scaled analysis (default is 20).

	--binning-method=BINNING METHOD
		Specifies how the bins should be computed. Available methods are either equal_width: each bin is of equal width along the x-axis [default]; or equal_frequency: each bin contains an equal number of features (can increase statistical power to detect overdispersed features at high expression values, at the cost of reduced resolution along the x-axis)

	-h, --help
		Show this help message and exit
```

## seurat-scripts_seurat-get-random-genes.R

### Tool Description
Fetch a reproducible set of random genes from a serialized Seurat object (positional arguments: input object, output text file, number of genes).

### Metadata
- **Docker Image**: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/r-seurat-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/seurat-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Fetch a set of random genes from a serialized Seurat object (random but reproducible, fixed seed 42).
The script prints no help; it reads three positional arguments:

Usage: seurat-get-random-genes.R <input_object_file> <output_text_file> <ngenes>

  input_object_file   serialized Seurat object (RDS)
  output_text_file    text file in which to write the gene names, one per line
  ngenes              number of random genes to fetch
```

## seurat-scripts_seurat-hover-locator.R

### Tool Description
Turn a Seurat plot (ggplot2 RDS) into an interactive HTML hover plot (Seurat HoverLocator).

### Metadata
- **Docker Image**: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/r-seurat-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/seurat-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/seurat-hover-locator.R [options]


Options:
	--plot-rds=RDS WITH GGPLOT2 OBJECT FROM SEURAT 4
		FILE IN

	--information-table=INFORMATION-TABLE
		Table with information for overlaying on the plot. Usually the result of calling FetchData on the original Seurat object.

	--do-not-stringsAsFactors
		Load strings as factors.

	--key=KEY
		Key (index) for the information table

	--do-not-keepLeadingZeros
		If TRUE a column containing numeric data with leading zeros will be read as character, otherwise leading zeros will be removed and converted to numeric.

	--do-not-axes
		Display x- and y-axes

	--dark-theme
		Plot using a dark theme?

	--output-html=OUTPUT-HTML
		HTML output file

	--do-not-selfcontained
		Whether to save the HTML as a single self-contained file (with external resources base64 encoded) or a file with external resources placed in an adjacent directory.

	--libdir=LIBDIR
		Directory to copy HTML dependencies into (defaults to filename_files).

	-h, --help
		Show this help message and exit
```

## seurat-scripts_seurat-integration.R

### Tool Description
Integrate Seurat objects: find anchors and integrate the data (Seurat FindIntegrationAnchors and IntegrateData).

### Metadata
- **Docker Image**: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/r-seurat-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/seurat-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/seurat-integration.R [options]


Options:
	-i INPUT FILES, --input-object-files=INPUT FILES
		A list of Seurat objects between which to find anchors for downstream integration. Input files in either RDS-Seurat, Loom or SCE, comma separated.

	--input-format=INPUT FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the input format to read.

	--reference-object-files=INPUT FILES FOR REFERENCE OBJECTS
		A vector specifying the object/s to be used as a reference during integration. If NULL (default), all pairwise anchors are found (no reference/s). If not NULL, the corresponding objects in this list will be used as references. When using a set of specified references, anchors are first found between each query and each reference. The references are then integrated through pairwise integration. Each query is then mapped to the integrated reference.

	--reference-format=REFERENCE INPUT FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the input format to read.

	--assay-list=ASSAY-LIST
		A vector of assay names specifying which assay to use when constructing anchors. If NULL, the current default assay for each object is used.

	--anchor-features=ANCHOR-FEATURES
		A numeric value (this will call 'SelectIntegrationFeatures' to select the provided number of features to be used in anchor finding) or a file with a vector of features to be used as input to the anchor finding process (comma separated)

	-s, --do-not-scale
		Whether or not to scale the features provided. Only call if you have previously scaled the features you want to use for each object in the object.list

	-n NORMALIZATION-METHOD, --normalization-method=NORMALIZATION-METHOD
		Name of normalization method used: LogNormalize or SCT

	--sct-clip-range=SCT-CLIP-RANGE
		Numeric of length two specifying the min and max values the Pearson residual will be clipped to

	--reduction=REDUCTION
		Dimensional reduction to perform when finding anchors. Can be cca (Canonical correlation analysis) or rpca (Reciprocal PCA)

	--do-not-l2-norm
		Perform L2 normalization on the CCA cell embeddings after dimensional reduction

	-d DIMS, --dims=DIMS
		Which dimensions to use from the CCA to specify the neighbor search space

	--k-anchor=K-ANCHOR
		How many neighbors (k) to use when picking anchors

	--k-filter=K-FILTER
		How many neighbors (k) to use when filtering anchors

	--k-score=K-SCORE
		How many neighbors (k) to use when scoring anchors

	--max-features=MAX-FEATURES
		The maximum number of features to use when specifying the neighborhood search space in the anchor filtering

	--nn-method=NN-METHOD
		Method for nearest neighbor finding. Options include: rann, annoy

	--n-trees=N-TREES
		More trees gives higher precision when using annoy approximate nearest neighbor search

	--eps=EPS
		Error bound on the neighbor finding algorithm (from RANN)

	--verbose
		Print progress bars and output

	--new-assay-name=NEW-ASSAY-NAME
		Name for the new assay containing the integrated data

	--integrate-features-pca=INTEGRATE-FEATURES-PCA
		Vector of features to use when computing the PCA to determine the weights. Only set if you want a different set from those used in the anchor finding process

	--features-to-integrate=FEATURES-TO-INTEGRATE
		Vector of features to integrate. By default, will use the features used in anchor finding.

	--integrate-dims=INTEGRATE-DIMS
		Number of dimensions to use in the anchor weighting procedure

	--k-weight=K-WEIGHT
		Number of neighbors to consider when weighting anchors

	--weight-reduction=WEIGHT-REDUCTION
		Dimension reduction to use when calculating anchor weights. This can be one of: A string, specifying the name of a dimension reduction present in all objects to be integrated; A vector of strings, specifying the name of a dimension reduction to use for each object to be integrated; A vector of DimReduc objects, specifying the object to use for each object in the integration; NULL, in which case a new PCA will be calculated and used to calculate anchor weights. Note that, if specified, the requested dimension reduction will only be used for calculating anchor weights in the first merge between reference and query, as the merged object will subsequently contain more cells than was in query, and weights will need to be calculated for all cells in the object.

	--sd-weight=SD-WEIGHT
		Controls the bandwidth of the Gaussian kernel for weighting

	--sample-tree=SAMPLE-TREE
		Specify the order of integration. If NULL, will compute automatically.

	--preserve-order
		Do not reorder objects based on size for each pairwise integration.

	--integrate-eps=INTEGRATE-EPS
		Error bound on the neighbor finding algorithm (from 'RANN')

	-o OUTPUT-OBJECT-FILE, --output-object-file=OUTPUT-OBJECT-FILE
		FILE IN

	--output-format=OUTPUT-FORMAT
		Output format

	-h, --help
		Show this help message and exit
```

## seurat-scripts_seurat-map-query.R

### Tool Description
Map query cells onto a reference with anchors (Seurat MapQuery).

### Metadata
- **Docker Image**: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/r-seurat-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/seurat-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/seurat-map-query.R [options]


Options:
	-q INPUT FILE, --query-object-file=INPUT FILE
		Query file with Seurat object in either RDS-Seurat, Loom or SCE

	--query-format=INPUT FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the input format to read.

	-a SEURAT TRANSFER ANCHORS FILE, --anchors-object-file=SEURAT TRANSFER ANCHORS FILE
		Input file with Seurat object with anchors in either RDS-Seurat, Loom or SCE

	--anchors-format=ANCHORS FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the anchors format to read.

	-r SEURAT REFERENCE OBJECT FILE, --reference-object-file=SEURAT REFERENCE OBJECT FILE
		Input file with Seurat object with reference (and UMAP) in either RDS-Seurat, Loom or SCE

	--reference-format=ANCHORS FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the reference format to read.

	--refdata-field-or-assay=REFDATA-FIELD-OR-ASSAY
		The name of the metadata field or assay from the reference object provided. This requires the reference parameter to be specified.

	--new-reduction-name=NEW-REDUCTION-NAME
		Name for new integrated dimensional reduction.

	--reference-reduction=REFERENCE-REDUCTION
		Name of reduction to use from the reference for neighbor finding

	--reduction-model=REDUCTION-MODEL
		DimReduc object name that contains the umap model

	--transferdata-args=TRANSFERDATA-ARGS
		A named list of additional arguments to TransferData, written in R syntax .ie list( argument = 'value' )

	--integrated-embedding-args=INTEGRATED-EMBEDDING-ARGS
		A named list of additional arguments to IntegrateEmbeddings, written in R syntax .ie list( argument = 'value' )

	--project-umap-args=PROJECT-UMAP-ARGS
		A named list of additional arguments to ProjectUMAP, written in R syntax .ie list( argument = 'value' )

	-o OUTPUT-OBJECT-FILE, --output-object-file=OUTPUT-OBJECT-FILE
		FILE IN

	--output-format=OUTPUT-FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the anchors format to read.'

	-h, --help
		Show this help message and exit
```

## seurat-scripts_seurat-normalise-data.R

### Tool Description
Normalise the data of a Seurat object (Seurat NormalizeData).

### Metadata
- **Docker Image**: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/r-seurat-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/seurat-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/seurat-normalise-data.R [options]


Options:
	-i INPUT-OBJECT-FILE, --input-object-file=INPUT-OBJECT-FILE
		File name in which a serialized R matrix object may be found.

	--input-format=INPUT-FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the input format to read.

	--output-format=OUTPUT-FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the output format.

	-n NORMALIZATION-METHOD, --normalization-method=NORMALIZATION-METHOD
		Method for normalization. Default is log-normalization (LogNormalize). Can be 'CLR' or 'RC' additionally.

	-s SCALE-FACTOR, --scale-factor=SCALE-FACTOR
		Sets the scale factor for cell-level normalization.

	-o OUTPUT-OBJECT-FILE, --output-object-file=OUTPUT-OBJECT-FILE
		File name in which to store serialized R object of type 'Seurat'.'

	--margin=MARGIN
		If performing CLR normalization, normalize across features (1) or cells (2).

	--block-size=BLOCK-SIZE
		How many cells should be run in each chunk, will try to split evenly across threads

	-h, --help
		Show this help message and exit
```

## seurat-scripts_seurat-plot.R

### Tool Description
Make a Seurat plot (FeaturePlot, RidgePlot, DimPlot, VlnPlot or DotPlot) and save it to a file.

### Metadata
- **Docker Image**: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/r-seurat-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/seurat-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Warning messages:
1: In storage.mode(default) <- type : NAs introduced by coercion
2: In storage.mode(default) <- type : NAs introduced by coercion
Usage: /usr/local/bin/seurat-plot.R [options]


Options:
	-i INPUT FILE, --input-object-file=INPUT FILE
		Query file with Seurat object in either RDS-Seurat, Loom or SCE

	--input-format=INPUT FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the input format to read.

	--plot-type=PLOT-TYPE
		Either FeaturePlot, RidgePlot, DimPlot, VlnPlot or DotPlot.

	--dims=DIMS
		Dimensions to plot, must be a two-length numeric vector specifying x- and y-dimensions

	--cells=CELLS
		Vector of cells to plot (default is all cells)

	--cols=COLS
		Vector of colors, each color corresponds to an identity class. This may also be a single character or numeric value corresponding to a palette as specified by brewer.pal.info. By default, ggplot2 assigns colors. We also include a number of palettes from the pals package. See 'DiscretePalette' for details.

	--pt-size=PT-SIZE
		Adjust point size for plotting

	--reduction=REDUCTION
		Which dimensionality reduction to use. If not specified, first searches for umap, then tsne, then pca

	--group-by=GROUP-BY
		Name of one or more metadata columns to group (color) cells by (for example, orig.ident); pass 'ident' to group by identity class

	--split-by=SPLIT-BY
		Name of a metadata column to split plot by; see 'FetchData' for more details

	--shape-by=SHAPE-BY
		If NULL, all points are circles (default). You can specify any cell attribute (that can be pulled with FetchData) allowing for both different colors and different shapes on cells.  Only applicable if raster is FALSE.

	--order=ORDER
		Specify the order of plotting for the idents. This can be useful for crowded plots if points of interest are being buried. Provide either a full list of valid idents or a subset to be plotted last (on top)

	--shuffle
		Whether to randomly shuffle the order of points. This can be useful for crowded plots if points of interest are being buried. (default is FALSE)

	--seed=SEED
		Sets the seed if randomly shuffling the order of points.

	--label
		Whether to label the clusters

	--label-size=LABEL-SIZE
		Sets size of labels

	--label-color=LABEL-COLOR
		Sets the color of the label text

	--label-box
		Whether to put a box around the label text (geom_text vs geom_label)

	--repel
		Repel labels

	--cells-highlight=CELLS-HIGHLIGHT
		A list of character or numeric vectors of cells to highlight. If only one group of cells desired, can simply pass a vector instead of a list. If set, colors selected cells to the color(s) in  'cols.highlight'  and other cells black (white if dark.theme = TRUE); will also resize to the size(s) passed to 'sizes.highlight'.

	--cols-highlight=COLS-HIGHLIGHT
		A vector of colors to highlight the cells as; will repeat to the length groups in cells.highlight. Comma separated.

	--sizes-highlight=SIZES-HIGHLIGHT
		Size of highlighted cells; will repeat to the length groups in cells.highlight

	--na-value=NA-VALUE
		Color value for NA points when using custom scale

	--ncol=NCOL
		Number of columns for display when combining plots

	--features=FEATURES
		A vector of features to plot, defaults to VariableFeatures of the object.

	--do-not-group-bar
		Add a color bar showing group status for cells

	--group-colors=GROUP-COLORS
		Colors to use for the color bar, comma separated.

	--disp-min=DISP-MIN
		Minimum display value (all values below are clipped)

	--disp-max=DISP-MAX
		Maximum display value (all values above are clipped); defaults to 2.5 if slot is 'scale.data', 6 otherwise

	--slot=SLOT
		Data slot to use, choose from raw.data, data, or scale.data

	--assay=ASSAY
		Assay to pull from

	--do-not-label
		Label the cell identies above the color bar

	--size=SIZE
		Size of text above color bar

	--hjust=HJUST
		Horizontal justification of text above color bar

	--angle=ANGLE
		Angle of text above color bar

	--do-not-raster
		If true, plot with geom_raster, else use geom_tile. geom_raster may look blurry on some viewing applications such as Preview due to how the raster is interpolated. Set this to FALSE if you are encountering that issue (note that plots may take longer to produce/render).

	--do-not-draw-lines
		Include white lines to separate the groups

	--lines-width=LINES-WIDTH
		Integer number to adjust the width of the separating white lines. Corresponds to the number of cells between each group.

	--group-bar-height=GROUP-BAR-HEIGHT
		Scale the height of the color bar

	--do-not-combine
		Combine plots into a single patchwork or ed ggplot object. If FALSE return a list of ggplot objects.

	--cols-ridgeplot=COLS-RIDGEPLOT
		Colors to use for plotting, comma separated

	--idents=IDENTS
		Which classes to include in the plot (default is all)

	--sort
		Sort identity classes (on the x-axis) by the average expression of the attribute being potted, can also pass 'increasing' or 'decreasing' to change sort direction

	--y-max=Y-MAX
		Maximum y axis value

	--same-y-lims
		Set all the y-axis limits to the same values

	--log
		plot the feature axis on log scale

	--stack
		Horizontally stack plots for each feature

	--fill-by=FILL-BY
		Color violins/ridges based on either 'feature' or 'ident'

	--cols-feature-plot=COLS-FEATURE-PLOT
		The two colors to form the gradient over. Provide as string vector with the first color corresponding to low values, the second to high. Also accepts a Brewer color scale or vector of colors.

	--min-cutoff=MIN-CUTOFF
		Vector of minimum cutoff values for each feature, may specify quantile in the form of 'q##' where '##' is the quantile (eg, 'q1', 'q10')

	--max-cutoff=MAX-CUTOFF
		Vector of maximum cutoff values for each feature, may specify quantile in the form of 'q##' where '##' is the quantile (eg, 'q1', 'q10')

	--keep-scale=KEEP-SCALE
		How to handle the color scale across multiple plots.

	--blend
		Scale and blend expression values to visualize coexpression of two features

	--blend-threshold=BLEND-THRESHOLD
		The color cutoff from weak signal to strong signal; ranges from 0 to 1.

	--coord-fixed
		Plot cartesian coordinates with fixed aspect ratio

	--do-not-by-col
		If splitting by a factor, plot the splits per column with the features as rows; ignored if blend = TRUE.

	--adjust=ADJUST
		Adjust parameter for geom_violin

	--split-plot
		plot each group of the split violin plots by multiple or single violin shapes.

	--flip
		flip plot orientation (identities on x-axis)

	--cols-dot-plot=COLS-DOT-PLOT
		Colors to plot: the name of a palette from RColorBrewer::brewer.pal.info , a pair of colors defining a gradient, or 3+ colors defining multiple gradients (if split.by is set)

	--col-min=COL-MIN
		Minimum scaled average expression threshold (everything smaller will be set to this)

	--col-max=COL-MAX
		Maximum scaled average expression threshold (everything larger will be set to this)

	--dot-min=DOT-MIN
		The fraction of cells at which to draw the smallest dot (default is 0). All cell groups with less than this expressing the given gene will have no dot drawn.

	--dot-scale=DOT-SCALE
		Scale the size of the points, similar to cex

	--cluster-idents
		Whether to order identities by hierarchical clusters based on given features, default is FALSE

	--do-not-scale
		Determine whether the data is scaled, will be done by default

	--scale-by=SCALE-BY
		Scale the size of the points by 'size' or by 'radius'

	--scale-min=SCALE-MIN
		Set lower limit for scaling, use NA for default

	--scale-max=SCALE-MAX
		Set upper limit for scaling, use NA for default

	--output-rds-file=OUTPUT-RDS-FILE
		Path to RDS to keep the plot object

	--plot-out=PLOT-OUT
		File name to create on disk.

	--plot-format=PLOT-FORMAT
		Format to use, either PNG, EPS, PostScript, TeX, PDF, JPEG, TIFF or SVG

	--scale-factor=SCALE-FACTOR
		Multiplicative scaling factor.

	--width=WIDTH
		Width of the figure, in the selected units.

	--height=HEIGHT
		Height of the figure, in the selected units.

	--units=UNITS
		Units for the plot dimensions.

	--dpi=DPI
		Plot resolution. Also accepts a string input: retina (320), print (300), or screen (72). Applies only to raster output types.

	--do-not-limitsize
		When TRUE (the default) ggsave() will not save images larger than 50x50 inches, to prevent the common error of specifying dimensions in pixels.

	--bg=BG
		Background colour. If NULL, uses the plot.background fill value from the plot theme.

	-h, --help
		Show this help message and exit
```

## seurat-scripts_seurat-read-10x.R

### Tool Description
Read 10x or tab-separated expression data into a Seurat object (Seurat Read10X and CreateSeuratObject).

### Metadata
- **Docker Image**: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/r-seurat-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/seurat-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/seurat-read-10x.R [options]


Options:
	-f DATA-FILE, --data-file=DATA-FILE
		A tab-separated file containing expression data.

	-d DATA-DIR, --data-dir=DATA-DIR
		Directory containing the matrix.mtx, genes.tsv, and barcodes.tsv files matching 10X conventions (overrides --data-file).

	-o OUTPUT-OBJECT-FILE, --output-object-file=OUTPUT-OBJECT-FILE
		File name in which to store serialized R matrix object.

	--output-format=OUTPUT-FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the output format.

	--metadata=METADATA
		Path to a file with metdata for the cells, first column should be cell identifiers as used in the cells 10x file.

	--min-cells=MIN-CELLS
		Include features detected in at least this many cells. Will subset the counts matrix as well. To reintroduce excluded features, create a new object with a lower cutoff.

	--min-features=MIN-FEATURES
		Include cells where at least this many features are detected.

	--gene-column=GENE NAME COLUMN
		Specify which column of genes.tsv or features.tsv to use for gene names; default is 2.

	--not-unique-features
		Do not make feature names unique (default FALSE - make them unique).

	--project=SETS THE PROJECT NAME FOR THE SEURAT OBJECT.
		Sets the project name for the Seurat object.

	--names-field=INDEX FOR FIELD WITH CELLS NAME
		For the initial identity class for each cell, choose this field for the cell's name. E.g. If your cells are named as BARCODE_CLUSTER_CELLTYPE in the input matrix, set names.field to 3 to set the initial identities to CELLTYPE.

	--names-delim=DELIMITER FIELD WITHIN CELLS NAME
		For the initial identity class for each cell, choose this delimiter from the cell's column name. E.g. If your cells are named as BARCODE-CLUSTER-CELLTYPE, set this to '-' to separate the cell name into its component parts for picking the relevant field.

	-h, --help
		Show this help message and exit
```

## seurat-scripts_seurat-run-pca.R

### Tool Description
Run principal component analysis on a Seurat object (Seurat RunPCA).

### Metadata
- **Docker Image**: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/r-seurat-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/seurat-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/seurat-run-pca.R [options]


Options:
	-i INPUT-OBJECT-FILE, --input-object-file=INPUT-OBJECT-FILE
		File name in which a serialized R matrix object may be found.

	--input-format=INPUT-FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the input format to read.

	--output-format=OUTPUT-FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the output format.

	-e PC-GENES, --pc-genes=PC-GENES
		File with gene names to scale/center. Default is all genes in object@data.

	-c PC-CELLS, --pc-cells=PC-CELLS
		File with cell names to scale/center. Default is all cells in object@data.

	-p PCS-COMPUTE, --pcs-compute=PCS-COMPUTE
		Total Number of PCs to compute and store (50 by default).

	-r, --reverse-pca
		By default computes the PCA on the cell x gene matrix. Setting to true will compute it on gene x cell matrix.

	-o OUTPUT-OBJECT-FILE, --output-object-file=OUTPUT-OBJECT-FILE
		File name in which to store serialized R object of type 'Seurat'.'

	-b OUTPUT-EMBEDDINGS-FILE, --output-embeddings-file=OUTPUT-EMBEDDINGS-FILE
		File name in which to store a csv-format embeddings table with PCs by cell.

	-l OUTPUT-LOADINGS-FILE, --output-loadings-file=OUTPUT-LOADINGS-FILE
		File name in which to store a csv-format loadings table with PCs by gene.

	-s OUTPUT-STDEV-FILE, --output-stdev-file=OUTPUT-STDEV-FILE
		File name in which to store PC stdev values (one per line).

	--no-weight-by-var
		Do not weight the cell embeddings by the variance of each PC (weights the gene loadings if rev.pca is TRUE)

	--ndims-print=NUM OF DIMS. PRINT
		PCs to print genes for

	--nfeatures-print=N FEATURES PRINT
		Number of genes to print for each PC

	--reduction-key=REDUCTION KEY
		dimensional reduction key, specifies the string before the number for the dimension names. PC by default

	--reduction-name=REDUCTION NAME
		dimensional reduction name, pca by default

	-h, --help
		Show this help message and exit
```

## seurat-scripts_seurat-run-tsne.R

### Tool Description
Run t-SNE on a Seurat object (Seurat RunTSNE).

### Metadata
- **Docker Image**: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/r-seurat-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/seurat-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/seurat-run-tsne.R [options]


Options:
	-i INPUT-OBJECT-FILE, --input-object-file=INPUT-OBJECT-FILE
		File name in which a serialized R matrix object may be found.

	--input-format=INPUT-FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the input format to read.

	--output-format=OUTPUT-FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the output format.

	-r REDUCTION-USE, --reduction-use=REDUCTION-USE
		Which dimensional reduction (e.g. PCA, ICA) to use for the tSNE. Default is PCA.

	--tsne-method=TSNE-METHOD
		Select the method to use to compute the tSNE. Available methods are: Rtsne, Flt-SNE

	--perplexity=PERPLEXITY
		Perplexity value for tSNE, if none is set, the default from seurat (30) is used.

	-c CELLS-USE, --cells-use=CELLS-USE
		File to be used to derive a vector of which cells to analyze (default, all cells).

	--dim_embed=DIM_EMBED
		The dimensional space of the resulting tSNE embedding (default is 2). For example, set to 3 for a 3d tSNE

	-d DIMS-USE, --dims-use=DIMS-USE
		A comma-separated list of the which dimensions to use as input features.

	-e GENES-USE, --genes-use=GENES-USE
		File to be used to derive a vector of gene names. If set, run the tSNE on this subset of genes (instead of running on a set of reduced dimensions). Not set (NULL) by default.

	-o OUTPUT-OBJECT-FILE, --output-object-file=OUTPUT-OBJECT-FILE
		File name in which to store serialized R object of type 'Seurat'.'

	-b OUTPUT-EMBEDDINGS-FILE, --output-embeddings-file=OUTPUT-EMBEDDINGS-FILE
		File name in which to store a csv-format embeddings table with PCs by cell.

	--random-seed=RANDOM-SEED
		Seed of the random number generator

	--add-iter
		If an existing tSNE has already been computed, uses the current tSNE to seed the algorithm and then adds additional iterations on top of this

	--reduction-key=REDUCTIO KEY
		dimensional reduction key, specifies the string before the number for the dimension names. tSNE_ by default

	--reduction-name=REDUCTION NAME
		dimensional reduction name, specifies the position in the object$dr list. tsne by default

	-h, --help
		Show this help message and exit
```

## seurat-scripts_seurat-scale-data.R

### Tool Description
Scale and centre the data of a Seurat object (Seurat ScaleData).

### Metadata
- **Docker Image**: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/r-seurat-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/seurat-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/seurat-scale-data.R [options]


Options:
	-i INPUT-OBJECT-FILE, --input-object-file=INPUT-OBJECT-FILE
		File name in which a serialized R matrix object may be found.

	--input-format=INPUT-FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the input format to read.

	--output-format=OUTPUT-FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the output format.

	-e GENES-USE, --genes-use=GENES-USE
		File with gene names to scale/center (one gene per line). Default is all genes in object@data.

	-v VARS-TO-REGRESS, --vars-to-regress=VARS-TO-REGRESS
		Comma-separated list of variables to regress out (previously latent.vars in RegressOut). For example, nUMI, or percent.mito.

	-m MODEL-USE, --model-use=MODEL-USE
		Use a linear model or generalized linear model (poisson, negative binomial) for the regression. Options are 'linear' (default), 'poisson', and 'negbinom'.

	-u USE-UMI, --use-umi=USE-UMI
		Regress on UMI count data. Default is FALSE for linear modeling, but automatically set to TRUE if model.use is 'negbinom' or 'poisson'.

	-s, --do-not-scale
		Skip the data scale.

	-c, --do-not-center
		Skip data centering.

	-x SCALE-MAX, --scale-max=SCALE-MAX
		Max value to return for scaled data. The default is 10. Setting this can help reduce the effects of genes that are only expressed in a very small number of cells. If regressing out latent variables and using a non-linear model, the default is 50.

	-b BLOCK-SIZE, --block-size=BLOCK-SIZE
		Default size for number of genes to scale at in a single computation. Increasing block.size may speed up calculations but at an additional memory cost.

	-d MIN-CELLS-TO-BLOCK, --min-cells-to-block=MIN-CELLS-TO-BLOCK
		If object contains fewer than this number of cells, don't block for scaling calculations.

	-n CHECK-FOR-NORM, --check-for-norm=CHECK-FOR-NORM
		Check to see if data has been normalized, if not, output a warning (TRUE by default).

	-o OUTPUT-OBJECT-FILE, --output-object-file=OUTPUT-OBJECT-FILE
		File name in which to store serialized R object of type 'Seurat'.'

	-h, --help
		Show this help message and exit
```

## seurat-scripts_seurat-select-integration-features.R

### Tool Description
Select features that are variable across several Seurat objects (Seurat SelectIntegrationFeatures).

### Metadata
- **Docker Image**: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/r-seurat-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/seurat-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/seurat-select-integration-features.R [options]


Options:
	-i INPUT FILES, --input-object-files=INPUT FILES
		A list of Seurat objects between which to find anchors for downstream integration. Input files in either RDS-Seurat, Loom or SCE, comma separated.

	--input-format=INPUT FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the input format to read.

	--nfeatures=NUMBER OF FEATURES
		Number of features to return

	--assay-list=ASSAY-LIST
		Name or vector of assay names (one for each object) from which to pull the variable features.

	--do-not-verbose
		Print messages

	--fvf-nfeatures=FVF-NFEATURES
		nfeatures for FindVariableFeatures. Used if VariableFeatures have not been set for any object in input.

	--file-out=RDATA FILE WITH FEATURES
		FILE IN

	-h, --help
		Show this help message and exit
```

## seurat-scripts_seurat-split-object.R

### Tool Description
Split a Seurat object into several objects by a metadata field (Seurat SplitObject).

### Metadata
- **Docker Image**: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/r-seurat-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/seurat-scripts/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: /usr/local/bin/seurat-split-object.R [options]


Options:
	-i INPUT-OBJECT, --input-object=INPUT-OBJECT
		RDS/Loom/SCE serialised object with content to split.

	-m METADATA-RDS, --metadata-rds=METADATA-RDS
		Optional RDS with metadata.

	--input-format=INPUT-FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the input format to read.

	--output-format=OUTPUT-FORMAT
		Either loom, seurat, anndata or singlecellexperiment for the output format.

	-o OUTPUT-PATH, --output-path=OUTPUT-PATH
		Output path, where split files will be left

	--split-by=SPLIT-BY
		Field to split data by. Required.

	-h, --help
		Show this help message and exit
```

## Metadata
- **Skill**: generated

## seurat-scripts_seurat-run-umap.R

### Tool Description
Run UMAP (Uniform Manifold Approximation and Projection) on a Seurat object. Note: The provided input text was a container build error log; arguments below are derived from standard seurat-scripts documentation for this tool.

### Metadata
- **Docker Image**: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
- **Homepage**: https://github.com/ebi-gene-expression-group/r-seurat-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/seurat-scripts/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0 uri: while building SIF from layers: packer failed to pack: while unpacking rootfs: while unpacking layer sha256:58155126c75d3dd19aaeccc9bd758e1d9c86a8e2e9a5f7ce2a48beeb7de9b173: unpack entry: usr/local/bin/pandoc: unpack to regular file: short write: write /tmp/build-temp-1751262533/rootfs/usr/local/bin/pandoc: no space left on device
```

