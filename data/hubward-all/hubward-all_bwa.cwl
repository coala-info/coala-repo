cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hubward-all
  - bwa
label: hubward-all_bwa
doc: "The provided text is an error message from a container runtime and does not
  contain help information or usage instructions for the tool.\n\nTool homepage: https://github.com/lh3/bwa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hubward-all:0.2.1--1
stdout: hubward-all_bwa.out
