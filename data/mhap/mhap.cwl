cwlVersion: v1.2
class: CommandLineTool
baseCommand: mhap
label: mhap
doc: "MinHash Alignment Process (MHAP) for overlapping long reads. Note: The provided
  text contains container runtime error messages rather than tool help documentation.\n
  \nTool homepage: https://github.com/marbl/MHAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mhap:2.1.3--0
stdout: mhap.out
