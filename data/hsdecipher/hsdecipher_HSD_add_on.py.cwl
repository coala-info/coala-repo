cwlVersion: v1.2
class: CommandLineTool
baseCommand: hsdecipher_HSD_add_on.py
label: hsdecipher_HSD_add_on.py
doc: "HSD add-on for hsdecipher (Note: The provided text contains container runtime
  error logs rather than tool help text, so no arguments could be extracted).\n\n
  Tool homepage: https://github.com/zx0223winner/HSDecipher"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hsdecipher:1.1.2--hdfd78af_0
stdout: hsdecipher_HSD_add_on.py.out
