cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/scmap-index-cluster.R
label: scmap-cli_scmap-index-cluster.R
doc: "Index clustering information for scmap\n\nTool homepage: https://github.com/ebi-gene-expression-group/scmap-cli"
inputs:
  - id: cluster_col
    type: string
    doc: Column name in the 'colData' slot of the SingleCellExperiment object 
      containing the cell classification information.
    inputBinding:
      position: 101
      prefix: --cluster-col
  - id: input_object_file
    type: File
    doc: singleCellExperiment object containing expression values and 
      experimental information. Must have been appropriately prepared.
    inputBinding:
      position: 101
      prefix: --input-object-file
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
  - id: output_plot_file
    type:
      - 'null'
      - File
    doc: Optional file name in which to store a PNG-format heatmap-style index 
      visualisation.
    outputBinding:
      glob: $(inputs.output_plot_file)
  - id: output_object_file
    type: File
    doc: File name in which to store serialized R object of type 
      'SingleCellExperiment'.
    outputBinding:
      glob: $(inputs.output_object_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scmap-cli:0.1.0--hdfd78af_0
