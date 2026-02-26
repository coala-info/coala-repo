cwlVersion: v1.2
class: CommandLineTool
baseCommand: ropebwt3_get
label: ropebwt3_get
doc: "Get sequences from an FMR index\n\nTool homepage: https://github.com/lh3/ropebwt3"
inputs:
  - id: idx_fmr
    type: File
    doc: Input FMR index file
    inputBinding:
      position: 1
  - id: int
    type:
      type: array
      items: int
    doc: Integer values to retrieve
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
stdout: ropebwt3_get.out
