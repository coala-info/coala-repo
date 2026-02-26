cwlVersion: v1.2
class: CommandLineTool
baseCommand: snk create
label: snk_create
doc: "Create a default snk.yaml project that can be installed with snk\n\nTool homepage:
  https://snk.wytamma.com"
inputs:
  - id: path
    type: Directory
    doc: Path to create the snk.yaml project
    default: None
    inputBinding:
      position: 1
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force creation of the project, overwriting existing files if necessary.
    inputBinding:
      position: 102
      prefix: --force
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snk:0.31.1--pyhdfd78af_0
stdout: snk_create.out
