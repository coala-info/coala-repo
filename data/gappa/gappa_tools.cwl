cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gappa
  - tools
label: gappa_tools
doc: "Auxiliary commands of gappa.\n\nTool homepage: https://github.com/lczech/gappa"
inputs:
  - id: citation
    type:
      - 'null'
      - boolean
    doc: Print references to be cited when using gappa.
    inputBinding:
      position: 101
  - id: license
    type:
      - 'null'
      - boolean
    doc: Show the license of gappa.
    inputBinding:
      position: 101
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
stdout: gappa_tools.out
