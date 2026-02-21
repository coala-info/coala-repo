cwlVersion: v1.2
class: CommandLineTool
baseCommand: vmatch_chain2dim
label: vmatch_chain2dim
doc: "The provided text is a container runtime error log and does not contain help
  information or argument definitions for the tool vmatch_chain2dim.\n\nTool homepage:
  http://www.vmatch.de/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vmatch:2.3.1--h7b50bb2_0
stdout: vmatch_chain2dim.out
