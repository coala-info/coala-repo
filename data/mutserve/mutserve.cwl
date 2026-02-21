cwlVersion: v1.2
class: CommandLineTool
baseCommand: mutserve
label: mutserve
doc: "A variant caller for mitochondrial DNA (Note: The provided text contains error
  logs rather than help documentation, so no arguments could be extracted).\n\nTool
  homepage: https://github.com/seppinho/mutserve"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mutserve:2.0.3--hdfd78af_0
stdout: mutserve.out
