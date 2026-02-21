cwlVersion: v1.2
class: CommandLineTool
baseCommand: cfm
label: cfm
doc: "Competitive Fragmentation Modeling (Note: The provided text is a container build
  error log and does not contain help documentation or argument definitions).\n\n
  Tool homepage: https://sourceforge.net/p/cfm-id/wiki/Home/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cfm:33--h7600467_7
stdout: cfm.out
