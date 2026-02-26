cwlVersion: v1.2
class: CommandLineTool
baseCommand: owl_merge
label: owl_merge
doc: "Merge multiple profiles\n\nTool homepage: https://github.com/PacificBiosciences/owl"
inputs:
  - id: files
    type:
      type: array
      items: File
    doc: Input files to merge
    inputBinding:
      position: 101
      prefix: --files
  - id: verbose
    type:
      - 'null'
      - type: array
        items: boolean
    doc: Verbosity
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/owl:0.4.0--h9ee0642_0
stdout: owl_merge.out
