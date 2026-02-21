cwlVersion: v1.2
class: CommandLineTool
baseCommand: graph2pro-var_graph2pro-var.sh
label: graph2pro-var_graph2pro-var.sh
doc: "A tool for proteogenomics using variation graphs. (Note: The provided help text
  contains only system error messages regarding container execution and does not list
  specific command-line arguments.)\n\nTool homepage: https://github.com/COL-IU/graph2pro-var"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graph2pro-var:1.0.0--0
stdout: graph2pro-var_graph2pro-var.sh.out
