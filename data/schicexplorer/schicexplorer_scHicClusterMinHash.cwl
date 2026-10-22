cwlVersion: v1.2
class: CommandLineTool
baseCommand: scHicClusterMinHash
label: schicexplorer_scHicClusterMinHash
doc: "scHicClusterMinHash uses kmeans, spectral, agglomerative (ward, complete, average or single) or birch clustering to associate each cell to a cluster. The clustering is applied on dimension reduced data based on an approximate kNN search with the local sensitive hashing technique MinHash.\n\nTool homepage: https://github.com/joachimwolff/scHiCExplorer"
inputs:
  - id: matrix
    type: File
    doc: "The single cell Hi-C interaction matrices to cluster. Needs to be in scool format"
    inputBinding:
      position: 101
      prefix: --matrix
  - id: number_of_clusters
    type:
      - 'null'
      - int
    doc: "Number of to be computed clusters (default: 12)"
    inputBinding:
      position: 101
      prefix: --numberOfClusters
  - id: cluster_method
    type:
      - 'null'
      - string
    doc: "Algorithm to cluster the Hi-C matrices (spectral, kmeans, agglomerative_ward, agglomerative_complete, agglomerative_average, agglomerative_single, birch; default: spectral)"
    inputBinding:
      position: 101
      prefix: --clusterMethod
  - id: euclidean_mode_min_hash
    type:
      - 'null'
      - boolean
    doc: "This option uses the number of hash collisions only for a candidate set selection and computes on them the euclidean distance."
    inputBinding:
      position: 101
      prefix: --euclideanModeMinHash
  - id: intra_chromosomal_contacts_only
    type:
      - 'null'
      - boolean
    doc: "This option loads only the intra-chromosomal contacts. Can improve the cluster result if data is very noisy."
    inputBinding:
      position: 101
      prefix: --intraChromosomalContactsOnly
  - id: save_intermediate_raw_matrix_path
    type:
      - 'null'
      - string
    doc: "This option activates the save of the intermediate raw scHi-C matrix."
    inputBinding:
      position: 102
      prefix: --saveIntermediateRawMatrix
  - id: create_scatter_plot_path
    type:
      - 'null'
      - string
    doc: "Create a scatter plot for the clustering, the x and y are the first and second principal component of the computed k-nn graph. (default: scatterPlot.eps)"
    inputBinding:
      position: 102
      prefix: --createScatterPlot
  - id: dpi
    type:
      - 'null'
      - int
    doc: "The dpi of the scatter plot. (default: 300)"
    inputBinding:
      position: 101
      prefix: --dpi
  - id: number_of_hash_functions
    type:
      - 'null'
      - int
    doc: "Number of to be used hash functions for minHash (default: 4000)"
    inputBinding:
      position: 101
      prefix: --numberOfHashFunctions
  - id: number_of_nearest_neighbors
    type:
      - 'null'
      - int
    doc: "Number of to be used computed nearest neighbors for the knn graph."
    inputBinding:
      position: 101
      prefix: --numberOfNearestNeighbors
  - id: share_of_matrix_to_be_transferred
    type:
      - 'null'
      - float
    doc: "Which share of rows shall be transferred from Python to C++ at once. Values between 0 and 1. (default: 0.25)"
    inputBinding:
      position: 101
      prefix: --shareOfMatrixToBeTransferred
  - id: save_memory
    type:
      - 'null'
      - boolean
    doc: "Load data only with one core, this method saves memory but is significantly slower."
    inputBinding:
      position: 101
      prefix: --saveMemory
  - id: cell_coloring_type
    type:
      - 'null'
      - File
    doc: "A two column list, first colum the cell names as stored in the scool file, second column the associated coloring for the scatter plot"
    inputBinding:
      position: 101
      prefix: --cell_coloring_type
  - id: cell_coloring_batch
    type:
      - 'null'
      - File
    doc: "A two column list, first colum the cell names as stored in the scool file, second column the associated coloring for the scatter plot"
    inputBinding:
      position: 101
      prefix: --cell_coloring_batch
  - id: no_pca
    type:
      - 'null'
      - boolean
    doc: "Do not computes PCA on top of a k-nn."
    inputBinding:
      position: 101
      prefix: --noPCA
  - id: no_umap
    type:
      - 'null'
      - boolean
    doc: "Do not computes UMAP on top of a k-nn/PCA."
    inputBinding:
      position: 101
      prefix: --noUMAP
  - id: dimensions_pca
    type:
      - 'null'
      - int
    doc: "The number of dimensions from the PCA matrix that should be considered for clustering. (default: 100)"
    inputBinding:
      position: 101
      prefix: --dimensionsPCA
  - id: color_map
    type:
      - 'null'
      - string
    doc: "Color map to use for the heatmap, supported are the categorical colormaps from holoviews. (default: glasbey_dark)"
    inputBinding:
      position: 101
      prefix: --colorMap
  - id: fontsize
    type:
      - 'null'
      - int
    doc: "Fontsize in the plot for x and y axis. (default: 15)"
    inputBinding:
      position: 101
      prefix: --fontsize
  - id: distance
    type:
      - 'null'
      - int
    doc: "Contact distance to consider"
    inputBinding:
      position: 101
      prefix: --distance
  - id: figuresize
    type:
      - 'null'
      - type: array
        items: float
    doc: "Size of the figure: x-size y-size (default: 15 6)"
    inputBinding:
      position: 101
      prefix: --figuresize
  - id: chromosomes
    type:
      - 'null'
      - type: array
        items: string
    doc: "List of to be computed chromosomes"
    inputBinding:
      position: 101
      prefix: --chromosomes
  - id: absolute_values
    type:
      - 'null'
      - string
    doc: "Return the number of hash collisions as measure instead of 0 - 1 normalized values."
    inputBinding:
      position: 101
      prefix: --absoluteValues
  - id: latex_table_path
    type:
      - 'null'
      - string
    doc: "Return the overlap statistics if --cell_coloring_type is given as a latex table."
    inputBinding:
      position: 102
      prefix: --latexTable
  - id: run_in_hyperopt_mode
    type:
      - 'null'
      - boolean
    doc: "Compute the correct associated average of the given clusters to"
    inputBinding:
      position: 101
      prefix: --runInHyperoptMode
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads. Using the python multiprocessing module."
    inputBinding:
      position: 101
      prefix: --threads
  - id: umap_n_neighbors
    type:
      - 'null'
      - int
    doc: "Number of neighbors (default: 30)"
    inputBinding:
      position: 101
      prefix: --umap_n_neighbors
  - id: umap_n_components
    type:
      - 'null'
      - int
    doc: "Number of components (default: 2)"
    inputBinding:
      position: 101
      prefix: --umap_n_components
  - id: umap_metric
    type:
      - 'null'
      - string
    doc: "Metric of umap. (default: canberra)"
    inputBinding:
      position: 101
      prefix: --umap_metric
  - id: umap_n_epochs
    type:
      - 'null'
      - int
    doc: "Number of epochs"
    inputBinding:
      position: 101
      prefix: --umap_n_epochs
  - id: umap_learning_rate
    type:
      - 'null'
      - float
    doc: "Learning rate (default: 1.0)"
    inputBinding:
      position: 101
      prefix: --umap_learning_rate
  - id: umap_init
    type:
      - 'null'
      - string
    doc: "Initialization method (default: spectral)"
    inputBinding:
      position: 101
      prefix: --umap_init
  - id: umap_min_dist
    type:
      - 'null'
      - float
    doc: "Minimum distance of two neighbors (default: 0.3)"
    inputBinding:
      position: 101
      prefix: --umap_min_dist
  - id: umap_spread
    type:
      - 'null'
      - float
    doc: "Spread (default: 1.0)"
    inputBinding:
      position: 101
      prefix: --umap_spread
  - id: umap_set_op_mix_ratio
    type:
      - 'null'
      - float
    doc: "set_op_mix_ratio (default: 1.0)"
    inputBinding:
      position: 101
      prefix: --umap_set_op_mix_ratio
  - id: umap_local_connectivity
    type:
      - 'null'
      - float
    doc: "local connectivity (default: 1.0)"
    inputBinding:
      position: 101
      prefix: --umap_local_connectivity
  - id: umap_repulsion_strength
    type:
      - 'null'
      - float
    doc: "repulsion strength (default: 1.0)"
    inputBinding:
      position: 101
      prefix: --umap_repulsion_strength
  - id: umap_negative_sample_rate
    type:
      - 'null'
      - int
    doc: "negative sample rate (default: 5)"
    inputBinding:
      position: 101
      prefix: --umap_negative_sample_rate
  - id: umap_transform_queue_size
    type:
      - 'null'
      - float
    doc: "transform queue size (default: 4.0)"
    inputBinding:
      position: 101
      prefix: --umap_transform_queue_size
  - id: umap_a
    type:
      - 'null'
      - float
    doc: "a"
    inputBinding:
      position: 101
      prefix: --umap_a
  - id: umap_b
    type:
      - 'null'
      - float
    doc: "b"
    inputBinding:
      position: 101
      prefix: --umap_b
  - id: umap_angular_rp_forest
    type:
      - 'null'
      - boolean
    doc: "angular rp forest"
    inputBinding:
      position: 101
      prefix: --umap_angular_rp_forest
  - id: umap_target_n_neighbors
    type:
      - 'null'
      - int
    doc: "target number of neighbors (default: -1)"
    inputBinding:
      position: 101
      prefix: --umap_target_n_neighbors
  - id: umap_target_metric
    type:
      - 'null'
      - string
    doc: "target metric (default: categorical)"
    inputBinding:
      position: 101
      prefix: --umap_target_metric
  - id: umap_target_weight
    type:
      - 'null'
      - float
    doc: "target weight (default: 0.5)"
    inputBinding:
      position: 101
      prefix: --umap_target_weight
  - id: umap_force_approximation_algorithm
    type:
      - 'null'
      - boolean
    doc: "force approximation algorithm"
    inputBinding:
      position: 101
      prefix: --umap_force_approximation_algorithm
  - id: umap_verbose
    type:
      - 'null'
      - boolean
    doc: "verbose"
    inputBinding:
      position: 101
      prefix: --umap_verbose
  - id: umap_unique
    type:
      - 'null'
      - boolean
    doc: "umap unique"
    inputBinding:
      position: 101
      prefix: --umap_unique
  - id: out_file_name_path
    type: string
    doc: "File name to save the resulting clusters"
    inputBinding:
      position: 102
      prefix: --outFileName
outputs:
  - id: out_file_name
    type:
      - 'null'
      - File
    doc: "Cluster assignment of the cells"
    outputBinding:
      glob: "$(inputs.out_file_name_path)"
  - id: save_intermediate_raw_matrix
    type:
      - 'null'
      - File
    doc: "Intermediate raw matrix"
    outputBinding:
      glob: "$(inputs.save_intermediate_raw_matrix_path)"
  - id: create_scatter_plot
    type:
      - 'null'
      - File
    doc: "Scatter plot of the clustering"
    outputBinding:
      glob: "$(inputs.create_scatter_plot_path)"
  - id: latex_table
    type:
      - 'null'
      - File
    doc: "Overlap statistics as latex table"
    outputBinding:
      glob: "$(inputs.latex_table_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/schicexplorer:7--py_0
