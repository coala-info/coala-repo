cwlVersion: v1.2
class: CommandLineTool
baseCommand: hsdecipher_HSD_categories.py
label: hsdecipher_HSD_categories.py
doc: "The provided text does not contain help information or a description of the
  tool; it contains container runtime log messages and a fatal error regarding disk
  space.\n\nTool homepage: https://github.com/zx0223winner/HSDecipher"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hsdecipher:1.1.2--hdfd78af_0
stdout: hsdecipher_HSD_categories.py.out
