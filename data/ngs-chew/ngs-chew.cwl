cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngs-chew
label: ngs-chew
doc: "The provided text contains system error logs and container runtime information
  rather than the tool's help documentation. As a result, no arguments or descriptions
  could be extracted.\n\nTool homepage: https://github.com/bihealth/ngs-chew"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-chew:0.9.4--pyhdfd78af_0
stdout: ngs-chew.out
