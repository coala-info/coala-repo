cwlVersion: v1.2
class: CommandLineTool
baseCommand: treesap
label: treesap
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system log indicating a failure to build a container
  image due to insufficient disk space.\n\nTool homepage: https://github.com/niemasd/TreeSAP"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/treesap:1.0.10--pyh7cba7a3_0
stdout: treesap.out
