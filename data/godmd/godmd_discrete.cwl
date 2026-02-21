cwlVersion: v1.2
class: CommandLineTool
baseCommand: godmd_discrete
label: godmd_discrete
doc: "Discrete Molecular Dynamics (DMD) simulation tool. (Note: The provided help
  text contains only system error messages regarding container execution and does
  not list specific command-line arguments.)\n\nTool homepage: http://mmb.irbbarcelona.org/gitlab/adam/GOdMD"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/godmd:1.7--hb2a3317_0
stdout: godmd_discrete.out
