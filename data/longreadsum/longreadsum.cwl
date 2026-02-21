cwlVersion: v1.2
class: CommandLineTool
baseCommand: longreadsum
label: longreadsum
doc: "A tool for summarizing long-read sequencing data (Note: The provided text contains
  container runtime error messages rather than the tool's help documentation).\n\n
  Tool homepage: https://github.com/WGLab/LongReadSum"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/longreadsum:1.3.1--py310h65e1ce4_3
stdout: longreadsum.out
