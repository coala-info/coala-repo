cwlVersion: v1.2
class: CommandLineTool
baseCommand: liftUp
label: ucsc-liftup
doc: "The provided text does not contain help information for the tool. It consists
  of container engine logs and a fatal error message regarding image retrieval.\n\n
  Tool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-liftup:482--h0b57e2e_0
stdout: ucsc-liftup.out
