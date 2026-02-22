cwlVersion: v1.2
class: CommandLineTool
baseCommand: piper
label: piper
doc: "A tool for genomic analysis (Note: The provided text contains system error messages
  rather than help documentation, so specific arguments could not be extracted).\n\
  \nTool homepage: https://github.com/databio/pypiper/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/piper:0.14.5--pyhdfd78af_0
stdout: piper.out
