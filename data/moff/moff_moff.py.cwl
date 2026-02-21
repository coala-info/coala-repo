cwlVersion: v1.2
class: CommandLineTool
baseCommand: moff_moff.py
label: moff_moff.py
doc: "moFF (modiFication-Free) is a tool for the quantification of mass spectrometry
  data. (Note: The provided help text contains only system error messages and no argument
  definitions).\n\nTool homepage: https://github.com/compomics/moFF"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/moff:2.0.3--py36_2
stdout: moff_moff.py.out
