cwlVersion: v1.2
class: CommandLineTool
baseCommand: scanpy-cli
label: scanpy-scripts_scanpy-cli
doc: "Command line interface to [scanpy](https://github.com/theislab/scanpy)\n\nTool
  homepage: https://github.com/ebi-gene-expression-group/scanpy-scripts"
inputs:
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print debug information
    inputBinding:
      position: 101
      prefix: --debug
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Set scanpy verbosity
    inputBinding:
      position: 101
      prefix: --verbosity
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
stdout: scanpy-scripts_scanpy-cli.out
