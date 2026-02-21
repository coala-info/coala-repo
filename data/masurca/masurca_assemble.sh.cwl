cwlVersion: v1.2
class: CommandLineTool
baseCommand: masurca_assemble.sh
label: masurca_assemble.sh
doc: "MaSuRCA assembly script (Note: The provided text contains system error messages
  and does not include usage instructions or argument definitions).\n\nTool homepage:
  http://masurca.blogspot.co.uk/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/masurca:4.1.4--h6b3f7d6_0
stdout: masurca_assemble.sh.out
