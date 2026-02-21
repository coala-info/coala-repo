cwlVersion: v1.2
class: CommandLineTool
baseCommand: hicup
label: hicup
doc: "Hi-C User Pipeline (HiCUP) for processing Hi-C data. (Note: The provided text
  is a container runtime error log and does not contain usage instructions or argument
  definitions.)\n\nTool homepage: http://www.bioinformatics.babraham.ac.uk/projects/hicup/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hicup:0.9.2--hdfd78af_1
stdout: hicup.out
