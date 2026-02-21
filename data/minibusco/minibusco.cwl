cwlVersion: v1.2
class: CommandLineTool
baseCommand: minibusco
label: minibusco
doc: "The provided text contains error logs related to a container runtime failure
  and does not include the help documentation for minibusco. As a result, no arguments
  could be parsed.\n\nTool homepage: https://github.com/huangnengCSU/minibusco"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minibusco:0.2.1--pyh7cba7a3_0
stdout: minibusco.out
