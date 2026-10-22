cwlVersion: v1.2
class: CommandLineTool
baseCommand: scHicClusterCompartments
label: schicexplorer_scHicClusterCompartments
doc: "scHicClusterCompartments uses kmeans or spectral clustering to associate each cell to a cluster and therefore to its cell cycle. The clustering is applied on dimension reduced data based on the A/B compartments track.\n\nTool homepage: https://github.com/joachimwolff/scHiCExplorer"
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
    doc: "Algorithm to cluster the Hi-C matrices (spectral, kmeans; default: spectral)"
    inputBinding:
      position: 101
      prefix: --clusterMethod
  - id: chromosomes
    type:
      - 'null'
      - type: array
        items: string
    doc: "List of chromosomes to be included in the correlation."
    inputBinding:
      position: 101
      prefix: --chromosomes
  - id: norm
    type:
      - 'null'
      - boolean
    doc: "Different obs-exp normalization as used by Homer software."
    inputBinding:
      position: 101
      prefix: --norm
  - id: binarization
    type:
      - 'null'
      - boolean
    doc: "Set all positive values of eigenvector to 1 and all negative ones to 0."
    inputBinding:
      position: 101
      prefix: --binarization
  - id: extra_track
    type:
      - 'null'
      - File
    doc: "Either a gene track or a histon mark coverage file (preferably a broad mark) is needed to decide if the values of the eigenvector need a sign flip or not."
    inputBinding:
      position: 101
      prefix: --extraTrack
  - id: histon_mark_type
    type:
      - 'null'
      - string
    doc: "set it to active or inactive. This is only necessary if a histon mark coverage file is given as an extraTrack. (default: active)"
    inputBinding:
      position: 101
      prefix: --histonMarkType
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
