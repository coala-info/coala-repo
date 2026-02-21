cwlVersion: v1.2
class: CommandLineTool
baseCommand: seq2squiggle
label: seq2squiggle
doc: "The provided text does not contain help information or usage instructions; it
  is an error log from a failed container build process.\n\nTool homepage: https://github.com/ZKI-PH-ImageAnalysis/seq2squiggle"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seq2squiggle:0.3.4--pyhdfd78af_0
stdout: seq2squiggle.out
