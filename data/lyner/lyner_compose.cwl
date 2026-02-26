cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
  - compose
label: lyner_compose
doc: "Compose a pipeline from a list of transformations.\n\nTool homepage: https://github.com/tedil/lyner"
inputs:
  - id: transformations
    type:
      type: array
      items: string
    doc: List of transformations to compose.
    inputBinding:
      position: 1
  - id: config_file
    type:
      - 'null'
      - File
    doc: Configuration file for the pipeline.
    inputBinding:
      position: 102
      prefix: --config
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file to the pipeline.
    inputBinding:
      position: 102
      prefix: --input
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file from the pipeline.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
