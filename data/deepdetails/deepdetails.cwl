cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepdetails
label: deepdetails
doc: "DeepDetails tool (Note: The provided text contains container runtime error logs
  rather than command-line help documentation.)\n\nTool homepage: https://details.yulab.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepdetails:0.1.1rc1--pyhdfd78af_0
stdout: deepdetails.out
