cwlVersion: v1.2
class: CommandLineTool
baseCommand: sccellfie
label: sccellfie
doc: "The provided text contains system error messages related to a Singularity/Docker
  container execution failure and does not contain the tool's help documentation or
  argument definitions.\n\nTool homepage: https://github.com/earmingol/scCellFie"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sccellfie:0.5.0--pyhdfd78af_0
stdout: sccellfie.out
