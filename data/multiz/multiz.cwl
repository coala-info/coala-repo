cwlVersion: v1.2
class: CommandLineTool
baseCommand: multiz
label: multiz
doc: "A tool for multiple alignment of genomic sequences. (Note: The provided text
  is a container runtime error message and does not contain help documentation or
  argument definitions.)\n\nTool homepage: http://www.bx.psu.edu/miller_lab/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/multiz:11.2--h7b50bb2_7
stdout: multiz.out
