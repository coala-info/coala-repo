cwlVersion: v1.2
class: CommandLineTool
baseCommand: clermontyping_clermont.py
label: clermontyping_clermont.py
doc: "Clermont typing tool for Escherichia coli phylotyping.\n\nTool homepage: https://github.com/happykhan/ClermonTyping"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clermontyping:24.02--py312hdfd78af_1
stdout: clermontyping_clermont.py.out
