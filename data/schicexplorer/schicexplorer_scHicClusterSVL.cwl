cwlVersion: v1.2
class: CommandLineTool
baseCommand: scHicClusterSVL
label: schicexplorer_scHicClusterSVL
doc: "scHicClusterSVL uses kmeans or spectral clustering to associate each cell to a cluster and therefore to its cell cycle. The clustering is applied on dimension reduced data based on the ratio of short vs long range contacts per chromosome.\n\nTool homepage: https://github.com/joachimwolff/scHiCExplorer"
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
    doc: "Number of to be computed clusters (default: 7)"
    inputBinding:
      position: 101
      prefix: --numberOfClusters
  - id: cluster_method
    type:
      - 'null'
      - string
    doc: "Algorithm to cluster the Hi-C matrices (spectral, kmeans; default: spectral)"
    inputBinding:
      position: 101
      prefix: --clusterMethod
  - id: distance_short_range
    type:
      - 'null'
      - int
    doc: "Distance which should be considered as short range. Default 2MB. (default: 2000000)"
    inputBinding:
      position: 101
      prefix: --distanceShortRange
  - id: distance_long_range
    type:
      - 'null'
      - int
    doc: "Distance which should be considered as long range. Default 12MB. (default: 12000000)"
    inputBinding:
      position: 101
      prefix: --distanceLongRange
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads. Using the python multiprocessing module."
    inputBinding:
      position: 101
      prefix: --threads
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
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/schicexplorer:7--py_0
