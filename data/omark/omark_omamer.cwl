cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - omark
  - omamer
label: omark_omamer
doc: "OMark is a tool for proteome quality assessment. (Note: The provided text contains
  container runtime errors and does not include usage instructions or argument definitions.)\n
  \nTool homepage: https://github.com/DessimozLab/omark"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/omark:0.4.1--pyh7e72e81_0
stdout: omark_omamer.out
