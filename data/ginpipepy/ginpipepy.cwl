cwlVersion: v1.2
class: CommandLineTool
baseCommand: ginpipepy
label: ginpipepy
doc: "A tool for genomic pipeline processing (Note: The provided text contains system
  error logs rather than help documentation, so specific arguments could not be extracted).\n
  \nTool homepage: https://github.com/KleistLab/ginpipepy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ginpipepy:1.0.0--pyhb7b1952_0
stdout: ginpipepy.out
