cwlVersion: v1.2
class: CommandLineTool
baseCommand: scmap-scmap-cell.R
label: scmap-cli_scmap-scmap-cell.R
doc: "Annotates cells of a projection dataset using labels of a reference dataset.\n\
  \nTool homepage: https://github.com/ebi-gene-expression-group/scmap-cli"
inputs:
  - id: cluster_col
    type:
      - 'null'
      - string
    doc: Column name in the 'colData' slot of the SingleCellExperiment index 
      object containing the cell classification information. If found in the 
      index object, scmapCell2Cluster() will be run to annotate cells of the 
      projection dataset using labels of the reference.
    inputBinding:
      position: 101
      prefix: --cluster-col
  - id: index_object_file
    type: File
    doc: "'SingleCellExperiment' object previously prepared with the scmap-index-cluster.R
      script."
    inputBinding:
      position: 101
      prefix: --index-object-file
  - id: nearest_neighbours_threshold
    type: int
    doc: A positive integer specifying the number of matching nearest neighbours
      required to label a cell.
    inputBinding:
      position: 101
      prefix: --nearest-neighbours-threshold
  - id: number_nearest_neighbours
    type: int
    doc: A positive integer specifying the number of nearest neighbours to find.
    inputBinding:
      position: 101
      prefix: --number-nearest-neighbours
  - id: projection_object_file
    type: File
    doc: "'SingleCellExperiment' object to project."
    inputBinding:
      position: 101
      prefix: --projection-object-file
  - id: threshold
    type:
      - 'null'
      - float
    doc: Threshold on similarity (or probability for SVM and RF).
    inputBinding:
      position: 101
      prefix: --threshold
outputs:
  - id: output_object_file
    type:
      - 'null'
      - File
    doc: File name in which to store serialized R object of type 
      'SingleCellExperiment', containing the input object specified by 
      --projection-object-file with cluster labels in its colData (where 
      --cluster-col is set and scmapCell2Cluster() is run).
    outputBinding:
      glob: $(inputs.output_object_file)
  - id: output_clusters_text_file
    type:
      - 'null'
      - File
    doc: File name in which to text-format cell type assignments.
    outputBinding:
      glob: $(inputs.output_clusters_text_file)
  - id: closest_cells_text_file
    type:
      - 'null'
      - File
    doc: File name in which to store the top cell IDs of the cells of the 
      reference dataset that a given cell of the projection dataset is closest 
      to.
    outputBinding:
      glob: $(inputs.closest_cells_text_file)
  - id: closest_cells_similarities_text_file
    type:
      - 'null'
      - File
    doc: File name in which to store cosine similarities for the top cells of 
      the reference dataset that a given cell of the projection dataset is 
      closest to.
    outputBinding:
      glob: $(inputs.closest_cells_similarities_text_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scmap-cli:0.1.0--hdfd78af_0
