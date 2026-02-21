cwlVersion: v1.2
class: CommandLineTool
baseCommand: rpbp
label: rpbp
doc: "The provided text is a container runtime error log and does not contain help
  documentation or argument definitions for the 'rpbp' tool.\n\nTool homepage: https://github.com/dieterich-lab/rp-bp"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rpbp:4.0.1--py311he264feb_0
stdout: rpbp.out
