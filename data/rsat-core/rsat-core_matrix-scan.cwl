cwlVersion: v1.2
class: CommandLineTool
baseCommand: matrix-scan
label: rsat-core_matrix-scan
doc: "The provided text is a container runtime error log and does not contain the
  help documentation or usage instructions for the tool.\n\nTool homepage: http://rsat.eu/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsat-core:2025.04.04--hb2a3317_1
stdout: rsat-core_matrix-scan.out
