cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - monocle3
label: monocle3-cli_monocle3
doc: "The provided text does not contain help information for the tool. It is a system
  error message indicating a failure to build the container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/ebi-gene-expression-group/monocle-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/monocle3-cli:0.0.9--r36_1
stdout: monocle3-cli_monocle3.out
