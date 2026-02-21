cwlVersion: v1.2
class: CommandLineTool
baseCommand: flippyr_flippyr.py
label: flippyr_flippyr.py
doc: "A tool for flipping SNPs (Note: The provided text contains container runtime
  error logs rather than help documentation, so no arguments could be extracted).\n
  \nTool homepage: https://github.com/BEFH/flippyr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/flippyr:0.6.1--pyh7e72e81_0
stdout: flippyr_flippyr.py.out
