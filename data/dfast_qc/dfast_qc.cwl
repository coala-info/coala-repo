cwlVersion: v1.2
class: CommandLineTool
baseCommand: dfast_qc
label: dfast_qc
doc: "A quality control tool for DFAST (DDBJ Fast Annotation and Submission Tool).
  Note: The provided help text contains only system error messages and does not list
  specific arguments.\n\nTool homepage: https://dfast.nig.ac.jp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dfast:1.3.7--h5ca1c30_0
stdout: dfast_qc.out
