cwlVersion: v1.2
class: CommandLineTool
baseCommand: halfdeep
label: halfdeep
doc: "A tool for deep learning-based genomic analysis (Note: The provided help text
  contains container runtime errors and does not list specific command-line arguments).\n
  \nTool homepage: https://github.com/richard-burhans/HalfDeep"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/halfdeep:0.1.0--hdfd78af_1
stdout: halfdeep.out
