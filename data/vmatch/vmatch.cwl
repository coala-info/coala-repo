cwlVersion: v1.2
class: CommandLineTool
baseCommand: vmatch
label: vmatch
doc: "The provided text does not contain help information or a description for the
  tool; it contains container build logs and a fatal error message.\n\nTool homepage:
  http://www.vmatch.de/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vmatch:2.3.1--h7b50bb2_0
stdout: vmatch.out
