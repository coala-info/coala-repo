cwlVersion: v1.2
class: CommandLineTool
baseCommand: hificnv
label: hificnv
doc: "HiFiCNV: Copy number variant calling for HiFi reads. (Note: The provided text
  contains system error messages regarding container execution and does not include
  the standard help/usage information.)\n\nTool homepage: https://github.com/PacificBiosciences/HiFiCNV"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hificnv:1.0.1--h9ee0642_0
stdout: hificnv.out
