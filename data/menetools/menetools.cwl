cwlVersion: v1.2
class: CommandLineTool
baseCommand: menetools
label: menetools
doc: "A tool for metabolic network expansion and gap-filling (Note: The provided text
  contains system error messages rather than help documentation).\n\nTool homepage:
  https://github.com/cfrioux/MeneTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/menetools:2.0.6--py_0
stdout: menetools.out
