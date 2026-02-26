cwlVersion: v1.2
class: CommandLineTool
baseCommand: gapc
label: bellmans-gapc
doc: "The Bellman's GAP compiler (gapc) for Algebraic Dynamic Programming. Note: The
  provided input text contained a Docker system error ('no space left on device')
  rather than the tool's help output. The following arguments are based on standard
  gapc usage.\n\nTool homepage: https://bibiserv.cebitec.uni-bielefeld.de/gapc"
inputs:
  - id: input_file
    type: File
    doc: The .gap source file to compile
    inputBinding:
      position: 1
  - id: include_dir
    type:
      - 'null'
      - type: array
        items: Directory
    doc: Add directory to include path
    inputBinding:
      position: 102
      prefix: --include
  - id: prefix
    type:
      - 'null'
      - string
    doc: Set the prefix for generated code
    inputBinding:
      position: 102
      prefix: --prefix
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Set the output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bellmans-gapc:2024.01.12--h3053a90_5
