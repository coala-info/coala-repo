cwlVersion: v1.2
class: CommandLineTool
baseCommand: bleach
label: bleach
doc: "Bleach is a Python library that sanitizes HTML; it can also linkify text and
  manage allowed attributes.\n\nTool homepage: https://github.com/bleachbit/bleachbit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bleach:1.4.2--py35_0
stdout: bleach.out
