cwlVersion: v1.2
class: CommandLineTool
baseCommand: godmd
label: godmd
doc: "Discrete Molecular Dynamics (DMD) simulation tool\n\nTool homepage: http://mmb.irbbarcelona.org/gitlab/adam/GOdMD"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/godmd:1.7--hb2a3317_0
stdout: godmd.out
