cwlVersion: v1.2
class: CommandLineTool
baseCommand: rsem-generate-data-matrix
label: rsem_rsem-generate-data-matrix
doc: "Generate a data matrix from RSEM results. Note: The provided help text contains
  only system error logs and does not list specific arguments.\n\nTool homepage: https://deweylab.github.io/RSEM/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
stdout: rsem_rsem-generate-data-matrix.out
