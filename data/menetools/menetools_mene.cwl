cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - menetools
  - mene
label: menetools_mene
doc: "A tool from the menetools suite (Metabolic Network Expansion). Note: The provided
  text contains only system error messages and no help documentation; therefore, no
  arguments could be extracted.\n\nTool homepage: https://github.com/cfrioux/MeneTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/menetools:2.0.6--py_0
stdout: menetools_mene.out
