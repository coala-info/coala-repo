cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - spapros
  - evaluation
label: spapros_evaluation
doc: "Create a selection of probesets for an h5ad file.\n\nTool homepage: https://github.com/theislab/spapros"
inputs:
  - id: data
    type: File
    doc: Path to the h5ad dataset file
    inputBinding:
      position: 1
  - id: probeset
    type: File
    doc: Path to the probeset file
    inputBinding:
      position: 2
  - id: marker_file
    type: File
    doc: Path to the marker file
    inputBinding:
      position: 3
  - id: probeset_ids
    type:
      - 'null'
      - type: array
        items: string
    doc: Several probeset ids
    inputBinding:
      position: 4
  - id: parameters
    type:
      - 'null'
      - File
    doc: Path to a yaml file containing parameters
    inputBinding:
      position: 105
      prefix: --parameters
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output path
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spapros:0.1.6--pyhdfd78af_0
