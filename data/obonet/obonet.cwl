cwlVersion: v1.2
class: CommandLineTool
baseCommand: obonet
label: obonet
doc: "A Python library for parsing OBO (Open Biomedical Ontologies) files into NetworkX
  graphs. (Note: The provided text contains system error messages rather than tool
  help text; no arguments could be extracted from the input.)\n\nTool homepage: https://github.com/dhimmel/obonet"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/obonet:1.1.1--pyh7e72e81_0
stdout: obonet.out
