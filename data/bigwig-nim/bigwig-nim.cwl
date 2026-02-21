cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigwig
label: bigwig-nim
doc: "A tool for handling BigWig files (Note: The provided text contains system error
  logs rather than help documentation, so specific arguments could not be extracted).\n
  \nTool homepage: https://github.com/brentp/bigwig-nim"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bigwig-nim:0.0.3--h9ee0642_0
stdout: bigwig-nim.out
