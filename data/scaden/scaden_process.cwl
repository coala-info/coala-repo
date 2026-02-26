cwlVersion: v1.2
class: CommandLineTool
baseCommand: scaden process
label: scaden_process
doc: "Process a dataset for training\n\nTool homepage: https://github.com/KevinMenden/scaden"
inputs:
  - id: training_dataset
    type: File
    doc: training dataset to be processed
    inputBinding:
      position: 1
  - id: data_for_prediction
    type: File
    doc: data for prediction
    inputBinding:
      position: 2
  - id: var_cutoff
    type:
      - 'null'
      - float
    doc: Filter out genes with a variance less than the specified cutoff. A low 
      cutoff is recommended,this should only remove genes that are obviously 
      uninformative.
    inputBinding:
      position: 103
      prefix: --var_cutoff
outputs:
  - id: processed_path
    type:
      - 'null'
      - File
    doc: Path of processed file. Must end with .h5ad
    outputBinding:
      glob: $(inputs.processed_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scaden:1.1.2--pyhdfd78af_0
