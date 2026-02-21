cwlVersion: v1.2
class: CommandLineTool
baseCommand: dunovo_align-families.py
label: dunovo_align-families.py
doc: "The provided text is an error log indicating a system failure (no space left
  on device) and does not contain the help text or usage information for the tool.\n
  \nTool homepage: https://github.com/galaxyproject/dunovo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dunovo:3.0.2--h7b50bb2_4
stdout: dunovo_align-families.py.out
