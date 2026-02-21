cwlVersion: v1.2
class: CommandLineTool
baseCommand: DBGraph2Pro
label: graph2pro-var_DBGraph2Pro
doc: "A tool for graph-based proteogenomics database construction (Note: The provided
  help text contains system error messages and does not list specific command-line
  arguments).\n\nTool homepage: https://github.com/COL-IU/graph2pro-var"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graph2pro-var:1.0.0--0
stdout: graph2pro-var_DBGraph2Pro.out
