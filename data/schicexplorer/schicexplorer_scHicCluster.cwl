cwlVersion: v1.2
class: CommandLineTool
baseCommand: scHicCluster
label: schicexplorer_scHicCluster
doc: "Uses kmeans or spectral clustering to associate each cell to a cluster and therefore
  to its cell cycle. The clustering can be run on the raw data, on a kNN computed
  via the exact euclidean distance or via PCA. Please consider also the other clustering
  and dimension reduction approaches of the scHicExplorer suite. They can give you
  better results, can be faster or less memory demanding.\n\nTool homepage: https://github.com/joachimwolff/scHiCExplorer"
inputs:
  - id: additional_pca
    type:
      - 'null'
      - boolean
    doc: Computes PCA on top of a k-nn. Can improve the cluster result.
    inputBinding:
      position: 101
      prefix: --additionalPCA
  - id: cell_coloring_batch
    type:
      - 'null'
      - string
    doc: A two column list, first colum the cell names as stored in the scool 
      file, second column the associated coloring for the scatter plot
    inputBinding:
      position: 101
      prefix: --cell_coloring_batch
  - id: cell_coloring_type
    type:
      - 'null'
      - string
    doc: A two column list, first colum the cell names as stored in the scool 
      file, second column the associated coloring for the scatter plot
    inputBinding:
      position: 101
      prefix: --cell_coloring_type
  - id: chromosomes
    type:
      - 'null'
      - type: array
        items: string
    doc: List of to be plotted chromosomes
    inputBinding:
      position: 101
      prefix: --chromosomes
  - id: cluster_method
    type:
      - 'null'
      - string
    doc: Algorithm to cluster the Hi-C matrices
    inputBinding:
      position: 101
      prefix: --clusterMethod
  - id: color_map
    type:
      - 'null'
      - string
    doc: 'Color map to use for the heatmap, supported are the categorical colormaps
      from holoviews: http://holoviews.org/user_guide/Colormaps.html'
    inputBinding:
      position: 101
      prefix: --colorMap
  - id: create_scatter_plot
    type:
      - 'null'
      - string
    doc: Create a scatter plot for the clustering, the x and y are the first and
      second principal component of the computed k-nn graph.
    inputBinding:
      position: 101
      prefix: --createScatterPlot
  - id: dimension_reduction_method
    type:
      - 'null'
      - string
    doc: Dimension reduction methods, knn with euclidean distance, pca
    inputBinding:
      position: 101
      prefix: --dimensionReductionMethod
  - id: dimensions_pca
    type:
      - 'null'
      - int
    doc: The number of dimensions from the PCA matrix that should be considered 
      for clustering. Can improve the cluster result.
    inputBinding:
      position: 101
      prefix: --dimensionsPCA
  - id: dpi
    type:
      - 'null'
      - int
    doc: The dpi of the scatter plot.
    inputBinding:
      position: 101
      prefix: --dpi
  - id: figuresize
    type:
      - 'null'
      - string
    doc: Fontsize in the plot for x and y axis.
    inputBinding:
      position: 101
      prefix: --figuresize
  - id: font_size
    type:
      - 'null'
      - int
    doc: Fontsize in the plot for x and y axis.
    inputBinding:
      position: 101
      prefix: --fontsize
  - id: intra_chromosomal_contacts_only
    type:
      - 'null'
      - boolean
    doc: This option loads only the intra-chromosomal contacts. Can improve the 
      cluster result if data is very noisy.
    inputBinding:
      position: 101
      prefix: --intraChromosomalContactsOnly
  - id: latex_table
    type:
      - 'null'
      - string
    doc: Return the overlap statistics if --cell_coloring_type is given as a 
      latex table.
    inputBinding:
      position: 101
      prefix: --latexTable
  - id: matrix
    type: File
    doc: The single cell Hi-C interaction matrices to cluster. Needs to be in 
      scool format
    inputBinding:
      position: 101
      prefix: --matrix
  - id: number_of_clusters
    type:
      - 'null'
      - int
    doc: Number of to be computed clusters
    inputBinding:
      position: 101
      prefix: --numberOfClusters
  - id: number_of_nearest_neighbors
    type:
      - 'null'
      - int
    doc: Number of to be used computed nearest neighbors for the knn graph. 
      Default is either the default value or the number of the provided cells, 
      whatever is smaller.
    inputBinding:
      position: 101
      prefix: --numberOfNearestNeighbors
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads. Using the python multiprocessing module.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: out_file_name
    type:
      - 'null'
      - File
    doc: File name to save the resulting clusters
    outputBinding:
      glob: $(inputs.out_file_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/schicexplorer:7--py_0
