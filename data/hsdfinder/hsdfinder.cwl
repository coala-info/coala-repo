cwlVersion: v1.2
class: CommandLineTool
baseCommand: hsdfinder
label: hsdfinder
doc: "Highly Sensitive Deletion Finder (Note: The provided text is a system error
  message and does not contain tool-specific help information or arguments).\n\nTool
  homepage: https://github.com/zx0223winner/HSDFinder"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hsdfinder:1.1.1--hdfd78af_0
stdout: hsdfinder.out
