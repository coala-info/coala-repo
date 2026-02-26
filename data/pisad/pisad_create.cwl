cwlVersion: v1.2
class: CommandLineTool
baseCommand: create
label: pisad_create
doc: "Create a new data structure from an input file.\n\nTool homepage: https://github.com/ZhantianXu/PISAD"
inputs:
  - id: input_file
    type: File
    doc: Input file
    inputBinding:
      position: 101
      prefix: -i
  - id: k
    type:
      - 'null'
      - int
    doc: Parameter k
    inputBinding:
      position: 101
      prefix: -k
  - id: limit
    type:
      - 'null'
      - int
    doc: Limit
    inputBinding:
      position: 101
      prefix: -l
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pisad:1.2.0--pl5321h6f0a7f7_0
