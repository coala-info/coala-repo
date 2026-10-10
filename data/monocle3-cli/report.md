# monocle3-cli CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| monocle3-cli_create | PASS |  |
| monocle3-cli_diffExp | PASS |  |
| monocle3-cli_learnGraph | PASS |  |
| monocle3-cli_orderCells | PASS |  |
| monocle3-cli_partition | PASS | default resolution gave one cluster on this data; run with --resolution 0.001 gave 3 clusters |
| monocle3-cli_plotCells | PASS |  |
| monocle3-cli_preprocess | PASS |  |
| monocle3-cli_reduceDim | PASS |  |
| monocle3-cli_topMarkers | PASS |  |

## monocle3-cli_create

### Tool Description
Creation of Monocle 3 object from expression and metadata.

### Metadata
- **Docker Image**: quay.io/biocontainers/monocle3-cli:0.0.9--r36_1
- **Homepage**: https://github.com/ebi-gene-expression-group/monocle-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/monocle3-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: monocle3 create [options] <output_object>

<output_object>:
		Output object, can be SingleCellExperiment(sce), Seurat object(seurat), or CellDataSet V3(cds3). Only cds3 is supported currently.

Options:
	-F STR, --output-object-format=STR
		Format of output object. [Default: cds3]

	-I, --introspective
		Print introspective information of the output object.

	--expression-matrix=STR
		Expression matrix, genes as rows, cells as columns. Required input.  Provide as TSV, CSV, RDS or MTX. In the case of MTX, requires both --cell-metadata and --gene-annotation.

	--cell-metadata=STR
		Per-cell annotation, optional unless expression as MTX. Row names must match the column names of the expression matrix. Provide as TSV, CSV or RDS.

	--gene-annotation=STR
		Per-gene annotation, optional unless expression as MTX. Row names must match the row names of the expression matrix. Provide as TSV, CSV or RDS.

	-v, --verbose
		Emit verbose output.

	-h, --help
		Show this help message and exit
```

## monocle3-cli_preprocess

### Tool Description
Normalisation, scaling, initial dimension reduction.

### Metadata
- **Docker Image**: quay.io/biocontainers/monocle3-cli:0.0.9--r36_1
- **Homepage**: https://github.com/ebi-gene-expression-group/monocle-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/monocle3-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: monocle3 preprocess [options] <input_object> <output_object>

<input_object>:
		Input object, can be SingleCellExperiment(sce), Seurat object(seurat), CellDataSet V2(cds2) or V3(cds3). Only cds3 is supported currently. 

<output_object>:
		Output object, can be SingleCellExperiment(sce), Seurat object(seurat), or CellDataSet V3(cds3). Only cds3 is supported currently.

Options:
	-f STR, --input-object-format=STR
		Format of input object. [Default: cds3]

	-F STR, --output-object-format=STR
		Format of output object. [Default: cds3]

	-I, --introspective
		Print introspective information of the output object.

	--method=STR
		The initial dimension method to use, choose from {PCA, LSI}. [Default: PCA]

	--num-dim=INT
		The dimensionality of the reduced space. [Default: 50]

	--norm-method=STR
		Determines how to transform expression values prior to reducing dimensionality, choose from {log, size_only}. [Default: log]

	--use-genes=STR
		Manually subset the gene pool to these genes for dimensionality reduction, NULL to skip. [Default: NULL]

	--residual-model-formula-str=STR
		A string model formula specifying effects to subtract from the data, NULL to skip. [Default: NULL]

	--pseudo-count=FLOAT
		Amount to increase expression values before dimensionality reduction. [Default: 1]

	--no-scaling
		When this option is NOT set, scale each gene before running trajectory reconstruction.

	-v, --verbose
		Emit verbose output.

	-h, --help
		Show this help message and exit
```

## monocle3-cli_reduceDim

### Tool Description
Reduce dimensionality by UMAP.

### Metadata
- **Docker Image**: quay.io/biocontainers/monocle3-cli:0.0.9--r36_1
- **Homepage**: https://github.com/ebi-gene-expression-group/monocle-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/monocle3-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: monocle3 reduceDim [options] <input_object> <output_object>

<input_object>:
		Input object, can be SingleCellExperiment(sce), Seurat object(seurat), CellDataSet V2(cds2) or V3(cds3). Only cds3 is supported currently. 

<output_object>:
		Output object, can be SingleCellExperiment(sce), Seurat object(seurat), or CellDataSet V3(cds3). Only cds3 is supported currently.

Options:
	-f STR, --input-object-format=STR
		Format of input object. [Default: cds3]

	-F STR, --output-object-format=STR
		Format of output object. [Default: cds3]

	-I, --introspective
		Print introspective information of the output object.

	--max-components=INT
		The dimensionality of the reduced space. [Default 2]

	--reduction-method=STR
		The algorithm to use for dimensionality reduction, choose from {UMAP, tSNE, PCA, LSI}. [Default: UMAP]

	--preprocess-method=STR
		The preprocessing method used on the data, choose from {PCA, LSI}. [Default: PCA]

	--cores=CORES
		The number of cores to be used for dimensionality reduction. [Default: 1]

	-v, --verbose
		Emit verbose output.

	-h, --help
		Show this help message and exit
```

## monocle3-cli_partition

### Tool Description
Partition cells into groups.

### Metadata
- **Docker Image**: quay.io/biocontainers/monocle3-cli:0.0.9--r36_1
- **Homepage**: https://github.com/ebi-gene-expression-group/monocle-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/monocle3-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: monocle3 partition [options] <input_object> <output_object>

<input_object>:
		Input object, can be SingleCellExperiment(sce), Seurat object(seurat), CellDataSet V2(cds2) or V3(cds3). Only cds3 is supported currently. 

<output_object>:
		Output object, can be SingleCellExperiment(sce), Seurat object(seurat), or CellDataSet V3(cds3). Only cds3 is supported currently.

Options:
	-f STR, --input-object-format=STR
		Format of input object. [Default: cds3]

	-F STR, --output-object-format=STR
		Format of output object. [Default: cds3]

	-I, --introspective
		Print introspective information of the output object.

	--reduction-method=STR
		The dimensionality reduction to base the clustering on, choose from {UMAP, tSNE, PCA, LSI}. [Default: UMAP]

	--knn=INT
		Number of nearest neighbours used for Louvain clustering. [Default: 20]

	--weight
		When this option is set, calculate the weight for each edge in the kNN graph.

	--louvain-iter=INT
		The number of iteration for Louvain clustering. [Default: 1]

	--resolution=FLOAT
		Resolution of clustering result, specifying the granularity of clusters. Not used by default and the standard igraph louvain clustering algorithm will be used.

	--partition-qval=FLOAT
		The q-value threshold used to determine the partition of cells. [Default: 0.05]

	-v, --verbose
		Emit verbose output.

	-h, --help
		Show this help message and exit
```

## monocle3-cli_topMarkers

### Tool Description
Get top markers for each groups

### Metadata
- **Docker Image**: quay.io/biocontainers/monocle3-cli:0.0.9--r36_1
- **Homepage**: https://github.com/ebi-gene-expression-group/monocle-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/monocle3-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: monocle3 topMarkers [options] <input_object> <output_table>

<input_object>:
		Input object, can be SingleCellExperiment(sce), Seurat object(seurat), CellDataSet V2(cds2) or V3(cds3). Only cds3 is supported currently. 

<output_table>:
		Output table file name.

Options:
	-f STR, --input-object-format=STR
		Format of input object. [Default: cds3]

	-F STR, --output-table-format=STR
		Format of output table, choose from {tsv, csv}. [Default: tsv]

	-I, --introspective
		Print introspective information of the output table.

	--group-cells-by=GROUP-CELLS-BY
		Cell groups, choose from "cluster", "partition", or any categorical variable in `colData(cds)`}. [Default: cluster]

	--genes-to-test-per-group=GENES-TO-TEST-PER-GROUP
		Numeric, how many genes of the top ranked specific genes by Jenson-Shannon to do the more expensive regression test on. [Default: 25]

	--marker-sig-test
		A flag indicating whether to assess the discriminative power of each marker through logistic regression. Can be slow, consider disabling to speed up top_markers(). [Default: FALSE]

	--reference-cells=REFERENCE-CELLS
		If provided, top_markers will perform the marker significance test against a "reference set" of cells. Must be either a list of cell ids from colnames(cds) (comma separated), or a positive integer. If the latter, top_markers() will randomly select the specified number of reference cells. Accelerates the marker significance test at some cost in sensitivity.

	--cores=CORES
		The number of cores to be used for marker testing. [Default: 1]

	--filter-fraction-expression=FLOAT
		Filters the markers test result by this fraction of expression [Default: 0.1]

	--top-n-markers=TOP-N-MARKERS
		The number of top marker genes to report in plots and in top markers list. [Default: 5]

	--plot-top-markers=PLOT-TOP-MARKERS
		Save top marker by cell group plot to a file specified by this option.

	--save-full-markers=SAVE-FULL-MARKERS
		Save full marker table to a file specified by this option.

	-v, --verbose
		Emit verbose output.

	-h, --help
		Show this help message and exit
```

## monocle3-cli_learnGraph

### Tool Description
Learn trajectories.

### Metadata
- **Docker Image**: quay.io/biocontainers/monocle3-cli:0.0.9--r36_1
- **Homepage**: https://github.com/ebi-gene-expression-group/monocle-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/monocle3-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: monocle3 learnGraph [options] <input_object> <output_object>

<input_object>:
		Input object, can be SingleCellExperiment(sce), Seurat object(seurat), CellDataSet V2(cds2) or V3(cds3). Only cds3 is supported currently. 

<output_object>:
		Output object, can be SingleCellExperiment(sce), Seurat object(seurat), or CellDataSet V3(cds3). Only cds3 is supported currently.

Options:
	-f STR, --input-object-format=STR
		Format of input object. [Default: cds3]

	-F STR, --output-object-format=STR
		Format of output object. [Default: cds3]

	-I, --introspective
		Print introspective information of the output object.

	--no-partition
		When this option is set, learn a single tree structure for all the partitions. If not set, use the partitions calculated when clustering and identify disjoint graphs in each.

	--no-close-loop
		When this option is set, skip the additional run of loop closing after computing the principal graphs to identify potential loop structure in the data space.

	--euclidean-distance-ratio=FLOAT
		The maximal ratio between the euclidean distance of two tip nodes in the spanning tree inferred from SimplePPT algorithm and that of the maximum distance between any connecting points on the spanning tree allowed to be connected during the loop closure procedure. [Default: 1]

	--geodesic-distance-ratio=FLOAT
		The minimal ratio between the geodestic distance of two tip nodes in the spanning tree inferred from SimplePPT algorithm and that of the length of the diameter path on the spanning tree allowed to be connected during the loop closure procedure. (Both euclidean_distance_ratio and geodestic_distance_ratio need to be satisfied to introduce the edge for loop closure.)

	--no-prune-graph
		When this option is set, perform an additional run of graph pruning to remove smaller insignificant branches.

	--minimal-branch-len=INT
		The minimal length of the diameter path for a branch to be preserved during graph pruning procedure. [Default: 10]

	--orthogonal-proj-tip
		When this option is set, perform orthogonal projection for cells corresponding to the tip principal points.

	-v, --verbose
		Emit verbose output.

	-h, --help
		Show this help message and exit
```

## monocle3-cli_orderCells

### Tool Description
Adjust the start of pseudo-time

### Metadata
- **Docker Image**: quay.io/biocontainers/monocle3-cli:0.0.9--r36_1
- **Homepage**: https://github.com/ebi-gene-expression-group/monocle-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/monocle3-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: monocle3 orderCells [options] <input_object> <output_object>

<input_object>:
		Input object, can be SingleCellExperiment(sce), Seurat object(seurat), CellDataSet V2(cds2) or V3(cds3). Only cds3 is supported currently. 

<output_object>:
		Output object, can be SingleCellExperiment(sce), Seurat object(seurat), or CellDataSet V3(cds3). Only cds3 is supported currently.

Options:
	-f STR, --input-object-format=STR
		Format of input object. [Default: cds3]

	-F STR, --output-object-format=STR
		Format of output object. [Default: cds3]

	-I, --introspective
		Print introspective information of the output object.

	--root-pr-nodes=STR
		The starting principal points. We learn a principal graph that passes
		through the middle of the data points and use it to represent the
		developmental process. Exclusive with --root-cells.

	--root-cells=STR
		The starting cells. Each cell corresponds to a principal point and multiple cells can correspond to the same principal point. Exclusive with --root-pr-nodes.

	--cell-phenotype=STR
		The cell phenotype (column in pdata) used to identify root principal nodes.

	--root-type=STR
		The value of the phenotype specified by "--cell-pheontype" that defines cells root principal nodes.

	--reduction-method=STR
		The dimensionality reduction that was used for clustering, choose from {UMAP, tSNE, PCA, LSI}. [Default: UMAP]

	-v, --verbose
		Emit verbose output.

	-h, --help
		Show this help message and exit
```

## monocle3-cli_diffExp

### Tool Description
Identify genes with varing expression along trajectories.

### Metadata
- **Docker Image**: quay.io/biocontainers/monocle3-cli:0.0.9--r36_1
- **Homepage**: https://github.com/ebi-gene-expression-group/monocle-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/monocle3-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: monocle3 diffExp [options] <input_object> <output_table>

<input_object>:
		Input object, can be SingleCellExperiment(sce), Seurat object(seurat), CellDataSet V2(cds2) or V3(cds3). Only cds3 is supported currently. 

<output_table>:
		Output table file name.

Options:
	-f STR, --input-object-format=STR
		Format of input object. [Default: cds3]

	-F STR, --output-table-format=STR
		Format of output table, choose from {tsv, csv}. [Default: tsv]

	-I, --introspective
		Print introspective information of the output table.

	--neighbor-graph=STR
		What neighbor graph to use, "principal_graph" recommended for trajectory analysis, choose from {principal_graph, knn}. [Default: knn]

	--reduction-method=STR
		The dimensionality reduction to base the clustering on, choose from {UMAP}. [Default: UMAP]

	--knn=KNN
		Number of nearest neighbors used for building the kNN graph which is passed to knn2nb function during the Moran's I (Geary's C) test procedure.

	--method=METHOD
		A character string specifying the method for detecting significant genes showing correlated expression along the principal graph embedded in the low dimensional space, choose from {Moran_I}. [Default: Moran_I]

	--alternative=ALTERNATIVE
		A character string specifying the alternative hypothesis, choose from {greater, less, two.sided}. [Default: greater]

	--cores=CORES
		The number of cores to be used while testing each gene for differential expression. [Default: 1]

	-v, --verbose
		Emit verbose output.

	-h, --help
		Show this help message and exit
```

## monocle3-cli_plotCells

### Tool Description
Visualise trajectories.

### Metadata
- **Docker Image**: quay.io/biocontainers/monocle3-cli:0.0.9--r36_1
- **Homepage**: https://github.com/ebi-gene-expression-group/monocle-scripts
- **Package**: https://anaconda.org/channels/bioconda/packages/monocle3-cli/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: monocle3 plotCells [options] <input_object> <output_plot>

<input_object>:
		Input object, can be SingleCellExperiment(sce), Seurat object(seurat), CellDataSet V2(cds2) or V3(cds3). Only cds3 is supported currently. 

<output_plot>:
		Output plot file name.

Options:
	-f STR, --input-object-format=STR
		Format of input object. [Default: cds3]

	-F STR, --output-plot-format=STR
		Format of output plot, choose from {png, pdf}. [Default: png]

	--xdim=XDIM
		The column of reducedDimS(cds) to plot on the horizontal axis. [Default: 1]

	--ydim=YDIM
		The column of reducedDimS(cds) to plot on the vertical axis. [Default: 2]

	--reduction-method=STR
		The dimensionality reduction for plotting, choose from {UMAP, tSNE, PCA, LSI}. [Default: UMAP]

	--color-cells-by=COLOR-CELLS-BY
		The cell attribute (e.g. the column of pData(cds)) to map to each cell's color, or one of {clusters, partitions, pseudotime}. [Default: pseudotime]

	--genes=STR
		A comma-separated list of gene IDs/short names to plot, one per panel.

	--norm-method=STR
		Determines how to transform expression values for plotting, choose from {log, size_only}. [Default: log]

	--cell-size=CELL-SIZE
		The size of the point for each cell. [Default: 1.5]

	--alpha=ALPHA
		The alpha aesthetics for the original cell points, useful to highlight the learned principal graph.

	--label-cell-groups
		If set, display the cell group names directly on the plot. Otherwise include a color legend on the side of the plot.

	--no-trajectory-graph
		When this option is set, skip displaying the trajectory graph inferred by learn_graph().

	--label-groups-by-cluster
		If set, and setting --color-cells-by to something other than cluster, label the cells of each cluster independently. Can result in duplicate labels being present in the manifold.

	--label-leaves
		If set, label the leaves of the principal graph.

	--label-roots
		If set, label the roots of the principal graph.

	--label-branch-points
		If set, label the branch points of the principal graph.

	-v, --verbose
		Emit verbose output.

	-h, --help
		Show this help message and exit
```

