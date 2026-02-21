cwlVersion: v1.2
class: CommandLineTool
baseCommand: hsdecipher_HSD_statistics.py
label: hsdecipher_HSD_statistics.py
doc: "A script for HSD statistics (Note: The provided text contains container execution
  errors and does not include help documentation or argument definitions).\n\nTool
  homepage: https://github.com/zx0223winner/HSDecipher"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hsdecipher:1.1.2--hdfd78af_0
stdout: hsdecipher_HSD_statistics.py.out
