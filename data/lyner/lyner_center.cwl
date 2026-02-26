cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
  - center
label: lyner_center
doc: "Center the matrix.\n\nTool homepage: https://github.com/tedil/lyner"
inputs:
  - id: input
    type: File
    doc: Input matrix file
    inputBinding:
      position: 1
  - id: center_type
    type:
      - 'null'
      - string
    doc: Type of centering to perform (mean, median)
    default: mean
    inputBinding:
      position: 102
      prefix: --center-type
  - id: log
    type:
      - 'null'
      - boolean
    doc: Log transform the data before centering
    inputBinding:
      position: 102
      prefix: --log
  - id: log_base
    type:
      - 'null'
      - float
    doc: Base of the log transform
    default: 2.0
    inputBinding:
      position: 102
      prefix: --log-base
  - id: scale
    type:
      - 'null'
      - boolean
    doc: Scale the data after centering
    inputBinding:
      position: 102
      prefix: --scale
  - id: scale_type
    type:
      - 'null'
      - string
    doc: Type of scaling to perform (std, mad)
    default: std
    inputBinding:
      position: 102
      prefix: --scale-type
  - id: selection
    type:
      - 'null'
      - string
    doc: Selection of rows/columns to center
    inputBinding:
      position: 102
      prefix: --selection
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output matrix file
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
