cwlVersion: v1.2
class: CommandLineTool
baseCommand: scmap-index-cell.R
label: scmap-cli_scmap-index-cell.R
doc: "Index cell data for scmap\n\nTool homepage: https://github.com/ebi-gene-expression-group/scmap-cli"
inputs:
  - id: input_object_file
    type: File
    doc: singleCellExperiment object containing expression values and 
      experimental information. Must have been appropriately prepared.
    inputBinding:
      position: 101
      prefix: --input-object-file
  - id: number_chunks
    type: int
    doc: Number of chunks into which the expr matrix is split.
    inputBinding:
      position: 101
      prefix: --number-chunks
  - id: number_clusters
    type: int
    doc: Number of clusters per group for k-means clustering.
    inputBinding:
      position: 101
      prefix: --number-clusters
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Set random seed to make scmap-cell reproducible.
    inputBinding:
      position: 101
      prefix: --random-seed
  - id: remove_mat
    type:
      - 'null'
      - boolean
    doc: 'Should expression data be removed from index object? Default: FALSE'
    inputBinding:
      position: 101
      prefix: --remove-mat
  - id: train_id
    type:
      - 'null'
      - string
    doc: ID of the training dataset (optional)
    inputBinding:
      position: 101
      prefix: --train-id
outputs:
  - id: output_object_file
    type: File
    doc: File name in which to store serialized R object of type 
      'SingleCellExperiment'.
    outputBinding:
      glob: $(inputs.output_object_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scmap-cli:0.1.0--hdfd78af_0
