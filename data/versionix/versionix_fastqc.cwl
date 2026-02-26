cwlVersion: v1.2
class: CommandLineTool
baseCommand: versionix
label: versionix_fastqc
doc: "Versionix returns the version of bioinformatics software.\n\nTool homepage:
  https://github.com/sequana/versionix"
inputs:
  - id: standalone
    type:
      - 'null'
      - string
    doc: TEXT
    inputBinding:
      position: 1
  - id: logger_level
    type:
      - 'null'
      - string
    doc: level for debugging (INFO|DEBUG|WARNING|ERROR)
    inputBinding:
      position: 102
      prefix: --logger-level
  - id: registered
    type:
      - 'null'
      - boolean
    doc: Prints the list of registered tools
    inputBinding:
      position: 102
      prefix: --registered
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/versionix:0.99.3--pyhdfd78af_0
stdout: versionix_fastqc.out
