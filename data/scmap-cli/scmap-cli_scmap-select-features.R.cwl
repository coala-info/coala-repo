cwlVersion: v1.2
class: CommandLineTool
baseCommand: scmap-select-features.R
label: scmap-cli_scmap-select-features.R
doc: "Selects features based on expression and dropout distributions.\n\nTool homepage:
  https://github.com/ebi-gene-expression-group/scmap-cli"
inputs:
  - id: input_object_file
    type: File
    doc: singleCellExperiment object containing expression values and 
      experimental information. Must have been appropriately prepared.
    inputBinding:
      position: 101
      prefix: --input-object-file
  - id: n_features
    type: int
    doc: Number of the features to be selected.
    inputBinding:
      position: 101
      prefix: --n-features
outputs:
  - id: output_plot_file
    type:
      - 'null'
      - File
    doc: Optional file name in which to store a PNG-format plot of 
      log(expression) versus log(dropout) distribution for all genes. Selected 
      features are highlighted with the red colour.
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
