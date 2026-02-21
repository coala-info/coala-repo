cwlVersion: v1.2
class: CommandLineTool
baseCommand: mtglink_LRez
label: mtglink_LRez
doc: "The provided text does not contain help information or a description of the
  tool. It contains system log messages and a fatal error regarding container image
  building.\n\nTool homepage: https://github.com/anne-gcd/MTG-Link"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtglink:2.4.1--hdfd78af_0
stdout: mtglink_LRez.out
