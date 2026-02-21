cwlVersion: v1.2
class: CommandLineTool
baseCommand: graph2pro-var
label: graph2pro-var
doc: "A tool for variant-aware proteogenomics. (Note: The provided text contains system
  error messages regarding container image conversion and does not include the actual
  command-line help documentation.)\n\nTool homepage: https://github.com/COL-IU/graph2pro-var"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graph2pro-var:1.0.0--0
stdout: graph2pro-var.out
