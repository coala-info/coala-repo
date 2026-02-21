cwlVersion: v1.2
class: CommandLineTool
baseCommand: chainStitchId
label: ucsc-chainstitchid
doc: "Join together chain fragments that have the same ID.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chainstitchid:482--h0b57e2e_0
stdout: ucsc-chainstitchid.out
